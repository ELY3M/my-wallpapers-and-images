package net.sprd.skins.modules.share
{
    import flash.display.*;
    import flash.geom.*;
    import mx.skins.*;

    public class TabContentSkin extends Border
    {

        public function TabContentSkin()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("fillColors");
            var _loc_4:* = getStyle("fillAlphas");
            var _loc_5:* = getStyle("fillRatios");
            var _loc_6:* = new Matrix();
            _loc_6.createGradientBox(param1, param2, SkinUtil.deg2rad(90));
            graphics.clear();
            graphics.beginGradientFill(GradientType.LINEAR, _loc_3, _loc_4, _loc_5, _loc_6);
            graphics.drawRect(0, 0, param1, param2);
            graphics.endFill();
            graphics.lineStyle(1, 15395303);
            graphics.moveTo(0, param2 - 1);
            graphics.lineTo(param1, param2 - 1);
            graphics.lineStyle(1, 16777215);
            graphics.moveTo(0, param2);
            graphics.lineTo(param1, param2);
            graphics.lineStyle();
            return;
        }// end function

    }
}
