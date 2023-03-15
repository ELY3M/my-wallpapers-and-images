package net.sprd.entities
{

    public interface IShop extends IBaseEntity
    {

        public function IShop();

        function get user() : String;

        function set user(param1:String) : void;

        function get country() : String;

        function set country(param1:String) : void;

        function get language() : String;

        function set language(param1:String) : void;

        function get currency() : String;

        function set currency(param1:String) : void;

    }
}
