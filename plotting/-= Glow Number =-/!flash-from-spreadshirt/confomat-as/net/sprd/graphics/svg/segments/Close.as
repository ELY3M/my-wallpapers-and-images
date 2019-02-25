package net.sprd.graphics.svg.segments
{
    import flash.geom.*;

    public class Close extends PathSegment
    {

        public function Close()
        {
            return;
        }// end function

        override public function get type() : String
        {
            return PathSegment.CLOSE;
        }// end function

        override public function get endPoint() : Point
        {
            return _target;
        }// end function

        override public function get svgString() : String
        {
            return "Z";
        }// end function

    }
}
