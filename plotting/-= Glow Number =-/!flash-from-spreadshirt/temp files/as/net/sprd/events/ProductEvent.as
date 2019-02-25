package net.sprd.events
{
    import flash.events.*;
    import net.sprd.entities.*;

    public class ProductEvent extends Event
    {
        private var _product:IProduct;
        public static const CHANGED:String = "productChanged";
        public static const INITIALIZED:String = "productInitialized";
        public static const ERROR:String = "productError";
        public static const CONFIGURATIONS_INITIALIZED:String = "productConfigurationsInitialized";
        public static const Z_ORDER_CHANGED:String = "zOrderChanged";
        public static const SAVE_STARTED:String = "saveStarted";
        public static const SAVE_FAULT:String = "saveFault";
        public static const SAVE_COMPLETED:String = "saveCompleted";

        public function ProductEvent(param1:String, param2:IProduct, param3:Boolean = false, param4:Boolean = false)
        {
            super(param1, param3, param4);
            this._product = param2;
            return;
        }// end function

        public function get product() : IProduct
        {
            return this._product;
        }// end function

        override public function clone() : Event
        {
            return new ProductEvent(type, this.product, bubbles, cancelable);
        }// end function

        override public function toString() : String
        {
            return formatToString("ProductEvent", "type", "bubbles", "cancelable", "eventPhase", "product");
        }// end function

    }
}
