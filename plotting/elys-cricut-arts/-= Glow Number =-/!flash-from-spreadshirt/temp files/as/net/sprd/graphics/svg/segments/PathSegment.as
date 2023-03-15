package net.sprd.graphics.svg.segments
{
    import flash.display.*;
    import flash.geom.*;

    public class PathSegment extends Object implements IPathSegment
    {
        private var _isRelative:Boolean = false;
        private var _viewScale:Number = 1;
        protected var _startPoint:Point;
        protected var _target:Point;
        public static const MOVETO:String = "moveTo";
        public static const LINETO:String = "lineTo";
        public static const CURVETO_QUADRATIC:String = "curveTo_quad";
        public static const CLOSE:String = "close";

        public function PathSegment(param1:Number = 0, param2:Number = 0)
        {
            this._startPoint = new Point(0, 0);
            this._target = new Point(param1, param2);
            return;
        }// end function

        public function get type() : String
        {
            throw new Error("Overwrite me");
        }// end function

        public function get isRelative() : Boolean
        {
            return this._isRelative;
        }// end function

        public function set isRelative(param1:Boolean) : void
        {
            this._isRelative = param1;
            return;
        }// end function

        public function get viewScale() : Number
        {
            return this._viewScale;
        }// end function

        public function set viewScale(param1:Number) : void
        {
            this._viewScale = param1;
            return;
        }// end function

        public function draw(param1:Graphics) : void
        {
            throw new Error("Overwrite me");
        }// end function

        public function get endPoint() : Point
        {
            return this._target;
        }// end function

        public function get startPoint() : Point
        {
            return this._startPoint;
        }// end function

        public function set startPoint(param1:Point) : void
        {
            this._startPoint = param1.clone();
            return;
        }// end function

        public function set target(param1:Point) : void
        {
            this._target = param1.clone();
            return;
        }// end function

        public function get svgString() : String
        {
            throw new Error("Overwrite me");
        }// end function

        public function clone(param1:IPathSegment = null) : IPathSegment
        {
            var _loc_2:* = param1 ? (PathSegment(param1)) : (new PathSegment());
            _loc_2.isRelative = this.isRelative;
            _loc_2.startPoint = this.startPoint;
            _loc_2.viewScale = this.viewScale;
            _loc_2.target = this._target;
            return _loc_2;
        }// end function

    }
}
