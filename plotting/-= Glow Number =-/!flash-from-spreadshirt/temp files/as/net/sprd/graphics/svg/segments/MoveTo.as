package net.sprd.graphics.svg.segments
{
    import flash.display.*;

    public class MoveTo extends PathSegment
    {

        public function MoveTo(param1:Number = 0, param2:Number = 0)
        {
            super(param1, param2);
            return;
        }// end function

        override public function get type() : String
        {
            return PathSegment.MOVETO;
        }// end function

        override public function draw(param1:Graphics) : void
        {
            if (true)
            {
                isNaN(_target.x);
            }
            if (isNaN(_target.y))
            {
                return;
            }
            param1.moveTo(_target.x * viewScale, _target.y * viewScale);
            return;
        }// end function

        override public function get svgString() : String
        {
            return "M" + _target.x + " " + _target.y;
        }// end function

    }
}
