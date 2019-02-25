package net.sprd.graphics.svg
{

    public class SVGRect extends SVGShape
    {

        public function SVGRect(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0)
        {
            this.x = param1;
            this.y = param2;
            this.width = param3;
            this.height = param4;
            return;
        }// end function

        override public function clone(param1:ISVGShape = null) : ISVGShape
        {
            var _loc_2:* = param1 ? (SVGRect(param1)) : (new SVGRect());
            super.clone(_loc_2);
            return _loc_2;
        }// end function

    }
}
