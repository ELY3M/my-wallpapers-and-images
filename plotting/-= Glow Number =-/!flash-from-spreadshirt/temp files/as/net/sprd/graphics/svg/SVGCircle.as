package net.sprd.graphics.svg
{
    import flash.geom.*;

    public class SVGCircle extends SVGShape
    {
        private var _radius:Number;
        private var _center:Point;

        public function SVGCircle(param1:Number = 0, param2:Number = 0, param3:Number = 0)
        {
            this._center = new Point(param1, param2);
            this._radius = param3;
            return;
        }// end function

        override public function get height() : Number
        {
            return this._radius * 2;
        }// end function

        override public function set height(param1:Number) : void
        {
            if (this._radius == param1 / 2)
            {
                return;
            }
            this._radius = param1 / 2;
            markModified();
            return;
        }// end function

        override public function get width() : Number
        {
            return this._radius * 2;
        }// end function

        override public function set width(param1:Number) : void
        {
            if (this._radius == param1 / 2)
            {
                return;
            }
            this._radius = param1 / 2;
            markModified();
            return;
        }// end function

        public function get radius() : Number
        {
            return this._radius;
        }// end function

        public function set radius(param1:Number) : void
        {
            if (this._radius == param1)
            {
                return;
            }
            this._radius = param1;
            markModified();
            return;
        }// end function

        public function get center() : Point
        {
            return this._center;
        }// end function

        public function set center(param1:Point) : void
        {
            if (this._center == param1)
            {
                return;
            }
            this._center = param1;
            markModified();
            return;
        }// end function

        override public function clone(param1:ISVGShape = null) : ISVGShape
        {
            var _loc_2:* = param1 ? (SVGCircle(param1)) : (new SVGCircle());
            super.clone(_loc_2);
            _loc_2.radius = this.radius;
            _loc_2.center = this.center;
            return _loc_2;
        }// end function

    }
}
