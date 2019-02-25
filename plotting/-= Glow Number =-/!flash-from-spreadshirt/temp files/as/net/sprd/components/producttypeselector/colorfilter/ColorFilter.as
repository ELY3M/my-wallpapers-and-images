package net.sprd.components.producttypeselector.colorfilter
{
    import flash.filters.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import net.sprd.components.producttypeselector.*;

    public class ColorFilter extends Canvas implements IBindingClient
    {
        private var _93630586bevel:BevelFilter;
        private var _97427706field:Canvas;
        private var _3175821glow:GlowFilter;
        private var _592831722innerShadow:DropShadowFilter;
        private var _106851532popUp:PopUpButton;
        private var _786294436xLabel:Label;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;
        private var myTileList:TileList;
        private var _1763739238_dataProvider:ProductTypeSelectorModel;
        private var _dataProviderChanged:Boolean;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function ColorFilter()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:PopUpButton, id:"popUp", propertiesFactory:function () : Object
                {
                    return {width:48, height:18, styleName:"myPUB"};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"field", stylesFactory:function () : void
                {
                    this.backgroundColor = 16777215;
                    this.cornerRadius = 3;
                    this.borderThickness = 0;
                    this.borderStyle = "solid";
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {width:20, height:14, x:2, y:2, childDescriptors:[new UIComponentDescriptor({type:Label, id:"xLabel", stylesFactory:function () : void
                    {
                        this.textAlign = "center";
                        this.paddingTop = 0;
                        this.paddingBottom = 0;
                        this.fontSize = 8;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {x:2, y:0, width:12, height:14, text:"-"};
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
            var bindings:* = this._ColorFilter_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_net_sprd_components_producttypeselector_colorfilter_ColorFilterWatcherSetupUtil");
                var _loc_2:* = watcherSetupUtilClass;
                _loc_2.watcherSetupUtilClass["init"](null);
            }
            _watcherSetupUtil.setup(this, function (param1:String)
            {
                return target[param1];
            }// end function
            , function (param1:String)
            {
                return ColorFilter[param1];
            }// end function
            , bindings, watchers);
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this._ColorFilter_BevelFilter1_i();
            this._ColorFilter_GlowFilter1_i();
            this._ColorFilter_DropShadowFilter1_i();
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

        public function set dataProvider(param1:ProductTypeSelectorModel) : void
        {
            if (this._dataProvider == param1)
            {
                return;
            }
            this._dataProvider = param1;
            this._dataProviderChanged = true;
            invalidateProperties();
            return;
        }// end function

        private function initTileList() : void
        {
            this.myTileList = new ColorTileList();
            this.myTileList.width = 86;
            this.myTileList.height = Math.ceil(this._dataProvider.sortColors.length / 4) * 14;
            this.myTileList.columnCount = 4;
            this.myTileList.horizontalScrollPolicy = "off";
            this.myTileList.verticalScrollPolicy = "off";
            this.myTileList.dataProvider = this._dataProvider.sortColors;
            this.myTileList.itemRenderer = new ClassFactory(ColorRenderer);
            this.myTileList.addEventListener(ListEvent.ITEM_CLICK, this.onItemClick);
            this.popUp.popUp = this.myTileList;
            this.field.setStyle("backgroundColor", 16777215);
            return;
        }// end function

        private function onItemClick(param1:ListEvent) : void
        {
            var _loc_2:* = param1.target.selectedItem;
            this.field.setStyle("backgroundColor", _loc_2);
            this.xLabel.visible = uint(_loc_2) == 16777215;
            this._dataProvider.filterByAppearance(_loc_2);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this._dataProviderChanged)
            {
                this._dataProviderChanged = false;
                this.initTileList();
            }
            return;
        }// end function

        private function _ColorFilter_BevelFilter1_i() : BevelFilter
        {
            var _loc_1:* = new BevelFilter();
            _loc_1.distance = 2;
            _loc_1.angle = 90;
            _loc_1.highlightColor = 0;
            _loc_1.highlightAlpha = 0.1;
            _loc_1.shadowColor = 16777215;
            _loc_1.shadowAlpha = 0.4;
            _loc_1.quality = 2;
            _loc_1.strength = 3;
            this.bevel = _loc_1;
            BindingManager.executeBindings(this, "bevel", this.bevel);
            return _loc_1;
        }// end function

        private function _ColorFilter_GlowFilter1_i() : GlowFilter
        {
            var _loc_1:* = new GlowFilter();
            _loc_1.inner = true;
            _loc_1.color = 16777215;
            _loc_1.alpha = 1;
            _loc_1.strength = 1;
            this.glow = _loc_1;
            BindingManager.executeBindings(this, "glow", this.glow);
            return _loc_1;
        }// end function

        private function _ColorFilter_DropShadowFilter1_i() : DropShadowFilter
        {
            var _loc_1:* = new DropShadowFilter();
            _loc_1.color = 16777215;
            _loc_1.alpha = 0.2;
            _loc_1.inner = true;
            _loc_1.angle = -90;
            _loc_1.distance = 2;
            _loc_1.strength = 4;
            _loc_1.blurY = 4;
            _loc_1.blurX = 4;
            _loc_1.quality = 4;
            this.innerShadow = _loc_1;
            BindingManager.executeBindings(this, "innerShadow", this.innerShadow);
            return _loc_1;
        }// end function

        private function _ColorFilter_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, function () : Array
            {
                var _loc_1:*;
                if (_loc_1 != null)
                {
                }
                if (!(_loc_1 is Array))
                {
                }
                return _loc_1 is Proxy ? (_loc_1) : ([_loc_1]);
            }// end function
            , null, "field.filters");
            return result;
        }// end function

        public function get bevel() : BevelFilter
        {
            return this._93630586bevel;
        }// end function

        public function set bevel(param1:BevelFilter) : void
        {
            var _loc_2:* = this._93630586bevel;
            if (_loc_2 !== param1)
            {
                this._93630586bevel = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bevel", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get field() : Canvas
        {
            return this._97427706field;
        }// end function

        public function set field(param1:Canvas) : void
        {
            var _loc_2:* = this._97427706field;
            if (_loc_2 !== param1)
            {
                this._97427706field = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "field", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get glow() : GlowFilter
        {
            return this._3175821glow;
        }// end function

        public function set glow(param1:GlowFilter) : void
        {
            var _loc_2:* = this._3175821glow;
            if (_loc_2 !== param1)
            {
                this._3175821glow = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "glow", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get innerShadow() : DropShadowFilter
        {
            return this._592831722innerShadow;
        }// end function

        public function set innerShadow(param1:DropShadowFilter) : void
        {
            var _loc_2:* = this._592831722innerShadow;
            if (_loc_2 !== param1)
            {
                this._592831722innerShadow = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "innerShadow", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get popUp() : PopUpButton
        {
            return this._106851532popUp;
        }// end function

        public function set popUp(param1:PopUpButton) : void
        {
            var _loc_2:* = this._106851532popUp;
            if (_loc_2 !== param1)
            {
                this._106851532popUp = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "popUp", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get xLabel() : Label
        {
            return this._786294436xLabel;
        }// end function

        public function set xLabel(param1:Label) : void
        {
            var _loc_2:* = this._786294436xLabel;
            if (_loc_2 !== param1)
            {
                this._786294436xLabel = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "xLabel", _loc_2, param1));
                }
            }
            return;
        }// end function

        private function get _dataProvider() : ProductTypeSelectorModel
        {
            return this._1763739238_dataProvider;
        }// end function

        private function set _dataProvider(param1:ProductTypeSelectorModel) : void
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
            ColorFilter._watcherSetupUtil = param1;
            return;
        }// end function

    }
}
