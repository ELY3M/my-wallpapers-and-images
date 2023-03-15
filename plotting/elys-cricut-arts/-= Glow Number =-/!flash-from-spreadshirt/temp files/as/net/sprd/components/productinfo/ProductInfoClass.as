package net.sprd.components.productinfo
{
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import net.sprd.common.utils.*;
    import net.sprd.events.*;
    import net.sprd.models.product.*;

    public class ProductInfoClass extends VBox
    {
        public var productTypeName:Label;
        public var productTypeBrand:Label;
        public var product:IProductModel;
        private var productTypeChanged:Boolean;
        private var componentComplete:Boolean;

        public function ProductInfoClass()
        {
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.productTypeChanged)
            {
                this.productTypeChanged = false;
                this.productTypeName.text = this.product.name ? (StringUtil.ucwords(this.product.name)) : ("");
                this.productTypeBrand.text = this.product.brand ? (StringUtil.ucwords(this.product.brand)) : ("");
                endEffectsStarted();
                visible = true;
            }
            return;
        }// end function

        public function bus_productTypeChangedHandler(param1:Event) : void
        {
            this.productTypeChanged = true;
            invalidateProperties();
            if (!this.componentComplete)
            {
            }
            if (visible)
            {
                this.componentComplete = true;
                dispatchEvent(new ApplicationEvent(ApplicationEvent.COMPONENT_COMPLETE, true));
            }
            return;
        }// end function

    }
}
