package net.sprd.components.common
{
    import flash.geom.*;
    import mx.controls.*;

    public class MoreButton extends LinkButton
    {
        private var _orientation:int;
        public static const LEFT:uint = 0;
        public static const RIGHT:uint = 1;
        public static const TOP:uint = 2;
        public static const BOTTOM:uint = 3;

        public function MoreButton()
        {
            this._orientation = -1;
            return;
        }// end function

        public function get orientation() : int
        {
            return this._orientation;
        }// end function

        public function set orientation(param1:int) : void
        {
            this._orientation = param1;
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:ColorTransform;
            super.updateDisplayList(param1, param2);
            if (currentIcon)
            {
                currentIcon.x = textField.getBounds(this).right;
                _loc_3 = new ColorTransform();
                if (phase == "up")
                {
                    _loc_3.color = getStyle("color");
                }
                if (phase != "over")
                {
                }
                if (phase == "down")
                {
                    _loc_3.color = getStyle("textRollOverColor");
                }
                currentIcon.transform.colorTransform = _loc_3;
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = measureText(label);
            var _loc_2:* = _loc_1.width;
            var _loc_3:* = _loc_1.height;
            _loc_2 = _loc_2 + (getStyle("paddingLeft") + getStyle("paddingRight"));
            viewIcon();
            viewSkin();
            var _loc_4:* = currentIcon ? (currentIcon.width) : (0);
            var _loc_5:* = currentIcon ? (currentIcon.height) : (0);
            var _loc_6:* = _loc_2 + 20;
            measuredWidth = _loc_2 + 20;
            measuredMinWidth = _loc_6;
            var _loc_6:* = _loc_3;
            measuredHeight = _loc_3;
            measuredMinHeight = _loc_6;
            return;
        }// end function

    }
}
