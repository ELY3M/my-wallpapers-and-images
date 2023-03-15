package net.sprd.components.debugconsole
{
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.events.*;
    import net.sprd.api.*;
    import net.sprd.api.io.xml.*;
    import net.sprd.entities.*;
    import net.sprd.models.product.*;

    public class DebugConsoleClass extends Panel
    {
        public var debugInput:TextArea;
        private var _product:IProductModel;
        private var _processor:ProductProcessor;

        public function DebugConsoleClass()
        {
            this._processor = new ProductProcessor();
            return;
        }// end function

        public function get product() : IProductModel
        {
            return this._product;
        }// end function

        private function set _309474065product(param1:IProductModel) : void
        {
            this._product = param1;
            return;
        }// end function

        override protected function childrenCreated() : void
        {
            super.childrenCreated();
            titleBar.addEventListener(MouseEvent.MOUSE_DOWN, this.onTitleMouseDown);
            titleBar.addEventListener(MouseEvent.MOUSE_UP, this.onTitleMouseUp);
            return;
        }// end function

        protected function onCreateFromXMLClick(param1:MouseEvent) : void
        {
            var _loc_2:* = IProduct(this._processor.deserialize(new XML(this.debugInput.text)));
            this._product.initializeProduct(_loc_2.id);
            return;
        }// end function

        protected function onXMLFromProductClick(param1:MouseEvent) : void
        {
            var _loc_2:* = IProduct(API.em.get(this._product.currentProductID, APIRegistry.PRODUCT));
            this.debugInput.text = this._processor.serialize(_loc_2).toString();
            return;
        }// end function

        private function onTitleMouseDown(param1:MouseEvent) : void
        {
            startDrag();
            return;
        }// end function

        private function onTitleMouseUp(param1:MouseEvent) : void
        {
            stopDrag();
            return;
        }// end function

        public function set product(param1:IProductModel) : void
        {
            var _loc_2:* = this.product;
            if (_loc_2 !== param1)
            {
                this._309474065product = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "product", _loc_2, param1));
                }
            }
            return;
        }// end function

    }
}
