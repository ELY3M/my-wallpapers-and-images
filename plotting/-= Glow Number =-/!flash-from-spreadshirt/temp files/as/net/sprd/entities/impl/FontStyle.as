package net.sprd.entities.impl
{

    public class FontStyle extends BaseEntity implements IFontStyle
    {
        private var _weight:String;
        private var _style:String;
        private var _minSize:Number;
        private var _fontFamilyID:String;
        private var _filePath:String;
        private var _name:String;

        public function FontStyle()
        {
            return;
        }// end function

        public function get weight() : String
        {
            return this._weight;
        }// end function

        public function set weight(param1:String) : void
        {
            this._weight = param1;
            return;
        }// end function

        public function get style() : String
        {
            return this._style;
        }// end function

        public function set style(param1:String) : void
        {
            this._style = param1;
            return;
        }// end function

        public function get minSize() : Number
        {
            return this._minSize;
        }// end function

        public function set minSize(param1:Number) : void
        {
            this._minSize = param1;
            return;
        }// end function

        public function get fontFamily() : String
        {
            return this._fontFamilyID;
        }// end function

        public function set fontFamily(param1:String) : void
        {
            this._fontFamilyID = param1;
            return;
        }// end function

        public function get fontFilePath() : String
        {
            return this._filePath;
        }// end function

        public function set fontFilePath(param1:String) : void
        {
            this._filePath = param1;
            return;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

    }
}
