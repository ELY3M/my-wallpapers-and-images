package net.sprd.components.basket
{
    import flash.events.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import net.sprd.components.common.*;
    import net.sprd.skins.d2c.buttons.*;

    public class Basket extends BasketClass implements IBindingClient
    {
        private var _1282133823fadeIn:Fade;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function Basket()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._documentDescriptor_ = new UIComponentDescriptor({type:BasketClass, effects:["showEffect"], propertiesFactory:function () : Object
            {
                return {width:300, height:60, childDescriptors:[new UIComponentDescriptor({type:ProgressButton, id:"addToBasketButton", events:{click:"__addToBasketButton_click"}, propertiesFactory:function () : Object
                {
                    return {width:148, height:48, styleName:"prioOne", useHandCursor:true, buttonMode:true, x:154};
                }// end function
                }), new UIComponentDescriptor({type:ProgressButton, id:"updateProductButton", events:{click:"__updateProductButton_click"}, propertiesFactory:function () : Object
                {
                    return {width:148, height:48, styleName:"prioOne", visible:false, useHandCursor:true, buttonMode:true, x:154, label:"Update Product", progressLabel:"in progress"};
                }// end function
                }), new UIComponentDescriptor({type:LinkButton, id:"vatNoticeLabel", events:{click:"__vatNoticeLabel_click", rollOver:"__vatNoticeLabel_rollOver", rollOut:"__vatNoticeLabel_rollOut"}, stylesFactory:function () : void
                {
                    this.textAlign = "right";
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {styleName:"priceNotesLabel", width:100, bottom:10, visible:false};
                }// end function
                }), new UIComponentDescriptor({type:LinkButton, id:"shippingNoticeLabel", events:{click:"__shippingNoticeLabel_click", rollOver:"__shippingNoticeLabel_rollOver", rollOut:"__shippingNoticeLabel_rollOut"}, stylesFactory:function () : void
                {
                    this.textAlign = "right";
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {styleName:"priceNotesLabel", width:100, visible:false};
                }// end function
                })]};
            }// end function
            });
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            var bindings:* = this._Basket_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_net_sprd_components_basket_BasketWatcherSetupUtil");
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
            this.width = 300;
            this.height = 60;
            this.clipContent = false;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.visible = false;
            this.alpha = 0;
            this._Basket_Fade1_i();
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

        private function basketLabel() : String
        {
            return resourceManager.getString("confomat7", "basket_section.btn_add_to_basket");
        }// end function

        private function _Basket_Fade1_i() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaFrom = 0;
            _loc_1.alphaTo = 1;
            _loc_1.startDelay = 500;
            this.fadeIn = _loc_1;
            BindingManager.executeBindings(this, "fadeIn", this.fadeIn);
            return _loc_1;
        }// end function

        public function __addToBasketButton_click(param1:MouseEvent) : void
        {
            onAddToBasketClick(param1);
            return;
        }// end function

        public function __updateProductButton_click(param1:MouseEvent) : void
        {
            onUpdateProductClick(param1);
            return;
        }// end function

        public function __vatNoticeLabel_click(param1:MouseEvent) : void
        {
            externalAPI.displayTaxDetails();
            return;
        }// end function

        public function __vatNoticeLabel_rollOver(param1:MouseEvent) : void
        {
            vatNoticeLabel.styleName = "priceNotesLabelHover";
            return;
        }// end function

        public function __vatNoticeLabel_rollOut(param1:MouseEvent) : void
        {
            vatNoticeLabel.styleName = "priceNotesLabel";
            return;
        }// end function

        public function __shippingNoticeLabel_click(param1:MouseEvent) : void
        {
            externalAPI.displayShippingDetails();
            return;
        }// end function

        public function __shippingNoticeLabel_rollOver(param1:MouseEvent) : void
        {
            shippingNoticeLabel.styleName = "priceNotesLabelHover";
            return;
        }// end function

        public function __shippingNoticeLabel_rollOut(param1:MouseEvent) : void
        {
            shippingNoticeLabel.styleName = "priceNotesLabel";
            return;
        }// end function

        private function _Basket_bindingsSetup() : Array
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
            result[2] = new Binding(this, function () : String
            {
                var _loc_1:* = basketLabel();
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "addToBasketButton.label");
            result[3] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "universal.in_progress");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "addToBasketButton.progressLabel");
            result[4] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "basket_section.label_incl_VAT");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "vatNoticeLabel.label");
            result[5] = new Binding(this, function () : Number
            {
                return addToBasketButton.x - 112;
            }// end function
            , null, "vatNoticeLabel.x");
            result[6] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "basket_section.label_excl_shipping");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "shippingNoticeLabel.label");
            result[7] = new Binding(this, function () : Number
            {
                return addToBasketButton.x - 112;
            }// end function
            , null, "shippingNoticeLabel.x");
            result[8] = new Binding(this, function () : Object
            {
                return ConfomatConfiguration.platform == ConfomatConfiguration.PLATFORM_EU ? (-3) : (10);
            }// end function
            , null, "shippingNoticeLabel.bottom");
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
