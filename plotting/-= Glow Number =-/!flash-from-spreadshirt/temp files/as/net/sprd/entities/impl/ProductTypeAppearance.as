package net.sprd.entities.impl
{

    public class ProductTypeAppearance extends BaseEntity implements IProductTypeAppearance
    {
        private var _name:String;
        private var _colors:Array;
        private var _printTypes:Array;
        private var _previewURI:String;

        public function ProductTypeAppearance(param1:String, param2:String)
        {
            this._colors = [];
            this._printTypes = [];
            this.id = param1;
            this._name = param2;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get colors() : Array
        {
            return this._colors;
        }// end function

        public function addColor(param1:String) : void
        {
            this._colors.push(param1);
            return;
        }// end function

        public function get printTypes() : Array
        {
            return this._printTypes;
        }// end function

        public function addPrintType(param1:String) : void
        {
            this._printTypes.push(param1);
            return;
        }// end function

        public function get previewURI() : String
        {
            return this._previewURI;
        }// end function

        public function set previewURI(param1:String) : void
        {
            this._previewURI = param1;
            return;
        }// end function

    }
}
