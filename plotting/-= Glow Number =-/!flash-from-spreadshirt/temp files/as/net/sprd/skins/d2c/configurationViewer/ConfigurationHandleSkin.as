package net.sprd.skins.d2c.configurationViewer
{
    import flash.filters.*;
    import mx.skins.*;
    import mx.utils.*;

    public class ConfigurationHandleSkin extends Border
    {

        public function ConfigurationHandleSkin()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:uint;
            var _loc_6:GlowFilter;
            _loc_3 = getStyle("borderColor");
            var _loc_4:* = getStyle("backgroundColor");
            var _loc_5:* = getStyle("cornerRadius");
            graphics.clear();
            switch(name)
            {
                case "upSkin":
                case "overSkin":
                {
                    graphics.beginFill(_loc_4);
                    graphics.drawRoundRect(0, 0, param1, param2, _loc_5, _loc_5);
                    _loc_6 = new GlowFilter(_loc_3, 0.4, 2, 2, 6, BitmapFilterQuality.HIGH);
                    filters = [_loc_6];
                    break;
                }
                case "downSkin":
                {
                    graphics.beginFill(ColorUtil.adjustBrightness(_loc_4, -60));
                    graphics.drawRoundRect(0, 0, param1, param2, _loc_5, _loc_5);
                    _loc_6 = new GlowFilter(_loc_3, 0.4, 2, 2, 10, BitmapFilterQuality.HIGH);
                    filters = [_loc_6];
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
