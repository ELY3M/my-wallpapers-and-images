package net.sprd.skins.d2c
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.states.*;
    import mx.utils.*;
    import net.sprd.common.graphics.*;

    public class ButtonSkin extends UIComponent implements IBindingClient
    {
        public var _ButtonSkin_SetProperty1:SetProperty;
        public var _ButtonSkin_SetProperty10:SetProperty;
        public var _ButtonSkin_SetProperty11:SetProperty;
        public var _ButtonSkin_SetProperty12:SetProperty;
        public var _ButtonSkin_SetProperty13:SetProperty;
        public var _ButtonSkin_SetProperty14:SetProperty;
        public var _ButtonSkin_SetProperty15:SetProperty;
        public var _ButtonSkin_SetProperty16:SetProperty;
        public var _ButtonSkin_SetProperty17:SetProperty;
        public var _ButtonSkin_SetProperty18:SetProperty;
        public var _ButtonSkin_SetProperty19:SetProperty;
        public var _ButtonSkin_SetProperty2:SetProperty;
        public var _ButtonSkin_SetProperty20:SetProperty;
        public var _ButtonSkin_SetProperty21:SetProperty;
        public var _ButtonSkin_SetProperty22:SetProperty;
        public var _ButtonSkin_SetProperty23:SetProperty;
        public var _ButtonSkin_SetProperty24:SetProperty;
        public var _ButtonSkin_SetProperty25:SetProperty;
        public var _ButtonSkin_SetProperty26:SetProperty;
        public var _ButtonSkin_SetProperty27:SetProperty;
        public var _ButtonSkin_SetProperty28:SetProperty;
        public var _ButtonSkin_SetProperty29:SetProperty;
        public var _ButtonSkin_SetProperty3:SetProperty;
        public var _ButtonSkin_SetProperty30:SetProperty;
        public var _ButtonSkin_SetProperty4:SetProperty;
        public var _ButtonSkin_SetProperty5:SetProperty;
        public var _ButtonSkin_SetProperty6:SetProperty;
        public var _ButtonSkin_SetProperty7:SetProperty;
        public var _ButtonSkin_SetProperty8:SetProperty;
        public var _ButtonSkin_SetProperty9:SetProperty;
        private var _250872343toDisabled:Transition;
        private var _334218376toDownSelected:Transition;
        private var _1022157894toEnabled:Transition;
        private var _869004817toOver:Transition;
        private var _1994326442toOverSelected:Transition;
        private var _3565174toUp:Transition;
        private var _1356588849toUpSelected:Transition;
        private var __moduleFactoryInitialized:Boolean = false;
        private var _backgroundBrightness:Number = 0;
        private var _selectionBorderAlpha:Number = 0;
        private var _gradientAngle:Number = -90;
        private var _selectionBorder:Sprite;
        private var _buttonShape:Sprite;
        private var _textField:UITextField;
        private var _textColor:uint;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function ButtonSkin()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            var bindings:* = this._ButtonSkin_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_net_sprd_skins_d2c_ButtonSkinWatcherSetupUtil");
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
            this.states = [this._ButtonSkin_State1_c(), this._ButtonSkin_State2_c(), this._ButtonSkin_State3_c(), this._ButtonSkin_State4_c(), this._ButtonSkin_State5_c(), this._ButtonSkin_State6_c(), this._ButtonSkin_State7_c(), this._ButtonSkin_State8_c()];
            this.transitions = [this._ButtonSkin_Transition1_i(), this._ButtonSkin_Transition2_i(), this._ButtonSkin_Transition3_i(), this._ButtonSkin_Transition4_i(), this._ButtonSkin_Transition5_i(), this._ButtonSkin_Transition6_i(), this._ButtonSkin_Transition7_i()];
            this.addEventListener("initialize", this.___ButtonSkin_UIComponent1_initialize);
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

        protected function creationCompleteHandler(param1:FlexEvent) : void
        {
            var _loc_2:uint;
            removeEventListener(FlexEvent.CREATION_COMPLETE, this.creationCompleteHandler);
            if (parent is Button)
            {
                _loc_2 = 0;
                while (_loc_2++ < parent.numChildren)
                {
                    
                    if (parent.getChildAt(_loc_2) is UITextField)
                    {
                        this._textField = UITextField(parent.getChildAt(_loc_2));
                        break;
                    }
                }
            }
            return;
        }// end function

        public function get backgroundBrightness() : Number
        {
            return this._backgroundBrightness;
        }// end function

        public function set backgroundBrightness(param1:Number) : void
        {
            this._backgroundBrightness = param1;
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

        public function get gradientAngle() : Number
        {
            return this._gradientAngle;
        }// end function

        public function set gradientAngle(param1:Number) : void
        {
            this._gradientAngle = param1;
            invalidateDisplayList();
            return;
        }// end function

        public function get textColor() : Number
        {
            return this._textColor;
        }// end function

        public function set textColor(param1:Number) : void
        {
            this._textColor = param1;
            invalidateDisplayList();
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("cornerRadius");
            var _loc_4:* = getStyle("fillColors").concat();
            var _loc_5:* = getStyle("fillAlphas");
            var _loc_6:* = getStyle("textSelectedColor");
            var _loc_7:* = getStyle("borderColor");
            var _loc_8:* = new DropShadowFilter(1, 90, 8419182, 0.25, 4, 4, 1, BitmapFilterQuality.HIGH);
            _loc_4[0] = ColorUtil.adjustBrightness(_loc_4[0], this.backgroundBrightness);
            _loc_4[1] = ColorUtil.adjustBrightness(_loc_4[1], this.backgroundBrightness);
            _loc_7 = ColorUtil.adjustBrightness(_loc_7, this.backgroundBrightness * 2);
            if (!this._buttonShape)
            {
                this._buttonShape = new Sprite();
                addChild(this._buttonShape);
            }
            this._buttonShape.graphics.clear();
            var _loc_9:* = new Matrix();
            _loc_9.createGradientBox(param1 * 0.65, param2 * 0.65, UnitUtil.deg2rad(this.gradientAngle), 0, 0);
            this._buttonShape.graphics.beginGradientFill(GradientType.LINEAR, _loc_4, _loc_5, [0, 127], _loc_9, SpreadMethod.PAD);
            this._buttonShape.graphics.drawRoundRect(0, 0, param1, param2, _loc_3, _loc_3);
            var _loc_10:* = new DropShadowFilter(4, -90, 8419182, 0.15, 4, 4, 1, BitmapFilterQuality.HIGH, true);
            var _loc_11:* = new GlowFilter(_loc_7, 1, 3, 3, 2, BitmapFilterQuality.HIGH, true);
            var _loc_12:* = new GlowFilter(_loc_6, this._selectionBorderAlpha, 2, 2, 2, BitmapFilterQuality.HIGH, true);
            var _loc_13:* = new GlowFilter(_loc_6, this._selectionBorderAlpha, 2, 2, 2, BitmapFilterQuality.HIGH, false);
            if (this._selectionBorderAlpha > 0)
            {
                this._buttonShape.filters = [_loc_10, _loc_11, _loc_8, _loc_12, _loc_13];
            }
            else
            {
                this._buttonShape.filters = [_loc_10, _loc_11, _loc_8];
            }
            if (this._textField)
            {
                this._textField.setStyle("color", this.textColor);
            }
            return;
        }// end function

        private function _ButtonSkin_State1_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "up";
            _loc_1.overrides = [this._ButtonSkin_SetProperty1_i(), this._ButtonSkin_SetProperty2_i(), this._ButtonSkin_SetProperty3_i(), this._ButtonSkin_SetProperty4_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty1_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "backgroundBrightness";
            _loc_1.value = 0;
            this._ButtonSkin_SetProperty1 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty1", this._ButtonSkin_SetProperty1);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty2_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "selectionBorderAlpha";
            _loc_1.value = 0;
            this._ButtonSkin_SetProperty2 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty2", this._ButtonSkin_SetProperty2);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty3_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "gradientAngle";
            _loc_1.value = 90;
            this._ButtonSkin_SetProperty3 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty3", this._ButtonSkin_SetProperty3);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty4_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "textColor";
            this._ButtonSkin_SetProperty4 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty4", this._ButtonSkin_SetProperty4);
            return _loc_1;
        }// end function

        private function _ButtonSkin_State2_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "over";
            _loc_1.overrides = [this._ButtonSkin_SetProperty5_i(), this._ButtonSkin_SetProperty6_i(), this._ButtonSkin_SetProperty7_i(), this._ButtonSkin_SetProperty8_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty5_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "backgroundBrightness";
            _loc_1.value = 0;
            this._ButtonSkin_SetProperty5 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty5", this._ButtonSkin_SetProperty5);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty6_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "selectionBorderAlpha";
            _loc_1.value = 0;
            this._ButtonSkin_SetProperty6 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty6", this._ButtonSkin_SetProperty6);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty7_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "gradientAngle";
            _loc_1.value = 270;
            this._ButtonSkin_SetProperty7 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty7", this._ButtonSkin_SetProperty7);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty8_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "textColor";
            this._ButtonSkin_SetProperty8 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty8", this._ButtonSkin_SetProperty8);
            return _loc_1;
        }// end function

        private function _ButtonSkin_State3_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "down";
            _loc_1.overrides = [this._ButtonSkin_SetProperty9_i(), this._ButtonSkin_SetProperty10_i(), this._ButtonSkin_SetProperty11_i(), this._ButtonSkin_SetProperty12_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty9_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "backgroundBrightness";
            _loc_1.value = -8;
            this._ButtonSkin_SetProperty9 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty9", this._ButtonSkin_SetProperty9);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty10_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "selectionBorderAlpha";
            _loc_1.value = 0;
            this._ButtonSkin_SetProperty10 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty10", this._ButtonSkin_SetProperty10);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty11_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "gradientAngle";
            _loc_1.value = 270;
            this._ButtonSkin_SetProperty11 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty11", this._ButtonSkin_SetProperty11);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty12_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "textColor";
            this._ButtonSkin_SetProperty12 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty12", this._ButtonSkin_SetProperty12);
            return _loc_1;
        }// end function

        private function _ButtonSkin_State4_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "selectedUp";
            _loc_1.basedOn = "up";
            _loc_1.overrides = [this._ButtonSkin_SetProperty13_i(), this._ButtonSkin_SetProperty14_i(), this._ButtonSkin_SetProperty15_i(), this._ButtonSkin_SetProperty16_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty13_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "backgroundBrightness";
            _loc_1.value = 0;
            this._ButtonSkin_SetProperty13 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty13", this._ButtonSkin_SetProperty13);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty14_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "selectionBorderAlpha";
            _loc_1.value = 1;
            this._ButtonSkin_SetProperty14 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty14", this._ButtonSkin_SetProperty14);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty15_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "gradientAngle";
            _loc_1.value = 90;
            this._ButtonSkin_SetProperty15 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty15", this._ButtonSkin_SetProperty15);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty16_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "textColor";
            this._ButtonSkin_SetProperty16 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty16", this._ButtonSkin_SetProperty16);
            return _loc_1;
        }// end function

        private function _ButtonSkin_State5_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "selectedOver";
            _loc_1.basedOn = "over";
            _loc_1.overrides = [this._ButtonSkin_SetProperty17_i(), this._ButtonSkin_SetProperty18_i(), this._ButtonSkin_SetProperty19_i(), this._ButtonSkin_SetProperty20_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty17_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "selectionBorderAlpha";
            _loc_1.value = 1;
            this._ButtonSkin_SetProperty17 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty17", this._ButtonSkin_SetProperty17);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty18_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "backgroundBrightness";
            _loc_1.value = 0;
            this._ButtonSkin_SetProperty18 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty18", this._ButtonSkin_SetProperty18);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty19_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "gradientAngle";
            _loc_1.value = 270;
            this._ButtonSkin_SetProperty19 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty19", this._ButtonSkin_SetProperty19);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty20_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "textColor";
            this._ButtonSkin_SetProperty20 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty20", this._ButtonSkin_SetProperty20);
            return _loc_1;
        }// end function

        private function _ButtonSkin_State6_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "selectedDown";
            _loc_1.basedOn = "down";
            _loc_1.overrides = [this._ButtonSkin_SetProperty21_i(), this._ButtonSkin_SetProperty22_i(), this._ButtonSkin_SetProperty23_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty21_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "backgroundBrightness";
            _loc_1.value = 0;
            this._ButtonSkin_SetProperty21 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty21", this._ButtonSkin_SetProperty21);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty22_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "selectionBorderAlpha";
            _loc_1.value = 1;
            this._ButtonSkin_SetProperty22 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty22", this._ButtonSkin_SetProperty22);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty23_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "textColor";
            this._ButtonSkin_SetProperty23 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty23", this._ButtonSkin_SetProperty23);
            return _loc_1;
        }// end function

        private function _ButtonSkin_State7_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "disabled";
            _loc_1.overrides = [this._ButtonSkin_SetProperty24_i(), this._ButtonSkin_SetProperty25_i(), this._ButtonSkin_SetProperty26_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty24_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "selectionBorderAlpha";
            _loc_1.value = 0;
            this._ButtonSkin_SetProperty24 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty24", this._ButtonSkin_SetProperty24);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty25_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "backgroundBrightness";
            _loc_1.value = 0;
            this._ButtonSkin_SetProperty25 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty25", this._ButtonSkin_SetProperty25);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty26_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "textColor";
            this._ButtonSkin_SetProperty26 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty26", this._ButtonSkin_SetProperty26);
            return _loc_1;
        }// end function

        private function _ButtonSkin_State8_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "selectedDisabled";
            _loc_1.basedOn = "up";
            _loc_1.overrides = [this._ButtonSkin_SetProperty27_i(), this._ButtonSkin_SetProperty28_i(), this._ButtonSkin_SetProperty29_i(), this._ButtonSkin_SetProperty30_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty27_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "backgroundBrightness";
            _loc_1.value = 0;
            this._ButtonSkin_SetProperty27 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty27", this._ButtonSkin_SetProperty27);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty28_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "selectionBorderAlpha";
            _loc_1.value = 5;
            this._ButtonSkin_SetProperty28 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty28", this._ButtonSkin_SetProperty28);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty29_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "gradientAngle";
            _loc_1.value = 90;
            this._ButtonSkin_SetProperty29 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty29", this._ButtonSkin_SetProperty29);
            return _loc_1;
        }// end function

        private function _ButtonSkin_SetProperty30_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "textColor";
            this._ButtonSkin_SetProperty30 = _loc_1;
            BindingManager.executeBindings(this, "_ButtonSkin_SetProperty30", this._ButtonSkin_SetProperty30);
            return _loc_1;
        }// end function

        private function _ButtonSkin_Transition1_i() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "*";
            _loc_1.toState = "up";
            this.toUp = _loc_1;
            BindingManager.executeBindings(this, "toUp", this.toUp);
            return _loc_1;
        }// end function

        private function _ButtonSkin_Transition2_i() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "*";
            _loc_1.toState = "*";
            this.toEnabled = _loc_1;
            BindingManager.executeBindings(this, "toEnabled", this.toEnabled);
            return _loc_1;
        }// end function

        private function _ButtonSkin_Transition3_i() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "*";
            _loc_1.toState = "over";
            this.toOver = _loc_1;
            BindingManager.executeBindings(this, "toOver", this.toOver);
            return _loc_1;
        }// end function

        private function _ButtonSkin_Transition4_i() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "*";
            _loc_1.toState = "selectedUp";
            this.toUpSelected = _loc_1;
            BindingManager.executeBindings(this, "toUpSelected", this.toUpSelected);
            return _loc_1;
        }// end function

        private function _ButtonSkin_Transition5_i() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "*";
            _loc_1.toState = "selectedOver";
            this.toOverSelected = _loc_1;
            BindingManager.executeBindings(this, "toOverSelected", this.toOverSelected);
            return _loc_1;
        }// end function

        private function _ButtonSkin_Transition6_i() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "*";
            _loc_1.toState = "selectedDown";
            this.toDownSelected = _loc_1;
            BindingManager.executeBindings(this, "toDownSelected", this.toDownSelected);
            return _loc_1;
        }// end function

        private function _ButtonSkin_Transition7_i() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "*";
            _loc_1.toState = "disabled";
            this.toDisabled = _loc_1;
            BindingManager.executeBindings(this, "toDisabled", this.toDisabled);
            return _loc_1;
        }// end function

        public function ___ButtonSkin_UIComponent1_initialize(param1:FlexEvent) : void
        {
            this.creationCompleteHandler(param1);
            return;
        }// end function

        private function _ButtonSkin_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty1.target");
            result[1] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty2.target");
            result[2] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty3.target");
            result[3] = new Binding(this, function ()
            {
                return getStyle("color");
            }// end function
            , null, "_ButtonSkin_SetProperty4.value");
            result[4] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty4.target");
            result[5] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty5.target");
            result[6] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty6.target");
            result[7] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty7.target");
            result[8] = new Binding(this, function ()
            {
                return getStyle("textRollOverColor");
            }// end function
            , null, "_ButtonSkin_SetProperty8.value");
            result[9] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty8.target");
            result[10] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty9.target");
            result[11] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty10.target");
            result[12] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty11.target");
            result[13] = new Binding(this, function ()
            {
                return getStyle("color");
            }// end function
            , null, "_ButtonSkin_SetProperty12.value");
            result[14] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty12.target");
            result[15] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty13.target");
            result[16] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty14.target");
            result[17] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty15.target");
            result[18] = new Binding(this, function ()
            {
                return getStyle("textSelectedColor");
            }// end function
            , null, "_ButtonSkin_SetProperty16.value");
            result[19] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty16.target");
            result[20] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty17.target");
            result[21] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty18.target");
            result[22] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty19.target");
            result[23] = new Binding(this, function ()
            {
                return getStyle("textSelectedColor");
            }// end function
            , null, "_ButtonSkin_SetProperty20.value");
            result[24] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty20.target");
            result[25] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty21.target");
            result[26] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty22.target");
            result[27] = new Binding(this, function ()
            {
                return getStyle("textSelectedColor");
            }// end function
            , null, "_ButtonSkin_SetProperty23.value");
            result[28] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty23.target");
            result[29] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty24.target");
            result[30] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty25.target");
            result[31] = new Binding(this, function ()
            {
                return getStyle("disabledColor");
            }// end function
            , null, "_ButtonSkin_SetProperty26.value");
            result[32] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty26.target");
            result[33] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty27.target");
            result[34] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty28.target");
            result[35] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty29.target");
            result[36] = new Binding(this, function ()
            {
                return getStyle("textSelectedColor");
            }// end function
            , null, "_ButtonSkin_SetProperty30.value");
            result[37] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_ButtonSkin_SetProperty30.target");
            return result;
        }// end function

        public function get toDisabled() : Transition
        {
            return this._250872343toDisabled;
        }// end function

        public function set toDisabled(param1:Transition) : void
        {
            var _loc_2:* = this._250872343toDisabled;
            if (_loc_2 !== param1)
            {
                this._250872343toDisabled = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toDisabled", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get toDownSelected() : Transition
        {
            return this._334218376toDownSelected;
        }// end function

        public function set toDownSelected(param1:Transition) : void
        {
            var _loc_2:* = this._334218376toDownSelected;
            if (_loc_2 !== param1)
            {
                this._334218376toDownSelected = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toDownSelected", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get toEnabled() : Transition
        {
            return this._1022157894toEnabled;
        }// end function

        public function set toEnabled(param1:Transition) : void
        {
            var _loc_2:* = this._1022157894toEnabled;
            if (_loc_2 !== param1)
            {
                this._1022157894toEnabled = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toEnabled", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get toOver() : Transition
        {
            return this._869004817toOver;
        }// end function

        public function set toOver(param1:Transition) : void
        {
            var _loc_2:* = this._869004817toOver;
            if (_loc_2 !== param1)
            {
                this._869004817toOver = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toOver", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get toOverSelected() : Transition
        {
            return this._1994326442toOverSelected;
        }// end function

        public function set toOverSelected(param1:Transition) : void
        {
            var _loc_2:* = this._1994326442toOverSelected;
            if (_loc_2 !== param1)
            {
                this._1994326442toOverSelected = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toOverSelected", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get toUp() : Transition
        {
            return this._3565174toUp;
        }// end function

        public function set toUp(param1:Transition) : void
        {
            var _loc_2:* = this._3565174toUp;
            if (_loc_2 !== param1)
            {
                this._3565174toUp = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toUp", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get toUpSelected() : Transition
        {
            return this._1356588849toUpSelected;
        }// end function

        public function set toUpSelected(param1:Transition) : void
        {
            var _loc_2:* = this._1356588849toUpSelected;
            if (_loc_2 !== param1)
            {
                this._1356588849toUpSelected = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toUpSelected", _loc_2, param1));
                }
            }
            return;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
        {
            _watcherSetupUtil = param1;
            return;
        }// end function

    }
}
