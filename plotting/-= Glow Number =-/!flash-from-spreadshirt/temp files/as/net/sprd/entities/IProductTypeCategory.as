package net.sprd.entities
{

    public interface IProductTypeCategory extends IBaseEntity
    {

        public function IProductTypeCategory();

        function get name() : String;

        function set name(param1:String) : void;

        function get productTypes() : Array;

        function addProductType(param1:String) : void;

        function get department() : String;

        function set department(param1:String) : void;

    }
}
