package net.sprd.models.product
{
    import ConfigurationModel.as$807.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import flashx.textLayout.edit.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;
    import net.sprd.api.*;
    import net.sprd.common.colors.*;
    import net.sprd.common.graphics.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.entities.*;
    import net.sprd.entities.impl.*;
    import net.sprd.events.*;
    import net.sprd.graphics.svg.*;
    import net.sprd.graphics.svg.transformations.*;
    import net.sprd.models.common.*;
    import net.sprd.models.product.errors.*;
    import net.sprd.models.product.renderer.*;
    import net.sprd.models.product.rules.*;
    import net.sprd.models.product.texthandling.*;
    import net.sprd.text.*;
    import net.sprd.valueObjects.*;

    public class ConfigurationModel extends EventDispatcher implements IConfigurationModel
    {
        public var bus:IEventDispatcher;
        private var _configuration:IConfiguration;
        private var _printArea:IPrintArea;
        private var _printType:IPrintType;
        private var _state:uint = 0;
        private var renderer:IConfigurationRenderer;
        private var _testSprite:Sprite;
        private var _layers:Array;
        private var _product:IProductModel;
        private var _unscaledWidth:Number = 1;
        private var _unscaledHeight:Number = 1;
        private var _flipX:int = 1;
        private var _flipY:int = 1;
        private var _rotation:Number = 0;
        private var _testTextFlow:TextFlow;
        private var _textFlow:TextFlow;
        private var _horizontalTextAutoStretch:Boolean = false;
        private var _allowConstraintError:Boolean = false;
        private var _textOfferedForDeletion:Boolean;
        private var _isDefaultConfiguration:Boolean;
        private var _selectedLayerIndex:int;
        private var _textOperationStrategy:ITextOperationStrategy;
        private var _autoCorrection:Boolean = false;
        private static const log:ILogger = LogContext.getLogger(this);

        public function ConfigurationModel(param1:String = null)
        {
            this._configuration = new Configuration();
            this._layers = [];
            if (param1)
            {
                this._configuration.id = param1;
            }
            return;
        }// end function

        public function initializeFromSVG(param1:ISVGShape, param2:Point, param3:Number, param4:Number, param5:IProductModel, param6:Boolean = true) : void
        {
            this._configuration.svgContent = param1;
            this._configuration.offset = param2;
            this._configuration.svgContent.width = param3;
            this._configuration.svgContent.height = param4;
            if (param6)
            {
                API.em.add(this._configuration);
            }
            this._product = param5;
            this.initializeFromSVGInternal();
            this.recalculateSVGTransformation(param3, param4);
            this.updateDependencies();
            return;
        }// end function

        public function initializeFromDeserializedConfiguration(param1:IConfiguration, param2:IProductModel) : void
        {
            this._product = param2;
            this._configuration = param1;
            this.initializeFromSVGInternal();
            this.updateDependencies();
            return;
        }// end function

        public function get state() : int
        {
            return this._state;
        }// end function

        public function get configurationID() : String
        {
            return this._configuration.id;
        }// end function

        public function get type() : String
        {
            return this._configuration.type;
        }// end function

        public function set type(param1:String) : void
        {
            if (param1 == this.type)
            {
                return;
            }
            if (param1 != ConfigurationType.TEXT)
            {
            }
            if (param1 != ConfigurationType.DESIGN)
            {
                throw new Error("Invalid configuration type " + param1);
            }
            this._configuration.type = param1;
            return;
        }// end function

        public function get printArea() : IPrintArea
        {
            return this._printArea;
        }// end function

        public function set printArea(param1:IPrintArea) : void
        {
            if (param1 == this._printArea)
            {
                return;
            }
            this._configuration.printArea = param1.id;
            this._printArea = param1;
            return;
        }// end function

        public function getPossiblePrintTypes() : Array
        {
            return PrintTypeRules.findPossibleConfigurationPrintTypes(this);
        }// end function

        public function doesFitIntoPrintTypeMaxBounds(param1:IPrintType) : Boolean
        {
            return PrintTypeRules.doesConfigurationFitIntoPrintTypeMaxBounds(this, param1);
        }// end function

        public function get printType() : IPrintType
        {
            return this._printType;
        }// end function

        public function set printType(param1:IPrintType) : void
        {
            if (param1 != null)
            {
            }
            if (this._printType != null)
            {
            }
            if (param1.id == this._printType.id)
            {
                return;
            }
            var _loc_2:* = this.rgbColors;
            this._configuration.printType = param1.id;
            this._printType = param1;
            this.rgbColors = _loc_2;
            this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.PRINT_TYPE_CHANGED, this));
            return;
        }// end function

        public function get unscaledWidth() : Number
        {
            if (this.type == ConfigurationType.DESIGN)
            {
                return this.design.net.sprd.entities:IDesign::width;
            }
            return this._unscaledWidth;
        }// end function

        public function get unscaledHeight() : Number
        {
            if (this.type == ConfigurationType.DESIGN)
            {
                return this.design.net.sprd.entities:IDesign::height;
            }
            return this._unscaledHeight;
        }// end function

        public function get width() : Number
        {
            return this._configuration.svgContent.width;
        }// end function

        public function set width(param1:Number) : void
        {
            this.recalculateSVGTransformation(param1, this.height);
            this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.TRANSFORMED, this));
            return;
        }// end function

        public function get height() : Number
        {
            return this._configuration.svgContent.height;
        }// end function

        public function set height(param1:Number) : void
        {
            this.recalculateSVGTransformation(this.width, param1);
            this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.TRANSFORMED, this));
            return;
        }// end function

        public function get offset() : Point
        {
            return this._configuration.offset;
        }// end function

        public function set offset(param1:Point) : void
        {
            if (param1.equals(this._configuration.offset))
            {
                return;
            }
            this.guardTransformationChange(this.rotation, this.flipX, this.flipY, ConfigurationModelConstants.NO_SCALE, param1, true);
            this._configuration.offset = param1;
            this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.TRANSFORMED, this));
            return;
        }// end function

        public function get rotation() : Number
        {
            return this._rotation;
        }// end function

        public function set rotation(param1:Number) : void
        {
            if (this._rotation == param1)
            {
                return;
            }
            this.guardTransformationChange(param1, this.flipX, this.flipY, ConfigurationModelConstants.NO_SCALE, this.offset, true);
            this._rotation = param1;
            this.recalculateSVGTransformation(this.width, this.height);
            this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.TRANSFORMED, this));
            return;
        }// end function

        public function set centerScale(param1:Point) : void
        {
            var _loc_7:Number;
            if (param1.equals(ConfigurationModelConstants.NO_SCALE))
            {
                return;
            }
            this.guardTransformationChange(this.rotation, this.flipX, this.flipY, param1, this.offset, false);
            var _loc_2:* = this.width;
            var _loc_3:* = this.width * Math.abs(param1.x);
            var _loc_4:* = this.height;
            var _loc_5:* = this.height * Math.abs(param1.y);
            var _loc_6:Boolean;
            if (this.type == ConfigurationType.TEXT)
            {
                if (this._allowConstraintError)
                {
                    _loc_7 = 0;
                }
                else
                {
                    _loc_7 = ConfigurationSizeRules.calculateMinimumFontSize(this);
                    _loc_6 = TextFlowUtil.canDecreaseFontSize(this.textFlow, param1.x, 1, _loc_7);
                    if (!_loc_6)
                    {
                        throw new FontResizeError();
                    }
                }
                this._unscaledWidth = _loc_3;
                this._unscaledHeight = _loc_5;
                TextFlowUtil.decreaseFontSize(this.textFlow, param1.x, 1, _loc_7);
                TextFlowUtil.decreaseFontSize(this._testTextFlow, param1.x, 1, _loc_7);
            }
            this._configuration.offset = new Point(this.offset.x + (_loc_2 - _loc_3) / 2, this.offset.y + (_loc_4 - _loc_5) / 2);
            this.recalculateSVGTransformation(_loc_3, _loc_5);
            if (this.type == ConfigurationType.TEXT)
            {
                dispatchEvent(new ConfigurationEvent(ConfigurationEvent.FONT_CHANGED, this));
            }
            this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.TRANSFORMED, this));
            return;
        }// end function

        public function get flipX() : int
        {
            return this._flipX;
        }// end function

        public function set flipX(param1:int) : void
        {
            if (param1 == this._flipX)
            {
                return;
            }
            this._flipX = param1;
            this.recalculateSVGTransformation(this.width, this.height);
            this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.TRANSFORMED, this));
            return;
        }// end function

        public function get flipY() : int
        {
            return this._flipY;
        }// end function

        public function set flipY(param1:int) : void
        {
            if (param1 == this._flipY)
            {
                return;
            }
            this._flipY = param1;
            this.recalculateSVGTransformation(this.width, this.height);
            this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.TRANSFORMED, this));
            return;
        }// end function

        public function get svgContent() : ISVGShape
        {
            if (this._configuration.svgContent)
            {
                return this._configuration.svgContent;
            }
            return null;
        }// end function

        public function get isChangeable() : Boolean
        {
            return this._configuration.isChangeable;
        }// end function

        public function set isChangeable(param1:Boolean) : void
        {
            this._configuration.isChangeable = param1;
            return;
        }// end function

        public function get rgbColors() : Array
        {
            if (this.svgContent)
            {
                return this.svgContent.rgbColors.filter(function () : Boolean
            {
                return true;
            }// end function
            );
            }
            return [];
        }// end function

        public function set rgbColors(param1:Array) : void
        {
            var _loc_2:Array;
            var _loc_3:int;
            if (this.svgContent)
            {
                if (this.printType.id == PrintType.SPECIALFLEX)
                {
                    _loc_3 = 1;
                    while (_loc_3++ < param1.length)
                    {
                        
                        param1[_loc_3] = param1[0];
                    }
                }
                _loc_2 = PrintTypeRules.getValidRGBColorsForPrintType(this.printType, param1);
                this.svgContent.rgbColors = _loc_2;
                if (this.printType.colorSpace == ColorSpace.PRINTCOLORS)
                {
                    this.svgContent.printColors = PrintTypeRules.getPrintColorIdsForRGBColors(this.printType, _loc_2);
                }
                else
                {
                    this.svgContent.printColors = [];
                }
                this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.COLOR_CHANGED, this));
            }
            return;
        }// end function

        public function get selectedLayerIndex() : int
        {
            return this._selectedLayerIndex;
        }// end function

        public function set selectedLayerIndex(param1:int) : void
        {
            if (this._selectedLayerIndex == param1)
            {
                return;
            }
            this._selectedLayerIndex = param1;
            this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.LAYER_SELECTION_CHANGED, this));
            return;
        }// end function

        public function get printColors() : Array
        {
            if (this.svgContent)
            {
                return this.svgContent.printColors.concat();
            }
            return [];
        }// end function

        public function set printColors(param1:Array) : void
        {
            this.rgbColors = PrintTypeRules.getRGBColorsForPrintColorIds(param1);
            return;
        }// end function

        public function get bitmap() : Boolean
        {
            if (this.type == ConfigurationType.DESIGN)
            {
            }
            return this.rgbColors.length == 0;
        }// end function

        public function get transformation() : Matrix
        {
            return this.getTransformation(this.rotation, this.flipX, this.flipY, new Point(1, 1), this.offset);
        }// end function

        public function moveToDefaultPosition(param1:String) : void
        {
            var _loc_2:* = ProductDefaultRules.getDefaultGeometry(this, this.product.currentPrintArea, param1);
            var _loc_3:* = ConfigurationSizeRules.getConfigurationBounds(this.product.currentPrintArea, _loc_2);
            this._configuration.offset = _loc_3.topLeft;
            this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.TRANSFORMED, this));
            return;
        }// end function

        public function getMinimumFontSize() : Number
        {
            return ConfigurationSizeRules.calculateMinimumFontSize(this);
        }// end function

        public function getMaximumFontSize() : Number
        {
            return ConfigurationSizeRules.calculateMaximumFontSize(this);
        }// end function

        public function remove() : int
        {
            if (this.product != null)
            {
                return this.product.removeConfiguration(this);
            }
            return -1;
        }// end function

        public function getTransformation(param1:Number, param2:int, param3:int, param4:Point, param5:Point) : Matrix
        {
            var _loc_6:* = new Matrix();
            _loc_6.scale(param4.x * this.width / this.unscaledWidth, param4.y * this.height / this.unscaledHeight);
            _loc_6.translate((-param4.x) * this.width / 2, (-param4.y) * this.height / 2);
            _loc_6.scale(param2, param3);
            _loc_6.rotate(UnitUtil.deg2rad(param1));
            _loc_6.translate(param5.x + this.width / 2, param5.y + this.height / 2);
            return _loc_6;
        }// end function

        public function getConstraintViolationInfo(param1:Number, param2:int, param3:int, param4:Point, param5:Point) : ConstraintViolationInfo
        {
            return this.product != null ? (this.product.getConstraintViolationDetector(this.printArea).getConstraintViolationInfo(this, param1, param2, param3, param4, param5)) : (new ConstraintViolationInfo());
        }// end function

        public function getCurrentConstraintViolationInfo() : ConstraintViolationInfo
        {
            return this.getConstraintViolationInfo(this.rotation, this.flipX, this.flipY, ConfigurationModelConstants.NO_SCALE, this.offset);
        }// end function

        public function get constraintViolationDetector() : IConstraintViolationDetector
        {
            return this.product != null ? (this.product.getConstraintViolationDetector(this.printArea)) : (NullConstraintViolationDetector.instance);
        }// end function

        private function guardTransformationChange(param1:Number, param2:int, param3:int, param4:Point, param5:Point, param6:Boolean) : void
        {
            if (this._allowConstraintError)
            {
                return;
            }
            var _loc_7:* = this.getConstraintViolationInfo(param1, param2, param3, param4, param5);
            if (param6)
            {
                if (true)
                {
                }
                if (_loc_7.configurationCollisions.size > 0)
                {
                    throw new CollisionError(_loc_7);
                }
            }
            else if (_loc_7.invalid)
            {
                throw new CollisionError(_loc_7);
            }
            return;
        }// end function

        public function get product() : IProductModel
        {
            return this._product;
        }// end function

        public function get testSprite() : DisplayObject
        {
            return this._testSprite;
        }// end function

        public function get testTextFlow() : TextFlow
        {
            return this._testTextFlow;
        }// end function

        public function get textFlow() : TextFlow
        {
            return this._textFlow;
        }// end function

        public function get layers() : Array
        {
            return this._layers;
        }// end function

        public function set designId(param1:String) : void
        {
            this.configuration.designId = param1;
            return;
        }// end function

        public function get designId() : String
        {
            return this.configuration.designId;
        }// end function

        public function get design() : IDesign
        {
            return API.em.get(this.configuration.designId, APIRegistry.DESIGN) as IDesign;
        }// end function

        public function get horizontalTextAutoStretch() : Boolean
        {
            return this._horizontalTextAutoStretch;
        }// end function

        public function set horizontalTextAutoStretch(param1:Boolean) : void
        {
            this._horizontalTextAutoStretch = param1;
            return;
        }// end function

        public function get modified() : Boolean
        {
            return this.configuration.modified;
        }// end function

        public function markModified(param1:Boolean = true)
        {
            this.configuration.markModified(param1);
            return;
        }// end function

        public function setTextBox(param1:Number, param2:Number) : void
        {
            var _loc_3:* = this.width;
            var _loc_4:* = this.height;
            this.svgContent.width = param1;
            this._unscaledWidth = this._unscaledWidth / _loc_3 * param1;
            this.svgContent.height = param2;
            this._unscaledHeight = this._unscaledHeight / _loc_4 * param2;
            var _loc_5:* = Math.cos(UnitUtil.deg2rad(this.rotation));
            var _loc_6:* = Math.sin(UnitUtil.deg2rad(this.rotation));
            var _loc_7:* = (param1 - _loc_3) / 2;
            var _loc_8:* = (param2 - _loc_4) / 2;
            this.offset.x = this.offset.x - _loc_6 * _loc_8 + (_loc_5 - 1) * _loc_7;
            this.offset.y = this.offset.y + _loc_6 * _loc_7 + (_loc_5 - 1) * _loc_8;
            this.updateTestContainerController();
            this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.TRANSFORMED, this));
            return;
        }// end function

        public function adjustHeightToTextFit() : Number
        {
            var _loc_1:* = TextFlowUtil.textHeight(this._testTextFlow, true);
            var _loc_2:* = _loc_1 - this.height;
            if (_loc_2 == 0)
            {
                return 0;
            }
            this.setTextBox(this.width, _loc_1);
            return _loc_2;
        }// end function

        public function get allowConstraintError() : Boolean
        {
            return this._allowConstraintError;
        }// end function

        public function set allowConstraintError(param1:Boolean) : void
        {
            this._allowConstraintError = param1;
            return;
        }// end function

        public function get price() : Money
        {
            var _loc_2:Array;
            var _loc_3:Dictionary;
            var _loc_4:int;
            var _loc_1:Number;
            if (this.type == ConfigurationType.DESIGN)
            {
                _loc_1 = _loc_1 + this.design.price.amount;
            }
            if (this.printType.colorSpace == ColorSpace.PRINTCOLORS)
            {
                _loc_2 = this.usedPrintColors;
                if (_loc_2.length > 0)
                {
                    _loc_1 = _loc_1 + this.printType.price.amount;
                }
                _loc_3 = new Dictionary();
                _loc_4 = 0;
                while (_loc_4++ < _loc_2.length)
                {
                    
                    if (_loc_3[_loc_2[_loc_4]])
                    {
                        continue;
                    }
                    _loc_3[_loc_2[_loc_4]] = 1;
                    if (_loc_2[_loc_4])
                    {
                    }
                    if (!_loc_2[_loc_4].price)
                    {
                        log.warn("Missing print color or print color price for print " + "color \'" + _loc_2[_loc_4] + "\'.");
                        continue;
                    }
                    _loc_1 = _loc_1 + _loc_2[_loc_4].price.amount;
                }
            }
            else
            {
                _loc_1 = _loc_1 + this.printType.price.amount;
            }
            return new Money(_loc_1, this.product.basePrice.currencyID);
        }// end function

        public function setColorOnTextSelection(param1:SelectionState, param2:IPrintColor) : void
        {
            var _loc_3:* = new TextLayoutFormat();
            _loc_3.color = ColorUtil.getIntegerColor(param2.hexCode);
            if (param1.absoluteStart == param1.absoluteEnd)
            {
                param1 = null;
            }
            IEditManager(this._textFlow.interactionManager).applyLeafFormat(_loc_3, param1);
            return;
        }// end function

        public function get textOfferedForDeletion() : Boolean
        {
            return this._textOfferedForDeletion;
        }// end function

        public function set textOfferedForDeletion(param1:Boolean) : void
        {
            this._textOfferedForDeletion = param1;
            return;
        }// end function

        public function get isEmpty() : Boolean
        {
            if (this.type == ConfigurationType.TEXT)
            {
                if (this.textFlow)
                {
                    if (this.textFlow.getText())
                    {
                    }
                }
                if (this.textFlow.getText().replace(/\s/g, "").length == 0)
                {
                    return true;
                }
            }
            else if (this.type == ConfigurationType.DESIGN)
            {
                if (this.design)
                {
                }
                if (!this.design.id)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function get isDefaultConfiguration() : Boolean
        {
            return this._isDefaultConfiguration;
        }// end function

        public function set isDefaultConfiguration(param1:Boolean) : void
        {
            this._isDefaultConfiguration = param1;
            return;
        }// end function

        public function get canBeRemoved() : Boolean
        {
            if (true)
            {
            }
            if (true)
            {
            }
            return this.textOfferedForDeletion;
        }// end function

        public function get configuration() : IConfiguration
        {
            return this._configuration;
        }// end function

        public function setSelection(param1:Boolean) : void
        {
            if (param1)
            {
                this.product.selectConfiguration(this);
            }
            else if (this.product.selectedConfiguration == this)
            {
                this.product.selectConfiguration(null);
            }
            return;
        }// end function

        public function get textOperationStrategy() : ITextOperationStrategy
        {
            return this._textOperationStrategy;
        }// end function

        public function createConfigurationRenderer() : IConfigurationRenderer
        {
            return this.type == ConfigurationType.DESIGN ? (new DesignConfigurationRenderer(this)) : (new TextConfigurationRenderer(this));
        }// end function

        private function get usedPrintColors() : Array
        {
            if (this.type == ConfigurationType.TEXT)
            {
                return TextFlowUtil.usedColors(this._textFlow, true).map(function (param1:int, param2, param3)
            {
                return PrintTypeRules.getPrintColorForRGBColor(printType, Color.fromHex(param1));
            }// end function
            );
            }
            return this.printColors.map(function (param1:String, param2, param3)
            {
                return API.em.get(param1, APIRegistry.PRINT_COLOR);
            }// end function
            );
        }// end function

        private function updateDependencies() : void
        {
            var that:*;
            var renderer_complete:Function;
            var renderer_error:Function;
            if (this.updatePrintArea())
            {
            }
            if (this.updatePrintType())
            {
            }
            if (!this.updateFonts())
            {
                this._state = ModelState.ERROR;
                this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.ERROR, this));
                return;
            }
            if (this.printType.colorSpace == ColorSpace.PRINTCOLORS)
            {
                this.printColors = this._configuration.svgContent.printColors;
            }
            else
            {
                this.rgbColors = this._configuration.svgContent.rgbColors;
            }
            that;
            renderer_complete = function (param1:Event) : void
            {
                var _loc_2:Boolean;
                var _loc_3:int;
                var _loc_4:Number;
                var _loc_5:SelectionState;
                var _loc_6:TextLayoutFormat;
                if (type == ConfigurationType.TEXT)
                {
                    renderer.render();
                    _testSprite = _testTextFlow.flowComposer.getControllerAt(0).container;
                    adjustHeightToTextFit();
                    _layers = [_testSprite];
                    if (_autoCorrection)
                    {
                        _loc_2 = allowConstraintError;
                        allowConstraintError = true;
                        _loc_3 = expectedNumberOfTextLines();
                        if (_loc_3 > 0)
                        {
                        }
                        if (_testTextFlow.flowComposer.numLines > _loc_3)
                        {
                            ConstraintViolationFixes.shrinkFontSizeToFitLineNumber(that, _loc_3);
                        }
                        if (that.getCurrentConstraintViolationInfo().boundaryCollision)
                        {
                            ConstraintViolationFixes.shrinkToRemoveBoundaryCollision(that);
                        }
                        if (that.getCurrentConstraintViolationInfo().maxBoundViolation)
                        {
                            ConstraintViolationFixes.shrinkToRemoveMaxBoundViolation(that);
                        }
                        allowConstraintError = _loc_2;
                        adjustHeightToTextFit();
                    }
                    else
                    {
                        if (isDefaultConfiguration)
                        {
                            if (true)
                            {
                            }
                        }
                        if (TextFlowUtil.textHeight(_testTextFlow, true) > that.printArea.defaultPositioningBox.height)
                        {
                            _loc_4 = ConfigurationSizeRules.calculateMinimumFontSize(that);
                            _loc_5 = textFlow.interactionManager.getSelectionState();
                            if (_loc_5.absoluteStart == _loc_5.absoluteEnd)
                            {
                                _loc_5 = new SelectionState(textFlow, 0, textFlow.textLength);
                            }
                            _loc_6 = new TextLayoutFormat();
                            _loc_6.fontSize = _loc_4;
                            IEditManager(textFlow.interactionManager).applyLeafFormat(_loc_6, _loc_5);
                            textFlow.flowComposer.updateAllControllers();
                            textFlow.interactionManager.setFocus();
                            _loc_5 = _testTextFlow.interactionManager.getSelectionState();
                            if (_loc_5.absoluteStart == _loc_5.absoluteEnd)
                            {
                                _loc_5 = new SelectionState(_testTextFlow, 0, _testTextFlow.textLength);
                            }
                            _loc_6 = new TextLayoutFormat();
                            _loc_6.fontSize = _loc_4;
                            IEditManager(_testTextFlow.interactionManager).applyLeafFormat(_loc_6, _loc_5);
                            _testTextFlow.flowComposer.updateAllControllers();
                            _testTextFlow.interactionManager.setFocus();
                            adjustHeightToTextFit();
                            if (that.getCurrentConstraintViolationInfo().invalid)
                            {
                                _loc_2 = _allowConstraintError;
                                _allowConstraintError = true;
                                that.offset = new Point(0, 0);
                                that.setTextBox(that.printArea.width, that.printArea.height);
                                adjustHeightToTextFit();
                                that.moveToDefaultPosition(ConfigurationModelConstants.ABSOLUTE_CENTER);
                                _allowConstraintError = _loc_2;
                            }
                        }
                    }
                }
                else
                {
                    _testSprite = renderer.render();
                    _layers = renderer.layers();
                    if (_autoCorrection)
                    {
                        _loc_2 = allowConstraintError;
                        allowConstraintError = true;
                        if (that.getCurrentConstraintViolationInfo().boundaryCollision)
                        {
                            ConstraintViolationFixes.shrinkToRemoveBoundaryCollision(that);
                        }
                        if (that.getCurrentConstraintViolationInfo().maxBoundViolation)
                        {
                            ConstraintViolationFixes.shrinkToRemoveMaxBoundViolation(that);
                        }
                        else if (that.getCurrentConstraintViolationInfo().minBoundViolation)
                        {
                            ConstraintViolationFixes.expandToRemoveMinBoundViolation(that);
                        }
                        allowConstraintError = _loc_2;
                    }
                }
                _state = ModelState.INITIALIZED;
                bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.INITIALIZED, that));
                return;
            }// end function
            ;
            renderer_error = function (param1:Event) : void
            {
                _state = ModelState.ERROR;
                log.warn("Renderer error: " + param1);
                bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.ERROR, that));
                return;
            }// end function
            ;
            this.renderer = this.createConfigurationRenderer();
            with ({})
            {
                {}.onDependenciesComplete = function (param1:Event) : void
            {
                EventUtil.registerOnetimeListeners(renderer, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [renderer_complete, renderer_error]);
                renderer.loadAssets();
                return;
            }// end function
            ;
            }
            with ({})
            {
                {}.onDependenciesFault = function (param1:Event) : void
            {
                log.warn("Problem loading dependencies for configuration " + configurationID);
                _state = ModelState.ERROR;
                bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.ERROR, that));
                return;
            }// end function
            ;
            }
            API.em.startBatch(function (param1:Event) : void
            {
                EventUtil.registerOnetimeListeners(renderer, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [renderer_complete, renderer_error]);
                renderer.loadAssets();
                return;
            }// end function
            , function (param1:Event) : void
            {
                log.warn("Problem loading dependencies for configuration " + configurationID);
                _state = ModelState.ERROR;
                bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.ERROR, that));
                return;
            }// end function
            );
            switch(this.type)
            {
                case ConfigurationType.DESIGN:
                {
                    API.em.load(this.configuration.designId, APIRegistry.DESIGN);
                    break;
                }
                case ConfigurationType.TEXT:
                {
                    FontManager.getInstance().loadFontFamilies(null, null);
                    break;
                }
                default:
                {
                    break;
                }
            }
            API.em.commitBatch();
            return;
        }// end function

        private function expectedNumberOfTextLines() : int
        {
            var _loc_2:Number;
            var _loc_3:int;
            var _loc_4:SVGText;
            if (this.type !== ConfigurationType.TEXT)
            {
                return -1;
            }
            if (!this.svgContent)
            {
                return -1;
            }
            var _loc_1:* = SVGText(this.svgContent);
            if (_loc_1.tspans.length == 1)
            {
            }
            if (_loc_1.tspans[0].tspans.length == 1)
            {
                return _loc_1.tspans[0].tspans[0].text.split("\n").length;
            }
            if (_loc_1.tspans.length > 0)
            {
                _loc_2 = -10000001;
                _loc_3 = 0;
                if (_loc_1.y)
                {
                    _loc_2 = _loc_1.y;
                }
                for each (_loc_4 in _loc_1.tspans)
                {
                    
                    if (_loc_4.y)
                    {
                    }
                    if (_loc_4.y != _loc_2)
                    {
                        _loc_2 = _loc_4.y;
                    }
                }
                return _loc_3++++;
            }
            return -1;
        }// end function

        private function updatePrintArea() : Boolean
        {
            if (this._configuration.printArea)
            {
                this._printArea = IPrintArea(API.em.get(this._configuration.printArea, APIRegistry.PRINT_AREA));
                if (this._printArea)
                {
                }
                if (this._printArea.state != EntityState.LOADED)
                {
                    log.error("print area " + this._configuration.printArea + " not found or not loaded");
                    return false;
                }
            }
            return true;
        }// end function

        private function updatePrintType() : Boolean
        {
            if (this._configuration.printType)
            {
                this._printType = IPrintType(API.em.get(this._configuration.printType, APIRegistry.PRINT_TYPE));
                if (this._printType)
                {
                }
                if (this._printType.state != EntityState.LOADED)
                {
                    log.error("print type " + this._configuration.printType + " not found or not loaded");
                    return false;
                }
            }
            return true;
        }// end function

        private function updateFonts() : Boolean
        {
            if (this.type == ConfigurationType.TEXT)
            {
                return this.checkFontsExist(SVGText(this.svgContent), null);
            }
            return true;
        }// end function

        private function checkFontsExist(param1:SVGText, param2:String) : Boolean
        {
            var _loc_3:SVGText;
            var _loc_4:IFontStyle;
            if (param1.fontID)
            {
                param2 = param1.fontID;
            }
            if (param2)
            {
                _loc_4 = IFontStyle(API.em.get(param2, APIRegistry.FONT_STYLE));
                if (_loc_4)
                {
                }
                if (_loc_4.state != EntityState.LOADED)
                {
                    log.error("font " + param2 + " not found or not loaded");
                    return false;
                }
            }
            for each (_loc_3 in param1.tspans)
            {
                
                if (!this.checkFontsExist(_loc_3, param2))
                {
                    return false;
                }
            }
            return true;
        }// end function

        private function recalculateSVGTransformation(param1:Number, param2:Number) : void
        {
            this.svgContent.width = param1;
            this.svgContent.height = param2;
            var _loc_3:* = param1 / 2;
            var _loc_4:* = param2 / 2;
            var _loc_5:Array;
            if (this.flipX == 1)
            {
            }
            if (this.flipY != 1)
            {
                _loc_5.push(new Translate(-_loc_3, -_loc_4));
                _loc_5.push(new Scale(this.flipX, this.flipY));
                _loc_5.push(new Translate(_loc_3, _loc_4));
            }
            if (this.rotation != 0)
            {
                _loc_5.push(new Rotation(this.rotation, _loc_3, _loc_4));
            }
            this.svgContent.transformations = _loc_5;
            if (this.type == ConfigurationType.TEXT)
            {
                this.updateTestContainerController();
            }
            return;
        }// end function

        public function updateSVGContent() : void
        {
            if (this.isEmpty)
            {
                return;
            }
            if (this.type == ConfigurationType.TEXT)
            {
                if (this.textFlow)
                {
                }
                if (this.textFlow.flowComposer)
                {
                }
                if (this.textFlow.flowComposer.numControllers == 0)
                {
                    return;
                }
                this._configuration.svgContent = TextFlowSVGConverter.convertToSVG(this.textFlow, this.printType, this.width, this.height);
            }
            this.recalculateSVGTransformation(this.width, this.height);
            return;
        }// end function

        private function initializeFromSVGInternal() : void
        {
            var _loc_2:ISVGTransformation;
            var _loc_1:int;
            while (_loc_1++ < this.svgContent.transformations.length)
            {
                
                _loc_2 = this.svgContent.transformations[_loc_1];
                if (_loc_2 is Rotation)
                {
                    this._rotation = Rotation(_loc_2).angle;
                    continue;
                }
                if (_loc_2 is Scale)
                {
                    if (Scale(_loc_2).sx < 0)
                    {
                        this._flipX = -1;
                    }
                    if (Scale(_loc_2).sy < 0)
                    {
                        this._flipY = -1;
                    }
                }
            }
            if (this._configuration.type == ConfigurationType.TEXT)
            {
                this._textOfferedForDeletion = this._product.isExample;
                this._unscaledWidth = TextFlowSVGConverter.widthFromSVG(SVGText(this._configuration.svgContent));
                this._configuration.svgContent.width = this._unscaledWidth;
                this._unscaledHeight = this._configuration.svgContent.height;
                this._textFlow = TextFlowSVGConverter.convertFromSVG(SVGText(this.svgContent));
                this._testTextFlow = TextFlowSVGConverter.convertFromSVG(SVGText(this.svgContent));
                if (this._configuration.isChangeable)
                {
                    this._textFlow.interactionManager = new EditManager();
                    this._testTextFlow.interactionManager = new EditManager();
                }
                else
                {
                    this._textFlow.interactionManager = new PimpedSelectionManager();
                    this._testTextFlow.interactionManager = new PimpedSelectionManager();
                }
                this._textOperationStrategy = new DefaultTextOperationStrategy(this);
            }
            return;
        }// end function

        private function updateTestContainerController() : void
        {
            if (!this._testTextFlow)
            {
                return;
            }
            var _loc_1:* = this._testTextFlow.flowComposer.getControllerAt(0);
            if (!_loc_1)
            {
                return;
            }
            _loc_1.setCompositionSize(this.svgContent.width, this.svgContent.height);
            this._testTextFlow.flowComposer.updateAllControllers();
            return;
        }// end function

        public function set autoCorrection(param1:Boolean) : void
        {
            this._autoCorrection = param1;
            return;
        }// end function

    }
}
