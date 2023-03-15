package net.sprd.entities
{

    public interface IDesignCategory extends IBaseEntity
    {

        public function IDesignCategory();

        function get name() : String;

        function set name(param1:String) : void;

        function get type() : String;

        function set type(param1:String) : void;

        function get weight() : Number;

        function set weight(param1:Number) : void;

        function get bestsellers() : String;

        function set bestsellers(param1:String) : void;

        function addSubCategory(param1:String) : void;

        function get subCategories() : Array;

        function getEntryCount(param1:String) : uint;

        function setEntryCount(param1:String, param2:uint) : void;

    }
}
