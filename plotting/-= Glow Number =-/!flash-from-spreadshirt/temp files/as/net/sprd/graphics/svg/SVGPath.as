package net.sprd.graphics.svg
{
    import net.sprd.graphics.svg.segments.*;

    public class SVGPath extends SVGShape
    {
        private var _segments:Array;

        public function SVGPath()
        {
            this._segments = [];
            return;
        }// end function

        public function addSegment(param1:IPathSegment) : void
        {
            if (this.segments.length > 0)
            {
                param1.startPoint = IPathSegment(this._segments[this._segments.length - 1]).endPoint;
            }
            this._segments.push(param1);
            markModified();
            return;
        }// end function

        public function get segments() : Array
        {
            return this._segments;
        }// end function

        override public function clone(param1:ISVGShape = null) : ISVGShape
        {
            var _loc_3:IPathSegment;
            var _loc_2:* = param1 ? (SVGPath(param1)) : (new SVGPath());
            super.clone(_loc_2);
            for each (_loc_3 in this.segments)
            {
                
                _loc_2.addSegment(_loc_3.clone());
            }
            return _loc_2;
        }// end function

    }
}
