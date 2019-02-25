package net.sprd.events
{
    import flash.events.*;
    import net.sprd.entities.*;

    public class BasketEvent extends Event
    {
        private var _item:IBasketItem;
        private var _message:String;
        private var _code:String;
        public static const ITEM_UPDATED:String = "basket_item_updated";
        public static const ITEM_CREATED:String = "basket_item_created";
        public static const ITEM_LOADED:String = "basket_item_loaded";
        public static const ITEM_ERROR:String = "basket_item_error";

        public function BasketEvent(param1:IBasketItem, param2:String, param3:String = "", param4:String = "", param5:Boolean = false, param6:Boolean = false)
        {
            super(param2, param5, param6);
            this._item = param1;
            this._code = param3;
            this._message = param4;
            return;
        }// end function

        override public function clone() : Event
        {
            return new BasketEvent(this.item, type, this.code, this.message, bubbles, cancelable);
        }// end function

        public function get item() : IBasketItem
        {
            return this._item;
        }// end function

        public function get message() : String
        {
            return this._message;
        }// end function

        public function get code() : String
        {
            return this._code;
        }// end function

    }
}
