package net.sprd.skins.d2c
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import mx.skins.*;
    import mx.utils.*;
    import net.sprd.common.graphics.*;

    public class TextFieldSkin extends Border
    {

        public function TextFieldSkin()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("backgroundColor");
            var _loc_4:* = ColorUtil.adjustBrightness(_loc_3, -10);
            var _loc_5:* = getStyle("borderColor");
            var _loc_6:* = getStyle("cornerRadius");
            graphics.clear();
            var _loc_7:* = new Matrix();
            _loc_7.createGradientBox(param1, param2, UnitUtil.deg2rad(90));
            graphics.beginFill(_loc_4);
            graphics.drawRoundRect(0, 0, param1, param2, _loc_6, _loc_6);
            graphics.beginGradientFill(GradientType.LINEAR, [_loc_4, _loc_3], [1, 1], [0, 255], _loc_7);
            graphics.drawRoundRect(1, 1, param1 - 2, param2 - 2, _loc_6, _loc_6);
            var _loc_8:* = new DropShadowFilter(1, 90, _loc_5, 0.35, 1.5, 1.5, 1, BitmapFilterQuality.HIGH, true);
            filters = [_loc_8];
            return;
        }// end function

    }
}
