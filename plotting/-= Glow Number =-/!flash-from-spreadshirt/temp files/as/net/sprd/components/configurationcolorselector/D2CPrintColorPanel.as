package net.sprd.components.configurationcolorselector
{
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;

    public class D2CPrintColorPanel extends D2CPrintColorPanelClass implements IBindingClient
    {
        private var _1980604081colorInfo:Canvas;
        private var _1796958329printType:RadioButtonGroup;
        private var _1797497067specialColorsLabel:Label;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function D2CPrintColorPanel()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._documentDescriptor_ = new UIComponentDescriptor({type:D2CPrintColorPanelClass, propertiesFactory:function () : Object
            {
                return {width:200, childDescriptors:[new UIComponentDescriptor({type:VBox, propertiesFactory:function () : Object
                {
                    return {childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"colorInfo", propertiesFactory:function () : Object
                    {
                        return {styleName:"functionGroup", childDescriptors:[new UIComponentDescriptor({type:Label, id:"colorNameLabel", propertiesFactory:function () : Object
                        {
                            return {text:"", styleName:"toolPanelCopy", left:11, top:8};
                        }// end function
                        }), new UIComponentDescriptor({type:TabNavigator, id:"printColors", events:{change:"__printColors_change"}, propertiesFactory:function () : Object
                        {
                            return {top:30, childDescriptors:[new UIComponentDescriptor({type:VBox, id:"foilTab", propertiesFactory:function () : Object
                            {
                                return {childDescriptors:[new UIComponentDescriptor({type:HBox, stylesFactory:function () : void
                                {
                                    this.paddingLeft = 11;
                                    return;
                                }// end function
                                , propertiesFactory:function () : Object
                                {
                                    return {childDescriptors:[new UIComponentDescriptor({type:RadioButton, id:"flexBtn", propertiesFactory:function () : Object
                                    {
                                        return {groupName:"printType"};
                                    }// end function
                                    }), new UIComponentDescriptor({type:RadioButton, id:"flockBtn", propertiesFactory:function () : Object
                                    {
                                        return {groupName:"printType"};
                                    }// end function
                                    })]};
                                }// end function
                                }), new UIComponentDescriptor({type:Box, stylesFactory:function () : void
                                {
                                    this.paddingLeft = 11;
                                    return;
                                }// end function
                                , propertiesFactory:function () : Object
                                {
                                    return {childDescriptors:[new UIComponentDescriptor({type:PrintColorList, id:"colors", events:{itemClick:"__colors_itemClick"}, propertiesFactory:function () : Object
                                    {
                                        return {columnCount:10, columnWidth:18, rowHeight:18, itemRenderer:_D2CPrintColorPanel_ClassFactory1_c(), showDataTips:true};
                                    }// end function
                                    })]};
                                }// end function
                                }), new UIComponentDescriptor({type:Canvas, id:"specialColorSection", propertiesFactory:function () : Object
                                {
                                    return {styleName:"functionGroup", childDescriptors:[new UIComponentDescriptor({type:Label, id:"specialColorsLabel", propertiesFactory:function () : Object
                                    {
                                        return {top:5, left:10, styleName:"toolPanelCopy"};
                                    }// end function
                                    }), new UIComponentDescriptor({type:PrintColorList, id:"specialColors", events:{itemClick:"__specialColors_itemClick"}, propertiesFactory:function () : Object
                                    {
                                        return {top:25, left:11, columnCount:10, columnWidth:18, rowHeight:18, itemRenderer:_D2CPrintColorPanel_ClassFactory2_c(), showDataTips:true};
                                    }// end function
                                    })]};
                                }// end function
                                })]};
                            }// end function
                            }), new UIComponentDescriptor({type:VBox, id:"digitalTab", stylesFactory:function () : void
                            {
                                this.paddingLeft = 10;
                                return;
                            }// end function
                            , propertiesFactory:function () : Object
                            {
                                return {childDescriptors:[new UIComponentDescriptor({type:PrintColorList, id:"digitalColors", events:{itemClick:"__digitalColors_itemClick"}, propertiesFactory:function () : Object
                                {
                                    return {top:20, columnCount:10, columnWidth:18, rowHeight:18, itemRenderer:_D2CPrintColorPanel_ClassFactory3_c(), showDataTips:true};
                                }// end function
                                })]};
                            }// end function
                            })]};
                        }// end function
                        })]};
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
            var bindings:* = this._D2CPrintColorPanel_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_net_sprd_components_configurationcolorselector_D2CPrintColorPanelWatcherSetupUtil");
                var _loc_2:* = watcherSetupUtilClass;
                _loc_2.watcherSetupUtilClass["init"](null);
            }
            _watcherSetupUtil.setup(this, function (param1:String)
            {
                return target[param1];
            }// end function
            , function (param1:String)
            {
                return D2CPrintColorPanel[param1];
            }// end function
            , bindings, watchers);
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.width = 200;
            this._D2CPrintColorPanel_RadioButtonGroup1_i();
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

        private function _D2CPrintColorPanel_RadioButtonGroup1_i() : RadioButtonGroup
        {
            var _loc_1:* = new RadioButtonGroup();
            _loc_1.addEventListener("itemClick", this.__printType_itemClick);
            _loc_1.initialized(this, "printType");
            this.printType = _loc_1;
            BindingManager.executeBindings(this, "printType", this.printType);
            return _loc_1;
        }// end function

        public function __printType_itemClick(param1:ItemClickEvent) : void
        {
            onCustomerRadioSelect(param1);
            return;
        }// end function

        public function __printColors_change(param1:IndexChangedEvent) : void
        {
            onCustomerPrintTypeChanged(param1);
            return;
        }// end function

        private function _D2CPrintColorPanel_ClassFactory1_c() : ClassFactory
        {
            var _loc_1:* = new ClassFactory();
            _loc_1.generator = PrintColorSwatch;
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        public function __colors_itemClick(param1:ListEvent) : void
        {
            onCustomerPrintColorSelect(param1);
            return;
        }// end function

        private function _D2CPrintColorPanel_ClassFactory2_c() : ClassFactory
        {
            var _loc_1:* = new ClassFactory();
            _loc_1.generator = PrintColorSwatch;
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        public function __specialColors_itemClick(param1:ListEvent) : void
        {
            onCustomerPrintColorSelect(param1);
            return;
        }// end function

        private function _D2CPrintColorPanel_ClassFactory3_c() : ClassFactory
        {
            var _loc_1:* = new ClassFactory();
            _loc_1.generator = PrintColorSwatch;
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        public function __digitalColors_itemClick(param1:ListEvent) : void
        {
            onCustomerPrintColorSelect(param1);
            return;
        }// end function

        private function _D2CPrintColorPanel_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "printtype_section.label_section_header");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "this.title");
            result[1] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "printtype_section.tab_foil_print");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "foilTab.label");
            result[2] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "printtype_section.label_flex_print");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "flexBtn.label");
            result[3] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "printtype_section.label_flock_print");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "flockBtn.label");
            result[4] = new Binding(this, function () : Function
            {
                return buildColorToolTip;
            }// end function
            , null, "colors.dataTipFunction");
            result[5] = new Binding(this, null, null, "specialColorSection.width", "width");
            result[6] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "printtype_section.label_special_print");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "specialColorsLabel.text");
            result[7] = new Binding(this, function () : Function
            {
                return buildColorToolTip;
            }// end function
            , null, "specialColors.dataTipFunction");
            result[8] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "printtype_section.tab_digital_print");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "digitalTab.label");
            result[9] = new Binding(this, function () : Function
            {
                return buildColorToolTip;
            }// end function
            , null, "digitalColors.dataTipFunction");
            return result;
        }// end function

        public function get colorInfo() : Canvas
        {
            return this._1980604081colorInfo;
        }// end function

        public function set colorInfo(param1:Canvas) : void
        {
            var _loc_2:* = this._1980604081colorInfo;
            if (_loc_2 !== param1)
            {
                this._1980604081colorInfo = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colorInfo", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get printType() : RadioButtonGroup
        {
            return this._1796958329printType;
        }// end function

        public function set printType(param1:RadioButtonGroup) : void
        {
            var _loc_2:* = this._1796958329printType;
            if (_loc_2 !== param1)
            {
                this._1796958329printType = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "printType", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get specialColorsLabel() : Label
        {
            return this._1797497067specialColorsLabel;
        }// end function

        public function set specialColorsLabel(param1:Label) : void
        {
            var _loc_2:* = this._1797497067specialColorsLabel;
            if (_loc_2 !== param1)
            {
                this._1797497067specialColorsLabel = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "specialColorsLabel", _loc_2, param1));
                }
            }
            return;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
        {
            D2CPrintColorPanel._watcherSetupUtil = param1;
            return;
        }// end function

    }
}
