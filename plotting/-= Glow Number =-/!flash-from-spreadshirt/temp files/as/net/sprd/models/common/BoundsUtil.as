package net.sprd.models.common
{
    import flash.geom.*;

    public class BoundsUtil extends Object
    {

        public function BoundsUtil()
        {
            return;
        }// end function

        public static function trimBoundsProportionally(param1:Rectangle, param2:Rectangle) : Rectangle
        {
            var _loc_3:Number;
            if (!param2.containsRect(param1))
            {
                _loc_3 = Math.min(param2.width / param1.width, param2.height / param1.height);
                param1.width = param1.width * _loc_3;
                param1.height = param1.height * _loc_3;
            }
            return param1;
        }// end function

    }
}
