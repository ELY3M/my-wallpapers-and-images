package net.sprd.components.productviewer
{
    import com.senocular.drawing.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.engine.*;
    import flash.utils.*;
    import flashx.textLayout.edit.*;
    import flashx.textLayout.events.*;
    import flashx.textLayout.formats.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.effects.easing.*;
    import mx.events.*;
    import mx.managers.*;
    import net.sprd.common.graphics.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.entities.*;
    import net.sprd.events.*;
    import net.sprd.models.common.*;
    import net.sprd.models.product.*;
    import net.sprd.models.product.errors.*;
    import net.sprd.models.product.renderer.*;
    import net.sprd.models.product.texthandling.*;
    import net.sprd.text.*;

    public class ConfigurationViewer extends Container implements IFocusManagerComponent
    {
        private const ROTATION_SNAP:Number = 10;
        private var fm:FontManager;
        public var bus:IEventDispatcher;
        private var _initialized:Boolean = false;
        private var _configuration:IConfigurationModel;
        private var _viewScale:Number = 1;
        private var _viewScaleChanged:Boolean;
        private var boundingBox:Rectangle;
        private var scaleHandle:Button;
        private var rotateHandle:Button;
        private var moveHandle:Button;
        private var deleteHandle:Button;
        private var reshapeTextBoxHandle:Button;
        private var _isOnBrightFabric:Boolean;
        private var _isOnBrightFabricChanged:Boolean;
        private var activeToolTip:IToolTip;
        private var outer:UIComponent;
        private var inner:Sprite;
        private var _constraintInfoChanged:Boolean;
        private var _constraintInfoVisualizer:ConstraintInfoVisualizer;
        private var _autoCorrection:Boolean;
        private var renderer:IConfigurationRenderer;
        private var _textEditEnabled:Boolean;
        private var _renderStateChanged:Boolean;
        private var _isSelected:Boolean;
        private var _selectionChanged:Boolean;
        private var _textEditEnabledChanged:Boolean;
        private var _interactiveMode:Boolean;
        private var _interactiveModeChanged:Boolean;
        private var globalMouseLocationOnDragStart:Point;
        private var globalCenterOnDragStart:Point;
        private var lastSuccessfulRotation:Number;
        private var lastSuccessfulScale:Point;
        private var lastSuccessfulTranslation:Point;
        private var lastSuccessfulReshape:Point;
        private var decoratorEffect:Parallel;
        private var decorators:Dictionary;
        private var activeDecorator:DisplayObject;
        private var _rendered:Boolean = false;
        private var focusedSelectionFormat:SelectionFormat;
        private var unfocusedSelectionFormat:SelectionFormat;
        private var inactiveSelectionFormat:SelectionFormat;
        private var invisibleSelectionFormat:SelectionFormat;
        private var dimensionFormatter:DimensionFormatter;
        private var canvasSizeViolation:Boolean;
        private static const log:ILogger = LogContext.getLogger(this);

        public function ConfigurationViewer(param1:IConfigurationModel, param2:Number, param3:Boolean, param4:Boolean, param5:Boolean)
        {
            this.fm = FontManager.getInstance();
            this.boundingBox = new Rectangle();
            this.outer = new UIComponent();
            this.decorators = new Dictionary();
            this._configuration = param1;
            this._viewScale = param2;
            this._autoCorrection = param3;
            this._isOnBrightFabric = param4;
            clipContent = false;
            if (param5)
            {
                this.setSelectedInternal(param5);
            }
            this.dimensionFormatter = new DimensionFormatter();
            this.dimensionFormatter.country = ConfomatConfiguration.country;
            return;
        }// end function

        public function init() : void
        {
            if (this._initialized)
            {
                throw new Error("ConfigurationViewer can only be initialized once.");
            }
            this._initialized = true;
            this._rendered = false;
            invalidateProperties();
            this.renderer = this.configuration.createConfigurationRenderer();
            if (this.configuration.type == ConfigurationType.TEXT)
            {
                this.configuration.textFlow.addEventListener(SelectionEvent.SELECTION_CHANGE, this.onSelectionChange);
            }
            EventUtil.registerOnetimeListeners(this.renderer, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [this.renderer_complete, this.renderer_error]);
            this.renderer.loadAssets();
            return;
        }// end function

        public function get configuration() : IConfigurationModel
        {
            return this._configuration;
        }// end function

        public function get viewScale() : Number
        {
            return this._viewScale;
        }// end function

        public function set viewScale(param1:Number) : void
        {
            this._viewScale = param1;
            this._viewScaleChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get isSelected() : Boolean
        {
            return this._isSelected;
        }// end function

        private function setSelected(param1:Boolean) : void
        {
            this.setSelectedInternal(param1);
            invalidateProperties();
            return;
        }// end function

        private function setSelectedInternal(param1:Boolean) : void
        {
            if (this._isSelected == param1)
            {
                return;
            }
            this._isSelected = param1;
            this._selectionChanged = true;
            if (this._textEditEnabled == param1)
            {
                return;
            }
            this._textEditEnabled = param1;
            this._textEditEnabledChanged = true;
            this._constraintInfoChanged = true;
            return;
        }// end function

        private function get textEditEnabled() : Boolean
        {
            return this._textEditEnabled;
        }// end function

        private function set textEditEnabled(param1:Boolean) : void
        {
            if (this._textEditEnabled == param1)
            {
                return;
            }
            this._textEditEnabled = param1;
            this._textEditEnabledChanged = true;
            invalidateProperties();
            return;
        }// end function

        private function get constraintInfo() : ConstraintViolationInfo
        {
            return this._constraintInfoVisualizer.constraintInfo;
        }// end function

        private function set constraintInfo(param1:ConstraintViolationInfo) : void
        {
            this.constraintInfoInternal = param1;
            invalidateProperties();
            return;
        }// end function

        private function set constraintInfoInternal(param1:ConstraintViolationInfo) : void
        {
            var _loc_2:* = this._constraintInfoVisualizer.constraintInfo ? (this._constraintInfoVisualizer.constraintInfo.toString()) : ("");
            var _loc_3:* = param1 ? (param1.toString()) : ("");
            this._constraintInfoChanged = true;
            this._constraintInfoVisualizer.constraintInfo = param1;
            return;
        }// end function

        public function updateConstraintInfo(param1:Number = 100000, param2:Point = null, param3:Point = null) : void
        {
            if (param1 == 100000)
            {
                param1 = this.configuration.rotation;
            }
            if (!param2)
            {
                param2 = ConfigurationModelConstants.NO_SCALE;
            }
            if (!param3)
            {
                param3 = this.configuration.offset;
            }
            this.constraintInfoInternal = this.configuration.getConstraintViolationInfo(param1, this.configuration.flipX, this.configuration.flipY, param2, param3);
            return;
        }// end function

        private function checkForCanvasSizeViolation() : void
        {
            var _loc_1:* = ProductViewer(parent.parent);
            var _loc_2:* = _loc_1.localToGlobal(new Point(0, 0));
            var _loc_3:* = _loc_1.localToGlobal(new Point(_loc_1.width, _loc_1.height));
            var _loc_4:* = new Rectangle(_loc_2.x, _loc_2.y, _loc_3.x - _loc_2.x, _loc_3.y - _loc_2.y);
            var _loc_5:* = new Point(this.boundingBox.x, this.boundingBox.y);
            var _loc_6:* = new Point(this.boundingBox.x + this.boundingBox.width, this.boundingBox.y);
            var _loc_7:* = new Point(this.boundingBox.x, this.boundingBox.y + this.boundingBox.height);
            var _loc_8:* = new Point(this.boundingBox.x + this.boundingBox.width, this.boundingBox.y + this.boundingBox.height);
            if (_loc_4.containsPoint(this.outer.localToGlobal(_loc_5)))
            {
            }
            if (_loc_4.containsPoint(this.outer.localToGlobal(_loc_6)))
            {
            }
            if (_loc_4.containsPoint(this.outer.localToGlobal(_loc_7)))
            {
            }
            this.canvasSizeViolation = !_loc_4.containsPoint(this.outer.localToGlobal(_loc_8));
            return;
        }// end function

        public function get isOnBrightFabric() : Boolean
        {
            return this._isOnBrightFabric;
        }// end function

        public function set isOnBrightFabric(param1:Boolean) : void
        {
            if (param1 == this._isOnBrightFabric)
            {
                return;
            }
            this._isOnBrightFabric = param1;
            this._isOnBrightFabricChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get interactiveMode() : Boolean
        {
            return this._interactiveMode;
        }// end function

        public function set interactiveMode(param1:Boolean) : void
        {
            if (param1 == this._interactiveMode)
            {
                return;
            }
            this._interactiveMode = param1;
            this._interactiveModeChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get autoCorrection() : Boolean
        {
            return this._autoCorrection;
        }// end function

        public function set autoCorrection(param1:Boolean) : void
        {
            this._autoCorrection = param1;
            return;
        }// end function

        private function resetSelectionFormat() : void
        {
            if (this.configuration.type != ConfigurationType.TEXT)
            {
                return;
            }
            if (this.textEditEnabled)
            {
                this.configuration.textFlow.interactionManager.flashx.textLayout.edit:ISelectionManager::focusedSelectionFormat = this.focusedSelectionFormat;
                this.configuration.textFlow.interactionManager.flashx.textLayout.edit:ISelectionManager::unfocusedSelectionFormat = this.unfocusedSelectionFormat;
                this.configuration.textFlow.interactionManager.flashx.textLayout.edit:ISelectionManager::inactiveSelectionFormat = this.inactiveSelectionFormat;
            }
            else
            {
                this.configuration.textFlow.interactionManager.flashx.textLayout.edit:ISelectionManager::focusedSelectionFormat = this.invisibleSelectionFormat;
                this.configuration.textFlow.interactionManager.flashx.textLayout.edit:ISelectionManager::unfocusedSelectionFormat = this.invisibleSelectionFormat;
                this.configuration.textFlow.interactionManager.flashx.textLayout.edit:ISelectionManager::inactiveSelectionFormat = this.invisibleSelectionFormat;
            }
            return;
        }// end function

        private function setMoveSelectionFormat() : void
        {
            if (this.configuration.type != ConfigurationType.TEXT)
            {
                return;
            }
            this.configuration.textFlow.interactionManager.flashx.textLayout.edit:ISelectionManager::focusedSelectionFormat = this.invisibleSelectionFormat;
            return;
        }// end function

        private function defineSelectionFormats() : void
        {
            this.focusedSelectionFormat = new SelectionFormat(16777215, 1, BlendMode.INVERT);
            this.unfocusedSelectionFormat = new SelectionFormat(16777215, 1);
            this.inactiveSelectionFormat = new SelectionFormat(16777215, 1);
            this.invisibleSelectionFormat = new SelectionFormat(0, 0, BlendMode.NORMAL, 0, 0);
            this.configuration.textFlow.interactionManager.flashx.textLayout.edit:ISelectionManager::unfocusedSelectionFormat = this.unfocusedSelectionFormat;
            this.configuration.textFlow.interactionManager.flashx.textLayout.edit:ISelectionManager::inactiveSelectionFormat = this.inactiveSelectionFormat;
            return;
        }// end function

        private function setVisualConfigurationTransformation(param1:Number, param2:Point, param3:Point) : void
        {
            var _loc_4:* = this.configuration.getTransformation(param1, this.configuration.flipX, this.configuration.flipY, param2, param3);
            _loc_4.scale(1 / this.viewScale, 1 / this.viewScale);
            this.outer.transform.matrix = _loc_4;
            invalidateDisplayList();
            return;
        }// end function

        private function locationSnapshot(param1:MouseEvent) : void
        {
            this.globalMouseLocationOnDragStart = new Point(param1.stageX, param1.stageY);
            this.globalCenterOnDragStart = this.outer.localToGlobal(GeometryUtil.center(this.boundingBox));
            return;
        }// end function

        private function rotateHandle_mouseDown(param1:MouseEvent) : void
        {
            if (stage)
            {
                this.interactiveMode = true;
                this.locationSnapshot(param1);
                this.lastSuccessfulRotation = this.configuration.rotation;
                this.registerMouseRotateHandler();
                this.activeDecorator = this.rotateHandle;
                this.setupToolTip();
            }
            return;
        }// end function

        private function currentRotation(param1:MouseEvent) : Number
        {
            var _loc_2:* = this.globalCenterOnDragStart.x;
            var _loc_3:* = this.globalCenterOnDragStart.y;
            var _loc_4:* = this.globalMouseLocationOnDragStart.x;
            var _loc_5:* = this.globalMouseLocationOnDragStart.y;
            var _loc_6:* = this.configuration.rotation + UnitUtil.rad2deg(Math.atan2(_loc_4 - _loc_2, _loc_5 - _loc_3) - Math.atan2(param1.stageX - _loc_2, param1.stageY - _loc_3));
            if (_loc_6 < 0)
            {
                _loc_6 = _loc_6 + 360 * Math.ceil((-_loc_6) / 360);
            }
            var _loc_7:* = (_loc_6 + this.ROTATION_SNAP / 2) % 45;
            var _loc_8:* = _loc_7 < this.ROTATION_SNAP ? (_loc_6 + this.ROTATION_SNAP / 2 - _loc_7) : (_loc_6);
            return _loc_8 >= 360 ? (_loc_8 - 360) : (_loc_8);
        }// end function

        private function stage_mouseMoveRotate(param1:MouseEvent) : void
        {
            var rotation:Number;
            var event:* = param1;
            if (stage)
            {
                try
                {
                    rotation = this.currentRotation(event);
                    this.updateConstraintInfo(rotation, ConfigurationModelConstants.NO_SCALE, this.configuration.offset);
                    this.setVisualConfigurationTransformation(rotation, ConfigurationModelConstants.NO_SCALE, this.configuration.offset);
                    this.checkForCanvasSizeViolation();
                    if (this.checkForConstraintViolation(true))
                    {
                        this.lastSuccessfulRotation = rotation;
                    }
                    this.updateToolTip(Math.abs(Math.round(rotation)) + ConfigurationModelConstants.DEGREE);
                }
                catch (e:Error)
                {
                }
            }
            return;
        }// end function

        private function stage_mouseUpRotate(param1:MouseEvent) : void
        {
            var _loc_2:Number;
            if (stage)
            {
                this.interactiveMode = false;
                this.activeDecorator = null;
                this.unregisterMouseRotateHandler();
                _loc_2 = this.currentRotation(param1);
                this.updateConstraintInfo(_loc_2, ConfigurationModelConstants.NO_SCALE, this.configuration.offset);
                this.setVisualConfigurationTransformation(_loc_2, ConfigurationModelConstants.NO_SCALE, this.configuration.offset);
                this.checkForCanvasSizeViolation();
                if (!this.checkForConstraintViolation(true))
                {
                    _loc_2 = this.lastSuccessfulRotation;
                    this.setVisualConfigurationTransformation(_loc_2, ConfigurationModelConstants.NO_SCALE, this.configuration.offset);
                }
                this.configuration.allowConstraintError = true;
                this.configuration.rotation = _loc_2;
                this.configuration.allowConstraintError = false;
                this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(this.configuration.product));
                this.updateConstraintInfo();
                if (this.configuration.type == ConfigurationType.TEXT)
                {
                    this.configuration.textFlow.flowComposer.updateAllControllers();
                }
                this.destroyToolTip();
                invalidateDisplayList();
            }
            return;
        }// end function

        private function currentScale(param1:MouseEvent) : Point
        {
            var _loc_2:* = Point.distance(this.globalCenterOnDragStart, new Point(param1.stageX, param1.stageY)) / Point.distance(this.globalCenterOnDragStart, this.globalMouseLocationOnDragStart);
            return new Point(_loc_2, _loc_2);
        }// end function

        private function scaleHandle_mouseDown(param1:MouseEvent) : void
        {
            if (stage)
            {
                this.interactiveMode = true;
                this.locationSnapshot(param1);
                this.lastSuccessfulScale = ConfigurationModelConstants.NO_SCALE;
                this.registerMouseScaleHandler();
                this.activeDecorator = this.scaleHandle;
                this.setupToolTip();
            }
            return;
        }// end function

        private function stage_mouseMoveScale(param1:MouseEvent) : void
        {
            var scale:Point;
            var event:* = param1;
            if (stage)
            {
                try
                {
                    scale = this.currentScale(event);
                    this.updateConstraintInfo(this.configuration.rotation, scale, this.configuration.offset);
                    this.setVisualConfigurationTransformation(this.configuration.rotation, scale, this.configuration.offset);
                    this.checkForCanvasSizeViolation();
                    if (this.checkForConstraintViolation(false))
                    {
                        this.lastSuccessfulScale = scale;
                    }
                    this.updateToolTip(this.dimensionFormatter.format(new Rectangle(0, 0, Math.abs(Math.round(scale.x * this.configuration.width / 10)), Math.abs(Math.round(scale.y * this.configuration.height / 10)))));
                }
                catch (e:Error)
                {
                }
            }
            return;
        }// end function

        private function stage_mouseUpScale(param1:MouseEvent) : void
        {
            var scale:Point;
            var controller:ContainerController;
            var event:* = param1;
            if (stage)
            {
                this.interactiveMode = false;
                this.activeDecorator = null;
                this.unregisterMouseScaleHandler();
                scale = this.currentScale(event);
                this.updateConstraintInfo(this.configuration.rotation, scale, this.configuration.offset);
                this.setVisualConfigurationTransformation(this.configuration.rotation, scale, this.configuration.offset);
                this.checkForCanvasSizeViolation();
                if (!this.checkForConstraintViolation(false))
                {
                    scale = this.lastSuccessfulScale;
                }
                this.configuration.allowConstraintError = true;
                try
                {
                    this.configuration.centerScale = scale;
                }
                catch (error:FontResizeError)
                {
                }
                finally
                {
                    this.configuration.allowConstraintError = false;
                }
                this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(this.configuration.product));
                this.setVisualConfigurationTransformation(this.configuration.rotation, ConfigurationModelConstants.NO_SCALE, this.configuration.offset);
                this.updateConstraintInfo();
                this.destroyToolTip();
                if (this.configuration.type == ConfigurationType.TEXT)
                {
                    controller = this.configuration.textFlow.flowComposer.getControllerAt(0);
                    controller.setCompositionSize(this.configuration.width, this.configuration.height);
                    this.configuration.textFlow.flowComposer.updateAllControllers();
                }
                invalidateDisplayList();
            }
            return;
        }// end function

        private function startMove(param1:MouseEvent) : void
        {
            if (stage)
            {
                this.interactiveMode = true;
                this.setMoveSelectionFormat();
                this.locationSnapshot(param1);
                this.lastSuccessfulTranslation = this.configuration.offset;
                this.registerMouseTranslateHandler();
                this.activeDecorator = this.moveHandle;
            }
            return;
        }// end function

        private function moveHandle_mouseDown(param1:MouseEvent) : void
        {
            this.startMove(param1);
            return;
        }// end function

        private function configuration_mouseDown(param1:MouseEvent) : void
        {
            if (this.configuration.type == ConfigurationType.TEXT)
            {
                if (this.textEditEnabled)
                {
                    this.swallowEvent(param1);
                    return;
                }
            }
            this.startMove(param1);
            return;
        }// end function

        private function currentTranslation(param1:MouseEvent) : Point
        {
            var _loc_2:* = new Point((param1.stageX - this.globalMouseLocationOnDragStart.x) * this.viewScale, (param1.stageY - this.globalMouseLocationOnDragStart.y) * this.viewScale);
            _loc_2 = _loc_2.add(this.configuration.offset);
            return _loc_2;
        }// end function

        private function stage_mouseMoveTranslate(param1:MouseEvent) : void
        {
            var _loc_2:Point;
            if (stage)
            {
                _loc_2 = this.currentTranslation(param1);
                this.updateConstraintInfo(this.configuration.rotation, ConfigurationModelConstants.NO_SCALE, _loc_2);
                this.setVisualConfigurationTransformation(this.configuration.rotation, ConfigurationModelConstants.NO_SCALE, _loc_2);
                this.checkForCanvasSizeViolation();
                if (this.checkForConstraintViolation(true))
                {
                    this.lastSuccessfulTranslation = _loc_2;
                }
            }
            return;
        }// end function

        private function stage_mouseUpTranslate(param1:MouseEvent) : void
        {
            var _loc_2:Point;
            if (stage)
            {
                this.activeDecorator = null;
                this.unregisterMouseTranslateHandler();
                this.interactiveMode = false;
                _loc_2 = this.currentTranslation(param1);
                if (_loc_2.equals(this.configuration.offset))
                {
                    return;
                }
                this.updateConstraintInfo(this.configuration.rotation, ConfigurationModelConstants.NO_SCALE, _loc_2);
                this.setVisualConfigurationTransformation(this.configuration.rotation, ConfigurationModelConstants.NO_SCALE, _loc_2);
                this.checkForCanvasSizeViolation();
                if (!this.checkForConstraintViolation(true))
                {
                    _loc_2 = this.lastSuccessfulTranslation;
                    this.setVisualConfigurationTransformation(this.configuration.rotation, ConfigurationModelConstants.NO_SCALE, _loc_2);
                }
                this.configuration.allowConstraintError = true;
                this.configuration.offset = _loc_2;
                this.configuration.allowConstraintError = false;
                this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(this.configuration.product));
                this.updateConstraintInfo();
                this.resetSelectionFormat();
                if (this.configuration.type == ConfigurationType.TEXT)
                {
                    this.configuration.textFlow.flowComposer.updateAllControllers();
                }
                invalidateDisplayList();
            }
            return;
        }// end function

        private function reshapeTextBoxHandle_mouseDown(param1:MouseEvent) : void
        {
            if (stage)
            {
                this.interactiveMode = true;
                this.locationSnapshot(param1);
                this.lastSuccessfulReshape = new Point(this.configuration.width, this.configuration.height);
                this.registerMouseReshapeHandler();
                this.activeDecorator = this.reshapeTextBoxHandle;
                this.setupToolTip();
            }
            return;
        }// end function

        private function currentReshape(param1:MouseEvent) : Point
        {
            var _loc_2:* = this.outer.globalToLocal(new Point(param1.stageX, param1.stageY));
            var _loc_3:* = this.outer.globalToLocal(this.globalMouseLocationOnDragStart);
            if (this.autoCorrection)
            {
                return new Point(Math.min(_loc_2.x < 20 ? (20) : (this.configuration.width * _loc_2.x / _loc_3.x), this.configuration.printType.net.sprd.entities:IPrintType::width), Math.min(_loc_2.y < 5 ? (5) : (this.configuration.height * _loc_2.y / _loc_3.y), this.configuration.printType.net.sprd.entities:IPrintType::height));
            }
            else
            {
                return new Point(_loc_2.x < 20 ? (20) : (this.configuration.width * _loc_2.x / _loc_3.x), _loc_2.y < 5 ? (5) : (this.configuration.height * _loc_2.y / _loc_3.y));
            }
        }// end function

        private function reshapeText(param1:Number, param2:Number) : void
        {
            var _loc_3:* = this.configuration.textFlow.flowComposer.getControllerAt(0);
            _loc_3.setCompositionSize(param1, param2);
            this.configuration.textFlow.flowComposer.updateAllControllers();
            this.boundingBox = new Rectangle(0, 0, param1, param2);
            invalidateDisplayList();
            return;
        }// end function

        private function stage_mouseMoveReshape(param1:MouseEvent) : void
        {
            var reshape:Point;
            var event:* = param1;
            if (stage)
            {
                try
                {
                    reshape = this.currentReshape(event);
                    this.reshapeText(reshape.x, reshape.y);
                    this.checkForCanvasSizeViolation();
                    if (!this.canvasSizeViolation)
                    {
                        this.lastSuccessfulReshape = new Point(reshape.x, reshape.y);
                        log.info("x" + this.lastSuccessfulReshape);
                    }
                    this.updateToolTip(this.dimensionFormatter.format(new Rectangle(0, 0, reshape.x / 10, reshape.y / 10)));
                    this.updateConstraintInfo();
                }
                catch (e:Error)
                {
                }
            }
            return;
        }// end function

        private function stage_mouseUpReshape(param1:MouseEvent) : void
        {
            var _loc_2:Point;
            if (stage)
            {
                this.interactiveMode = true;
                this.activeDecorator = null;
                this.unregisterMouseReshapeHandler();
                _loc_2 = this.currentReshape(param1);
                this.reshapeText(_loc_2.x, _loc_2.y);
                this.checkForCanvasSizeViolation();
                if (this.canvasSizeViolation)
                {
                    _loc_2 = this.lastSuccessfulReshape;
                    this.reshapeText(_loc_2.x, _loc_2.y);
                }
                this.configuration.setTextBox(_loc_2.x, _loc_2.y);
                this.configuration.adjustHeightToTextFit();
                this.reshapeText(this.configuration.width, this.configuration.height);
                this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(this.configuration.product));
                this.updateConstraintInfo();
                this.destroyToolTip();
                this.configuration.textFlow.flowComposer.updateAllControllers();
                invalidateDisplayList();
            }
            return;
        }// end function

        private function checkForConstraintViolation(param1:Boolean) : Boolean
        {
            if (this._autoCorrection)
            {
                if (!this.canvasSizeViolation)
                {
                    if (true)
                    {
                    }
                }
                return this.constraintInfo.invalid ? (param1 ? (if (this.constraintInfo.boundaryCollision) goto 6, this.constraintInfo.configurationCollisions.size <= 0) : (false)) : (true);
            }
            else
            {
                return !this.canvasSizeViolation;
            }
        }// end function

        private function setupToolTip() : void
        {
            if (this.activeToolTip)
            {
                this.destroyToolTip();
            }
            ToolTipManager.enabled = false;
            var _loc_1:* = new MouseEvent("");
            this.activeToolTip = ToolTipManager.createToolTip("", _loc_1.stageX, _loc_1.stageY);
            return;
        }// end function

        private function updateToolTip(param1:String) : void
        {
            var _loc_2:* = localToGlobal(this.activeDecorator.getBounds(this.activeDecorator.parent).topLeft);
            this.activeToolTip.text = param1;
            this.activeToolTip.x = Math.round(_loc_2.x - 10);
            this.activeToolTip.y = Math.round(_loc_2.y - this.activeToolTip.height);
            if (!this.activeToolTip.visible)
            {
                this.activeToolTip.setVisible(true);
            }
            return;
        }// end function

        private function destroyToolTip() : void
        {
            try
            {
                if (this.activeToolTip)
                {
                    this.activeToolTip.setVisible(false);
                }
                ToolTipManager.destroyToolTip(this.activeToolTip);
                this.activeToolTip = null;
            }
            catch (e:Error)
            {
            }
            ToolTipManager.enabled = true;
            return;
        }// end function

        private function getSaveStage() : Stage
        {
            return stage ? (stage) : (systemManager.stage);
        }// end function

        private function registerMouseTranslateHandler() : void
        {
            if (stage)
            {
                stage.addEventListener(MouseEvent.MOUSE_MOVE, this.stage_mouseMoveTranslate);
                stage.addEventListener(MouseEvent.MOUSE_UP, this.stage_mouseUpTranslate);
            }
            return;
        }// end function

        private function registerMouseScaleHandler() : void
        {
            if (stage)
            {
                stage.addEventListener(MouseEvent.MOUSE_MOVE, this.stage_mouseMoveScale);
                stage.addEventListener(MouseEvent.MOUSE_UP, this.stage_mouseUpScale);
            }
            return;
        }// end function

        private function registerMouseRotateHandler() : void
        {
            if (stage)
            {
                stage.addEventListener(MouseEvent.MOUSE_MOVE, this.stage_mouseMoveRotate);
                stage.addEventListener(MouseEvent.MOUSE_UP, this.stage_mouseUpRotate);
            }
            return;
        }// end function

        private function registerMouseReshapeHandler() : void
        {
            if (stage)
            {
                stage.addEventListener(MouseEvent.MOUSE_MOVE, this.stage_mouseMoveReshape);
                stage.addEventListener(MouseEvent.MOUSE_UP, this.stage_mouseUpReshape);
            }
            return;
        }// end function

        private function unregisterMouseTranslateHandler() : void
        {
            this.getSaveStage().removeEventListener(MouseEvent.MOUSE_MOVE, this.stage_mouseMoveTranslate);
            this.getSaveStage().removeEventListener(MouseEvent.MOUSE_UP, this.stage_mouseUpTranslate);
            return;
        }// end function

        private function unregisterMouseScaleHandler() : void
        {
            this.getSaveStage().removeEventListener(MouseEvent.MOUSE_MOVE, this.stage_mouseMoveScale);
            this.getSaveStage().removeEventListener(MouseEvent.MOUSE_UP, this.stage_mouseUpScale);
            return;
        }// end function

        private function unregisterMouseRotateHandler() : void
        {
            this.getSaveStage().removeEventListener(MouseEvent.MOUSE_MOVE, this.stage_mouseMoveRotate);
            this.getSaveStage().removeEventListener(MouseEvent.MOUSE_UP, this.stage_mouseUpRotate);
            return;
        }// end function

        private function unregisterMouseReshapeHandler() : void
        {
            this.getSaveStage().removeEventListener(MouseEvent.MOUSE_MOVE, this.stage_mouseMoveReshape);
            this.getSaveStage().removeEventListener(MouseEvent.MOUSE_UP, this.stage_mouseUpReshape);
            return;
        }// end function

        private function unregisterMouseClickHandler() : void
        {
            this.getSaveStage().removeEventListener(MouseEvent.CLICK, this.stage_click);
            return;
        }// end function

        private function unregisterMouseUpHandler() : void
        {
            this.getSaveStage().removeEventListener(MouseEvent.MOUSE_UP, this.stage_mouseUp);
            return;
        }// end function

        private function unregisterTextFlowHandler() : void
        {
            if (this.configuration.type == ConfigurationType.TEXT)
            {
                this.configuration.textFlow.removeEventListener(FlowOperationEvent.FLOW_OPERATION_BEGIN, this.textFlow_flowOperationBeginHandler);
                this.configuration.textFlow.removeEventListener(FlowOperationEvent.FLOW_OPERATION_END, this.textFlow_flowOperationEndHandler);
                this.configuration.textFlow.removeEventListener(SelectionEvent.SELECTION_CHANGE, this.onSelectionChange);
            }
            return;
        }// end function

        private function addDecorator(param1:UIComponent) : void
        {
            param1.endEffectsStarted();
            param1.visible = false;
            addChild(param1);
            this.decorators[param1] = false;
            return;
        }// end function

        private function hideAllDecoratorsBut(param1:DisplayObject) : void
        {
            var _loc_2:Object;
            for (_loc_2 in this.decorators)
            {
                
                this.decorators[_loc_2] = _loc_2 == param1;
            }
            return;
        }// end function

        private function showAllDecorators() : void
        {
            var _loc_1:Object;
            for (_loc_1 in this.decorators)
            {
                
                this.decorators[_loc_1] = true;
            }
            return;
        }// end function

        private function hideAllDecorators() : void
        {
            var _loc_1:Object;
            for (_loc_1 in this.decorators)
            {
                
                this.decorators[_loc_1] = false;
            }
            return;
        }// end function

        private function playDecoratorEffects() : void
        {
            var _loc_2:Object;
            var _loc_3:Array;
            var _loc_1:Array;
            for (_loc_2 in this.decorators)
            {
                
                if (_loc_2.visible)
                {
                }
                if (!this.decorators[_loc_2])
                {
                    _loc_1.push(_loc_2);
                    UIComponent(_loc_2).endEffectsStarted();
                    _loc_2.visible = false;
                }
            }
            this.decoratorEffect.play(_loc_1);
            _loc_3 = [];
            for (_loc_2 in this.decorators)
            {
                
                if (!_loc_2.visible)
                {
                }
                if (this.decorators[_loc_2])
                {
                    _loc_3.push(_loc_2);
                    UIComponent(_loc_2).endEffectsStarted();
                    _loc_2.visible = true;
                }
            }
            this.decoratorEffect.play(_loc_3, true);
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            useHandCursor = true;
            buttonMode = true;
            addChild(this.outer);
            this.moveHandle = new Button();
            this.moveHandle.name = "move";
            this.moveHandle.styleName = "configurationHandle";
            this.moveHandle.setStyle("icon", getStyle("moveIcon"));
            this.moveHandle.focusEnabled = false;
            var _loc_3:int;
            this.moveHandle.height = 15;
            this.moveHandle.width = _loc_3;
            this.addDecorator(this.moveHandle);
            this.scaleHandle = new Button();
            this.scaleHandle.styleName = "configurationHandle";
            this.scaleHandle.setStyle("icon", getStyle("scaleIcon"));
            this.scaleHandle.name = "scale";
            this.scaleHandle.focusEnabled = false;
            var _loc_3:int;
            this.scaleHandle.height = 15;
            this.scaleHandle.width = _loc_3;
            this.scaleHandle.endEffectsStarted();
            this.scaleHandle.visible = false;
            this.addDecorator(this.scaleHandle);
            if (this.configuration.type == ConfigurationType.TEXT)
            {
                this.reshapeTextBoxHandle = new Button();
                this.reshapeTextBoxHandle.styleName = "configurationHandle";
                this.reshapeTextBoxHandle.setStyle("icon", getStyle("reshapeIcon"));
                this.reshapeTextBoxHandle.name = "reshapeTextBox";
                this.reshapeTextBoxHandle.focusEnabled = false;
                var _loc_3:int;
                this.reshapeTextBoxHandle.height = 15;
                this.reshapeTextBoxHandle.width = _loc_3;
                this.reshapeTextBoxHandle.endEffectsStarted();
                this.reshapeTextBoxHandle.visible = false;
                this.addDecorator(this.reshapeTextBoxHandle);
            }
            this.rotateHandle = new Button();
            this.rotateHandle.styleName = "configurationHandle";
            this.rotateHandle.setStyle("icon", getStyle("rotateIcon"));
            this.rotateHandle.name = "rotate";
            this.rotateHandle.focusEnabled = false;
            var _loc_3:int;
            this.rotateHandle.height = 15;
            this.rotateHandle.width = _loc_3;
            this.addDecorator(this.rotateHandle);
            this.deleteHandle = new Button();
            this.deleteHandle.styleName = "configurationHandle";
            this.deleteHandle.setStyle("icon", getStyle("deleteIcon"));
            this.deleteHandle.name = "delete";
            this.deleteHandle.focusEnabled = false;
            var _loc_3:int;
            this.deleteHandle.height = 15;
            this.deleteHandle.width = _loc_3;
            this.addDecorator(this.deleteHandle);
            var _loc_1:* = new Zoom();
            _loc_1.zoomWidthFrom = 1;
            _loc_1.zoomWidthTo = 0.01;
            _loc_1.zoomHeightFrom = 1;
            _loc_1.zoomHeightTo = 0.01;
            _loc_1.easingFunction = Sine.easeIn;
            var _loc_2:* = new Fade();
            _loc_2.alphaFrom = 1;
            _loc_2.alphaTo = 0;
            _loc_2.easingFunction = Sine.easeIn;
            this.decoratorEffect = new Parallel();
            this.decoratorEffect.children = [_loc_2, _loc_1];
            this.decoratorEffect.duration = 200;
            this._constraintInfoVisualizer = new ConstraintInfoVisualizer(this.configuration);
            addChild(this._constraintInfoVisualizer);
            return;
        }// end function

        override protected function childrenCreated() : void
        {
            super.childrenCreated();
            if (!this.configuration.isChangeable)
            {
                return;
            }
            this.rotateHandle.addEventListener(MouseEvent.MOUSE_DOWN, this.rotateHandle_mouseDown, false, 0, true);
            this.scaleHandle.addEventListener(MouseEvent.MOUSE_DOWN, this.scaleHandle_mouseDown, false, 0, true);
            this.moveHandle.addEventListener(MouseEvent.MOUSE_DOWN, this.moveHandle_mouseDown, false, 0, true);
            this.deleteHandle.addEventListener(MouseEvent.CLICK, this.deleteHandle_click, false, 0, true);
            if (this.reshapeTextBoxHandle)
            {
                this.reshapeTextBoxHandle.addEventListener(MouseEvent.MOUSE_DOWN, this.reshapeTextBoxHandle_mouseDown, false, 0, true);
            }
            this.rotateHandle.addEventListener(MouseEvent.CLICK, this.swallowEvent, false, 0, true);
            this.scaleHandle.addEventListener(MouseEvent.CLICK, this.swallowEvent, false, 0, true);
            this.moveHandle.addEventListener(MouseEvent.CLICK, this.swallowEvent, false, 0, true);
            if (this.reshapeTextBoxHandle)
            {
                this.reshapeTextBoxHandle.addEventListener(MouseEvent.CLICK, this.swallowEvent, false, 0, true);
            }
            this.outer.addEventListener(MouseEvent.CLICK, this.configuration_click, false, 0, true);
            this.outer.addEventListener(MouseEvent.CLICK, this.configuration_click2, true, 0, true);
            this.outer.addEventListener(MouseEvent.MOUSE_DOWN, this.configuration_mouseDown, false, 0, true);
            addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyPressed);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            this.getSaveStage().addEventListener(Event.ACTIVATE, this.resetFocus);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this._renderStateChanged)
            {
                this._renderStateChanged = false;
                if (this._rendered)
                {
                    dispatchEvent(new Event(Event.COMPLETE));
                }
            }
            if (this._selectionChanged)
            {
                this._selectionChanged = false;
                if (this.isSelected)
                {
                    if (focusManager)
                    {
                    }
                    if (!stage)
                    {
                        log.error("stage missing - make sure lifecycle phase is right");
                    }
                    this.getSaveStage().addEventListener(MouseEvent.CLICK, this.stage_click, false, 0, true);
                    this.getSaveStage().addEventListener(MouseEvent.MOUSE_UP, this.stage_mouseUp);
                    this.outer.removeEventListener(MouseEvent.CLICK, this.configuration_click);
                    this.outer.removeEventListener(MouseEvent.CLICK, this.configuration_click2);
                    dispatchEvent(new FocusEvent(FocusEvent.FOCUS_IN));
                    if (this.configuration.type == ConfigurationType.TEXT)
                    {
                        if (this.configuration.isDefaultConfiguration)
                        {
                            this.configuration.textFlow.interactionManager.selectAll();
                        }
                        this.configuration.textFlow.interactionManager.setFocus();
                        this.configuration.textFlow.flowComposer.updateAllControllers();
                    }
                }
                else
                {
                    if (focusManager)
                    {
                        focusManager.hideFocus();
                    }
                    this.unregisterMouseClickHandler();
                    if (this.configuration.canBeRemoved)
                    {
                        this.configuration.remove();
                    }
                    else
                    {
                        this.outer.addEventListener(MouseEvent.CLICK, this.configuration_click, false, 0, true);
                        this._textEditEnabled = false;
                        this._textEditEnabledChanged = true;
                    }
                    if (this.configuration.type == ConfigurationType.TEXT)
                    {
                        this.configuration.textFlow.interactionManager.selectRange(-1, -1);
                    }
                }
                invalidateDisplayList();
            }
            if (this._textEditEnabledChanged)
            {
                this._textEditEnabledChanged = false;
                if (this.configuration.type == ConfigurationType.TEXT)
                {
                    if (this.textEditEnabled)
                    {
                        if (!this.configuration.isDefaultConfiguration)
                        {
                        }
                        if (!this.configuration.textOfferedForDeletion)
                        {
                            this.configuration.textFlow.interactionManager.selectRange(0, 0);
                        }
                        else
                        {
                            this.configuration.textFlow.interactionManager.selectAll();
                        }
                        this.configuration.textFlow.interactionManager.setFocus();
                        this.configuration.textFlow.flowComposer.updateAllControllers();
                    }
                    else
                    {
                        this.configuration.textFlow.interactionManager.selectRange(-1, -1);
                        this.getSaveStage().focus = this.getSaveStage();
                        this.configuration.textFlow.flowComposer.updateAllControllers();
                    }
                    this.resetSelectionFormat();
                }
                invalidateDisplayList();
            }
            if (this._viewScaleChanged)
            {
                this._viewScaleChanged = false;
                invalidateSize();
                invalidateDisplayList();
            }
            if (this._isOnBrightFabricChanged)
            {
                this._isOnBrightFabricChanged = false;
                invalidateDisplayList();
            }
            if (this._constraintInfoChanged)
            {
                this._constraintInfoChanged = false;
                invalidateDisplayList();
            }
            if (this._interactiveModeChanged)
            {
                this._interactiveModeChanged = false;
                this._constraintInfoVisualizer.showExplanation = this._interactiveMode;
            }
            if (this.isSelected)
            {
            }
            if (this.textEditEnabled)
            {
                callLater(this.fixFocus);
            }
            return;
        }// end function

        private function fixFocus() : void
        {
            if (this.configuration.type == ConfigurationType.TEXT)
            {
                if (this.textEditEnabled)
                {
                    this.resetSelectionFormat();
                    this.configuration.textFlow.interactionManager.refreshSelection();
                    this.configuration.textFlow.interactionManager.setFocus();
                    this.configuration.textFlow.flowComposer.updateAllControllers();
                    invalidateDisplayList();
                }
                else
                {
                    this.resetSelectionFormat();
                    this.configuration.textFlow.interactionManager.selectRange(-1, -1);
                    this.getSaveStage().focus = this.getSaveStage();
                    this.configuration.textFlow.flowComposer.updateAllControllers();
                    invalidateDisplayList();
                }
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            if (!this._constraintInfoVisualizer.constraintInfo)
            {
                this.updateConstraintInfo();
            }
            this.updateDecoratorVisibility();
            this.playDecoratorEffects();
            graphics.clear();
            var _loc_3:* = this.calculateTransformedBounds();
            this.updateConstraintInfoVisualizer(_loc_3.topLeft, _loc_3.topRight);
            if (this._isSelected)
            {
                this.updateDecoratorPositions(_loc_3.topLeft, _loc_3.topRight, _loc_3.bottomLeft, _loc_3.bottomRight);
            }
            return;
        }// end function

        private function updateDecoratorVisibility() : void
        {
            if (this._isSelected)
            {
            }
            if (this.textEditEnabled)
            {
                if (this.activeDecorator == null)
                {
                    this.showAllDecorators();
                }
                else
                {
                    this.hideAllDecoratorsBut(this.activeDecorator);
                }
            }
            else
            {
                this.hideAllDecorators();
            }
            return;
        }// end function

        private function calculateTransformedBounds() : Object
        {
            var _loc_1:* = this.outer.transform.matrix.clone();
            if (!_loc_1)
            {
                _loc_1 = new Matrix();
            }
            var _loc_2:* = _loc_1.transformPoint(this.boundingBox.topLeft);
            var _loc_3:* = _loc_1.transformPoint(new Point(this.boundingBox.right, this.boundingBox.top));
            var _loc_4:* = _loc_1.transformPoint(new Point(this.boundingBox.left, this.boundingBox.bottom));
            var _loc_5:* = _loc_1.transformPoint(this.boundingBox.bottomRight);
            return {topLeft:_loc_2, topRight:_loc_3, bottomLeft:_loc_4, bottomRight:_loc_5};
        }// end function

        private function updateConstraintInfoVisualizer(param1:Point, param2:Point) : void
        {
            this._constraintInfoVisualizer.move(param1.x + this.moveHandle.width / 2, param1.y - this._constraintInfoVisualizer.getBounds(null).height / 2);
            this._constraintInfoVisualizer.endEffectsStarted();
            if (this._constraintInfoVisualizer.constraintInfo)
            {
            }
            if (this._constraintInfoVisualizer.constraintInfo.invalid)
            {
            }
            this._constraintInfoVisualizer.visible = !this.autoCorrection;
            var _loc_3:* = this.outer.filters;
            if (this._constraintInfoVisualizer.constraintInfo)
            {
                if (!this._constraintInfoVisualizer.constraintInfo.invalid)
                {
                }
            }
            if (_loc_3.length == 0)
            {
                return;
            }
            if (this._constraintInfoVisualizer.constraintInfo)
            {
                if (this._constraintInfoVisualizer.constraintInfo.invalid)
                {
                }
            }
            if (_loc_3.length > 0)
            {
                return;
            }
            if (this._constraintInfoVisualizer.constraintInfo)
            {
            }
            this.outer.filters = this._constraintInfoVisualizer.constraintInfo.invalid ? ([new GlowFilter(16711680)]) : ([]);
            return;
        }// end function

        private function updateDecoratorPositions(param1:Point, param2:Point, param3:Point, param4:Point) : void
        {
            var temp:Point;
            var topLeft:* = param1;
            var topRight:* = param2;
            var bottomLeft:* = param3;
            var bottomRight:* = param4;
            if (this.configuration.flipX * this.configuration.flipY < 0)
            {
                temp = topLeft;
                topLeft = topRight;
                topRight = temp;
                temp = bottomLeft;
                bottomLeft = bottomRight;
                bottomRight = temp;
            }
            var lineColor:* = this.isOnBrightFabric ? (getStyle("darkBorderColor")) : (getStyle("brightBorderColor"));
            var _loc_6:* = graphics;
            with (graphics)
            {
                lineStyle(1, lineColor, 0.2, true);
                moveTo(topLeft.x, topLeft.y);
                lineTo(topRight.x, topRight.y);
                lineTo(bottomRight.x, bottomRight.y);
                lineTo(bottomLeft.x, bottomLeft.y);
                lineTo(topLeft.x, topLeft.y);
            }
            var line:* = new DashedLine(this, 2, 3);
            line.lineStyle(1, lineColor, 0.5);
            line.moveTo(topLeft.x, topLeft.y);
            line.lineTo(topRight.x, topRight.y);
            line.lineTo(bottomRight.x, bottomRight.y);
            line.lineTo(bottomLeft.x, bottomLeft.y);
            line.lineTo(topLeft.x, topLeft.y);
            this.moveHandle.move(topLeft.x - this.moveHandle.width / 2, topLeft.y - this.moveHandle.height / 2);
            this.rotateHandle.move(topRight.x - this.rotateHandle.width / 2, topRight.y - this.rotateHandle.height / 2);
            this.scaleHandle.move(bottomRight.x - this.scaleHandle.width / 2, bottomRight.y - this.scaleHandle.height / 2);
            this.deleteHandle.move(bottomLeft.x - this.deleteHandle.width / 2, bottomLeft.y - this.deleteHandle.height / 2);
            if (this.reshapeTextBoxHandle)
            {
                this.reshapeTextBoxHandle.move(bottomRight.x - 10 - this.reshapeTextBoxHandle.width, bottomRight.y - this.reshapeTextBoxHandle.height / 2);
            }
            if (this.configuration.type == ConfigurationType.TEXT)
            {
                this.configuration.textFlow.flowComposer.updateAllControllers();
            }
            return;
        }// end function

        public function bus_configurationSelectedHandler(param1:ConfigurationEvent) : void
        {
            this.updateConstraintInfo();
            this.setSelected(this.configuration == param1.configuration);
            invalidateDisplayList();
            return;
        }// end function

        public function bus_configurationChangedHandler(param1:ConfigurationEvent) : void
        {
            this.updateConstraintInfo();
            invalidateDisplayList();
            if (this.configuration != param1.configuration)
            {
                return;
            }
            this.setConfigurationGeometry();
            return;
        }// end function

        public function bus_configurationRemovedHandler(param1:ConfigurationEvent) : void
        {
            this.updateConstraintInfo();
            invalidateDisplayList();
            if (this.configuration != param1.configuration)
            {
                return;
            }
            if (parent)
            {
                PrintAreaViewer(parent).removeConfigurationViewer(this);
            }
            return;
        }// end function

        public function bus_productTypeChangedHandler(param1:ProductTypeEvent) : void
        {
            this.updateConstraintInfo();
            invalidateDisplayList();
            return;
        }// end function

        public function bus_configurationPrintTypeChangedHandler(param1:ConfigurationEvent) : void
        {
            this.updateConstraintInfo();
            invalidateDisplayList();
            return;
        }// end function

        public function bus_configurationColorChangedHandler(param1:ConfigurationEvent) : void
        {
            if (this.configuration.type == ConfigurationType.DESIGN)
            {
                this.updateConstraintInfo();
                invalidateDisplayList();
            }
            if (this.configuration != param1.configuration)
            {
                return;
            }
            if (this.configuration.type == ConfigurationType.DESIGN)
            {
                this.renderer.render();
            }
            return;
        }// end function

        public function bus_configurationFontChangedHandler(param1:ConfigurationEvent) : void
        {
            if (this.configuration != param1.configuration)
            {
                return;
            }
            this.updateConstraintInfo();
            invalidateDisplayList();
            return;
        }// end function

        private function setConfigurationGeometry() : void
        {
            if (this.configuration.type == ConfigurationType.DESIGN)
            {
                this.outer.width = this.configuration.unscaledWidth;
                this.outer.height = this.configuration.unscaledHeight;
            }
            else
            {
                this.outer.width = this.configuration.width;
                this.outer.height = this.configuration.height;
            }
            this.boundingBox = new Rectangle(0, 0, this.outer.width, this.outer.height);
            this.setVisualConfigurationTransformation(this.configuration.rotation, ConfigurationModelConstants.NO_SCALE, this.configuration.offset);
            invalidateProperties();
            return;
        }// end function

        private function renderer_complete(param1:Event) : void
        {
            var controller:ContainerController;
            var i:int;
            var l:Sprite;
            var event:* = param1;
            this.setConfigurationGeometry();
            this.inner = this.renderer.render();
            if (this.configuration.type == ConfigurationType.TEXT)
            {
                this.configuration.textFlow.addEventListener(FlowOperationEvent.FLOW_OPERATION_BEGIN, this.textFlow_flowOperationBeginHandler);
                this.configuration.textFlow.addEventListener(FlowOperationEvent.FLOW_OPERATION_END, this.textFlow_flowOperationEndHandler);
                this.defineSelectionFormats();
                controller = this.configuration.textFlow.flowComposer.getControllerAt(0);
                controller.setCompositionSize(this.configuration.width, this.configuration.height);
                this.configuration.textFlow.flowComposer.updateAllControllers();
            }
            else if (this.configuration.design.isVectorDesign)
            {
                i;
                while (i < this.renderer.layers().length)
                {
                    
                    l = this.renderer.layers()[i];
                    l.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent) : void
            {
                var _loc_2:* = renderer.layers().indexOf(param1.target);
                if (_loc_2 != -1)
                {
                    configuration.selectedLayerIndex = _loc_2;
                }
                return;
            }// end function
            );
                    i = i++;
                }
            }
            this.outer.addChild(this.inner);
            this._rendered = true;
            this._renderStateChanged = true;
            invalidateProperties();
            invalidateDisplayList();
            dispatchEvent(new ApplicationEvent(ApplicationEvent.COMPONENT_COMPLETE));
            return;
        }// end function

        private function textFlow_flowOperationBeginHandler(param1:FlowOperationEvent) : void
        {
            var _loc_3:Number;
            var _loc_2:* = this.configuration.textOperationStrategy.execute(param1.operation);
            if (!_loc_2)
            {
                param1.preventDefault();
            }
            else if (_loc_2.invalid)
            {
                param1.preventDefault();
                _loc_2.undo();
            }
            else if (_loc_2.fontSizeReduction != 1)
            {
                _loc_3 = this.autoCorrection ? (this.configuration.getMinimumFontSize()) : (0);
                TextFlowUtil.decreaseFontSize(this.configuration.textFlow, _loc_2.fontSizeReduction, this.configuration.width / this.configuration.unscaledWidth, _loc_3);
            }
            return;
        }// end function

        private function textFlow_flowOperationEndHandler(param1:FlowOperationEvent) : void
        {
            if (param1.isDefaultPrevented())
            {
                log.warn("Operation cancelled: " + param1.operation);
            }
            else if (param1.error)
            {
                log.warn("An Error occurred for " + param1.operation);
                param1.preventDefault();
            }
            else
            {
                this.configuration.markModified();
                this.configuration.isDefaultConfiguration = false;
                this.setVisualConfigurationTransformation(this.configuration.rotation, ConfigurationModelConstants.NO_SCALE, this.configuration.offset);
                this.reshapeText(this.configuration.width, this.configuration.height);
                this.configuration.textFlow.flowComposer.updateAllControllers();
                this.configuration.testTextFlow.flowComposer.updateAllControllers();
                this.configuration.updateSVGContent();
                this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(this.configuration.product));
                invalidateDisplayList();
                this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.TEXT_CHANGED, this.configuration));
            }
            return;
        }// end function

        private function renderer_error(param1:IOErrorEvent) : void
        {
            log.warn("Couldn\'t load configuration " + this.configuration.configurationID + ": " + param1 + ".");
            if (this.configuration.type == ConfigurationType.DESIGN)
            {
                log.warn("...Configuration will be removed.");
                this.configuration.remove();
            }
            return;
        }// end function

        private function configuration_click2(param1:MouseEvent) : void
        {
            if (this._configuration.textOfferedForDeletion)
            {
                this._configuration.textOfferedForDeletion = false;
                EditManager(this.configuration.textFlow.interactionManager).selectAll();
            }
            this.outer.removeEventListener(MouseEvent.CLICK, this.configuration_click2);
            return;
        }// end function

        private function configuration_click(param1:MouseEvent) : void
        {
            this.swallowEvent(param1);
            dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            return;
        }// end function

        private function stage_click(param1:MouseEvent) : void
        {
            this.swallowEvent(param1);
            if (hitTestPoint(param1.stageX, param1.stageY, true))
            {
                return;
            }
            var _loc_2:* = globalToLocal(new Point(param1.stageX, param1.stageY));
            var _loc_3:* = new FlexMouseEvent(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, param1.bubbles, param1.cancelable, _loc_2.x, _loc_2.y, param1.relatedObject, param1.ctrlKey, param1.altKey, param1.shiftKey, param1.buttonDown, param1.delta);
            dispatchEvent(_loc_3);
            return;
        }// end function

        private function stage_mouseUp(param1:MouseEvent) : void
        {
            if (!stage)
            {
                return;
            }
            this.unregisterMouseUpHandler();
            this.textEditEnabled = true;
            return;
        }// end function

        private function deleteHandle_click(param1:MouseEvent) : void
        {
            this.swallowEvent(param1);
            this.configuration.remove();
            this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(this.configuration.product));
            return;
        }// end function

        private function swallowEvent(param1:Event) : void
        {
            param1.stopImmediatePropagation();
            return;
        }// end function

        private function resetFocus(param1:Event) : void
        {
            if (this.isSelected)
            {
                this.fixFocus();
            }
            return;
        }// end function

        private function onRemovedFromStage(param1:Event) : void
        {
            this.unregisterTextFlowHandler();
            this.unregisterMouseClickHandler();
            this.unregisterMouseUpHandler();
            this.unregisterMouseReshapeHandler();
            this.unregisterMouseRotateHandler();
            this.unregisterMouseScaleHandler();
            this.unregisterMouseTranslateHandler();
            this.getSaveStage().removeEventListener(Event.ACTIVATE, this.resetFocus);
            this.destroyToolTip();
            if (this._constraintInfoVisualizer)
            {
                this._constraintInfoVisualizer.tearDown();
                removeChild(this._constraintInfoVisualizer);
            }
            return;
        }// end function

        private function onSelectionChange(param1:SelectionEvent) : void
        {
            if (!this.textEditEnabled)
            {
                return;
            }
            var _loc_2:* = this.configuration.textFlow.interactionManager.getCommonCharacterFormat();
            if (_loc_2)
            {
            }
            if (this.configuration.rgbColors[0] != _loc_2.color)
            {
                this.configuration.rgbColors = [_loc_2.color];
            }
            return;
        }// end function

        private function onKeyPressed(param1:KeyboardEvent) : void
        {
            var _loc_2:Point;
            if (this.isSelected)
            {
            }
            if (this.configuration.type == ConfigurationType.TEXT)
            {
                return;
            }
            switch(param1.keyCode)
            {
                case 37:
                {
                    _loc_2 = new Point(-1, 0);
                    break;
                }
                case 38:
                {
                    _loc_2 = new Point(0, -1);
                    break;
                }
                case 39:
                {
                    _loc_2 = new Point(1, 0);
                    break;
                }
                case 40:
                {
                    _loc_2 = new Point(0, 1);
                    break;
                }
                case 46:
                {
                    this.configuration.remove();
                    this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(this.configuration.product));
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_2)
            {
                if (param1.shiftKey)
                {
                    _loc_2.x = _loc_2.x * 10;
                    _loc_2.y = _loc_2.y * 10;
                }
                _loc_2 = this.configuration.offset.add(_loc_2);
                this.updateConstraintInfo(this.configuration.rotation, ConfigurationModelConstants.NO_SCALE, _loc_2);
                if (!this.checkForConstraintViolation(true))
                {
                    _loc_2 = this.lastSuccessfulTranslation;
                }
                else
                {
                    this.lastSuccessfulTranslation = _loc_2;
                }
                this.setVisualConfigurationTransformation(this.configuration.rotation, ConfigurationModelConstants.NO_SCALE, _loc_2);
                this.configuration.allowConstraintError = true;
                this.configuration.offset = _loc_2;
                this.configuration.allowConstraintError = false;
                this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(this.configuration.product));
                invalidateDisplayList();
            }
            return;
        }// end function

        public function applyFontStyleToTextSelection(param1:IFontFamily, param2:Boolean, param3:Boolean) : void
        {
            var family:* = param1;
            var bold:* = param2;
            var italic:* = param3;
            if (this.configuration.type != ConfigurationType.TEXT)
            {
                return;
            }
            if (!this.fm.isEmbeddedFontLoaded(family, bold, italic))
            {
                this.fm.loadFontAsset(family, bold, italic, function (param1:Event) : void
            {
                doApplyFontStyleToTextSelection(family, bold, italic);
                return;
            }// end function
            );
            }
            else
            {
                this.doApplyFontStyleToTextSelection(family, bold, italic);
            }
            return;
        }// end function

        private function doApplyFontStyleToTextSelection(param1:IFontFamily, param2:Boolean, param3:Boolean) : void
        {
            var _loc_4:* = new TextLayoutFormat();
            _loc_4.fontFamily = param1.getEmbeddedFontName();
            _loc_4.fontStyle = param3 ? (FontPosture.ITALIC) : (FontPosture.NORMAL);
            _loc_4.fontWeight = param2 ? (FontWeight.BOLD) : (FontWeight.NORMAL);
            IEditManager(this.configuration.textFlow.interactionManager).applyLeafFormat(_loc_4);
            this.configuration.textFlow.interactionManager.setFocus();
            return;
        }// end function

    }
}
