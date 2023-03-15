package net.sprd.components.configurationtools
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
    import net.sprd.components.configurationcolorselector.*;
    import net.sprd.components.configurationfontselector.*;
    import net.sprd.models.product.*;

    public class ToolBox extends ToolBoxClass implements IBindingClient
    {
        public var _ToolBox_Button1:Button;
        public var _ToolBox_Button2:Button;
        public var _ToolBox_HRule1:HRule;
        public var _ToolBox_HRule2:HRule;
        private var _134645996hideButton:Resize;
        private var _1260535879hideToolBar:Move;
        private var _181273558hideToolPanel:Fade;
        private var _1674853213orientations:VBox;
        private var _1482680331panelMove:Move;
        private var _1707117674positions:VBox;
        private var _297401487showButton:Resize;
        private var _751965794showToolBar:Move;
        private var _1071693617showToolPanel:Fade;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function ToolBox()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._documentDescriptor_ = new UIComponentDescriptor({type:ToolBoxClass, stylesFactory:function () : void
            {
                this.borderStyle = "none";
                return;
            }// end function
            , propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:ToolBar, id:"toolBar", effects:["showEffect", "hideEffect"], stylesFactory:function () : void
                {
                    this.showEffect = "showToolBar";
                    this.hideEffect = "hideToolBar";
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {childDescriptors:[new UIComponentDescriptor({type:VBox, id:"colors", propertiesFactory:function () : Object
                    {
                        return {styleName:"toolGroup", childDescriptors:[new UIComponentDescriptor({type:PrintColorButton, id:"color1Btn", events:{click:"__color1Btn_click"}, propertiesFactory:function () : Object
                        {
                            return {data:0, width:29, height:25, styleName:"formButton"};
                        }// end function
                        }), new UIComponentDescriptor({type:PrintColorButton, id:"color2Btn", events:{click:"__color2Btn_click"}, propertiesFactory:function () : Object
                        {
                            return {data:1, width:29, height:25, styleName:"formButton"};
                        }// end function
                        }), new UIComponentDescriptor({type:PrintColorButton, id:"color3Btn", events:{click:"__color3Btn_click"}, propertiesFactory:function () : Object
                        {
                            return {data:2, width:29, height:25, styleName:"formButton"};
                        }// end function
                        }), new UIComponentDescriptor({type:ArrowButton, id:"textToolsBtn", events:{click:"__textToolsBtn_click"}, propertiesFactory:function () : Object
                        {
                            return {width:29, height:25, label:"T", styleName:"formButton"};
                        }// end function
                        })]};
                    }// end function
                    }), new UIComponentDescriptor({type:HRule, id:"_ToolBox_HRule1", propertiesFactory:function () : Object
                    {
                        return {styleName:"componentDevider"};
                    }// end function
                    }), new UIComponentDescriptor({type:VBox, id:"positions", propertiesFactory:function () : Object
                    {
                        return {styleName:"toolGroup", childDescriptors:[new UIComponentDescriptor({type:Button, id:"_ToolBox_Button1", events:{click:"___ToolBox_Button1_click"}, propertiesFactory:function () : Object
                        {
                            return {label:"", width:29, height:25, styleName:"horizontalCenterButton"};
                        }// end function
                        }), new UIComponentDescriptor({type:Button, id:"_ToolBox_Button2", events:{click:"___ToolBox_Button2_click"}, propertiesFactory:function () : Object
                        {
                            return {label:"", width:29, height:25, styleName:"absCenterButton"};
                        }// end function
                        })]};
                    }// end function
                    }), new UIComponentDescriptor({type:HRule, id:"_ToolBox_HRule2", propertiesFactory:function () : Object
                    {
                        return {styleName:"componentDevider"};
                    }// end function
                    }), new UIComponentDescriptor({type:VBox, id:"orientations", propertiesFactory:function () : Object
                    {
                        return {styleName:"toolGroup", childDescriptors:[new UIComponentDescriptor({type:Button, events:{click:"___ToolBox_Button3_click"}, propertiesFactory:function () : Object
                        {
                            return {width:29, height:25, label:"", styleName:"flipHButton"};
                        }// end function
                        }), new UIComponentDescriptor({type:Button, events:{click:"___ToolBox_Button4_click"}, propertiesFactory:function () : Object
                        {
                            return {width:29, height:25, label:"", styleName:"flipVButton"};
                        }// end function
                        })]};
                    }// end function
                    })]};
                }// end function
                }), new UIComponentDescriptor({type:NoticeMarker, id:"colorNotice", events:{click:"__colorNotice_click"}, effects:["showEffect", "hideEffect"], stylesFactory:function () : void
                {
                    this.showEffect = "showToolPanel";
                    this.hideEffect = "hideToolPanel";
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {width:200, height:20, right:51, top:12, data:0};
                }// end function
                }), new UIComponentDescriptor({type:TextTools, id:"textTools", effects:["showEffect", "hideEffect"], stylesFactory:function () : void
                {
                    this.showEffect = "showToolPanel";
                    this.hideEffect = "hideToolPanel";
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {width:200, visible:false, right:51, top:40};
                }// end function
                })]};
            }// end function
            });
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            var bindings:* = this._ToolBox_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_net_sprd_components_configurationtools_ToolBoxWatcherSetupUtil");
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
            this.clipContent = false;
            this._ToolBox_Resize2_i();
            this._ToolBox_Move2_i();
            this._ToolBox_Fade2_i();
            this._ToolBox_Move3_i();
            this._ToolBox_Resize1_i();
            this._ToolBox_Move1_i();
            this._ToolBox_Fade1_i();
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
                this.borderStyle = "none";
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

        override protected function createChildren() : void
        {
            super.createChildren();
            switch(ConfomatConfiguration.mode)
            {
                case ConfomatModes.ADMIN:
                {
                    colorPanel = new AdminPrintColorPanel();
                    break;
                }
                case ConfomatModes.D2C:
                case ConfomatModes.PARTNER:
                {
                    colorPanel = new D2CPrintColorPanel();
                    break;
                }
                default:
                {
                    throw new Error("Unknown confomat mode: \'" + ConfomatConfiguration.mode + "\'.");
                    break;
                }
            }
            colorPanel.width = 200;
            colorPanel.right = 51;
            colorPanel.setStyle("showEffect", this.showToolPanel);
            colorPanel.setStyle("hideEffect", this.hideToolPanel);
            colorPanel.setStyle("moveEffect", this.panelMove);
            addChild(colorPanel);
            return;
        }// end function

        private function _ToolBox_Resize2_i() : Resize
        {
            var _loc_1:* = new Resize();
            _loc_1.heightFrom = 0;
            _loc_1.heightTo = 25;
            this.hideButton = _loc_1;
            BindingManager.executeBindings(this, "hideButton", this.hideButton);
            return _loc_1;
        }// end function

        private function _ToolBox_Move2_i() : Move
        {
            var _loc_1:* = new Move();
            _loc_1.xBy = 50;
            _loc_1.easingFunction = Sine.easeIn;
            this.hideToolBar = _loc_1;
            BindingManager.executeBindings(this, "hideToolBar", this.hideToolBar);
            return _loc_1;
        }// end function

        private function _ToolBox_Fade2_i() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaFrom = 1;
            _loc_1.alphaTo = 0;
            this.hideToolPanel = _loc_1;
            BindingManager.executeBindings(this, "hideToolPanel", this.hideToolPanel);
            return _loc_1;
        }// end function

        private function _ToolBox_Move3_i() : Move
        {
            var _loc_1:* = new Move();
            _loc_1.duration = 300;
            this.panelMove = _loc_1;
            BindingManager.executeBindings(this, "panelMove", this.panelMove);
            return _loc_1;
        }// end function

        private function _ToolBox_Resize1_i() : Resize
        {
            var _loc_1:* = new Resize();
            _loc_1.heightFrom = 25;
            _loc_1.heightTo = 0;
            this.showButton = _loc_1;
            BindingManager.executeBindings(this, "showButton", this.showButton);
            return _loc_1;
        }// end function

        private function _ToolBox_Move1_i() : Move
        {
            var _loc_1:* = new Move();
            _loc_1.xBy = -50;
            _loc_1.easingFunction = Sine.easeOut;
            this.showToolBar = _loc_1;
            BindingManager.executeBindings(this, "showToolBar", this.showToolBar);
            return _loc_1;
        }// end function

        private function _ToolBox_Fade1_i() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaFrom = 0;
            _loc_1.alphaTo = 1;
            this.showToolPanel = _loc_1;
            BindingManager.executeBindings(this, "showToolPanel", this.showToolPanel);
            return _loc_1;
        }// end function

        public function __color1Btn_click(param1:MouseEvent) : void
        {
            onColorBtnClick(param1);
            return;
        }// end function

        public function __color2Btn_click(param1:MouseEvent) : void
        {
            onColorBtnClick(param1);
            return;
        }// end function

        public function __color3Btn_click(param1:MouseEvent) : void
        {
            onColorBtnClick(param1);
            return;
        }// end function

        public function __textToolsBtn_click(param1:MouseEvent) : void
        {
            onTextBtnClick(param1);
            return;
        }// end function

        public function ___ToolBox_Button1_click(param1:MouseEvent) : void
        {
            onDefaultPositionClick(param1);
            return;
        }// end function

        public function ___ToolBox_Button2_click(param1:MouseEvent) : void
        {
            onDefaultPositionClick(param1);
            return;
        }// end function

        public function ___ToolBox_Button3_click(param1:MouseEvent) : void
        {
            flip(-1, 1);
            return;
        }// end function

        public function ___ToolBox_Button4_click(param1:MouseEvent) : void
        {
            flip(1, -1);
            return;
        }// end function

        public function __colorNotice_click(param1:MouseEvent) : void
        {
            onColorNoticeClick(param1);
            return;
        }// end function

        private function _ToolBox_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, function () : Number
            {
                return FXDefaults.MOVE_DURATION;
            }// end function
            , null, "showToolBar.duration");
            result[1] = new Binding(this, function () : Number
            {
                return FXDefaults.MOVE_DURATION;
            }// end function
            , null, "hideToolBar.duration");
            result[2] = new Binding(this, function () : Number
            {
                return FXDefaults.FADE_DURATION;
            }// end function
            , null, "showToolPanel.duration");
            result[3] = new Binding(this, function () : Number
            {
                return FXDefaults.FADE_DURATION;
            }// end function
            , null, "hideToolPanel.duration");
            result[4] = new Binding(this, null, null, "toolBar.x", "width");
            result[5] = new Binding(this, function () : Number
            {
                return colors.width;
            }// end function
            , null, "_ToolBox_HRule1.width");
            result[6] = new Binding(this, function () : Object
            {
                return ConfigurationModelConstants.HORIZONTAL_CENTER;
            }// end function
            , null, "_ToolBox_Button1.data");
            result[7] = new Binding(this, function () : Object
            {
                return ConfigurationModelConstants.ABSOLUTE_CENTER;
            }// end function
            , null, "_ToolBox_Button2.data");
            result[8] = new Binding(this, function () : Number
            {
                return positions.width;
            }// end function
            , null, "_ToolBox_HRule2.width");
            result[9] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "toolbox.color_notice");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "colorNotice.notice");
            return result;
        }// end function

        public function get hideButton() : Resize
        {
            return this._134645996hideButton;
        }// end function

        public function set hideButton(param1:Resize) : void
        {
            var _loc_2:* = this._134645996hideButton;
            if (_loc_2 !== param1)
            {
                this._134645996hideButton = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hideButton", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get hideToolBar() : Move
        {
            return this._1260535879hideToolBar;
        }// end function

        public function set hideToolBar(param1:Move) : void
        {
            var _loc_2:* = this._1260535879hideToolBar;
            if (_loc_2 !== param1)
            {
                this._1260535879hideToolBar = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hideToolBar", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get hideToolPanel() : Fade
        {
            return this._181273558hideToolPanel;
        }// end function

        public function set hideToolPanel(param1:Fade) : void
        {
            var _loc_2:* = this._181273558hideToolPanel;
            if (_loc_2 !== param1)
            {
                this._181273558hideToolPanel = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hideToolPanel", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get orientations() : VBox
        {
            return this._1674853213orientations;
        }// end function

        public function set orientations(param1:VBox) : void
        {
            var _loc_2:* = this._1674853213orientations;
            if (_loc_2 !== param1)
            {
                this._1674853213orientations = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "orientations", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get panelMove() : Move
        {
            return this._1482680331panelMove;
        }// end function

        public function set panelMove(param1:Move) : void
        {
            var _loc_2:* = this._1482680331panelMove;
            if (_loc_2 !== param1)
            {
                this._1482680331panelMove = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "panelMove", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get positions() : VBox
        {
            return this._1707117674positions;
        }// end function

        public function set positions(param1:VBox) : void
        {
            var _loc_2:* = this._1707117674positions;
            if (_loc_2 !== param1)
            {
                this._1707117674positions = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "positions", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get showButton() : Resize
        {
            return this._297401487showButton;
        }// end function

        public function set showButton(param1:Resize) : void
        {
            var _loc_2:* = this._297401487showButton;
            if (_loc_2 !== param1)
            {
                this._297401487showButton = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showButton", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get showToolBar() : Move
        {
            return this._751965794showToolBar;
        }// end function

        public function set showToolBar(param1:Move) : void
        {
            var _loc_2:* = this._751965794showToolBar;
            if (_loc_2 !== param1)
            {
                this._751965794showToolBar = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showToolBar", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get showToolPanel() : Fade
        {
            return this._1071693617showToolPanel;
        }// end function

        public function set showToolPanel(param1:Fade) : void
        {
            var _loc_2:* = this._1071693617showToolPanel;
            if (_loc_2 !== param1)
            {
                this._1071693617showToolPanel = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showToolPanel", _loc_2, param1));
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
