package net.sprd.graphics.svg.segments
{
    import flash.display.*;
    import flash.geom.*;

    public class QuadraticBezier extends PathSegment
    {
        private var _control:Point;

        public function QuadraticBezier(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0)
        {
            super(param3, param4);
            this._control = new Point(param1, param2);
            return;
        }// end function

        public function get control() : Point
        {
            return this._control;
        }// end function

        public function set control(param1:Point) : void
        {
            this._control = param1.clone();
            return;
        }// end function

        override public function get type() : String
        {
            return PathSegment.CURVETO_QUADRATIC;
        }// end function

        override public function draw(param1:Graphics) : void
        {
            param1.curveTo(this._control.x * viewScale, this._control.y * viewScale, endPoint.x * viewScale, endPoint.y * viewScale);
            return;
        }// end function

        override public function get svgString() : String
        {
            return "Q" + this._control.x + " " + this._control.y + " " + _target.x + " " + _target.y;
        }// end function

        override public function clone(param1:IPathSegment = null) : IPathSegment
        {
            var _loc_2:* = param1 ? (QuadraticBezier(param1)) : (new QuadraticBezier());
            super.clone(_loc_2);
            _loc_2.control = this.control;
            return _loc_2;
        }// end function

    }
}
