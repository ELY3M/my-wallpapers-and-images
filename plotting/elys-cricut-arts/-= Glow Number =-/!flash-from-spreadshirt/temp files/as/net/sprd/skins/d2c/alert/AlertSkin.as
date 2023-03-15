package net.sprd.skins.d2c.alert
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import mx.skins.halo.*;
    import net.sprd.common.graphics.*;

    public class AlertSkin extends PanelSkin
    {

        public function AlertSkin()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("cornerRadius");
            var _loc_4:* = getStyle("fillColors");
            var _loc_5:* = getStyle("fillAlphas");
            var _loc_6:* = getStyle("fillRatios");
            var _loc_7:* = getStyle("borderColor");
            var _loc_8:* = new Matrix();
            _loc_8.createGradientBox(param1, param2, UnitUtil.deg2rad(270));
            var _loc_9:Array;
            var _loc_10:uint;
            while (_loc_10++ < _loc_6.length)
            {
                
                _loc_9.push(Math.round(255 * _loc_6[_loc_10] / 100));
            }
            graphics.clear();
            graphics.beginGradientFill(GradientType.LINEAR, _loc_4, _loc_5, _loc_9, _loc_8);
            graphics.drawRoundRect(0, 0, param1, param2, _loc_3, _loc_3);
            var _loc_11:* = new GlowFilter(_loc_7, 0.4, 2, 2, 4, BitmapFilterQuality.HIGH);
            var _loc_12:* = new GlowFilter(16777215, 0.7, 2, 2, 4, BitmapFilterQuality.HIGH, true);
            var _loc_13:* = new DropShadowFilter(2, 90, 4865073, 0.25, 8, 8, 1, BitmapFilterQuality.HIGH);
            filters = [_loc_12, _loc_11, _loc_13];
            return;
        }// end function

    }
}
