package net.sprd.entities.impl
{
    import flash.utils.*;
    import net.sprd.common.collections.*;
    import net.sprd.entities.*;
    import net.sprd.valueObjects.*;

    public class ProductType extends BaseEntity implements IProductType
    {
        private var _name:String;
        private var _lifeCycleState:int = 1;
        private var _description:String;
        private var _brand:String;
        private var _price:Money;
        private var _defaultView:IProductTypeView;
        private var _defaultAppearance:IProductTypeAppearance;
        private var _appearances:Array;
        private var _sizes:Array;
        private var _views:Array;
        private var _printAreas:ICollection;
        private var _productTypeCategories:ICollection;
        private var _stockStates:Dictionary;
        private var _attributes:Array;

        public function ProductType()
        {
            this._price = new Money(0, "1");
            this._appearances = [];
            this._sizes = [];
            this._views = [];
            this._attributes = [];
            this._printAreas = new ArrayList();
            this._productTypeCategories = new ArrayList();
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

        public function get description() : String
        {
            return this._description;
        }// end function

        public function set description(param1:String) : void
        {
            this._description = param1;
            return;
        }// end function

        public function get brand() : String
        {
            return this._brand;
        }// end function

        public function set brand(param1:String) : void
        {
            this._brand = param1;
            return;
        }// end function

        public function get price() : Money
        {
            return this._price;
        }// end function

        public function set price(param1:Money) : void
        {
            this._price = param1;
            return;
        }// end function

        public function get defaultAppearance() : IProductTypeAppearance
        {
            var _loc_1:* = this._appearances.indexOf(this._defaultAppearance);
            if (_loc_1 != -1)
            {
                return this._appearances[_loc_1];
            }
            return this._appearances[0];
        }// end function

        public function set defaultAppearance(param1:IProductTypeAppearance) : void
        {
            this._defaultAppearance = param1;
            return;
        }// end function

        public function setDefaultAppearanceById(param1:String) : void
        {
            var _loc_2:IProductTypeAppearance;
            for each (_loc_2 in this._appearances)
            {
                
                if (_loc_2.id == param1)
                {
                    this._defaultAppearance = _loc_2;
                    return;
                }
            }
            this._defaultAppearance = this._appearances[0];
            return;
        }// end function

        public function getAppearanceById(param1:String) : IProductTypeAppearance
        {
            var _loc_2:IProductTypeAppearance;
            for each (_loc_2 in this._appearances)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function get appearances() : Array
        {
            return this._appearances;
        }// end function

        public function addAppearance(param1:IProductTypeAppearance) : void
        {
            this._appearances.push(param1);
            return;
        }// end function

        public function get sizes() : Array
        {
            return this._sizes;
        }// end function

        public function addSize(param1:IProductTypeSize) : void
        {
            this._sizes.push(param1);
            return;
        }// end function

        public function getSizeById(param1:String) : IProductTypeSize
        {
            var _loc_2:IProductTypeSize;
            for each (_loc_2 in this._sizes)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function addAttribute(param1:IProductTypeAttribute) : void
        {
            this._attributes.push(param1);
            return;
        }// end function

        public function get views() : Array
        {
            return this._views;
        }// end function

        public function addView(param1:IProductTypeView) : void
        {
            this._views.push(param1);
            return;
        }// end function

        public function get defaultView() : IProductTypeView
        {
            var _loc_1:* = this._views.indexOf(this._defaultView);
            if (_loc_1 != -1)
            {
                return this._views[_loc_1];
            }
            return this._views[0];
        }// end function

        public function setDefaultViewById(param1:String) : void
        {
            var _loc_2:IProductTypeView;
            for each (_loc_2 in this._views)
            {
                
                if (_loc_2.id == param1)
                {
                    this._defaultView = _loc_2;
                    return;
                }
            }
            this._defaultView = this._views[0];
            return;
        }// end function

        public function getViewById(param1:String) : IProductTypeView
        {
            var _loc_2:IProductTypeView;
            for each (_loc_2 in this._views)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function get printAreas() : Array
        {
            return this._printAreas.toArray();
        }// end function

        public function addPrintArea(param1:String) : void
        {
            this._printAreas.add(param1);
            return;
        }// end function

        public function isOnStock(param1:String, param2:String) : Boolean
        {
            return Boolean(this._stockStates[param1 + "_" + param2]);
        }// end function

        public function setOnStock(param1:String, param2:String, param3:Boolean) : void
        {
            if (!this._stockStates)
            {
                this._stockStates = new Dictionary();
            }
            this._stockStates[param1 + "_" + param2] = param3;
            return;
        }// end function

        public function get stockStates() : Dictionary
        {
            return this._stockStates;
        }// end function

        public function isValid() : Boolean
        {
            var _loc_2:Boolean;
            var _loc_1:Boolean;
            for each (_loc_2 in this.stockStates)
            {
                
                if (_loc_2)
                {
                    _loc_1 = _loc_2;
                    break;
                }
            }
            if (_loc_1)
            {
            }
            if (this.appearances.length != 0)
            {
            }
            if (this.sizes.length != 0)
            {
            }
            if (this.views.length != 0)
            {
            }
            return this.printAreas.length != 0;
        }// end function

        public function get lifeCycleState() : int
        {
            return this._lifeCycleState;
        }// end function

        public function set lifeCycleState(param1:int) : void
        {
            this._lifeCycleState = param1;
            return;
        }// end function

        public function get attributes() : Array
        {
            return this._attributes;
        }// end function

    }
}
