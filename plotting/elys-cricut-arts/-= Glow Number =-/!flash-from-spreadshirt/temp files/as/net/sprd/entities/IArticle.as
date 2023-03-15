package net.sprd.entities
{
    import net.sprd.valueObjects.*;

    public interface IArticle extends IBaseEntity
    {

        public function IArticle();

        function get name() : String;

        function set name(param1:String) : void;

        function get description() : String;

        function set description(param1:String) : void;

        function get price() : Money;

        function set price(param1:Money) : void;

        function get shop() : String;

        function set shop(param1:String) : void;

        function get product() : String;

        function set product(param1:String) : void;

    }
}
