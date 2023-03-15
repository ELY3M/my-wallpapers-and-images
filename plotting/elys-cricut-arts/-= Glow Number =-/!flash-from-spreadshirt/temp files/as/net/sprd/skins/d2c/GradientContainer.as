package net.sprd.skins.d2c
{
    import mx.skins.halo.*;
    import mx.utils.*;

    public class GradientContainer extends HaloBorder
    {
        private var topCornerRadius:Number;
        private var bottomCornerRadius:Number;
        private var fillColors:Array;

        public function GradientContainer()
        {
            return;
        }// end function

        private function setupStyles() : void
        {
            this.fillColors = getStyle("fillColors") as Array;
            if (!this.fillColors)
            {
                this.fillColors = [16777215, 16777215];
            }
            this.topCornerRadius = getStyle("cornerRadius") as Number;
            if (!this.topCornerRadius)
            {
                this.topCornerRadius = 0;
            }
            this.bottomCornerRadius = getStyle("bottomCornerRadius") as Number;
            if (!this.bottomCornerRadius)
            {
                this.bottomCornerRadius = this.topCornerRadius;
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            this.setupStyles();
            var _loc_3:* = graphics;
            var _loc_4:* = borderMetrics;
            var _loc_5:* = param1 - _loc_4.left - _loc_4.right;
            var _loc_6:* = param2 - _loc_4.top - _loc_4.bottom;
            var _loc_7:* = verticalGradientMatrix(0, 0, _loc_5, _loc_6);
            _loc_3.beginGradientFill("linear", this.fillColors, [1, 1], [0, 255], _loc_7);
            var _loc_8:* = Math.max(this.topCornerRadius - 2, 0);
            var _loc_9:* = Math.max(this.bottomCornerRadius - 2, 0);
            GraphicsUtil.drawRoundRectComplex(_loc_3, _loc_4.left, _loc_4.top, _loc_5, _loc_6, _loc_8, _loc_8, _loc_9, _loc_9);
            _loc_3.endFill();
            return;
        }// end function

    }
}
