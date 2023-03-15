package net.sprd.graphics.svg
{

    public class SVGText extends SVGShape
    {
        private var _tspans:Array;
        private var _text:String;
        private var _fontStyle:String;
        private var _fontSize:Number;
        private var _fontWeight:String;
        private var _fontFamily:String;
        private var _fontFamilyID:String;
        private var _fontID:String;
        private var _textAnchor:String;
        private var _lineWidth:Number;
        private var _parentNode:SVGText;

        public function SVGText(param1:Number = 1.#QNAN, param2:Number = 1.#QNAN, param3:String = null)
        {
            this._tspans = [];
            this.text = param3;
            this.x = param1;
            this.y = param2;
            return;
        }// end function

        public function get text() : String
        {
            return this._text;
        }// end function

        public function set text(param1:String) : void
        {
            if (this._text == param1)
            {
                return;
            }
            this._text = param1;
            markModified();
            return;
        }// end function

        public function get rawText() : String
        {
            var _loc_2:SVGText;
            var _loc_1:* = this.text ? (this.text) : ("");
            for each (_loc_2 in this._tspans)
            {
                
                _loc_1 = _loc_1 + _loc_2.rawText;
            }
            return _loc_1;
        }// end function

        public function get fontStyle() : String
        {
            if (!this._fontStyle)
            {
            }
            if (this._parentNode)
            {
                return this._parentNode.fontStyle;
            }
            return this._fontStyle;
        }// end function

        public function set fontStyle(param1:String) : void
        {
            if (this._fontStyle == param1)
            {
                return;
            }
            this._fontStyle = param1;
            markModified();
            return;
        }// end function

        public function get fontSize() : Number
        {
            if (!this._fontSize)
            {
            }
            if (this._parentNode)
            {
                return this._parentNode.fontSize;
            }
            return this._fontSize;
        }// end function

        public function set fontSize(param1:Number) : void
        {
            if (this._fontSize == param1)
            {
                return;
            }
            this._fontSize = param1;
            markModified();
            return;
        }// end function

        public function get fontWeight() : String
        {
            if (!this._fontWeight)
            {
            }
            if (this._parentNode)
            {
                return this._parentNode.fontWeight;
            }
            return this._fontWeight;
        }// end function

        public function set fontWeight(param1:String) : void
        {
            if (this._fontWeight == param1)
            {
                return;
            }
            this._fontWeight = param1;
            markModified();
            return;
        }// end function

        public function get fontFamily() : String
        {
            if (!this._fontFamily)
            {
            }
            if (this._parentNode)
            {
                return this._parentNode.fontFamily;
            }
            return this._fontFamily;
        }// end function

        public function set fontFamily(param1:String) : void
        {
            if (this._fontFamily == param1)
            {
                return;
            }
            this._fontFamily = param1;
            markModified();
            return;
        }// end function

        public function get fontFamilyID() : String
        {
            if (!this._fontFamilyID)
            {
            }
            if (this._parentNode)
            {
                return this._parentNode.fontFamilyID;
            }
            return this._fontFamilyID;
        }// end function

        public function set fontFamilyID(param1:String) : void
        {
            if (this._fontFamilyID == param1)
            {
                return;
            }
            this._fontFamilyID = param1;
            markModified();
            return;
        }// end function

        public function get fontID() : String
        {
            if (!this._fontID)
            {
            }
            if (this._parentNode)
            {
                return this._parentNode.fontID;
            }
            return this._fontID;
        }// end function

        public function set fontID(param1:String) : void
        {
            if (this._fontID == param1)
            {
                return;
            }
            this._fontID = param1;
            markModified();
            return;
        }// end function

        public function get textAnchor() : String
        {
            if (!this._textAnchor)
            {
            }
            if (this._parentNode)
            {
                return this._parentNode.textAnchor;
            }
            return this._textAnchor;
        }// end function

        public function set textAnchor(param1:String) : void
        {
            if (this._textAnchor == param1)
            {
                return;
            }
            this._textAnchor = param1;
            markModified();
            return;
        }// end function

        public function get lineWidth() : Number
        {
            return this._lineWidth;
        }// end function

        public function set lineWidth(param1:Number) : void
        {
            if (this._lineWidth == param1)
            {
                return;
            }
            this._lineWidth = param1;
            markModified();
            return;
        }// end function

        public function get parent() : SVGText
        {
            return this._parentNode;
        }// end function

        public function set parent(param1:SVGText) : void
        {
            this._parentNode = param1;
            return;
        }// end function

        public function addTSpan(param1:SVGText) : void
        {
            param1.parent = this;
            this._tspans.push(param1);
            markModified();
            return;
        }// end function

        public function removeAllContents() : void
        {
            this._tspans = [];
            this._text = null;
            markModified();
            return;
        }// end function

        public function get tspans() : Array
        {
            return this._tspans;
        }// end function

        override public function get fillColor() : Number
        {
            var _loc_1:SVGText;
            if (isNaN(_fillColor))
            {
                isNaN(_fillColor);
            }
            if (this._parentNode)
            {
                return this._parentNode.fillColor;
            }
            if (isNaN(_fillColor))
            {
                isNaN(_fillColor);
            }
            if (!this._parentNode)
            {
            }
            if (this.tspans.length > 0)
            {
                for each (_loc_1 in this.tspans)
                {
                    
                    if (!isNaN(_loc_1._fillColor))
                    {
                        return _loc_1._fillColor;
                    }
                }
            }
            return _fillColor;
        }// end function

        override public function addPrintColor(param1:String) : void
        {
            if (_printColors.length > 0)
            {
            }
            if (_printColors[0] == param1)
            {
                return;
            }
            _printColors = [param1];
            markModified();
            return;
        }// end function

        override public function get printColors() : Array
        {
            if (super.printColors.length === 0)
            {
            }
            if (this._parentNode)
            {
                return this._parentNode.printColors;
            }
            return super.printColors;
        }// end function

        override public function get rgbColors() : Array
        {
            return [this.fillColor];
        }// end function

        override public function set rgbColors(param1:Array) : void
        {
            fillColor = param1[0];
            super.rgbColors = param1;
            return;
        }// end function

        override public function addRGBColor(param1:uint) : void
        {
            if (_rgbColors.length > 0)
            {
            }
            if (_rgbColors[0] == param1)
            {
                return;
            }
            _rgbColors = [param1];
            markModified();
            return;
        }// end function

        override public function clone(param1:ISVGShape = null) : ISVGShape
        {
            var _loc_3:SVGText;
            var _loc_4:SVGText;
            var _loc_2:* = param1 ? (SVGText(param1)) : (new SVGText());
            super.clone(_loc_2);
            for each (_loc_3 in this.tspans)
            {
                
                _loc_4 = SVGText(_loc_3.clone());
                _loc_4.parent = _loc_2;
                _loc_2.addTSpan(_loc_4);
            }
            _loc_2.text = this.text;
            _loc_2.fontFamilyID = this.fontFamilyID;
            _loc_2.fontStyle = this.fontStyle;
            _loc_2.fontSize = this.fontSize;
            _loc_2.fontWeight = this.fontWeight;
            _loc_2.fontFamily = this.fontFamily;
            _loc_2.fontID = this.fontID;
            _loc_2.textAnchor = this.textAnchor;
            _loc_2.lineWidth = this.lineWidth;
            return _loc_2;
        }// end function

        override public function equals(param1:ISVGShape) : Boolean
        {
            return super.equals(param1);
        }// end function

    }
}
