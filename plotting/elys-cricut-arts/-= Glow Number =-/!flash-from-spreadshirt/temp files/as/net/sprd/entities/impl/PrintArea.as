package net.sprd.entities.impl
{
    import net.sprd.common.collections.*;
    import net.sprd.graphics.svg.*;

    public class PrintArea extends BaseEntity implements IPrintArea
    {
        private var _appearanceColorIndex:uint;
        private var _width:Number;
        private var _height:Number;
        private var _defaultView:String;
        private var _allowsText:Boolean = true;
        private var _allowsDesign:Boolean = true;
        private var _excludedPrintTypes:ICollection;
        private var _hardBoundary:ISVGShape;
        private var _softBoundary:ISVGShape;
        private var _defaultPositioningBox:SVGRect;
        private var _defaultPositioningHorizontalAlignment:String = "middle";
        private var _defaultPositioningVerticalAlignment:String = "start";
        private var _defaultPositioningCanRotate:int = 0;

        public function PrintArea()
        {
            this._excludedPrintTypes = new ArrayList();
            return;
        }// end function

        public function get appearanceColorIndex() : uint
        {
            return this._appearanceColorIndex;
        }// end function

        public function set appearanceColorIndex(param1:uint) : void
        {
            this._appearanceColorIndex = param1;
            return;
        }// end function

        public function get width() : Number
        {
            return this._width;
        }// end function

        public function set width(param1:Number) : void
        {
            this._width = param1;
            return;
        }// end function

        public function get height() : Number
        {
            return this._height;
        }// end function

        public function set height(param1:Number) : void
        {
            this._height = param1;
            return;
        }// end function

        public function get defaultView() : String
        {
            return this._defaultView;
        }// end function

        public function set defaultView(param1:String) : void
        {
            this._defaultView = param1;
            return;
        }// end function

        public function get allowsText() : Boolean
        {
            return this._allowsText;
        }// end function

        public function set allowsText(param1:Boolean) : void
        {
            this._allowsText = param1;
            return;
        }// end function

        public function get allowsDesign() : Boolean
        {
            return this._allowsDesign;
        }// end function

        public function set allowsDesign(param1:Boolean) : void
        {
            this._allowsDesign = param1;
            return;
        }// end function

        public function get excludedPrintTypes() : Array
        {
            return this._excludedPrintTypes.toArray();
        }// end function

        public function excludePrintType(param1:String) : void
        {
            this._excludedPrintTypes.add(param1);
            return;
        }// end function

        public function includePrintType(param1:String) : void
        {
            this._excludedPrintTypes.remove(param1);
            return;
        }// end function

        public function get hardBoundary() : ISVGShape
        {
            if (this._softBoundary)
            {
                return this._softBoundary;
            }
            if (!this._hardBoundary)
            {
                return new SVGRect(0, 0, this.width, this.height);
            }
            return this._hardBoundary;
        }// end function

        public function set hardBoundary(param1:ISVGShape) : void
        {
            this._hardBoundary = param1;
            return;
        }// end function

        public function get softBoundary() : ISVGShape
        {
            if (!this._softBoundary)
            {
                return this.hardBoundary;
            }
            return this._softBoundary;
        }// end function

        public function set softBoundary(param1:ISVGShape) : void
        {
            this._softBoundary = param1;
            return;
        }// end function

        public function set defaultPositioningBox(param1:SVGRect) : void
        {
            this._defaultPositioningBox = param1;
            return;
        }// end function

        public function set defaultPositioningHorizontalAlignment(param1:String) : void
        {
            this._defaultPositioningHorizontalAlignment = param1;
            return;
        }// end function

        public function set defaultPositioningVerticalAlignment(param1:String) : void
        {
            this._defaultPositioningVerticalAlignment = param1;
            return;
        }// end function

        public function set defaultPositioningCanRotate(param1:int) : void
        {
            this._defaultPositioningCanRotate = param1;
            return;
        }// end function

        public function get defaultPositioningBox() : SVGRect
        {
            var _loc_1:ISVGShape;
            var _loc_2:SVGRect;
            var _loc_3:Number;
            var _loc_4:Number;
            var _loc_5:Number;
            var _loc_6:Number;
            if (!this._defaultPositioningBox)
            {
                _loc_1 = this.hardBoundary;
                if (!(_loc_1 is SVGRect))
                {
                    throw new Error("Non rectangular hard boundaries require an " + "explicitely specified default positioning box.");
                }
                _loc_2 = SVGRect(_loc_1.clone());
                _loc_3 = _loc_2.x;
                _loc_4 = _loc_2.y;
                _loc_5 = _loc_2.width;
                _loc_6 = _loc_2.height;
                _loc_2.x = _loc_3 + _loc_5 / 6;
                _loc_2.y = _loc_4 + _loc_6 / 7;
                _loc_2.width = _loc_5 / 1.5;
                _loc_2.height = _loc_6 / 2;
                return _loc_2;
            }
            return this._defaultPositioningBox;
        }// end function

        public function get defaultPositioningHorizontalAlignment() : String
        {
            return this._defaultPositioningHorizontalAlignment;
        }// end function

        public function get defaultPositioningVerticalAlignment() : String
        {
            return this._defaultPositioningVerticalAlignment;
        }// end function

        public function get defaultPositioningCanRotate() : int
        {
            return this._defaultPositioningCanRotate;
        }// end function

    }
}
