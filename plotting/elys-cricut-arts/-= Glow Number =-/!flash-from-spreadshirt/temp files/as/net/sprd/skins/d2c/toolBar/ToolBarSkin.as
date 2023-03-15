package net.sprd.skins.d2c.toolBar
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import mx.skins.*;
    import net.sprd.common.graphics.*;

    public class ToolBarSkin extends Border
    {

        public function ToolBarSkin()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_9:uint;
            var _loc_16:DropShadowFilter;
            var _loc_3:* = getStyle("fillColors");
            var _loc_4:* = getStyle("fillAlphas");
            var _loc_5:* = getStyle("fillRatios");
            var _loc_6:* = getStyle("borderColor");
            var _loc_7:* = getStyle("cornerRadius");
            var _loc_8:* = getStyle("dropShadowEnabled");
            _loc_9 = getStyle("dropShadowColor");
            var _loc_10:Array;
            var _loc_11:uint;
            while (_loc_11++ < _loc_5.length)
            {
                
                _loc_10.push(Math.round(255 * _loc_5[_loc_11] / 100));
            }
            var _loc_12:* = new Matrix();
            _loc_12.createGradientBox(param1, param2, UnitUtil.deg2rad(270));
            graphics.clear();
            graphics.beginGradientFill(GradientType.LINEAR, _loc_3, _loc_4, _loc_10, _loc_12);
            graphics.drawRoundRect(0, 0, param1, param2, _loc_7, _loc_7);
            var _loc_13:* = new DropShadowFilter(1, 270, 0, 0.1, 2, 2, 1, BitmapFilterQuality.HIGH, true);
            var _loc_14:* = new GlowFilter(16777215, 1, 2, 2, 2, BitmapFilterQuality.HIGH, true);
            var _loc_15:* = new GlowFilter(_loc_6, 0.2, 2, 2, 1, BitmapFilterQuality.HIGH);
            filters = [_loc_14, _loc_13, _loc_15];
            if (_loc_8)
            {
                _loc_16 = new DropShadowFilter(2, 90, _loc_9, 0.1, 8, 8, 1, BitmapFilterQuality.HIGH);
                filters = filters.concat([_loc_16]);
            }
            return;
        }// end function

    }
}
