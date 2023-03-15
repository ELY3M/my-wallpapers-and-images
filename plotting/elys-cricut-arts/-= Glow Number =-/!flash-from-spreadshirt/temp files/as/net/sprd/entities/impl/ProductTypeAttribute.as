package net.sprd.entities.impl
{

    public class ProductTypeAttribute extends BaseEntity implements IProductTypeAttribute
    {
        private var _name:String;
        private var _description:String;
        private var _key:String;

        public function ProductTypeAttribute(param1:String, param2:String, param3:String, param4:String)
        {
            this.id = param1;
            this._key = param2;
            this._name = param3;
            this._description = param4;
            return;
        }// end function

        public function get key() : String
        {
            return this._key;
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

        override public function toString() : String
        {
            return super.toString();
        }// end function

    }
}
