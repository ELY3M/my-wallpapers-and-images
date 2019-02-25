package net.sprd.skins.d2c
{
    import flash.display.*;
    import flash.geom.*;
    import mx.skins.*;
    import net.sprd.common.graphics.*;

    public class TabNavigatorSkin extends Border
    {

        public function TabNavigatorSkin()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("backgroundGradientColors");
            var _loc_4:* = new Matrix();
            _loc_4.createGradientBox(param1, param2, UnitUtil.deg2rad(90));
            graphics.clear();
            graphics.beginGradientFill(GradientType.LINEAR, _loc_3, [1, 1], [0, 255], _loc_4);
            graphics.drawRect(0, 0, param1, param2);
            return;
        }// end function

    }
}
