package net.sprd.events
{
    import flash.events.*;
    import net.sprd.entities.*;
    import net.sprd.entities.impl.*;

    public class ProductTypeEvent extends Event
    {
        private var _productType:IProductType;
        public static const CHANGED:String = "productTypeChanged";
        public static const APPEARANCE_CHANGED:String = "productTypeAppearanceChanged";
        public static const VIEW_CHANGED:String = "productTypeViewChanged";
        public static const SIZE_CHANGED:String = "productTypeSizeChanged";
        public static const ERROR:String = "productTypeError";

        public function ProductTypeEvent(param1:String, param2:IProductType, param3:Boolean = false, param4:Boolean = false)
        {
            super(param1, param3, param4);
            if (param2 == null)
            {
                param2 = new ProductType();
            }
            this._productType = param2;
            return;
        }// end function

        public function get productType() : IProductType
        {
            return this._productType;
        }// end function

        override public function clone() : Event
        {
            return new ProductTypeEvent(type, this.productType, bubbles, cancelable);
        }// end function

        override public function toString() : String
        {
            return formatToString("ProductTypeEvent", "type", "bubbles", "cancelable", "eventPhase", "productType");
        }// end function

    }
}
