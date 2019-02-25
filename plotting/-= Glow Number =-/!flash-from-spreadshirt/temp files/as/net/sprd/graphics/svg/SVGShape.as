package net.sprd.graphics.svg
{
    import flash.events.*;
    import net.sprd.entities.*;
    import net.sprd.graphics.svg.transformations.*;

    public class SVGShape extends EventDispatcher implements ISVGShape, IEventDispatcher
    {
        protected var _width:Number;
        protected var _height:Number;
        protected var _x:Number;
        protected var _y:Number;
        protected var _borderColor:Number;
        protected var _borderThickness:uint;
        protected var _fillColor:Number;
        protected var _printColors:Array;
        protected var _rgbColors:Array;
        protected var _transformations:Array;
        private var _modified:Boolean = true;

        public function SVGShape()
        {
            this._printColors = [];
            this._rgbColors = [];
            this._transformations = [];
            return;
        }// end function

        public function get x() : Number
        {
            return this._x;
        }// end function

        public function set x(param1:Number) : void
        {
            if (this._x == param1)
            {
                return;
            }
            this._x = param1;
            this.markModified();
            return;
        }// end function

        public function get y() : Number
        {
            return this._y;
        }// end function

        public function set y(param1:Number) : void
        {
            if (this._y == param1)
            {
                return;
            }
            this._y = param1;
            this.markModified();
            return;
        }// end function

        public function get width() : Number
        {
            return this._width;
        }// end function

        public function set width(param1:Number) : void
        {
            if (this._width == param1)
            {
                return;
            }
            this._width = param1;
            this.markModified();
            return;
        }// end function

        public function get height() : Number
        {
            return this._height;
        }// end function

        public function set height(param1:Number) : void
        {
            if (this._height == param1)
            {
                return;
            }
            this._height = param1;
            this.markModified();
            return;
        }// end function

        public function get borderColor() : Number
        {
            return this._borderColor;
        }// end function

        public function set borderColor(param1:Number) : void
        {
            if (this._borderColor == param1)
            {
                return;
            }
            this._borderColor = param1;
            this.markModified();
            return;
        }// end function

        public function get borderThickness() : uint
        {
            return this._borderThickness;
        }// end function

        public function set borderThickness(param1:uint) : void
        {
            if (this._borderThickness == param1)
            {
                return;
            }
            this._borderThickness = param1;
            this.markModified();
            return;
        }// end function

        public function get fillColor() : Number
        {
            return this._fillColor;
        }// end function

        public function set fillColor(param1:Number) : void
        {
            if (this.fillColor == param1)
            {
                return;
            }
            this._fillColor = param1;
            this.markModified();
            return;
        }// end function

        public function get printColors() : Array
        {
            return this._printColors;
        }// end function

        public function addPrintColor(param1:String) : void
        {
            this._printColors.push(param1);
            this.markModified();
            return;
        }// end function

        public function set printColors(param1:Array) : void
        {
            var values:* = param1;
            this._printColors = values.map(function (param1, param2:int, param3:Array) : String
            {
                if (param1 is IPrintColor)
                {
                    return IPrintColor(param1).id;
                }
                return param1;
            }// end function
            );
            this.markModified();
            return;
        }// end function

        public function get rgbColors() : Array
        {
            return this._rgbColors;
        }// end function

        public function set rgbColors(param1:Array) : void
        {
            this._rgbColors = param1;
            this.markModified();
            return;
        }// end function

        public function addRGBColor(param1:uint) : void
        {
            this._rgbColors.push(param1);
            this.markModified();
            return;
        }// end function

        public function addTransformation(param1:ISVGTransformation) : void
        {
            this._transformations.push(param1);
            this.markModified();
            return;
        }// end function

        public function get transformations() : Array
        {
            return this._transformations;
        }// end function

        public function set transformations(param1:Array) : void
        {
            this._transformations = param1;
            this.markModified();
            return;
        }// end function

        public function get modified() : Boolean
        {
            return this._modified;
        }// end function

        public function markModified(param1:Boolean = true) : void
        {
            this._modified = param1;
            return;
        }// end function

        public function clone(param1:ISVGShape = null) : ISVGShape
        {
            var _loc_3:ISVGTransformation;
            var _loc_4:uint;
            var _loc_5:String;
            var _loc_2:* = param1 ? (SVGShape(param1)) : (new SVGShape());
            _loc_2.width = this.width;
            _loc_2.height = this.height;
            _loc_2.x = this.x;
            _loc_2.y = this.y;
            _loc_2.borderColor = this.borderColor;
            _loc_2.borderThickness = this.borderThickness;
            _loc_2.fillColor = this.fillColor;
            for each (_loc_3 in this.transformations)
            {
                
                _loc_2.addTransformation(_loc_3.clone());
            }
            for each (_loc_4 in this.rgbColors)
            {
                
                _loc_2.addRGBColor(_loc_4);
            }
            for each (_loc_5 in this.printColors)
            {
                
                _loc_2.addPrintColor(_loc_5);
            }
            return _loc_2;
        }// end function

        public function equals(param1:ISVGShape) : Boolean
        {
            if (param1)
            {
            }
            if (this.borderColor == param1.borderColor)
            {
            }
            if (this.borderThickness == param1.borderThickness)
            {
            }
            if (this.fillColor == param1.fillColor)
            {
            }
            if (this.height == param1.height)
            {
            }
            if (this.width == param1.width)
            {
            }
            if (this.x == param1.x)
            {
            }
            return this.y == param1.y;
        }// end function

    }
}
