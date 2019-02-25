package net.sprd.skins.d2c
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.core.*;
    import mx.states.*;
    import mx.utils.*;
    import net.sprd.common.graphics.*;

    public class ComboBoxSkin extends UIComponent implements IBindingClient
    {
        public var _ComboBoxSkin_SetProperty1:SetProperty;
        public var _ComboBoxSkin_SetProperty10:SetProperty;
        public var _ComboBoxSkin_SetProperty2:SetProperty;
        public var _ComboBoxSkin_SetProperty3:SetProperty;
        public var _ComboBoxSkin_SetProperty4:SetProperty;
        public var _ComboBoxSkin_SetProperty5:SetProperty;
        public var _ComboBoxSkin_SetProperty6:SetProperty;
        public var _ComboBoxSkin_SetProperty7:SetProperty;
        public var _ComboBoxSkin_SetProperty8:SetProperty;
        public var _ComboBoxSkin_SetProperty9:SetProperty;
        private var __moduleFactoryInitialized:Boolean = false;
        private var _arrowColor:uint = 0;
        private var _brightness:int = 0;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function ComboBoxSkin()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            var bindings:* = this._ComboBoxSkin_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_net_sprd_skins_d2c_ComboBoxSkinWatcherSetupUtil");
                var _loc_2:* = watcherSetupUtilClass;
                _loc_2.watcherSetupUtilClass["init"](null);
            }
            _watcherSetupUtil.setup(this, function (param1:String)
            {
                return target[param1];
            }// end function
            , function (param1:String)
            {
                return [param1];
            }// end function
            , bindings, watchers);
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.states = [this._ComboBoxSkin_State1_c(), this._ComboBoxSkin_State2_c(), this._ComboBoxSkin_State3_c(), this._ComboBoxSkin_State4_c(), this._ComboBoxSkin_State5_c(), this._ComboBoxSkin_State6_c(), this._ComboBoxSkin_State7_c()];
            var i:uint;
            while (i < bindings.length)
            {
                
                Binding(bindings[i]).execute();
                i = i++;
            }
            return;
        }// end function

        override public function set moduleFactory(param1:IFlexModuleFactory) : void
        {
            super.moduleFactory = param1;
            if (this.__moduleFactoryInitialized)
            {
                return;
            }
            this.__moduleFactoryInitialized = true;
            return;
        }// end function

        override public function initialize() : void
        {
            super.initialize();
            return;
        }// end function

        public function get brightnessAdjust() : int
        {
            return this._brightness;
        }// end function

        public function set brightnessAdjust(param1:int) : void
        {
            if (param1 == this._brightness)
            {
                return;
            }
            this._brightness = param1;
            invalidateDisplayList();
            return;
        }// end function

        public function get arrowColor() : uint
        {
            return this._arrowColor;
        }// end function

        public function set arrowColor(param1:uint) : void
        {
            if (param1 == this._arrowColor)
            {
                return;
            }
            this._arrowColor = param1;
            invalidateDisplayList();
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:Number;
            var _loc_5:Array;
            super.updateDisplayList(param1, param2);
            _loc_3 = getStyle("cornerRadius");
            var _loc_4:* = getStyle("fillColors");
            _loc_5 = getStyle("fillAlphas");
            var _loc_6:* = getStyle("arrowButtonWidth");
            var _loc_7:* = getStyle("borderColor");
            var _loc_8:* = getStyle("borderAlpha");
            var _loc_9:* = getStyle("themeColor");
            var _loc_10:Array;
            var _loc_11:* = Sprite(getChildByName("base"));
            if (!_loc_11)
            {
                _loc_11 = new Sprite();
                _loc_11.name = "base";
                addChild(_loc_11);
            }
            var _loc_12:* = Sprite(getChildByName("button"));
            if (!_loc_12)
            {
                _loc_12 = new Sprite();
                _loc_12.name = "button";
                addChild(_loc_12);
            }
            var _loc_13:* = Sprite(getChildByName("arrow"));
            if (!_loc_13)
            {
                _loc_13 = new Sprite();
                _loc_13.name = "arrow";
                addChild(_loc_13);
            }
            graphics.clear();
            _loc_11.graphics.clear();
            _loc_12.graphics.clear();
            _loc_13.graphics.clear();
            var _loc_14:* = Math.round(_loc_6 / 3);
            var _loc_15:* = Math.round(param2 / 4);
            var _loc_16:Array;
            var _loc_17:* = new Matrix();
            _loc_17.createGradientBox(_loc_14, _loc_15, UnitUtil.deg2rad(90));
            _loc_13.graphics.beginGradientFill(GradientType.LINEAR, _loc_16, _loc_5, _loc_10, _loc_17);
            _loc_13.graphics.moveTo(0, 0);
            _loc_13.graphics.lineTo(_loc_14, 0);
            _loc_13.graphics.lineTo(_loc_14 / 2, _loc_15);
            _loc_13.graphics.lineTo(0, 0);
            _loc_13.x = param1 - _loc_6 + _loc_14;
            _loc_13.y = _loc_15 * 1.5;
            var _loc_18:* = new DropShadowFilter(1, 90, 16777215, 1, 1.1, 1.1, 2, BitmapFilterQuality.HIGH);
            _loc_13.filters = [_loc_18];
            var _loc_19:* = _loc_3 / 2;
            _loc_11.graphics.beginFill(_loc_7, _loc_8);
            _loc_11.graphics.drawRoundRect(0, 0, param1, param2, _loc_3, _loc_3);
            _loc_17.createGradientBox(param1 - _loc_6, param2, UnitUtil.deg2rad(90));
            _loc_11.graphics.beginGradientFill(GradientType.LINEAR, _loc_4, _loc_5, _loc_10, _loc_17);
            _loc_11.graphics.drawRoundRectComplex(1, 1, param1 - _loc_6 - 1, param2 - 2, _loc_19, 0, _loc_19, 0);
            _loc_17.createGradientBox(_loc_6 - 1, param2 - 2, UnitUtil.deg2rad(90));
            var _loc_20:Array;
            if (currentState != "over")
            {
            }
            if (currentState == "selectedOver")
            {
                _loc_20 = _loc_20.reverse();
            }
            _loc_20[0] = ColorUtil.adjustBrightness(_loc_20[0], this.brightnessAdjust);
            _loc_20[1] = ColorUtil.adjustBrightness(_loc_20[1], this.brightnessAdjust);
            _loc_12.graphics.beginGradientFill(GradientType.LINEAR, _loc_20, _loc_5, _loc_10, _loc_17);
            _loc_12.graphics.drawRoundRectComplex(0, 0, _loc_6 - 1, param2 - 2, 0, _loc_19, 0, _loc_19);
            _loc_12.x = param1 - _loc_6;
            _loc_12.y = 1;
            var _loc_21:* = new GlowFilter(16777215, 0.05, 3, 3, 50, 3, true);
            var _loc_22:* = new DropShadowFilter(4, 90, _loc_9, 0.05, 4, 4, 1, 3, true);
            var _loc_23:* = new DropShadowFilter(0, 180, 8419182, 0.25, 4, 4, 1, 3);
            _loc_12.filters = [_loc_21, _loc_22, _loc_23];
            return;
        }// end function

        private function _ComboBoxSkin_State1_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "up";
            _loc_1.overrides = [this._ComboBoxSkin_SetProperty1_i(), this._ComboBoxSkin_SetProperty2_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _ComboBoxSkin_SetProperty1_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "arrowColor";
            this._ComboBoxSkin_SetProperty1 = _loc_1;
            BindingManager.executeBindings(this, "_ComboBoxSkin_SetProperty1", this._ComboBoxSkin_SetProperty1);
            return _loc_1;
        }// end function

        private function _ComboBoxSkin_SetProperty2_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "brightnessAdjust";
            _loc_1.value = 0;
            this._ComboBoxSkin_SetProperty2 = _loc_1;
            BindingManager.executeBindings(this, "_ComboBoxSkin_SetProperty2", this._ComboBoxSkin_SetProperty2);
            return _loc_1;
        }// end function

        private function _ComboBoxSkin_State2_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "over";
            _loc_1.overrides = [this._ComboBoxSkin_SetProperty3_i(), this._ComboBoxSkin_SetProperty4_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _ComboBoxSkin_SetProperty3_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "arrowColor";
            this._ComboBoxSkin_SetProperty3 = _loc_1;
            BindingManager.executeBindings(this, "_ComboBoxSkin_SetProperty3", this._ComboBoxSkin_SetProperty3);
            return _loc_1;
        }// end function

        private function _ComboBoxSkin_SetProperty4_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "brightnessAdjust";
            _loc_1.value = 0;
            this._ComboBoxSkin_SetProperty4 = _loc_1;
            BindingManager.executeBindings(this, "_ComboBoxSkin_SetProperty4", this._ComboBoxSkin_SetProperty4);
            return _loc_1;
        }// end function

        private function _ComboBoxSkin_State3_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "down";
            _loc_1.overrides = [this._ComboBoxSkin_SetProperty5_i(), this._ComboBoxSkin_SetProperty6_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _ComboBoxSkin_SetProperty5_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "arrowColor";
            this._ComboBoxSkin_SetProperty5 = _loc_1;
            BindingManager.executeBindings(this, "_ComboBoxSkin_SetProperty5", this._ComboBoxSkin_SetProperty5);
            return _loc_1;
        }// end function

        private function _ComboBoxSkin_SetProperty6_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "brightnessAdjust";
            _loc_1.value = -15;
            this._ComboBoxSkin_SetProperty6 = _loc_1;
            BindingManager.executeBindings(this, "_ComboBoxSkin_SetProperty6", this._ComboBoxSkin_SetProperty6);
            return _loc_1;
        }// end function

        private function _ComboBoxSkin_State4_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "selectedUp";
            _loc_1.basedOn = "up";
            _loc_1.overrides = [this._ComboBoxSkin_SetProperty7_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _ComboBoxSkin_SetProperty7_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "brightnessAdjust";
            _loc_1.value = 0;
            this._ComboBoxSkin_SetProperty7 = _loc_1;
            BindingManager.executeBindings(this, "_ComboBoxSkin_SetProperty7", this._ComboBoxSkin_SetProperty7);
            return _loc_1;
        }// end function

        private function _ComboBoxSkin_State5_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "selectedOver";
            _loc_1.basedOn = "over";
            _loc_1.overrides = [this._ComboBoxSkin_SetProperty8_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _ComboBoxSkin_SetProperty8_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "brightnessAdjust";
            _loc_1.value = 0;
            this._ComboBoxSkin_SetProperty8 = _loc_1;
            BindingManager.executeBindings(this, "_ComboBoxSkin_SetProperty8", this._ComboBoxSkin_SetProperty8);
            return _loc_1;
        }// end function

        private function _ComboBoxSkin_State6_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "selectedDown";
            _loc_1.basedOn = "down";
            _loc_1.overrides = [this._ComboBoxSkin_SetProperty9_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _ComboBoxSkin_SetProperty9_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "brightnessAdjust";
            _loc_1.value = -10;
            this._ComboBoxSkin_SetProperty9 = _loc_1;
            BindingManager.executeBindings(this, "_ComboBoxSkin_SetProperty9", this._ComboBoxSkin_SetProperty9);
            return _loc_1;
        }// end function

        private function _ComboBoxSkin_State7_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "disabled";
            _loc_1.overrides = [this._ComboBoxSkin_SetProperty10_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _ComboBoxSkin_SetProperty10_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "brightnessAdjust";
            _loc_1.value = 15;
            this._ComboBoxSkin_SetProperty10 = _loc_1;
            BindingManager.executeBindings(this, "_ComboBoxSkin_SetProperty10", this._ComboBoxSkin_SetProperty10);
            return _loc_1;
        }// end function

        private function _ComboBoxSkin_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, function ()
            {
                return getStyle("arrowColor");
            }// end function
            , null, "_ComboBoxSkin_SetProperty1.value");
            result[1] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ComboBoxSkin_SetProperty1.target");
            result[2] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ComboBoxSkin_SetProperty2.target");
            result[3] = new Binding(this, function ()
            {
                return getStyle("selectionColor");
            }// end function
            , null, "_ComboBoxSkin_SetProperty3.value");
            result[4] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ComboBoxSkin_SetProperty3.target");
            result[5] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ComboBoxSkin_SetProperty4.target");
            result[6] = new Binding(this, function ()
            {
                return getStyle("selectionColor");
            }// end function
            , null, "_ComboBoxSkin_SetProperty5.value");
            result[7] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ComboBoxSkin_SetProperty5.target");
            result[8] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ComboBoxSkin_SetProperty6.target");
            result[9] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ComboBoxSkin_SetProperty7.target");
            result[10] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ComboBoxSkin_SetProperty8.target");
            result[11] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ComboBoxSkin_SetProperty9.target");
            result[12] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ComboBoxSkin_SetProperty10.target");
            return result;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
        {
            _watcherSetupUtil = param1;
            return;
        }// end function

    }
}
