package net.sprd.components.producttypeappeaeranceselector
{
    import flash.events.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import mx.states.*;
    import net.sprd.components.common.*;

    public class ProductColorSelector extends ProductColorSelectorClass implements IBindingClient
    {
        private var _1282133823fadeIn:Fade;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function ProductColorSelector()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._documentDescriptor_ = new UIComponentDescriptor({type:ProductColorSelectorClass, effects:["showEffect"], propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Image, id:"bgImage", events:{click:"__bgImage_click"}, propertiesFactory:function () : Object
                {
                    return {buttonMode:true, visible:false};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"swatchContainer", stylesFactory:function () : void
                {
                    this.borderStyle = "none";
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {x:28, y:28, horizontalScrollPolicy:"off", verticalScrollPolicy:"off"};
                }// end function
                })]};
            }// end function
            });
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            var bindings:* = this._ProductColorSelector_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_net_sprd_components_producttypeappeaeranceselector_ProductColorSelectorWatcherSetupUtil");
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
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.visible = false;
            this.alpha = 0;
            this.currentState = "open";
            this.states = [this._ProductColorSelector_State1_i(), this._ProductColorSelector_State2_i()];
            this.transitions = [this._ProductColorSelector_Transition1_c()];
            this._ProductColorSelector_Fade1_i();
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
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            super.initialize();
            return;
        }// end function

        private function _ProductColorSelector_Fade1_i() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaFrom = 0;
            _loc_1.alphaTo = 1;
            _loc_1.startDelay = 500;
            this.fadeIn = _loc_1;
            BindingManager.executeBindings(this, "fadeIn", this.fadeIn);
            return _loc_1;
        }// end function

        private function _ProductColorSelector_State1_i() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "closed";
            closedState = _loc_1;
            BindingManager.executeBindings(this, "closedState", closedState);
            return _loc_1;
        }// end function

        private function _ProductColorSelector_State2_i() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "open";
            openState = _loc_1;
            BindingManager.executeBindings(this, "openState", openState);
            return _loc_1;
        }// end function

        private function _ProductColorSelector_Transition1_c() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "*";
            _loc_1.toState = "open";
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        public function __bgImage_click(param1:MouseEvent) : void
        {
            swapStates();
            return;
        }// end function

        private function _ProductColorSelector_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, null, function (param1) : void
            {
                this.setStyle("showEffect", param1);
                return;
            }// end function
            , "this.showEffect", "fadeIn");
            result[1] = new Binding(this, function () : Number
            {
                return FXDefaults.FADE_DURATION;
            }// end function
            , null, "fadeIn.duration");
            result[2] = new Binding(this, function () : Object
            {
                return getStyle("image");
            }// end function
            , null, "bgImage.source");
            return result;
        }// end function

        public function get fadeIn() : Fade
        {
            return this._1282133823fadeIn;
        }// end function

        public function set fadeIn(param1:Fade) : void
        {
            var _loc_2:* = this._1282133823fadeIn;
            if (_loc_2 !== param1)
            {
                this._1282133823fadeIn = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fadeIn", _loc_2, param1));
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
