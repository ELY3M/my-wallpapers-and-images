package net.sprd.entities
{

    public interface IUser extends IBaseEntity
    {

        public function IUser();

        function get name() : String;

        function set name(param1:String) : void;

        function get country() : String;

        function set country(param1:String) : void;

        function get language() : String;

        function set language(param1:String) : void;

        function get currency() : String;

        function set currency(param1:String) : void;

        function get productTypes() : Array;

        function set productTypes(param1:Array) : void;

        function get printTypes() : Array;

        function set printTypes(param1:Array) : void;

        function get fontFamilies() : Array;

        function set fontFamilies(param1:Array) : void;

        function get productTypeDepartments() : Array;

        function set productTypeDepartments(param1:Array) : void;

        function get designCategories() : Array;

        function set designCategories(param1:Array) : void;

        function get designs() : Array;

        function set designs(param1:Array) : void;

        function get products() : Array;

        function set products(param1:Array) : void;

        function get currencies() : Array;

        function set currencies(param1:Array) : void;

        function get languages() : Array;

        function set languages(param1:Array) : void;

        function get countries() : Array;

        function set countries(param1:Array) : void;

        function get shops() : Array;

        function set shops(param1:Array) : void;

    }
}
