package net.sprd.entities.impl
{
    import flash.utils.*;

    public class DesignCategory extends BaseEntity implements IDesignCategory
    {
        private var _name:String;
        private var _type:String;
        private var _weight:Number;
        private var _bestsellers:String;
        private var _subCategories:Array;
        private var entryCount:Dictionary;

        public function DesignCategory()
        {
            this._subCategories = [];
            this.entryCount = new Dictionary();
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

        public function set type(param1:String) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get type() : String
        {
            return this._type;
        }// end function

        public function get weight() : Number
        {
            return this._weight;
        }// end function

        public function set weight(param1:Number) : void
        {
            this._weight = param1;
            return;
        }// end function

        public function get bestsellers() : String
        {
            return this._bestsellers;
        }// end function

        public function set bestsellers(param1:String) : void
        {
            this._bestsellers = param1;
            return;
        }// end function

        public function addSubCategory(param1:String) : void
        {
            this._subCategories.push(param1);
            return;
        }// end function

        public function get subCategories() : Array
        {
            return this._subCategories;
        }// end function

        public function getEntryCount(param1:String) : uint
        {
            return this.entryCount[param1];
        }// end function

        public function setEntryCount(param1:String, param2:uint) : void
        {
            this.entryCount[param1] = param2;
            return;
        }// end function

    }
}
