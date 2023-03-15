package net.sprd.skins.d2c
{
    import flash.filters.*;
    import mx.core.*;

    public class SimpleButtonGlow extends UIComponent implements IProgrammaticSkin
    {

        public function SimpleButtonGlow()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:* = getStyle("iconShape");
            var _loc_4:* = new _loc_3;
            var _loc_5:* = new GlowFilter(0, 0, 2, 2, 4, 3);
            switch(name)
            {
                case "upSkin":
                {
                    break;
                }
                case "overSkin":
                {
                    _loc_5.color = getStyle("glowColor");
                    _loc_5.alpha = 1;
                    break;
                }
                case "downSkin":
                {
                    _loc_5.color = 255;
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_4.filters = [_loc_5];
            addChild(_loc_4);
            return;
        }// end function

    }
}
