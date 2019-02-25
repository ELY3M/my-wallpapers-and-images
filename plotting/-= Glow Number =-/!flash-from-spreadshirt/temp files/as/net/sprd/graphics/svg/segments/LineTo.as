package net.sprd.graphics.svg.segments
{
    import flash.display.*;

    public class LineTo extends PathSegment
    {

        public function LineTo(param1:Number = 0, param2:Number = 0)
        {
            super(param1, param2);
            return;
        }// end function

        override public function get type() : String
        {
            return PathSegment.LINETO;
        }// end function

        override public function draw(param1:Graphics) : void
        {
            var target:* = param1;
            try
            {
                target.lineTo(_target.x * viewScale, _target.y * viewScale);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        override public function get svgString() : String
        {
            return "L" + _target.x + " " + _target.y;
        }// end function

    }
}
