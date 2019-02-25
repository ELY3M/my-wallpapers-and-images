package net.sprd.entities
{

    public interface IProductTypeDepartment extends IBaseEntity
    {

        public function IProductTypeDepartment();

        function get name() : String;

        function set name(param1:String) : void;

        function get categories() : Array;

        function addCategory(param1:String) : void;

    }
}
