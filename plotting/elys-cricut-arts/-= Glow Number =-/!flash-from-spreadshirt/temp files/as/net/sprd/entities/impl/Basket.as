package net.sprd.entities.impl
{

    public class Basket extends BaseEntity implements IBasket
    {
        private var _token:String;
        private var _user:String;
        private var _shop:String;
        private var _country:String;
        private var _basketItems:Array;

        public function Basket()
        {
            this._basketItems = [];
            return;
        }// end function

        public function get token() : String
        {
            return this._token;
        }// end function

        public function set token(param1:String) : void
        {
            this._token = param1;
            return;
        }// end function

        public function get user() : String
        {
            return this._user;
        }// end function

        public function set user(param1:String) : void
        {
            this._user = param1;
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

        public function get country() : String
        {
            return this._country;
        }// end function

        public function set country(param1:String) : void
        {
            this._country = param1;
            return;
        }// end function

        public function get basketItems() : Array
        {
            return this._basketItems;
        }// end function

        public function addBasketItem(param1:String) : void
        {
            this._basketItems.push(param1);
            return;
        }// end function

        public function removeBasketItem(param1:String) : void
        {
            var _loc_2:* = this._basketItems.indexOf(param1);
            if (_loc_2 >= 0)
            {
                this._basketItems.splice(_loc_2, 1);
            }
            return;
        }// end function

    }
}
