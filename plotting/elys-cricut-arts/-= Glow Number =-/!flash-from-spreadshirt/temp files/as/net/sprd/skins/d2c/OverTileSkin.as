package net.sprd.skins.d2c
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import mx.skins.*;
    import net.sprd.common.graphics.*;

    public class OverTileSkin extends Border
    {
        private const WIDTH:int = 100;
        private const HEIGHT:int = 100;

        public function OverTileSkin()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_5:Boolean;
            var _loc_9:DropShadowFilter;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("fillColors");
            var _loc_4:* = getStyle("cornerRadius");
            _loc_5 = getStyle("dropShadowEnabled");
            var _loc_6:* = getStyle("dropShadowColor");
            var _loc_7:* = new Matrix();
            _loc_7.createGradientBox(param1, param2, UnitUtil.deg2rad(90));
            graphics.beginGradientFill(GradientType.LINEAR, _loc_3, [1, 1], [0, 255], _loc_7);
            graphics.drawRoundRect(0, 0, param1, param2, _loc_4, _loc_4);
            var _loc_8:* = new GlowFilter(_loc_3[0], 1, 3, 3, 3, BitmapFilterQuality.HIGH);
            filters = [_loc_8];
            if (_loc_5)
            {
                _loc_9 = new DropShadowFilter(2, 90, _loc_6, 0.2, 8, 8, 1, BitmapFilterQuality.HIGH);
                filters = filters.concat([_loc_9]);
            }
            return;
        }// end function

    }
}
