package net.sprd.components.configurationfontselector
{
    import flash.events.*;
    import flash.utils.*;
    import flashx.textLayout.formats.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;

    public class TextTools extends TextToolsClass implements IBindingClient
    {
        private var _1983524646alignmentSettings:HBox;
        private var _534736274fontSettings:HBox;
        private var _906531004sizeSettings:HBox;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function TextTools()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._documentDescriptor_ = new UIComponentDescriptor({type:TextToolsClass, events:{initialize:"___TextTools_TextToolsClass1_initialize"}, propertiesFactory:function () : Object
            {
                return {width:200, childDescriptors:[new UIComponentDescriptor({type:VBox, propertiesFactory:function () : Object
                {
                    return {childDescriptors:[new UIComponentDescriptor({type:HBox, id:"fontSettings", stylesFactory:function () : void
                    {
                        this.horizontalGap = 5;
                        this.paddingLeft = 5;
                        this.paddingRight = 5;
                        this.paddingBottom = 4;
                        this.paddingTop = 4;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {styleName:"functionGroup", childDescriptors:[new UIComponentDescriptor({type:ComboBox, id:"fontFamilyCombo", events:{change:"__fontFamilyCombo_change"}, propertiesFactory:function () : Object
                        {
                            return {width:140, height:22, rowCount:15, prompt:"", labelField:"name", itemRenderer:_TextTools_ClassFactory1_c()};
                        }// end function
                        }), new UIComponentDescriptor({type:Button, id:"fontWeightButton", events:{click:"__fontWeightButton_click"}, propertiesFactory:function () : Object
                        {
                            return {styleName:"boldButton", width:20, height:20};
                        }// end function
                        }), new UIComponentDescriptor({type:Button, id:"fontStyleButton", events:{click:"__fontStyleButton_click"}, propertiesFactory:function () : Object
                        {
                            return {styleName:"italicButton", width:20, height:20};
                        }// end function
                        })]};
                    }// end function
                    }), new UIComponentDescriptor({type:HBox, id:"sizeSettings", stylesFactory:function () : void
                    {
                        this.horizontalGap = 5;
                        this.paddingLeft = 5;
                        this.paddingRight = 5;
                        this.paddingBottom = 4;
                        this.paddingTop = 4;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {styleName:"functionGroup", childDescriptors:[new UIComponentDescriptor({type:ComboBox, id:"fontSizeCombo", events:{close:"__fontSizeCombo_close", enter:"__fontSizeCombo_enter"}, propertiesFactory:function () : Object
                        {
                            return {width:140, height:22, rowCount:15, prompt:"", labelField:"name", editable:true};
                        }// end function
                        })]};
                    }// end function
                    }), new UIComponentDescriptor({type:HBox, id:"alignmentSettings", stylesFactory:function () : void
                    {
                        this.horizontalGap = 12;
                        this.paddingLeft = 6;
                        this.paddingRight = 6;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {childDescriptors:[new UIComponentDescriptor({type:Button, id:"alignLeftButton", events:{click:"__alignLeftButton_click"}, propertiesFactory:function () : Object
                        {
                            return {styleName:"alignLeftButton", width:38, height:25};
                        }// end function
                        }), new UIComponentDescriptor({type:Button, id:"alignCenterButton", events:{click:"__alignCenterButton_click"}, propertiesFactory:function () : Object
                        {
                            return {styleName:"alignCenterButton", width:38, height:25};
                        }// end function
                        }), new UIComponentDescriptor({type:Button, id:"alignRightButton", events:{click:"__alignRightButton_click"}, propertiesFactory:function () : Object
                        {
                            return {styleName:"alignRightButton", width:38, height:25};
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
            var bindings:* = this._TextTools_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_net_sprd_components_configurationfontselector_TextToolsWatcherSetupUtil");
                var _loc_2:* = watcherSetupUtilClass;
                _loc_2.watcherSetupUtilClass["init"](null);
            }
            _watcherSetupUtil.setup(this, function (param1:String)
            {
                return target[param1];
            }// end function
            , function (param1:String)
            {
                return TextTools[param1];
            }// end function
            , bindings, watchers);
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.width = 200;
            this.addEventListener("initialize", this.___TextTools_TextToolsClass1_initialize);
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

        public function ___TextTools_TextToolsClass1_initialize(param1:FlexEvent) : void
        {
            initFonts(param1);
            return;
        }// end function

        private function _TextTools_ClassFactory1_c() : ClassFactory
        {
            var _loc_1:* = new ClassFactory();
            _loc_1.generator = FontListRenderer;
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        public function __fontFamilyCombo_change(param1:ListEvent) : void
        {
            onFontChange(param1);
            return;
        }// end function

        public function __fontWeightButton_click(param1:MouseEvent) : void
        {
            onFontChange(param1);
            return;
        }// end function

        public function __fontStyleButton_click(param1:MouseEvent) : void
        {
            onFontChange(param1);
            return;
        }// end function

        public function __fontSizeCombo_close(param1:DropdownEvent) : void
        {
            onFontSizeChange(param1);
            return;
        }// end function

        public function __fontSizeCombo_enter(param1:FlexEvent) : void
        {
            onFontSizeChange(param1);
            return;
        }// end function

        public function __alignLeftButton_click(param1:MouseEvent) : void
        {
            onAlignmentChange(param1);
            return;
        }// end function

        public function __alignCenterButton_click(param1:MouseEvent) : void
        {
            onAlignmentChange(param1);
            return;
        }// end function

        public function __alignRightButton_click(param1:MouseEvent) : void
        {
            onAlignmentChange(param1);
            return;
        }// end function

        private function _TextTools_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "text_config_section.label_section_header");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "this.title");
            result[1] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "text_config_section.tooltip_font_selection");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "fontFamilyCombo.toolTip");
            result[2] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "text_config_section.tooltip_bold");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "fontWeightButton.toolTip");
            result[3] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "text_config_section.btn_bold");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "fontWeightButton.label");
            result[4] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "text_config_section.tooltip_italic");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "fontStyleButton.toolTip");
            result[5] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "text_config_section.btn_italic");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "fontStyleButton.label");
            result[6] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "text_config_section.tooltip_fontsize_slider");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "fontSizeCombo.toolTip");
            result[7] = new Binding(this, function () : Object
            {
                return TextAlign.LEFT;
            }// end function
            , null, "alignLeftButton.data");
            result[8] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "text_config_section.tooltip_text_align_left");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "alignLeftButton.toolTip");
            result[9] = new Binding(this, function () : Object
            {
                return TextAlign.CENTER;
            }// end function
            , null, "alignCenterButton.data");
            result[10] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "text_config_section.tooltip_text_align_center");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "alignCenterButton.toolTip");
            result[11] = new Binding(this, function () : Object
            {
                return TextAlign.RIGHT;
            }// end function
            , null, "alignRightButton.data");
            result[12] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "text_config_section.tooltip_text_align_right");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "alignRightButton.toolTip");
            return result;
        }// end function

        public function get alignmentSettings() : HBox
        {
            return this._1983524646alignmentSettings;
        }// end function

        public function set alignmentSettings(param1:HBox) : void
        {
            var _loc_2:* = this._1983524646alignmentSettings;
            if (_loc_2 !== param1)
            {
                this._1983524646alignmentSettings = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alignmentSettings", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get fontSettings() : HBox
        {
            return this._534736274fontSettings;
        }// end function

        public function set fontSettings(param1:HBox) : void
        {
            var _loc_2:* = this._534736274fontSettings;
            if (_loc_2 !== param1)
            {
                this._534736274fontSettings = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fontSettings", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get sizeSettings() : HBox
        {
            return this._906531004sizeSettings;
        }// end function

        public function set sizeSettings(param1:HBox) : void
        {
            var _loc_2:* = this._906531004sizeSettings;
            if (_loc_2 !== param1)
            {
                this._906531004sizeSettings = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sizeSettings", _loc_2, param1));
                }
            }
            return;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
        {
            TextTools._watcherSetupUtil = param1;
            return;
        }// end function

    }
}
