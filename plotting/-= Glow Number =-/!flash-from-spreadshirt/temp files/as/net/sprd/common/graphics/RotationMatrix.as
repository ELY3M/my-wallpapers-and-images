package net.sprd.common.graphics
{
    import flash.geom.*;

    public class RotationMatrix extends Matrix
    {

        public function RotationMatrix(param1:Number, param2:Number, param3:Number)
        {
            translate(-param1, -param2);
            super.rotate(param3);
            translate(param1, param2);
            return;
        }// end function

    }
}
