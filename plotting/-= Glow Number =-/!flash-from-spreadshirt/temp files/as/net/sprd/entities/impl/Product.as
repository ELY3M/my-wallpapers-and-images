package net.sprd.entities.impl
{
    import net.sprd.entities.*;

    public class Product extends BaseEntity implements IProduct
    {
        private var _name:String;
        private var _user:String;
        private var _productType:String;
        private var _productTypeAppearance:String;
        private var _allowsFreeColorSelection:Boolean;
        private var _isExample:Boolean;
        private var _configurations:Array;
        private var _defaultView:String;
        private var _token:String;

        public function Product()
        {
            this._configurations = [];
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            if (this._name == param1)
            {
                return;
            }
            this._name = param1;
            markModified();
            return;
        }// end function

        public function get user() : String
        {
            return this._user;
        }// end function

        public function set user(param1:String) : void
        {
            if (this._user == param1)
            {
                return;
            }
            this._user = param1;
            markModified();
            return;
        }// end function

        public function get productType() : String
        {
            return this._productType;
        }// end function

        public function set productType(param1:String) : void
        {
            if (this._productType == param1)
            {
                return;
            }
            this._productType = param1;
            markModified();
            return;
        }// end function

        public function get productTypeAppearance() : String
        {
            return this._productTypeAppearance;
        }// end function

        public function set productTypeAppearance(param1:String) : void
        {
            if (this._productTypeAppearance == param1)
            {
                return;
            }
            this._productTypeAppearance = param1;
            markModified();
            return;
        }// end function

        public function get allowsFreeColorSelection() : Boolean
        {
            return this._allowsFreeColorSelection;
        }// end function

        public function set allowsFreeColorSelection(param1:Boolean) : void
        {
            if (this._allowsFreeColorSelection == param1)
            {
                return;
            }
            this._allowsFreeColorSelection = param1;
            markModified();
            return;
        }// end function

        public function get isExample() : Boolean
        {
            return this._isExample;
        }// end function

        public function set isExample(param1:Boolean) : void
        {
            if (this._isExample == param1)
            {
                return;
            }
            this._isExample = param1;
            markModified();
            return;
        }// end function

        public function get configurations() : Array
        {
            return this._configurations;
        }// end function

        public function addConfiguration(param1:IConfiguration) : void
        {
            this._configurations.push(param1);
            markModified();
            return;
        }// end function

        public function getConfigurationById(param1:String) : IConfiguration
        {
            var _loc_2:IConfiguration;
            for each (_loc_2 in this.configurations)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function get defaultView() : String
        {
            return this._defaultView;
        }// end function

        public function set defaultView(param1:String) : void
        {
            if (this._defaultView == param1)
            {
                return;
            }
            this._defaultView = param1;
            markModified();
            return;
        }// end function

        public function clone() : IProduct
        {
            var _loc_2:IConfiguration;
            var _loc_1:* = new Product();
            _loc_1.id = id;
            _loc_1.state = state;
            _loc_1.resource = resource;
            _loc_1.name = this.name;
            _loc_1.user = this.user;
            _loc_1.productType = this.productType;
            _loc_1.productTypeAppearance = this.productTypeAppearance;
            _loc_1.allowsFreeColorSelection = this.allowsFreeColorSelection;
            _loc_1.isExample = this.isExample;
            _loc_1.defaultView = this.defaultView;
            for each (_loc_2 in this.configurations)
            {
                
                _loc_1.configurations.push(_loc_2.clone());
            }
            return _loc_1;
        }// end function

        public function set token(param1:String) : void
        {
            this._token = param1;
            return;
        }// end function

        public function get token() : String
        {
            return this._token;
        }// end function

    }
}
