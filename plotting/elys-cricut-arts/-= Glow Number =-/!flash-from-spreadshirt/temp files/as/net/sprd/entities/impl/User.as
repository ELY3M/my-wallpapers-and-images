package net.sprd.entities.impl
{

    public class User extends BaseEntity implements IUser
    {
        private var _name:String;
        private var _country:String;
        private var _language:String;
        private var _currency:String;
        private var _productTypes:Array;
        private var _printTypes:Array;
        private var _fontFamilies:Array;
        private var _productTypeDepartments:Array;
        private var _designCategories:Array;
        private var _designs:Array;
        private var _products:Array;
        private var _currencies:Array;
        private var _languages:Array;
        private var _countries:Array;
        private var _shops:Array;

        public function User()
        {
            this._productTypes = [];
            this._printTypes = [];
            this._fontFamilies = [];
            this._productTypeDepartments = [];
            this._designCategories = [];
            this._designs = [];
            this._products = [];
            this._currencies = [];
            this._languages = [];
            this._countries = [];
            this._shops = [];
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
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

        public function get language() : String
        {
            return this._language;
        }// end function

        public function set language(param1:String) : void
        {
            this._language = param1;
            return;
        }// end function

        public function get currency() : String
        {
            return this._currency;
        }// end function

        public function set currency(param1:String) : void
        {
            this._currency = param1;
            return;
        }// end function

        public function get productTypes() : Array
        {
            return null;
        }// end function

        public function set productTypes(param1:Array) : void
        {
            return;
        }// end function

        public function get printTypes() : Array
        {
            return null;
        }// end function

        public function set printTypes(param1:Array) : void
        {
            return;
        }// end function

        public function get fontFamilies() : Array
        {
            return null;
        }// end function

        public function set fontFamilies(param1:Array) : void
        {
            return;
        }// end function

        public function get productTypeDepartments() : Array
        {
            return null;
        }// end function

        public function set productTypeDepartments(param1:Array) : void
        {
            return;
        }// end function

        public function get designCategories() : Array
        {
            return null;
        }// end function

        public function set designCategories(param1:Array) : void
        {
            return;
        }// end function

        public function get designs() : Array
        {
            return null;
        }// end function

        public function set designs(param1:Array) : void
        {
            return;
        }// end function

        public function get products() : Array
        {
            return null;
        }// end function

        public function set products(param1:Array) : void
        {
            return;
        }// end function

        public function get currencies() : Array
        {
            return null;
        }// end function

        public function set currencies(param1:Array) : void
        {
            return;
        }// end function

        public function get languages() : Array
        {
            return null;
        }// end function

        public function set languages(param1:Array) : void
        {
            return;
        }// end function

        public function get countries() : Array
        {
            return null;
        }// end function

        public function set countries(param1:Array) : void
        {
            return;
        }// end function

        public function get shops() : Array
        {
            return null;
        }// end function

        public function set shops(param1:Array) : void
        {
            return;
        }// end function

    }
}
