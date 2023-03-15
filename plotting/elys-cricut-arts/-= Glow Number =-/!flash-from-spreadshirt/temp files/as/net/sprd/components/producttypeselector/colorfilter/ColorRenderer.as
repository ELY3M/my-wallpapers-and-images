package net.sprd.components.producttypeselector.colorfilter
{
    import flash.filters.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;

    public class ColorRenderer extends Box implements IBindingClient
    {
        public var _ColorRenderer_Canvas1:Canvas;
        private var _93630586bevel:BevelFilter;
        private var _3175821glow:GlowFilter;
        private var _786294436xLabel:Label;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function ColorRenderer()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._documentDescriptor_ = new UIComponentDescriptor({type:Box, stylesFactory:function () : void
            {
                this.paddingBottom = 0;
                this.paddingLeft = 2;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.backgroundAlpha = 0;
                return;
            }// end function
            , propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"_ColorRenderer_Canvas1", stylesFactory:function () : void
                {
                    this.borderStyle = "solid";
                    this.borderThickness = 0;
                    this.cornerRadius = 3;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {width:18, height:10, verticalCenter:0, horizontalCenter:0, childDescriptors:[new UIComponentDescriptor({type:Label, id:"xLabel", stylesFactory:function () : void
                    {
                        this.paddingTop = 0;
                        this.paddingBottom = 0;
                        this.fontSize = 8;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {x:0, y:-2, width:18, height:7, text:"-"};
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
            var bindings:* = this._ColorRenderer_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_net_sprd_components_producttypeselector_colorfilter_ColorRendererWatcherSetupUtil");
                var _loc_2:* = watcherSetupUtilClass;
                _loc_2.watcherSetupUtilClass["init"](null);
            }
            _watcherSetupUtil.setup(this, function (param1:String)
            {
                return target[param1];
            }// end function
            , function (param1:String)
            {
                return ColorRenderer[param1];
            }// end function
            , bindings, watchers);
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.percentWidth = 100;
            this.percentHeight = 100;
            this._ColorRenderer_BevelFilter1_i();
            this._ColorRenderer_GlowFilter1_i();
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
                this.paddingBottom = 0;
                this.paddingLeft = 2;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.backgroundAlpha = 0;
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

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            this.xLabel.visible = uint(data) == 16777215;
            return;
        }// end function

        private function _ColorRenderer_BevelFilter1_i() : BevelFilter
        {
            var _loc_1:* = new BevelFilter();
            _loc_1.distance = 2;
            _loc_1.angle = 90;
            _loc_1.highlightColor = 0;
            _loc_1.highlightAlpha = 0.1;
            _loc_1.shadowColor = 16777215;
            _loc_1.shadowAlpha = 0.1;
            _loc_1.quality = 2;
            _loc_1.strength = 3;
            this.bevel = _loc_1;
            BindingManager.executeBindings(this, "bevel", this.bevel);
            return _loc_1;
        }// end function

        private function _ColorRenderer_GlowFilter1_i() : GlowFilter
        {
            var _loc_1:* = new GlowFilter();
            _loc_1.inner = true;
            _loc_1.color = 0;
            _loc_1.alpha = 0.15;
            this.glow = _loc_1;
            BindingManager.executeBindings(this, "glow", this.glow);
            return _loc_1;
        }// end function

        private function _ColorRenderer_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, function () : uint
            {
                return int(data);
            }// end function
            , function (param1:uint) : void
            {
                _ColorRenderer_Canvas1.setStyle("backgroundColor", param1);
                return;
            }// end function
            , "_ColorRenderer_Canvas1.backgroundColor");
            result[1] = new Binding(this, function () : Array
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
            , null, "_ColorRenderer_Canvas1.filters");
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

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
        {
            ColorRenderer._watcherSetupUtil = param1;
            return;
        }// end function

    }
}
