package net.sprd.components.configurationtools
{
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import net.sprd.common.colors.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.components.common.*;
    import net.sprd.components.configurationcolorselector.*;
    import net.sprd.components.configurationfontselector.*;
    import net.sprd.entities.*;
    import net.sprd.events.*;
    import net.sprd.models.product.*;

    public class ToolBoxClass extends Canvas
    {
        public var bus:IEventDispatcher;
        public var toolBar:ToolBar;
        public var textToolsBtn:ArrowButton;
        public var color1Btn:PrintColorButton;
        public var color2Btn:PrintColorButton;
        public var color3Btn:PrintColorButton;
        public var colors:VBox;
        public var textTools:TextTools;
        public var colorPanel:BasePrintColorPanel;
        public var colorNotice:NoticeMarker;
        private var _configuration:IConfigurationModel;
        private var _configurationChanged:Boolean;
        private var _hostsTextConfiguration:Boolean;
        private var _colorNoticeClicked:Boolean;
        private static const log:ILogger = LogContext.getLogger(this);

        public function ToolBoxClass()
        {
            return;
        }// end function

        protected function flip(param1:int, param2:int) : void
        {
            this._configuration.flipX = param1 * this._configuration.flipX;
            this._configuration.flipY = param2 * this._configuration.flipY;
            this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(this._configuration.product));
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_2:IUIComponent;
            super.measure();
            var _loc_3:* = this.toolBar.measuredHeight;
            measuredMinHeight = this.toolBar.measuredHeight;
            measuredHeight = _loc_3;
            var _loc_1:Number;
            for each (_loc_2 in getChildren())
            {
                
                _loc_1 = Math.max(_loc_1, _loc_2.getExplicitOrMeasuredWidth());
            }
            measuredWidth = _loc_1;
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this._configurationChanged)
            {
                this._configurationChanged = false;
                this._hostsTextConfiguration = this._configuration ? (this._configuration.type == ConfigurationType.TEXT) : (false);
            }
            if (this._configuration)
            {
            }
            if (stage)
            {
                this.updateConfigurationControls();
                this.colorPanel.configuration = this._configuration;
                if (this.colorPanel.targetColorIndex >= this._configuration.printColors.length)
                {
                    this.colorPanel.targetColorIndex = 0;
                }
                if (this._hostsTextConfiguration)
                {
                    this.textTools.configuration = this._configuration;
                    this.textTools.endEffectsStarted();
                    this.textTools.visible = true;
                    this.textToolsBtn.selected = true;
                    if (!this._colorNoticeClicked)
                    {
                        this.colorNotice.endEffectsStarted();
                        this.colorNotice.visible = true;
                    }
                    this.colorPanel.endEffectsStarted();
                    this.colorPanel.visible = false;
                }
                else
                {
                    this.textTools.endEffectsStarted();
                    this.textTools.visible = false;
                    this.colorNotice.endEffectsStarted();
                    this.colorNotice.visible = false;
                    this.colorPanel.endEffectsStarted();
                    if (this._configuration.rgbColors.length <= 0)
                    {
                    }
                    this.colorPanel.visible = ConfomatConfiguration.mode == ConfomatModes.ADMIN;
                    Button(this["color" + (this.colorPanel.targetColorIndex + 1) + "Btn"]).selected = true;
                }
                this.toolBar.endEffectsStarted();
                this.toolBar.visible = true;
            }
            else
            {
                this.toolBar.endEffectsStarted();
                this.toolBar.visible = false;
                this.textTools.endEffectsStarted();
                this.textTools.visible = false;
                this.colorPanel.endEffectsStarted();
                this.colorPanel.visible = false;
                this.colorNotice.endEffectsStarted();
                this.colorNotice.visible = false;
                this.colorPanel.configuration = null;
                this.textTools.configuration = null;
            }
            return;
        }// end function

        private function updateConfigurationControls(param1:Boolean = true) : void
        {
            var _loc_3:PrintColorButton;
            if (param1)
            {
                this.resetButtonSelectionState();
            }
            this.textToolsBtn.height = this._hostsTextConfiguration ? (25) : (0);
            this.color1Btn.height = 0;
            this.color2Btn.height = 0;
            this.color3Btn.height = 0;
            var _loc_2:uint;
            while (_loc_2++ < this._configuration.rgbColors.length)
            {
                
                _loc_3 = PrintColorButton(this["color" + (_loc_2 + 1) + "Btn"]);
                _loc_3.printType = this._configuration.printType;
                _loc_3.color = ColorUtil.getIntegerColor(this._configuration.rgbColors[_loc_2]);
                _loc_3.height = 25;
            }
            return;
        }// end function

        protected function onTextBtnClick(param1:MouseEvent) : void
        {
            this.colorPanel.endEffectsStarted();
            this.colorPanel.visible = false;
            this.textTools.endEffectsStarted();
            this.textTools.visible = true;
            this.resetButtonSelectionState();
            this.textToolsBtn.selected = true;
            return;
        }// end function

        protected function onColorBtnClick(param1:MouseEvent) : void
        {
            this.disableColorNotice();
            var _loc_2:* = param1.target.data ? (param1.target.data) : (0);
            this.colorPanel.targetColorIndex = _loc_2;
            this.colorPanel.endEffectsStarted();
            this.colorPanel.visible = true;
            this.textTools.endEffectsStarted();
            this.textTools.visible = false;
            this.resetButtonSelectionState();
            this["color" + (_loc_2 + 1) + "Btn"].selected = true;
            return;
        }// end function

        protected function onColorNoticeClick(param1:MouseEvent) : void
        {
            this.onColorBtnClick(param1);
            return;
        }// end function

        private function disableColorNotice() : void
        {
            this._colorNoticeClicked = true;
            this.colorNotice.endEffectsStarted();
            this.colorNotice.visible = false;
            return;
        }// end function

        protected function onDefaultPositionClick(param1:MouseEvent) : void
        {
            this._configuration.moveToDefaultPosition(Button(param1.currentTarget).data as String);
            this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(this._configuration.product));
            return;
        }// end function

        private function resetButtonSelectionState() : void
        {
            this.color1Btn.selected = false;
            this.color2Btn.selected = false;
            this.color3Btn.selected = false;
            this.textToolsBtn.selected = false;
            return;
        }// end function

        public function bus_configurationColorChangedHandler(param1:ConfigurationEvent) : void
        {
            if (this._configuration)
            {
                this.updateConfigurationControls(false);
            }
            return;
        }// end function

        public function bus_configurationSelectionChangedHandler(param1:ConfigurationEvent) : void
        {
            if (this._configuration == param1.configuration)
            {
                return;
            }
            this._configuration = param1.configuration;
            this._configurationChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function bus_configurationLayerSelectionChangedHandler(param1:ConfigurationEvent) : void
        {
            switch(param1.configuration.selectedLayerIndex)
            {
                case 0:
                {
                    this.color1Btn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    break;
                }
                case 1:
                {
                    this.color2Btn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    break;
                }
                case 2:
                {
                    this.color3Btn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function bus_configurationRemovedChangedHandler(param1:ConfigurationEvent) : void
        {
            if (this._configuration != null)
            {
            }
            if (this._configuration == param1.configuration)
            {
                this._configuration = null;
                this._configurationChanged = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function bus_configurationsInitializedChangedHandler(param1:ProductEvent) : void
        {
            this._configuration = null;
            this._configurationChanged = true;
            invalidateProperties();
            return;
        }// end function

    }
}
