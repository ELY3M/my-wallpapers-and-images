package net.sprd.graphics.svg
{
    import flash.geom.*;

    public class SVGLine extends SVGShape
    {
        private var _start:Point;
        private var _end:Point;

        public function SVGLine(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0)
        {
            this._start = new Point(param1, param2);
            this._end = new Point(param3, param4);
            return;
        }// end function

        public function get start() : Point
        {
            return this._start;
        }// end function

        public function set start(param1:Point) : void
        {
            if (this._start.equals(param1))
            {
                return;
            }
            this._start = param1.clone();
            markModified();
            return;
        }// end function

        public function get end() : Point
        {
            return this._end;
        }// end function

        public function set end(param1:Point) : void
        {
            if (this._end.equals(param1))
            {
                return;
            }
            this._end = param1.clone();
            markModified();
            return;
        }// end function

        override public function clone(param1:ISVGShape = null) : ISVGShape
        {
            var _loc_2:* = param1 ? (SVGLine(param1)) : (new SVGLine());
            super.clone(_loc_2);
            _loc_2.start = this.start;
            _loc_2.end = this.end;
            return _loc_2;
        }// end function

    }
}
