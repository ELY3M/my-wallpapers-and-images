package net.sprd.skins.d2c.ScrollBar
{
    import flash.display.*;
    import flash.geom.*;
    import mx.skins.*;
    import mx.styles.*;
    import net.sprd.common.graphics.*;

    public class ScrollTrackSkin extends Border
    {

        public function ScrollTrackSkin()
        {
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return 11;
        }// end function

        override public function get measuredHeight() : Number
        {
            return 1;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("trackColors");
            StyleManager.getColorNames(_loc_3);
            var _loc_4:* = getStyle("borderColor");
            graphics.clear();
            graphics.beginFill(_loc_4);
            graphics.drawRect(0, 0, 1, param2);
            var _loc_5:* = new Matrix();
            _loc_5.createGradientBox(param1, param2, UnitUtil.deg2rad(180));
            graphics.beginGradientFill(GradientType.LINEAR, _loc_3, [1, 1], [0, 255], _loc_5);
            graphics.drawRect(1, 0, param1 - 1, param2);
            return;
        }// end function

    }
}
