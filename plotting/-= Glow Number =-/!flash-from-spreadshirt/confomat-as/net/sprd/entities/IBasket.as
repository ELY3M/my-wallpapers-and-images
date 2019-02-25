package net.sprd.entities
{

    public interface IBasket extends IBaseEntity
    {

        public function IBasket();

        function get token() : String;

        function set token(param1:String) : void;

        function get user() : String;

        function set user(param1:String) : void;

        function get shop() : String;

        function set shop(param1:String) : void;

        function get country() : String;

        function set country(param1:String) : void;

        function get basketItems() : Array;

        function addBasketItem(param1:String) : void;

        function removeBasketItem(param1:String) : void;

    }
}
