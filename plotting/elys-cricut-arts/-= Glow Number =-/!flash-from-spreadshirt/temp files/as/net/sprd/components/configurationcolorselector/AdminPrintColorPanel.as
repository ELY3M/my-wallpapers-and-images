package net.sprd.components.configurationcolorselector
{
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;

    public class AdminPrintColorPanel extends AdminPrintColorPanelClass implements IBindingClient
    {
        private var _1980604081colorInfo:Canvas;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function AdminPrintColorPanel()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._documentDescriptor_ = new UIComponentDescriptor({type:AdminPrintColorPanelClass, propertiesFactory:function () : Object
            {
                return {width:200, childDescriptors:[new UIComponentDescriptor({type:VBox, propertiesFactory:function () : Object
                {
                    return {childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"colorInfo", propertiesFactory:function () : Object
                    {
                        return {styleName:"functionGroup", childDescriptors:[new UIComponentDescriptor({type:Label, id:"colorNameLabel", propertiesFactory:function () : Object
                        {
                            return {text:"", styleName:"toolPanelCopy", left:11, top:8};
                        }// end function
                        }), new UIComponentDescriptor({type:VBox, id:"adminPrintColors", stylesFactory:function () : void
                        {
                            this.paddingLeft = 10;
                            return;
                        }// end function
                        , propertiesFactory:function () : Object
                        {
                            return {top:30, label:"Print Type / Print Color", childDescriptors:[new UIComponentDescriptor({type:ComboBox, id:"adminPrintTypeSelector", events:{change:"__adminPrintTypeSelector_change"}, propertiesFactory:function () : Object
                            {
                                return {labelFunction:adminPrintTypeComboLabel, width:175};
                            }// end function
                            }), new UIComponentDescriptor({type:PrintColorList, id:"adminPrintColorList", events:{itemClick:"__adminPrintColorList_itemClick"}, propertiesFactory:function () : Object
                            {
                                return {top:20, columnCount:10, columnWidth:18, rowHeight:18, itemRenderer:_AdminPrintColorPanel_ClassFactory1_c(), showDataTips:true, width:175};
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
            var bindings:* = this._AdminPrintColorPanel_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_net_sprd_components_configurationcolorselector_AdminPrintColorPanelWatcherSetupUtil");
                var _loc_2:* = watcherSetupUtilClass;
                _loc_2.watcherSetupUtilClass["init"](null);
            }
            _watcherSetupUtil.setup(this, function (param1:String)
            {
                return target[param1];
            }// end function
            , function (param1:String)
            {
                return AdminPrintColorPanel[param1];
            }// end function
            , bindings, watchers);
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.width = 200;
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

        public function __adminPrintTypeSelector_change(param1:ListEvent) : void
        {
            onAdminPrintTypeChanged(param1);
            return;
        }// end function

        private function _AdminPrintColorPanel_ClassFactory1_c() : ClassFactory
        {
            var _loc_1:* = new ClassFactory();
            _loc_1.generator = PrintColorSwatch;
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        public function __adminPrintColorList_itemClick(param1:ListEvent) : void
        {
            onAdminPrintColorSelect(param1);
            return;
        }// end function

        private function _AdminPrintColorPanel_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "printtype_section.label_section_header");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "this.title");
            result[1] = new Binding(this, function () : Function
            {
                return buildColorToolTip;
            }// end function
            , null, "adminPrintColorList.dataTipFunction");
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

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
        {
            AdminPrintColorPanel._watcherSetupUtil = param1;
            return;
        }// end function

    }
}
