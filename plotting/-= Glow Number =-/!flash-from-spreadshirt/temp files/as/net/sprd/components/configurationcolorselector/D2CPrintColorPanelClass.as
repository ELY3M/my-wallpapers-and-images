package net.sprd.components.configurationcolorselector
{
    import flash.events.*;
    import flash.geom.*;
    import flashx.textLayout.edit.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import net.sprd.api.*;
    import net.sprd.common.collections.*;
    import net.sprd.common.colors.*;
    import net.sprd.common.utils.*;
    import net.sprd.entities.*;
    import net.sprd.entities.impl.*;
    import net.sprd.events.*;
    import net.sprd.models.product.*;
    import net.sprd.models.product.rules.*;

    public class D2CPrintColorPanelClass extends BasePrintColorPanel
    {
        private var _796137859printColors:TabNavigator;
        public var bus:IEventDispatcher;
        public var colors:TileList;
        public var specialColors:TileList;
        public var digitalColors:TileList;
        public var flexBtn:RadioButton;
        public var flockBtn:RadioButton;
        public var foilTab:VBox;
        public var digitalTab:VBox;
        private var _2024363685specialColorSection:UIComponent;
        public var colorNameLabel:Label;
        private var _textFlow:TextFlow;
        private var _textSelectionChanged:Boolean;
        private var _configuration:IConfigurationModel;
        private var _configurationChanged:Boolean;
        private var _printTypeChanged:Boolean;
        private var _colorChanged:Boolean;
        private var _sizeChanged:Boolean;
        private var _availablePlotTypes:Array;
        private var _availableDigitalTypes:Array;
        private var _currentPrintColor:IPrintColor;
        private var _currentPrintType:IPrintType;
        private var _cachedBounds:Rectangle;
        private var _productTypeAppearanceChanged:Boolean;

        public function D2CPrintColorPanelClass()
        {
            this._cachedBounds = new Rectangle();
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
                    this._textFlow = this._configuration.textFlow;
                    this._textFlow.addEventListener(SelectionEvent.SELECTION_CHANGE, this.onTextSelectionChanged);
                }
                else
                {
                    this._textFlow = null;
                }
            }
            this._configurationChanged = true;
            invalidateProperties();
            return;
        }// end function

        protected function buildColorToolTip(param1:IPrintColor) : String
        {
            return StringUtil.ucwords(param1.name);
        }// end function

        private function updatePrintTypes() : void
        {
            var _loc_1:IPrintType;
            if (!this._configuration)
            {
                return;
            }
            this._availablePlotTypes = new Array();
            this._availableDigitalTypes = new Array();
            for each (_loc_1 in this._configuration.getPossiblePrintTypes())
            {
                
                if (_loc_1.lifeCycleState != LifeCycleState.ACTIVATED)
                {
                    continue;
                }
                if (_loc_1.colorSpace == ColorSpace.PRINTCOLORS)
                {
                    this._availablePlotTypes.push(_loc_1);
                    continue;
                }
                this._availableDigitalTypes.push(_loc_1);
            }
            invalidateDisplayList();
            return;
        }// end function

        private function updateControls() : void
        {
            var _loc_3:String;
            var _loc_4:ITextLayoutFormat;
            var _loc_5:uint;
            var _loc_6:IPrintColor;
            if (!this._configuration)
            {
                return;
            }
            this.digitalTab.enabled = this._availableDigitalTypes.length > 0;
            this.foilTab.enabled = this._availablePlotTypes.length > 0;
            var _loc_1:* = this._configuration.printType;
            var _loc_2:* = _loc_1.colorSpace == ColorSpace.PRINTCOLORS ? (0) : (1);
            this.printColors.selectedIndex = _loc_2;
            if (_loc_2 == 1)
            {
            }
            if (!this.digitalColors)
            {
                callLater(this.updateControls);
                return;
            }
            if (this.printColors.selectedIndex == 0)
            {
                if (_loc_1.id != PrintType.FLEX)
                {
                }
                this.flexBtn.selected = _loc_1.id == PrintType.SPECIALFLEX;
                this.flockBtn.selected = _loc_1.id == PrintType.FLOCK;
            }
            if (this.printColors.selectedIndex == 0)
            {
                this.flexBtn.enabled = this.printTypeIsAvailable(PrintType.FLEX);
                this.flockBtn.enabled = this.printTypeIsAvailable(PrintType.FLOCK);
            }
            if (this.printColors.selectedIndex == 0)
            {
                if (this._configuration.type == ConfigurationType.DESIGN)
                {
                    _loc_3 = this._configuration.printColors[targetColorIndex];
                    this._currentPrintColor = this.printColorForId(_loc_3);
                }
                else
                {
                    _loc_4 = this._textFlow.interactionManager.getCommonCharacterFormat();
                    if (_loc_4)
                    {
                    }
                    if (_loc_4.color != null)
                    {
                        this._currentPrintColor = PrintTypeRules.getPrintColorForRGBColor(_loc_1, Color.fromHex(_loc_4.color));
                    }
                    else
                    {
                        this._currentPrintColor = null;
                    }
                }
                if (this._configuration.printType.id != PrintType.SPECIALFLEX)
                {
                    this.specialColors.selectedItem = null;
                    this.colors.selectedItem = this._currentPrintColor;
                }
                else
                {
                    this.colors.selectedItem = null;
                    this.specialColors.selectedItem = this._currentPrintColor;
                }
                if (this.digitalColors)
                {
                    this.digitalColors.selectedItem = null;
                }
            }
            else
            {
                if (this._configuration.type == ConfigurationType.DESIGN)
                {
                    _loc_5 = this._configuration.rgbColors[targetColorIndex];
                    for each (_loc_6 in PrintTypeRules.digiColors)
                    {
                        
                        if (ColorUtil.getIntegerColor(_loc_6.hexCode) == _loc_5)
                        {
                            this._currentPrintColor = _loc_6;
                            break;
                        }
                    }
                }
                else
                {
                    _loc_4 = this._textFlow.interactionManager.getCommonCharacterFormat();
                    if (_loc_4)
                    {
                    }
                    if (_loc_4.color)
                    {
                        this._currentPrintColor = PrintTypeRules.getClosestPrintColorForRGBColor(PrintTypeRules.digiColors, Color.fromHex(_loc_4.color));
                    }
                    else
                    {
                        this._currentPrintColor = null;
                    }
                }
                this.digitalColors.selectedItem = this._currentPrintColor;
                this.specialColors.selectedItem = null;
                this.colors.selectedItem = null;
            }
            if (this._currentPrintColor)
            {
                this.colorNameLabel.text = resourceManager.getString("confomat7", "printtype_section.printtype_section_current_color") + " " + StringUtil.ucwords(this._currentPrintColor.name);
            }
            invalidateDisplayList();
            return;
        }// end function

        private function updatePrintColors() : void
        {
            var _loc_1:IPrintType;
            var _loc_2:Array;
            var _loc_3:IPrintType;
            if (!this._configuration)
            {
                return;
            }
            if (this._configuration.printType.colorSpace == ColorSpace.PRINTCOLORS)
            {
                _loc_1 = this._configuration.printType;
                _loc_2 = [];
                if (_loc_1.id != PrintType.FLEX)
                {
                }
                if (_loc_1.id == PrintType.FLOCK)
                {
                    _loc_2 = CollectionUtil.asArray(PrintTypeRules.printColorsFromPrintType(_loc_1));
                }
                else
                {
                    _loc_2 = CollectionUtil.asArray(PrintTypeRules.printColorsFromPrintType(this.printTypeForId(PrintType.FLEX)));
                }
                this.colors.dataProvider = _loc_2;
                if (!this.printTypeIsAvailable(PrintType.SPECIALFLEX))
                {
                    this.specialColorSection.enabled = false;
                }
                else
                {
                    this.specialColorSection.enabled = true;
                    _loc_3 = this.printTypeForId(PrintType.SPECIALFLEX);
                    this.specialColors.dataProvider = CollectionUtil.asArray(PrintTypeRules.printColorsFromPrintType(_loc_3));
                }
            }
            else if (this.digitalColors)
            {
                this.digitalColors.dataProvider = PrintTypeRules.digiColors;
            }
            this.updateControls();
            return;
        }// end function

        private function printTypeIsAvailable(param1:String) : Boolean
        {
            var printTypeID:* = param1;
            var testTypes:* = this._availableDigitalTypes.concat(this._availablePlotTypes);
            return testTypes.some(function (param1:IPrintType, param2:int, param3:Array) : Boolean
            {
                return param1.id == printTypeID;
            }// end function
            );
        }// end function

        private function printTypeForId(param1:String) : IPrintType
        {
            return IPrintType(API.em.get(param1, APIRegistry.PRINT_TYPE));
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
                        this.setNewColorForD2C(_loc_7);
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

        private function setNewColorForD2C(param1:IPrintColor) : void
        {
            var _loc_2:Array;
            var _loc_3:String;
            var _loc_4:uint;
            var _loc_5:SelectionState;
            if (this._configuration.type == ConfigurationType.DESIGN)
            {
                if (this._configuration.printType.colorSpace == ColorSpace.PRINTCOLORS)
                {
                    _loc_2 = this._configuration.printColors.concat();
                    for each (_loc_3 in _loc_2)
                    {
                        
                        if (this.printTypeForPrintColor(this.printColorForId(_loc_3)).id == PrintType.SPECIALFLEX)
                        {
                            this.replacePrintColorsForPrintType(this._currentPrintType);
                            _loc_2 = this._configuration.printColors.concat();
                        }
                    }
                    if (this._currentPrintType)
                    {
                    }
                    if (this._currentPrintType.id == PrintType.SPECIALFLEX)
                    {
                        _loc_4 = 0;
                        while (_loc_4++ < _loc_2.length)
                        {
                            
                            _loc_2[_loc_4] = param1.id;
                        }
                    }
                    else
                    {
                        _loc_2.splice(targetColorIndex, 1, param1.id);
                    }
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
                _loc_5 = this._textFlow.interactionManager.getSelectionState();
                if (this.printTypeForPrintColor(param1).id == PrintType.SPECIALFLEX)
                {
                    _loc_5 = new SelectionState(this._textFlow, 0, this._textFlow.textLength);
                }
                if (_loc_5.absoluteStart == _loc_5.absoluteEnd)
                {
                    _loc_5 = new SelectionState(this._textFlow, 0, this._textFlow.textLength);
                }
                this._configuration.setColorOnTextSelection(_loc_5, param1);
                this._textFlow.interactionManager.setFocus();
            }
            return;
        }// end function

        private function printTypeForPrintColor(param1:IPrintColor) : IPrintType
        {
            var _loc_2:IPrintType;
            var _loc_3:IPrintType;
            if (this.printColors.selectedIndex == 0)
            {
                for each (_loc_3 in this._availablePlotTypes)
                {
                    
                    if (_loc_3.printColors.indexOf(param1.id) > -1)
                    {
                        _loc_2 = _loc_3;
                        break;
                    }
                }
            }
            else
            {
                _loc_2 = this._configuration.printType;
            }
            return _loc_2;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this._configurationChanged)
            {
                this._configurationChanged = false;
                this._currentPrintType = this._configuration ? (this._configuration.printType) : (null);
                this.updatePrintTypes();
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
                this.updatePrintTypes();
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
                this.updatePrintTypes();
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

        protected function onCustomerPrintTypeChanged(param1:IndexChangedEvent) : void
        {
            if (param1.newIndex == 0)
            {
            }
            if (this._availablePlotTypes.length == 0)
            {
                return;
            }
            if (param1.newIndex == 1)
            {
            }
            if (this._availableDigitalTypes.length == 0)
            {
                return;
            }
            if (!this._configuration)
            {
                return;
            }
            var _loc_2:* = param1.newIndex == 0 ? (PrintTypeRules.findMatchingPrintType(this._configuration.product.getPreferredPrintTypeForPrintColorSpace(true), this._availablePlotTypes)) : (PrintTypeRules.findMatchingPrintType(this._configuration.product.getPreferredPrintTypeForPrintColorSpace(false), this._availableDigitalTypes));
            if (_loc_2 == this._configuration.printType)
            {
                return;
            }
            this._configuration.printType = _loc_2;
            this._currentPrintType = this._configuration.printType;
            this._printTypeChanged = true;
            invalidateProperties();
            this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(this.configuration.product));
            return;
        }// end function

        private function onTextSelectionChanged(param1:SelectionEvent) : void
        {
            this._textSelectionChanged = true;
            invalidateProperties();
            return;
        }// end function

        protected function onCustomerRadioSelect(param1:ItemClickEvent) : void
        {
            var _loc_2:String;
            if (param1.index == 0)
            {
                _loc_2 = PrintType.FLEX;
            }
            if (param1.index == 1)
            {
                _loc_2 = PrintType.FLOCK;
            }
            this._configuration.printType = this.printTypeForId(_loc_2);
            this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(this.configuration.product));
            return;
        }// end function

        protected function onCustomerPrintColorSelect(param1:ListEvent) : void
        {
            var _loc_2:* = IPrintColor(param1.itemRenderer.data);
            var _loc_3:* = this.printTypeForPrintColor(_loc_2);
            if (_loc_3 != this._currentPrintType)
            {
                this._configuration.printType = _loc_3;
            }
            this.setNewColorForD2C(_loc_2);
            this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(this.configuration.product));
            return;
        }// end function

        public function get printColors() : TabNavigator
        {
            return this._796137859printColors;
        }// end function

        public function set printColors(param1:TabNavigator) : void
        {
            var _loc_2:* = this._796137859printColors;
            if (_loc_2 !== param1)
            {
                this._796137859printColors = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "printColors", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get specialColorSection() : UIComponent
        {
            return this._2024363685specialColorSection;
        }// end function

        public function set specialColorSection(param1:UIComponent) : void
        {
            var _loc_2:* = this._2024363685specialColorSection;
            if (_loc_2 !== param1)
            {
                this._2024363685specialColorSection = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "specialColorSection", _loc_2, param1));
                }
            }
            return;
        }// end function

    }
}
