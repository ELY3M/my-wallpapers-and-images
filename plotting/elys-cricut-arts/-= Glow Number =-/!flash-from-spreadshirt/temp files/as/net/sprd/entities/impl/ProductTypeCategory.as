package net.sprd.entities.impl
{

    public class ProductTypeCategory extends BaseEntity implements IProductTypeCategory
    {
        private var _name:String;
        private var _productTypes:Array;
        private var _department:String;

        public function ProductTypeCategory()
        {
            this._productTypes = [];
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

        public function get productTypes() : Array
        {
            return this._productTypes;
        }// end function

        public function addProductType(param1:String) : void
        {
            this._productTypes.push(param1);
            return;
        }// end function

        public function set department(param1:String) : void
        {
            this._department = param1;
            return;
        }// end function

        public function get department() : String
        {
            return this._department;
        }// end function

    }
}
