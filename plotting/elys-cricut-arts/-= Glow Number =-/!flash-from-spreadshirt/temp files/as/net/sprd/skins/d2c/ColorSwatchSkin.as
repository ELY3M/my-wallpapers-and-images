package net.sprd.skins.d2c
{
    import flash.display.*;
    import flash.filters.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.states.*;

    public class ColorSwatchSkin extends UIComponent
    {
        private var _borderAlpha:Number = 1;
        private var _selectionBorderAlpha:Number = 0;
        private const UP_STATE:String = "up";
        private const DOWN_STATE:String = "down";
        private const OVER_STATE:String = "over";
        private const SELECTED_UP_STATE:String = "selectedUp";
        private const SELECTED_DOWN_STATE:String = "selectedDown";
        private const SELECTED_OVER_STATE:String = "selectedOver";

        public function ColorSwatchSkin()
        {
            this.init();
            return;
        }// end function

        private function init() : void
        {
            var _loc_1:* = new State();
            _loc_1.name = this.UP_STATE;
            _loc_1.overrides = [new SetProperty(this, "selectionBorderAlpha", 0)];
            var _loc_2:* = new State();
            _loc_2.name = this.OVER_STATE;
            _loc_2.overrides = [new SetProperty(this, "selectionBorderAlpha", 0)];
            var _loc_3:* = new State();
            _loc_3.name = this.DOWN_STATE;
            _loc_3.overrides = [new SetProperty(this, "selectionBorderAlpha", 0)];
            var _loc_4:* = new State();
            _loc_4.name = this.SELECTED_UP_STATE;
            _loc_4.overrides = [new SetProperty(this, "selectionBorderAlpha", 1)];
            var _loc_5:* = new State();
            _loc_5.name = this.SELECTED_OVER_STATE;
            _loc_5.overrides = [new SetProperty(this, "selectionBorderAlpha", 1)];
            var _loc_6:* = new State();
            _loc_6.name = this.SELECTED_DOWN_STATE;
            _loc_6.overrides = [new SetProperty(this, "selectionBorderAlpha", 1)];
            states = [_loc_1, _loc_2, _loc_3, _loc_4, _loc_5, _loc_6];
            var _loc_7:* = new AnimateProperty();
            _loc_7.duration = 300;
            _loc_7.property = "borderAlpha";
            _loc_7.target = this;
            var _loc_8:* = new AnimateProperty();
            _loc_8.duration = 300;
            _loc_8.property = "selectionBorderAlpha";
            _loc_8.target = this;
            var _loc_9:* = new Transition();
            _loc_9.toState = _loc_2.name;
            var _loc_10:* = new Transition();
            _loc_10.toState = _loc_1.name;
            _loc_10.effect = _loc_8;
            var _loc_11:* = new Transition();
            _loc_11.toState = _loc_4.name;
            _loc_11.effect = _loc_8;
            var _loc_12:* = new Transition();
            _loc_12.toState = _loc_5.name;
            _loc_12.effect = _loc_8;
            var _loc_13:* = new Transition();
            _loc_13.toState = _loc_6.name;
            _loc_13.effect = _loc_8;
            transitions = [_loc_9, _loc_10, _loc_11, _loc_12, _loc_13];
            return;
        }// end function

        public function get borderAlpha() : Number
        {
            return this._borderAlpha;
        }// end function

        public function set borderAlpha(param1:Number) : void
        {
            this._borderAlpha = param1;
            invalidateDisplayList();
            return;
        }// end function

        public function get selectionBorderAlpha() : Number
        {
            return this._selectionBorderAlpha;
        }// end function

        public function set selectionBorderAlpha(param1:Number) : void
        {
            this._selectionBorderAlpha = param1;
            invalidateDisplayList();
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_5:Sprite;
            var _loc_6:DropShadowFilter;
            super.updateDisplayList(param1, param2);
            graphics.clear();
            var _loc_3:* = getStyle("borderColor");
            var _loc_4:* = getStyle("selectionColor");
            graphics.beginFill(_loc_4, this._selectionBorderAlpha);
            graphics.drawRoundRect(0, 0, param1, param2, 8, 8);
            graphics.drawRoundRect(4, 4, param1 - 8, param2 - 8, 4, 4);
            graphics.beginFill(_loc_3);
            if (this._selectionBorderAlpha <= 0)
            {
                graphics.drawRoundRect(1, 1, param1 - 2, param2 - 2, 5, 5);
            }
            else
            {
                graphics.drawRoundRect(2, 2, param1 - 4, param2 - 4, 5, 5);
            }
            graphics.drawRoundRect(4, 4, param1 - 8, param2 - 8, 4, 4);
            graphics.beginFill(currentState == this.OVER_STATE ? (_loc_4) : (14143175), 1);
            graphics.drawRoundRect(3, 3, param1 - 6, param2 - 6, 4, 4);
            graphics.drawRoundRect(4, 4, param1 - 8, param2 - 8, 4, 4);
            if (!getChildByName("shader"))
            {
                _loc_5 = new Sprite();
                _loc_5.name = "shader";
                _loc_5.graphics.beginFill(16711935, 1);
                _loc_5.graphics.drawRoundRect(4, 4, param1 - 8, param2 - 8, 4, 4);
                _loc_6 = new DropShadowFilter(5, 90, 16777215, 0.3, 4, 4, 1, BitmapFilterQuality.HIGH, true, false, true);
                _loc_5.filters = [_loc_6];
                addChild(_loc_5);
            }
            filters = [new DropShadowFilter(0, 90, 8419182, 0.3, 4, 4, 1, BitmapFilterQuality.HIGH)];
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:int;
            measuredMinHeight = 22;
            measuredHeight = _loc_1;
            var _loc_1:int;
            measuredMinWidth = 22;
            measuredWidth = _loc_1;
            return;
        }// end function

    }
}
