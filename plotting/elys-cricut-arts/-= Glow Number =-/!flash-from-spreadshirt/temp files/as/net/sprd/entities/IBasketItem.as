package net.sprd.entities
{
    import net.sprd.valueObjects.*;

    public interface IBasketItem extends IBaseEntity
    {

        public function IBasketItem();

        function get shop() : String;

        function set shop(param1:String) : void;

        function get quantity() : uint;

        function set quantity(param1:uint) : void;

        function get elementID() : String;

        function set elementID(param1:String) : void;

        function get elementType() : String;

        function set elementType(param1:String) : void;

        function get appearance() : String;

        function set appearance(param1:String) : void;

        function get size() : String;

        function set size(param1:String) : void;

        function get price() : Money;

        function set price(param1:Money) : void;

        function get basket() : String;

        function set basket(param1:String) : void;

        function set oldProductId(param1:String) : void;

        function get oldProductId() : String;

        function get editBasketItemBaseUrl() : String;

        function set editBasketItemBaseUrl(param1:String) : void;

    }
}
