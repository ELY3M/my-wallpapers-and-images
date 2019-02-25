package net.sprd.components.configurationcolorselector
{
    import flash.events.*;
    import flash.geom.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.events.*;
    import net.sprd.api.*;
    import net.sprd.common.collections.*;
    import net.sprd.common.colors.*;
    import net.sprd.common.utils.*;
    import net.sprd.entities.*;
    import net.sprd.events.*;
    import net.sprd.models.product.*;
    import net.sprd.models.product.rules.*;

    public class AdminPrintColorPanelClass extends BasePrintColorPanel
    {
        public var bus:IEventDispatcher;
        public var adminPrintColors:VBox;
        public var adminPrintTypeSelector:ComboBox;
        public var adminPrintColorList:TileList;
        public var colorNameLabel:Label;
        private var _textFlow:TextFlow;
        private var _textSelectionChanged:Boolean;
        private var _configuration:IConfigurationModel;
        private var _configurationChanged:Boolean;
        private var _printTypeChanged:Boolean;
        private var _colorChanged:Boolean;
        private var _sizeChanged:Boolean;
        private var _currentPrintColor:IPrintColor;
        private var _currentPrintType:IPrintType;
        private var _cachedBounds:Rectangle;
        private var _productTypeAppearanceChanged:Boolean;

        public function AdminPrintColorPanelClass()
        {
            this._cachedBounds = new Rectangle();
            hasCloseButton = false;
            return;
        }// end function

        public function get configuration() : IConfigurationModel
        {
            return this._configuration;
        }// end function

        override public function set configuration(param1:IConfigurationModel) : void
        {
            if (this._configuration == param1)
            {
                return;
            }
            if (this._textFlow)
            {
                this._textFlow.removeEventListener(SelectionEvent.SELECTION_CHANGE, this.onTextSelectionChanged);
            }
            this._configuration = param1;
            if (this._configuration)
            {
                if (this._configuration.type == ConfigurationType.TEXT)
                {
                    this.adminPrintColorList.visible = true;
                    this._textFlow = this._configuration.textFlow;
                    this._textFlow.addEventListener(SelectionEvent.SELECTION_CHANGE, this.onTextSelectionChanged);
                }
                else
                {
                    this._textFlow = null;
                    this.adminPrintColorList.visible = this._configuration.design.isVectorDesign;
                }
            }
            this._configurationChanged = true;
            if (this._configuration)
            {
                this.adminPrintTypeSelector.dataProvider = CollectionUtil.concatAsArray(this._configuration.getPossiblePrintTypes());
                this.adminPrintTypeSelector.selectedItem = this._configuration.printType;
            }
            invalidateProperties();
            return;
        }// end function

        protected function buildColorToolTip(param1:IPrintColor) : String
        {
            return StringUtil.ucwords(param1.name);
        }// end function

        private function updateControls() : void
        {
            var _loc_1:ITextLayoutFormat;
            var _loc_2:String;
            var _loc_3:uint;
            var _loc_4:IPrintColor;
            if (!this._configuration)
            {
                return;
            }
            if (this._configuration.printType.colorSpace == ColorSpace.PRINTCOLORS)
            {
                if (this._configuration.type == ConfigurationType.DESIGN)
                {
                    _loc_2 = this._configuration.printColors[targetColorIndex];
                    this._currentPrintColor = this.printColorForId(_loc_2);
                }
                else
                {
                    _loc_1 = this._textFlow.interactionManager.getCommonCharacterFormat();
                    if (_loc_1)
                    {
                    }
                    if (_loc_1.color != null)
                    {
                        this._currentPrintColor = PrintTypeRules.getPrintColorForRGBColor(this._configuration.printType, Color.fromHex(_loc_1.color));
                    }
                    else
                    {
                        this._currentPrintColor = null;
                    }
                }
            }
            else if (this._configuration.type == ConfigurationType.DESIGN)
            {
                _loc_3 = this._configuration.rgbColors[targetColorIndex];
                for each (_loc_4 in PrintTypeRules.digiColors)
                {
                    
                    if (ColorUtil.getIntegerColor(_loc_4.hexCode) == _loc_3)
                    {
                        this._currentPrintColor = _loc_4;
                        break;
                    }
                }
            }
            else
            {
                _loc_1 = this._textFlow.interactionManager.getCommonCharacterFormat();
                if (_loc_1)
                {
                }
                if (_loc_1.color)
                {
                    this._currentPrintColor = PrintTypeRules.getClosestPrintColorForRGBColor(PrintTypeRules.digiColors, Color.fromHex(_loc_1.color));
                }
                else
                {
                    this._currentPrintColor = null;
                }
            }
            this.adminPrintColorList.selectedItem = this._currentPrintColor;
            return;
        }// end function

        private function updatePrintColors() : void
        {
            if (!this._configuration)
            {
                return;
            }
            if (this._configuration.printType.colorSpace == ColorSpace.PRINTCOLORS)
            {
                this.adminPrintColorList.dataProvider = CollectionUtil.asArray(PrintTypeRules.printColorsFromPrintType(this._configuration.printType));
            }
            else
            {
                this.adminPrintColorList.dataProvider = PrintTypeRules.digiColors;
            }
            this.updateControls();
            return;
        }// end function

        private function printColorForId(param1:String) : IPrintColor
        {
            return IPrintColor(API.em.get(param1, APIRegistry.PRINT_COLOR));
        }// end function

        private function replacePrintColorsForPrintType(param1:IPrintType) : void
        {
            var _loc_2:SelectionState;
            var _loc_3:uint;
            var _loc_4:uint;
            var _loc_5:uint;
            var _loc_6:ITextLayoutFormat;
            var _loc_7:IPrintColor;
            var _loc_8:Array;
            var _loc_9:String;
            var _loc_10:IPrintColor;
            if (!this._configuration)
            {
                return;
            }
            if (this._configuration.type == ConfigurationType.TEXT)
            {
                _loc_2 = this._textFlow.interactionManager.getSelectionState();
                _loc_3 = NaN;
                _loc_4 = 0;
                _loc_5 = 0;
                while (_loc_5--++ < this._textFlow.textLength)
                {
                    
                    _loc_6 = this._textFlow.interactionManager.getCommonCharacterFormat(new TextRange(this._textFlow, _loc_5, _loc_5 + 1));
                    if (_loc_3)
                    {
                    }
                    if (_loc_6.color == _loc_3)
                    {
                    }
                    if (_loc_5 == this._textFlow.textLength - 1)
                    {
                        if (param1.colorSpace == ColorSpace.PRINTCOLORS)
                        {
                            _loc_7 = PrintTypeRules.getPrintColorForRGBColor(param1, Color.fromHex(_loc_3));
                        }
                        else
                        {
                            _loc_7 = PrintTypeRules.getClosestPrintColorForRGBColor(PrintTypeRules.digiColors, Color.fromHex(_loc_3));
                        }
                        this._textFlow.interactionManager.selectRange(_loc_4, _loc_5);
                        this.setNewColorForAdmin(_loc_7);
                        _loc_4 = _loc_5;
                        if (_loc_5 < this._textFlow.textLength - 1)
                        {
                        }
                        _loc_3 = NaN;
                        continue;
                    }
                    _loc_3 = _loc_6.color;
                }
                this._textFlow.interactionManager.selectRange(_loc_2.anchorPosition, _loc_2.activePosition);
            }
            else if (this._configuration.type == ConfigurationType.DESIGN)
            {
                _loc_8 = [];
                if (param1.colorSpace == ColorSpace.PRINTCOLORS)
                {
                    for each (_loc_9 in this._configuration.rgbColors)
                    {
                        
                        _loc_8.push(PrintTypeRules.getPrintColorForRGBColor(param1, Color.fromHex(ColorUtil.getIntegerColor(_loc_9))).id);
                    }
                }
                else
                {
                    for each (_loc_9 in this._configuration.rgbColors)
                    {
                        
                        for each (_loc_10 in PrintTypeRules.digiColors)
                        {
                            
                            if (_loc_10.hexCode == _loc_9)
                            {
                                _loc_8.push(_loc_9);
                                break;
                            }
                        }
                    }
                }
                if (_loc_8.length == this._configuration.rgbColors.length)
                {
                    this._configuration.printColors = _loc_8;
                }
            }
            return;
        }// end function

        private function setNewColorForAdmin(param1:IPrintColor) : void
        {
            var _loc_2:Array;
            var _loc_3:SelectionState;
            if (this._configuration.type == ConfigurationType.DESIGN)
            {
                if (this._configuration.printType.colorSpace == ColorSpace.PRINTCOLORS)
                {
                    _loc_2 = this._configuration.printColors.concat();
                    _loc_2.splice(targetColorIndex, 1, param1.id);
                    this._configuration.printColors = _loc_2;
                }
                else
                {
                    _loc_2 = this._configuration.rgbColors.concat();
                    _loc_2.splice(targetColorIndex, 1, ColorUtil.getIntegerColor(param1.hexCode));
                    this._configuration.rgbColors = _loc_2;
                }
            }
            else
            {
                _loc_3 = this._textFlow.interactionManager.getSelectionState();
                this._configuration.setColorOnTextSelection(_loc_3, param1);
                this._textFlow.interactionManager.setFocus();
            }
            return;
        }// end function

        protected function adminPrintTypeComboLabel(param1:IPrintType) : String
        {
            return param1.name + " (" + param1.id + ")";
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this._configurationChanged)
            {
                this._configurationChanged = false;
                this._currentPrintType = this._configuration ? (this._configuration.printType) : (null);
                this.updateControls();
                callLater(this.updatePrintColors);
            }
            if (this._textSelectionChanged)
            {
                this._textSelectionChanged = false;
                this.updateControls();
            }
            if (this._sizeChanged)
            {
                this._sizeChanged = false;
                this.updateControls();
            }
            if (this._colorChanged)
            {
                this._colorChanged = false;
                this.updateControls();
            }
            if (this._printTypeChanged)
            {
                this._printTypeChanged = false;
                this.updatePrintColors();
                this.replacePrintColorsForPrintType(this._currentPrintType);
                this.updateControls();
            }
            if (this._productTypeAppearanceChanged)
            {
                this._productTypeAppearanceChanged = false;
                this.updateControls();
            }
            if (_targetColorIndexChanged)
            {
                _targetColorIndexChanged = false;
                this.updateControls();
                invalidateDisplayList();
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            move(x, targetColorIndex * 30);
            return;
        }// end function

        public function bus_configurationTransformationChangedHandler(param1:ConfigurationEvent) : void
        {
            if (param1.configuration != this._configuration)
            {
                return;
            }
            if (this._configuration.width == this._cachedBounds.width)
            {
            }
            if (this._configuration.height != this._cachedBounds.height)
            {
                this._cachedBounds = new Rectangle(this._configuration.offset.x, this._configuration.offset.y, this._configuration.width, this._configuration.height);
                this._sizeChanged = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function bus_configurationPrintTypeChangedHandler(param1:ConfigurationEvent) : void
        {
            if (param1.configuration != this._configuration)
            {
                return;
            }
            this._currentPrintType = this._configuration.printType;
            this._printTypeChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function bus_configurationColorChangedHandler(param1:ConfigurationEvent) : void
        {
            if (param1.configuration != this._configuration)
            {
                return;
            }
            this._colorChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function bus_productTypeAppearanceChangedHandler(param1:ProductTypeEvent) : void
        {
            this._productTypeAppearanceChanged = true;
            this._printTypeChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function bus_productTypeChangedHandler(param1:ProductTypeEvent) : void
        {
            this._productTypeAppearanceChanged = true;
            this._printTypeChanged = true;
            invalidateProperties();
            return;
        }// end function

        private function onTextSelectionChanged(param1:SelectionEvent) : void
        {
            this._textSelectionChanged = true;
            invalidateProperties();
            return;
        }// end function

        protected function onAdminPrintColorSelect(param1:ListEvent) : void
        {
            var _loc_2:* = IPrintColor(param1.itemRenderer.data);
            this.setNewColorForAdmin(_loc_2);
            this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(this.configuration.product));
            return;
        }// end function

        protected function onAdminPrintTypeChanged(param1:ListEvent) : void
        {
            this._configuration.printType = param1.target.selectedItem;
            this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(this.configuration.product));
            return;
        }// end function

    }
}
