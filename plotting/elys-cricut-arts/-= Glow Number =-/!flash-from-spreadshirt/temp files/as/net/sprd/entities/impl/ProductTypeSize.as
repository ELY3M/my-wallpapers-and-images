package net.sprd.entities.impl
{

    public class ProductTypeSize extends BaseEntity implements IProductTypeSize
    {
        private var _name:String;

        public function ProductTypeSize(param1:String, param2:String)
        {
            this.id = param1;
            this._name = param2;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        override public function toString() : String
        {
            return this.name;
        }// end function

    }
}
