package net.sprd.skins.d2c.toolBar
{
    import flash.display.*;
    import flash.geom.*;
    import mx.skins.*;
    import net.sprd.common.graphics.*;

    public class FunctionGroupSkin extends Border
    {

        public function FunctionGroupSkin()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("fillColors");
            var _loc_4:* = getStyle("fillAlphas");
            var _loc_5:* = getStyle("fillRatios");
            var _loc_6:* = getStyle("topBorderColor");
            var _loc_7:* = getStyle("bottomBorderColor");
            var _loc_8:Array;
            var _loc_9:uint;
            while (_loc_9++ < _loc_5.length)
            {
                
                _loc_8.push(Math.round(255 * _loc_5[_loc_9] / 100));
            }
            var _loc_10:* = new Matrix();
            _loc_10.createGradientBox(param1, param2, UnitUtil.deg2rad(90));
            graphics.clear();
            graphics.beginGradientFill(GradientType.LINEAR, _loc_3, _loc_4, _loc_8, _loc_10);
            graphics.drawRect(0, 0, param1, param2);
            graphics.endFill();
            graphics.lineStyle(1, _loc_6);
            graphics.moveTo(0, 0);
            graphics.lineTo(param1, 0);
            graphics.lineStyle(1, _loc_7);
            graphics.moveTo(0, param2);
            graphics.lineTo(param1, param2);
            return;
        }// end function

    }
}
