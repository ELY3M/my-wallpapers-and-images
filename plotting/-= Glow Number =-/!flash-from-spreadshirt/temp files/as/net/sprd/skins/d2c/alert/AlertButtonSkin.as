package net.sprd.skins.d2c.alert
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import mx.states.*;
    import mx.utils.*;
    import net.sprd.common.graphics.*;
    import net.sprd.components.common.*;

    public class AlertButtonSkin extends UIComponent implements IBindingClient
    {
        public var _AlertButtonSkin_AnimateProperty1:AnimateProperty;
        public var _AlertButtonSkin_AnimateProperty2:AnimateProperty;
        public var _AlertButtonSkin_AnimateProperty3:AnimateProperty;
        public var _AlertButtonSkin_AnimateProperty4:AnimateProperty;
        public var _AlertButtonSkin_SetProperty1:SetProperty;
        public var _AlertButtonSkin_SetProperty10:SetProperty;
        public var _AlertButtonSkin_SetProperty11:SetProperty;
        public var _AlertButtonSkin_SetProperty12:SetProperty;
        public var _AlertButtonSkin_SetProperty13:SetProperty;
        public var _AlertButtonSkin_SetProperty14:SetProperty;
        public var _AlertButtonSkin_SetProperty15:SetProperty;
        public var _AlertButtonSkin_SetProperty16:SetProperty;
        public var _AlertButtonSkin_SetProperty2:SetProperty;
        public var _AlertButtonSkin_SetProperty3:SetProperty;
        public var _AlertButtonSkin_SetProperty4:SetProperty;
        public var _AlertButtonSkin_SetProperty5:SetProperty;
        public var _AlertButtonSkin_SetProperty6:SetProperty;
        public var _AlertButtonSkin_SetProperty7:SetProperty;
        public var _AlertButtonSkin_SetProperty8:SetProperty;
        public var _AlertButtonSkin_SetProperty9:SetProperty;
        private var _869004817toOver:Transition;
        private var _1686462506toSelectedOver:Transition;
        private var _533598065toSelectedUp:Transition;
        private var _3565174toUp:Transition;
        private var __moduleFactoryInitialized:Boolean = false;
        private var _backgroundBrightness:Number = 0;
        private var _gradientAngle:Number = 90;
        private var _selectionAlpha:Number = 0;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function AlertButtonSkin()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            var bindings:* = this._AlertButtonSkin_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_net_sprd_skins_d2c_alert_AlertButtonSkinWatcherSetupUtil");
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
            this.states = [this._AlertButtonSkin_State1_c(), this._AlertButtonSkin_State2_c(), this._AlertButtonSkin_State3_c(), this._AlertButtonSkin_State4_c(), this._AlertButtonSkin_State5_c(), this._AlertButtonSkin_State6_c(), this._AlertButtonSkin_State7_c()];
            this.transitions = [this._AlertButtonSkin_Transition1_i(), this._AlertButtonSkin_Transition2_i(), this._AlertButtonSkin_Transition3_i(), this._AlertButtonSkin_Transition4_i()];
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

        public function get selectionAlpha() : Number
        {
            return this._selectionAlpha;
        }// end function

        public function set selectionAlpha(param1:Number) : void
        {
            this._selectionAlpha = param1;
            invalidateDisplayList();
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("fillColors").concat();
            var _loc_4:* = getStyle("fillAlphas");
            var _loc_5:* = getStyle("borderColor");
            var _loc_6:* = getStyle("borderAlpha");
            var _loc_7:* = getStyle("cornerRadius");
            var _loc_8:* = getStyle("selectionColor");
            var _loc_9:* = getStyle("dropShadowColor");
            _loc_3[0] = ColorUtil.adjustBrightness(_loc_3[0], this.backgroundBrightness);
            _loc_3[1] = ColorUtil.adjustBrightness(_loc_3[1], this.backgroundBrightness);
            var _loc_10:* = new Matrix();
            _loc_10.createGradientBox(param1, param2, UnitUtil.deg2rad(this.gradientAngle));
            graphics.clear();
            if (param2 != 0)
            {
            }
            if (param1 == 0)
            {
                return;
            }
            graphics.beginGradientFill(GradientType.LINEAR, _loc_3, _loc_4, [0, 166], _loc_10);
            graphics.drawRoundRect(0, 0, param1, param2, _loc_7, _loc_7);
            var _loc_11:* = new GlowFilter(_loc_5, 0.7, 2, 2, 1, BitmapFilterQuality.HIGH);
            var _loc_12:* = new GlowFilter(16777215, 0.7, 2, 2, 1, BitmapFilterQuality.HIGH, true);
            var _loc_13:* = new DropShadowFilter(1, 90, _loc_9, 0.35, 2, 2, 2, BitmapFilterQuality.HIGH);
            var _loc_14:* = new GlowFilter(_loc_8, this.selectionAlpha, 2, 2, 2, 3, true);
            var _loc_15:* = new GlowFilter(_loc_8, this.selectionAlpha, 2, 2, 2, 3, false);
            if (this.selectionAlpha == 0)
            {
                filters = [_loc_12, _loc_11, _loc_13];
            }
            else
            {
                filters = [_loc_14, _loc_15, _loc_13];
            }
            return;
        }// end function

        private function _AlertButtonSkin_State1_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "up";
            _loc_1.overrides = [this._AlertButtonSkin_SetProperty1_i(), this._AlertButtonSkin_SetProperty2_i(), this._AlertButtonSkin_SetProperty3_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_SetProperty1_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "selectionAlpha";
            _loc_1.value = 0;
            this._AlertButtonSkin_SetProperty1 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_SetProperty1", this._AlertButtonSkin_SetProperty1);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_SetProperty2_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "backgroundBrightness";
            _loc_1.value = 0;
            this._AlertButtonSkin_SetProperty2 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_SetProperty2", this._AlertButtonSkin_SetProperty2);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_SetProperty3_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "gradientAngle";
            _loc_1.value = 90;
            this._AlertButtonSkin_SetProperty3 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_SetProperty3", this._AlertButtonSkin_SetProperty3);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_State2_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "over";
            _loc_1.overrides = [this._AlertButtonSkin_SetProperty4_i(), this._AlertButtonSkin_SetProperty5_i(), this._AlertButtonSkin_SetProperty6_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_SetProperty4_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "selectionAlpha";
            _loc_1.value = 0;
            this._AlertButtonSkin_SetProperty4 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_SetProperty4", this._AlertButtonSkin_SetProperty4);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_SetProperty5_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "backgroundBrightness";
            _loc_1.value = -8;
            this._AlertButtonSkin_SetProperty5 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_SetProperty5", this._AlertButtonSkin_SetProperty5);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_SetProperty6_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "gradientAngle";
            _loc_1.value = -90;
            this._AlertButtonSkin_SetProperty6 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_SetProperty6", this._AlertButtonSkin_SetProperty6);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_State3_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "down";
            _loc_1.overrides = [this._AlertButtonSkin_SetProperty7_i(), this._AlertButtonSkin_SetProperty8_i(), this._AlertButtonSkin_SetProperty9_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_SetProperty7_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "selectionAlpha";
            _loc_1.value = 0;
            this._AlertButtonSkin_SetProperty7 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_SetProperty7", this._AlertButtonSkin_SetProperty7);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_SetProperty8_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "backgroundBrightness";
            _loc_1.value = -20;
            this._AlertButtonSkin_SetProperty8 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_SetProperty8", this._AlertButtonSkin_SetProperty8);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_SetProperty9_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "gradientAngle";
            _loc_1.value = -90;
            this._AlertButtonSkin_SetProperty9 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_SetProperty9", this._AlertButtonSkin_SetProperty9);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_State4_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "selectedUp";
            _loc_1.basedOn = "up";
            _loc_1.overrides = [this._AlertButtonSkin_SetProperty10_i(), this._AlertButtonSkin_SetProperty11_i(), this._AlertButtonSkin_SetProperty12_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_SetProperty10_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "backgroundBrightness";
            _loc_1.value = 0;
            this._AlertButtonSkin_SetProperty10 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_SetProperty10", this._AlertButtonSkin_SetProperty10);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_SetProperty11_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "gradientAngle";
            _loc_1.value = 90;
            this._AlertButtonSkin_SetProperty11 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_SetProperty11", this._AlertButtonSkin_SetProperty11);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_SetProperty12_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "selectionAlpha";
            _loc_1.value = 1;
            this._AlertButtonSkin_SetProperty12 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_SetProperty12", this._AlertButtonSkin_SetProperty12);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_State5_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "selectedOver";
            _loc_1.basedOn = "over";
            _loc_1.overrides = [this._AlertButtonSkin_SetProperty13_i(), this._AlertButtonSkin_SetProperty14_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_SetProperty13_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "gradientAngle";
            _loc_1.value = -90;
            this._AlertButtonSkin_SetProperty13 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_SetProperty13", this._AlertButtonSkin_SetProperty13);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_SetProperty14_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "selectionAlpha";
            _loc_1.value = 1;
            this._AlertButtonSkin_SetProperty14 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_SetProperty14", this._AlertButtonSkin_SetProperty14);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_State6_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "selectedDown";
            _loc_1.basedOn = "down";
            _loc_1.overrides = [this._AlertButtonSkin_SetProperty15_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_SetProperty15_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "selectionAlpha";
            _loc_1.value = 1;
            this._AlertButtonSkin_SetProperty15 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_SetProperty15", this._AlertButtonSkin_SetProperty15);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_State7_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "disabled";
            _loc_1.basedOn = "over";
            _loc_1.overrides = [this._AlertButtonSkin_SetProperty16_i()];
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_SetProperty16_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "alpha";
            _loc_1.value = 0.7;
            this._AlertButtonSkin_SetProperty16 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_SetProperty16", this._AlertButtonSkin_SetProperty16);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_Transition1_i() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "*";
            _loc_1.toState = "up";
            _loc_1.effect = this._AlertButtonSkin_AnimateProperty1_i();
            this.toUp = _loc_1;
            BindingManager.executeBindings(this, "toUp", this.toUp);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_AnimateProperty1_i() : AnimateProperty
        {
            var _loc_1:* = new AnimateProperty();
            _loc_1.property = "selectionAlpha";
            this._AlertButtonSkin_AnimateProperty1 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_AnimateProperty1", this._AlertButtonSkin_AnimateProperty1);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_Transition2_i() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "*";
            _loc_1.toState = "over";
            _loc_1.effect = this._AlertButtonSkin_AnimateProperty2_i();
            this.toOver = _loc_1;
            BindingManager.executeBindings(this, "toOver", this.toOver);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_AnimateProperty2_i() : AnimateProperty
        {
            var _loc_1:* = new AnimateProperty();
            _loc_1.property = "selectionAlpha";
            this._AlertButtonSkin_AnimateProperty2 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_AnimateProperty2", this._AlertButtonSkin_AnimateProperty2);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_Transition3_i() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "*";
            _loc_1.toState = "selectedUp";
            _loc_1.effect = this._AlertButtonSkin_AnimateProperty3_i();
            this.toSelectedUp = _loc_1;
            BindingManager.executeBindings(this, "toSelectedUp", this.toSelectedUp);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_AnimateProperty3_i() : AnimateProperty
        {
            var _loc_1:* = new AnimateProperty();
            _loc_1.property = "selectionAlpha";
            this._AlertButtonSkin_AnimateProperty3 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_AnimateProperty3", this._AlertButtonSkin_AnimateProperty3);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_Transition4_i() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "*";
            _loc_1.toState = "selectedOver";
            _loc_1.effect = this._AlertButtonSkin_AnimateProperty4_i();
            this.toSelectedOver = _loc_1;
            BindingManager.executeBindings(this, "toSelectedOver", this.toSelectedOver);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_AnimateProperty4_i() : AnimateProperty
        {
            var _loc_1:* = new AnimateProperty();
            _loc_1.property = "selectionAlpha";
            this._AlertButtonSkin_AnimateProperty4 = _loc_1;
            BindingManager.executeBindings(this, "_AlertButtonSkin_AnimateProperty4", this._AlertButtonSkin_AnimateProperty4);
            return _loc_1;
        }// end function

        private function _AlertButtonSkin_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_SetProperty1.target");
            result[1] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_SetProperty2.target");
            result[2] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_SetProperty3.target");
            result[3] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_SetProperty4.target");
            result[4] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_SetProperty5.target");
            result[5] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_SetProperty6.target");
            result[6] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_SetProperty7.target");
            result[7] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_SetProperty8.target");
            result[8] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_SetProperty9.target");
            result[9] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_SetProperty10.target");
            result[10] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_SetProperty11.target");
            result[11] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_SetProperty12.target");
            result[12] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_SetProperty13.target");
            result[13] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_SetProperty14.target");
            result[14] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_SetProperty15.target");
            result[15] = new Binding(this, null, null, "_AlertButtonSkin_SetProperty16.target", "parent");
            result[16] = new Binding(this, function () : Number
            {
                return FXDefaults.SHOW_SELECTION_DURATION;
            }// end function
            , null, "_AlertButtonSkin_AnimateProperty1.duration");
            result[17] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_AnimateProperty1.target");
            result[18] = new Binding(this, function () : Number
            {
                return FXDefaults.SHOW_SELECTION_DURATION;
            }// end function
            , null, "_AlertButtonSkin_AnimateProperty2.duration");
            result[19] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_AnimateProperty2.target");
            result[20] = new Binding(this, function () : Number
            {
                return FXDefaults.SHOW_SELECTION_DURATION;
            }// end function
            , null, "_AlertButtonSkin_AnimateProperty3.duration");
            result[21] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_AnimateProperty3.target");
            result[22] = new Binding(this, function () : Number
            {
                return FXDefaults.SHOW_SELECTION_DURATION;
            }// end function
            , null, "_AlertButtonSkin_AnimateProperty4.duration");
            result[23] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "_AlertButtonSkin_AnimateProperty4.target");
            return result;
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

        public function get toSelectedOver() : Transition
        {
            return this._1686462506toSelectedOver;
        }// end function

        public function set toSelectedOver(param1:Transition) : void
        {
            var _loc_2:* = this._1686462506toSelectedOver;
            if (_loc_2 !== param1)
            {
                this._1686462506toSelectedOver = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toSelectedOver", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get toSelectedUp() : Transition
        {
            return this._533598065toSelectedUp;
        }// end function

        public function set toSelectedUp(param1:Transition) : void
        {
            var _loc_2:* = this._533598065toSelectedUp;
            if (_loc_2 !== param1)
            {
                this._533598065toSelectedUp = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toSelectedUp", _loc_2, param1));
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

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
        {
            _watcherSetupUtil = param1;
            return;
        }// end function

    }
}
