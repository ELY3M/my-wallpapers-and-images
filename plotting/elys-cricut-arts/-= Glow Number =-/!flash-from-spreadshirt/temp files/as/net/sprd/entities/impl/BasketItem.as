package net.sprd.entities.impl
{
    import net.sprd.valueObjects.*;

    public class BasketItem extends BaseEntity implements IBasketItem
    {
        private var _shop:String;
        private var _quantity:uint = 0;
        private var _elementID:String;
        private var _elementType:String;
        private var _price:Money;
        private var _basket:String;
        private var _appearance:String;
        private var _size:String;
        private var _oldProductId:String;
        private var _editBasketItemBaseUrl:String;

        public function BasketItem()
        {
            return;
        }// end function

        public function get shop() : String
        {
            return this._shop;
        }// end function

        public function set shop(param1:String) : void
        {
            this._shop = param1;
            return;
        }// end function

        public function get quantity() : uint
        {
            return this._quantity;
        }// end function

        public function set quantity(param1:uint) : void
        {
            if (this._quantity == param1)
            {
                return;
            }
            this._quantity = param1;
            markModified();
            return;
        }// end function

        public function get elementID() : String
        {
            return this._elementID;
        }// end function

        public function set elementID(param1:String) : void
        {
            if (this._elementID == param1)
            {
                return;
            }
            this._elementID = param1;
            markModified();
            return;
        }// end function

        public function get elementType() : String
        {
            return this._elementType;
        }// end function

        public function set elementType(param1:String) : void
        {
            if (this._elementType == param1)
            {
                return;
            }
            this._elementType = param1;
            markModified();
            return;
        }// end function

        public function get price() : Money
        {
            return this._price;
        }// end function

        public function set price(param1:Money) : void
        {
            this._price = param1;
            return;
        }// end function

        public function get basket() : String
        {
            return this._basket;
        }// end function

        public function set basket(param1:String) : void
        {
            this._basket = param1;
            return;
        }// end function

        override public function get immutable() : Boolean
        {
            return false;
        }// end function

        public function get appearance() : String
        {
            return this._appearance;
        }// end function

        public function set appearance(param1:String) : void
        {
            if (param1 == this._appearance)
            {
                return;
            }
            this._appearance = param1;
            markModified();
            return;
        }// end function

        public function get size() : String
        {
            return this._size;
        }// end function

        public function set size(param1:String) : void
        {
            if (param1 == this._size)
            {
                return;
            }
            this._size = param1;
            markModified();
            return;
        }// end function

        public function get oldProductId() : String
        {
            return this._oldProductId;
        }// end function

        public function set oldProductId(param1:String) : void
        {
            this._oldProductId = param1;
            return;
        }// end function

        public function set editBasketItemBaseUrl(param1:String) : void
        {
            this._editBasketItemBaseUrl = param1;
            return;
        }// end function

        public function get editBasketItemBaseUrl() : String
        {
            return this._editBasketItemBaseUrl;
        }// end function

    }
}
