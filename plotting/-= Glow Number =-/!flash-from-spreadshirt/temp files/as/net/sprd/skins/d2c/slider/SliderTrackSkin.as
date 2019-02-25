package net.sprd.skins.d2c.slider
{
    import flash.display.*;
    import mx.core.*;
    import mx.skins.*;

    public class SliderTrackSkin extends Border
    {

        public function SliderTrackSkin()
        {
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return 200;
        }// end function

        override public function get measuredHeight() : Number
        {
            return 2;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_5:IFlexDisplayObject;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("trackColors") as Array;
            graphics.clear();
            graphics.lineStyle(1, _loc_3[0]);
            graphics.moveTo(-25, 0);
            graphics.lineTo(param1 + 25, 0);
            graphics.lineStyle(1, _loc_3[1]);
            graphics.moveTo(-25, 1);
            graphics.lineTo(param1 + 25, 1);
            var _loc_4:* = Class(getStyle("trackIcon"));
            if (_loc_4)
            {
            }
            if (parent)
            {
                _loc_5 = IFlexDisplayObject(new _loc_4);
                _loc_5.x = parent.x + 2;
                _loc_5.y = 16;
                parent.addChild(DisplayObject(_loc_5));
            }
            return;
        }// end function

    }
}
