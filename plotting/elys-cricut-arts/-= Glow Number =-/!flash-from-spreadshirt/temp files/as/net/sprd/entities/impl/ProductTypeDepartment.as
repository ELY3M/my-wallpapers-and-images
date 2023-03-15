package net.sprd.entities.impl
{

    public class ProductTypeDepartment extends BaseEntity implements IProductTypeDepartment
    {
        private var _name:String;
        private var _categories:Array;

        public function ProductTypeDepartment()
        {
            this._categories = [];
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

        public function get categories() : Array
        {
            return this._categories;
        }// end function

        public function addCategory(param1:String) : void
        {
            this._categories.push(param1);
            return;
        }// end function

    }
}
