package net.sprd.skins.d2c.toolBar
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import mx.skins.*;
    import net.sprd.common.graphics.*;

    public class NoticeMarkerSkin extends Border
    {

        public function NoticeMarkerSkin()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_18:DropShadowFilter;
            var _loc_3:* = getStyle("fillColors");
            var _loc_4:* = getStyle("fillAlphas");
            var _loc_5:* = getStyle("fillRatios");
            var _loc_6:* = getStyle("borderColor");
            var _loc_7:* = getStyle("cornerRadius");
            var _loc_8:* = getStyle("dropShadowEnabled");
            var _loc_9:* = getStyle("dropShadowColor");
            var _loc_10:Array;
            var _loc_11:uint;
            while (_loc_11++ < _loc_5.length)
            {
                
                _loc_10.push(Math.round(255 * _loc_5[_loc_11] / 100));
            }
            var _loc_12:Number;
            var _loc_13:* = (param2 - _loc_12) / 2;
            var _loc_14:* = new Matrix();
            _loc_14.createGradientBox(param1, param2, UnitUtil.deg2rad(270));
            graphics.clear();
            graphics.beginGradientFill(GradientType.LINEAR, _loc_3, _loc_4, _loc_10, _loc_14);
            _loc_7 = Math.round(_loc_7 / 2);
            graphics.moveTo(_loc_7, 0);
            graphics.lineTo(param1 - _loc_7, 0);
            graphics.curveTo(param1, 0, param1, _loc_7);
            graphics.lineTo(param1, _loc_13);
            graphics.lineTo(param1 + 5, _loc_13 + _loc_12 / 2);
            graphics.lineTo(param1, _loc_13 + _loc_12);
            graphics.lineTo(param1, param2 - _loc_7);
            graphics.curveTo(param1, param2, param1 - _loc_7, param2);
            graphics.lineTo(_loc_7, param2);
            graphics.curveTo(0, param2, 0, param2 - _loc_7);
            graphics.lineTo(0, _loc_7);
            graphics.curveTo(0, 0, _loc_7, 0);
            var _loc_15:* = new DropShadowFilter(1, 270, 0, 0.1, 2, 2, 1, BitmapFilterQuality.HIGH, true);
            var _loc_16:* = new GlowFilter(16777215, 1, 2, 2, 2, BitmapFilterQuality.HIGH, true);
            var _loc_17:* = new GlowFilter(_loc_6, 0.2, 2, 2, 1, BitmapFilterQuality.HIGH);
            filters = [_loc_16, _loc_15, _loc_17];
            if (_loc_8)
            {
                _loc_18 = new DropShadowFilter(2, 90, _loc_9, 0.1, 8, 8, 1, BitmapFilterQuality.HIGH);
                filters = filters.concat([_loc_18]);
            }
            return;
        }// end function

    }
}
