package net.sprd.components.common.categoryselector
{
    import flash.events.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.effects.easing.*;
    import mx.events.*;
    import mx.styles.*;
    import net.sprd.components.common.*;

    public class CategorySelector extends VBox implements IBindingClient
    {
        private var _93090825arrow:Canvas;
        private var _3023688bigH:Resize;
        private var _1282133823fadeIn:Fade;
        private var _1091436750fadeOut:Fade;
        private var _898954207smallH:Resize;
        private var _114240sub:HBox;
        private var _1823608956subCategories:ComboBox;
        private var _1368194385topCategories:ComboBox;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;
        private var _1763739238_dataProvider:ICategoryProvider;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function CategorySelector()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._documentDescriptor_ = new UIComponentDescriptor({type:VBox, events:{initialize:"___CategorySelector_VBox1_initialize"}, stylesFactory:function () : void
            {
                this.paddingLeft = 4;
                this.paddingRight = 4;
                return;
            }// end function
            , propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:ComboBox, id:"topCategories", events:{change:"__topCategories_change", dataChange:"__topCategories_dataChange"}, propertiesFactory:function () : Object
                {
                    return {labelField:"name", width:260, height:22, buttonMode:true, rowCount:17};
                }// end function
                }), new UIComponentDescriptor({type:HBox, id:"sub", propertiesFactory:function () : Object
                {
                    return {childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"arrow", events:{initialize:"__arrow_initialize"}, propertiesFactory:function () : Object
                    {
                        return {cacheAsBitmap:true, width:12, height:22};
                    }// end function
                    }), new UIComponentDescriptor({type:ComboBox, id:"subCategories", events:{change:"__subCategories_change"}, propertiesFactory:function () : Object
                    {
                        return {width:240, height:22, rowCount:15, buttonMode:true};
                    }// end function
                    })]};
                }// end function
                })]};
            }// end function
            });
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            var bindings:* = this._CategorySelector_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_net_sprd_components_common_categoryselector_CategorySelectorWatcherSetupUtil");
                var _loc_2:* = watcherSetupUtilClass;
                _loc_2.watcherSetupUtilClass["init"](null);
            }
            _watcherSetupUtil.setup(this, function (param1:String)
            {
                return target[param1];
            }// end function
            , function (param1:String)
            {
                return CategorySelector[param1];
            }// end function
            , bindings, watchers);
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this._CategorySelector_Resize1_i();
            this._CategorySelector_Fade1_i();
            this._CategorySelector_Fade2_i();
            this._CategorySelector_Resize2_i();
            this.addEventListener("initialize", this.___CategorySelector_VBox1_initialize);
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
            var factory:* = param1;
            super.moduleFactory = factory;
            if (this.__moduleFactoryInitialized)
            {
                return;
            }
            this.__moduleFactoryInitialized = true;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration(null, styleManager);
            }
            this.styleDeclaration.defaultFactory = function () : void
            {
                this.paddingLeft = 4;
                this.paddingRight = 4;
                return;
            }// end function
            ;
            return;
        }// end function

        override public function initialize() : void
        {
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            super.initialize();
            return;
        }// end function

        public function set dataProvider(param1:ICategoryProvider) : void
        {
            this._dataProvider = param1;
            IEventDispatcher(this._dataProvider).addEventListener("categoryChanged", this.dataProvider_categoryChanged);
            return;
        }// end function

        private function init() : void
        {
            this.sub.endEffectsStarted();
            this.sub.visible = false;
            return;
        }// end function

        private function topCategories_changeHandler(param1:ListEvent) : void
        {
            this._dataProvider.selectTopCategory(param1.target.selectedItem.id);
            this.subCategories.dataProvider = this._dataProvider.subCategories;
            this.subCategories.labelField = "name";
            if (this._dataProvider.subCategories.length == 0)
            {
                if (this.sub.visible)
                {
                    this.sub.endEffectsStarted();
                    this.fadeOut.play();
                    this.smallH.play();
                }
            }
            else if (!this.sub.visible)
            {
                this.sub.endEffectsStarted();
                this.fadeIn.play();
                this.bigH.play();
            }
            return;
        }// end function

        private function subCategories_changeHandler(param1:ListEvent) : void
        {
            this._dataProvider.selectSubCategory(param1.target.selectedItem.id);
            return;
        }// end function

        private function arrowInit() : void
        {
            this.arrow.graphics.lineStyle(1, getStyle("arrowColor"));
            this.arrow.graphics.moveTo(8, -6);
            this.arrow.graphics.lineTo(8, 7);
            this.arrow.graphics.curveTo(9, 11, 14, 11);
            this.arrow.graphics.moveTo(12, 13);
            this.arrow.graphics.beginFill(getStyle("arrowColor"));
            this.arrow.graphics.lineTo(12, 8);
            this.arrow.graphics.lineTo(18, 11);
            this.arrow.graphics.lineTo(12, 13);
            this.arrow.graphics.endFill();
            return;
        }// end function

        private function dataProvider_categoryChanged(param1:Event) : void
        {
            if (this.sub.visible)
            {
            }
            if (this.topCategories.selectedIndex == 0)
            {
                this.fadeOut.play();
                this.smallH.play();
            }
            return;
        }// end function

        private function _CategorySelector_Resize1_i() : Resize
        {
            var _loc_1:* = new Resize();
            _loc_1.easingFunction = Exponential.easeOut;
            _loc_1.heightTo = 50;
            this.bigH = _loc_1;
            BindingManager.executeBindings(this, "bigH", this.bigH);
            return _loc_1;
        }// end function

        private function _CategorySelector_Fade1_i() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaFrom = 0;
            _loc_1.alphaTo = 1;
            _loc_1.addEventListener("tweenEnd", this.__fadeIn_tweenEnd);
            this.fadeIn = _loc_1;
            BindingManager.executeBindings(this, "fadeIn", this.fadeIn);
            return _loc_1;
        }// end function

        public function __fadeIn_tweenEnd(param1:TweenEvent) : void
        {
            this.sub.visible = true;
            return;
        }// end function

        private function _CategorySelector_Fade2_i() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaFrom = 1;
            _loc_1.alphaTo = 0;
            _loc_1.addEventListener("tweenEnd", this.__fadeOut_tweenEnd);
            this.fadeOut = _loc_1;
            BindingManager.executeBindings(this, "fadeOut", this.fadeOut);
            return _loc_1;
        }// end function

        public function __fadeOut_tweenEnd(param1:TweenEvent) : void
        {
            this.sub.visible = false;
            return;
        }// end function

        private function _CategorySelector_Resize2_i() : Resize
        {
            var _loc_1:* = new Resize();
            _loc_1.heightTo = 25;
            this.smallH = _loc_1;
            BindingManager.executeBindings(this, "smallH", this.smallH);
            return _loc_1;
        }// end function

        public function ___CategorySelector_VBox1_initialize(param1:FlexEvent) : void
        {
            this.init();
            return;
        }// end function

        public function __topCategories_change(param1:ListEvent) : void
        {
            this.topCategories_changeHandler(param1);
            return;
        }// end function

        public function __topCategories_dataChange(param1:FlexEvent) : void
        {
            this.dataProvider_categoryChanged(param1);
            return;
        }// end function

        public function __arrow_initialize(param1:FlexEvent) : void
        {
            this.arrowInit();
            return;
        }// end function

        public function __subCategories_change(param1:ListEvent) : void
        {
            this.subCategories_changeHandler(param1);
            return;
        }// end function

        private function _CategorySelector_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "bigH.target");
            result[1] = new Binding(this, function () : Object
            {
                return this;
            }// end function
            , null, "smallH.target");
            result[2] = new Binding(this, function () : Number
            {
                return FXDefaults.FADE_DURATION;
            }// end function
            , null, "fadeIn.duration");
            result[3] = new Binding(this, null, null, "fadeIn.target", "sub");
            result[4] = new Binding(this, function () : Number
            {
                return FXDefaults.FADE_DURATION;
            }// end function
            , null, "fadeOut.duration");
            result[5] = new Binding(this, null, null, "fadeOut.target", "sub");
            result[6] = new Binding(this, function () : Object
            {
                return _dataProvider.topCategories;
            }// end function
            , null, "topCategories.dataProvider");
            result[7] = new Binding(this, function () : Object
            {
                return _dataProvider.selectedTopCategory;
            }// end function
            , null, "topCategories.selectedItem");
            return result;
        }// end function

        public function get arrow() : Canvas
        {
            return this._93090825arrow;
        }// end function

        public function set arrow(param1:Canvas) : void
        {
            var _loc_2:* = this._93090825arrow;
            if (_loc_2 !== param1)
            {
                this._93090825arrow = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "arrow", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get bigH() : Resize
        {
            return this._3023688bigH;
        }// end function

        public function set bigH(param1:Resize) : void
        {
            var _loc_2:* = this._3023688bigH;
            if (_loc_2 !== param1)
            {
                this._3023688bigH = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bigH", _loc_2, param1));
                }
            }
            return;
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

        public function get fadeOut() : Fade
        {
            return this._1091436750fadeOut;
        }// end function

        public function set fadeOut(param1:Fade) : void
        {
            var _loc_2:* = this._1091436750fadeOut;
            if (_loc_2 !== param1)
            {
                this._1091436750fadeOut = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fadeOut", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get smallH() : Resize
        {
            return this._898954207smallH;
        }// end function

        public function set smallH(param1:Resize) : void
        {
            var _loc_2:* = this._898954207smallH;
            if (_loc_2 !== param1)
            {
                this._898954207smallH = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "smallH", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get sub() : HBox
        {
            return this._114240sub;
        }// end function

        public function set sub(param1:HBox) : void
        {
            var _loc_2:* = this._114240sub;
            if (_loc_2 !== param1)
            {
                this._114240sub = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sub", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get subCategories() : ComboBox
        {
            return this._1823608956subCategories;
        }// end function

        public function set subCategories(param1:ComboBox) : void
        {
            var _loc_2:* = this._1823608956subCategories;
            if (_loc_2 !== param1)
            {
                this._1823608956subCategories = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "subCategories", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get topCategories() : ComboBox
        {
            return this._1368194385topCategories;
        }// end function

        public function set topCategories(param1:ComboBox) : void
        {
            var _loc_2:* = this._1368194385topCategories;
            if (_loc_2 !== param1)
            {
                this._1368194385topCategories = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "topCategories", _loc_2, param1));
                }
            }
            return;
        }// end function

        private function get _dataProvider() : ICategoryProvider
        {
            return this._1763739238_dataProvider;
        }// end function

        private function set _dataProvider(param1:ICategoryProvider) : void
        {
            var _loc_2:* = this._1763739238_dataProvider;
            if (_loc_2 !== param1)
            {
                this._1763739238_dataProvider = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_dataProvider", _loc_2, param1));
                }
            }
            return;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
        {
            CategorySelector._watcherSetupUtil = param1;
            return;
        }// end function

    }
}
