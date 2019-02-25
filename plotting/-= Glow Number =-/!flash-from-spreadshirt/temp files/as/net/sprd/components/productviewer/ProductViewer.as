package net.sprd.components.productviewer
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import net.sprd.common.collections.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.entities.*;
    import net.sprd.events.*;
    import net.sprd.models.common.*;
    import net.sprd.models.product.*;

    public class ProductViewer extends UIComponent
    {
        public var productModel:IProductModel;
        private var productTypeViewer:ProductTypeViewer;
        private var _productChanged:Boolean;
        private var _viewChanged:Boolean;
        private var _isProductTypeViewerComplete:Boolean;
        private var _productTypeChanged:Boolean;
        private var _productTypeAppearanceChanged:Boolean;
        private var viewScale:Number = 1;
        private var _printAreas:Dictionary;
        private var _isOnBrightFabric:Boolean;
        private var _isOnBrightFabricChanged:Boolean;
        private var selectedConfiguration:IConfigurationModel;
        private var _autoCorrection:Boolean;
        private var _autoCorrectionChanged:Boolean;
        private var initializingViews:ISet;
        private var _componentComplete:Boolean = false;
        private static const log:ILogger = LogContext.getLogger(this);

        public function ProductViewer()
        {
            var _this:ProductViewer;
            this._printAreas = new Dictionary();
            this.initializingViews = new SortedSet();
            _this;
            with ({})
            {
                {}.creationComplete = function (param1:FlexEvent) : void
            {
                var e:* = param1;
                if (parent)
                {
                    with ({})
                    {
                        {}.mouseClick = function (param1:MouseEvent) : void
                {
                    var _loc_2:*;
                    if (param1.target is DisplayObject)
                    {
                        _loc_2 = param1.target as DisplayObject;
                        while (_loc_2)
                        {
                            
                            if (_loc_2 is ConfigurationViewer)
                            {
                                return;
                            }
                            if (_loc_2 != _this)
                            {
                                if (_loc_2 is UIComponent)
                                {
                                }
                            }
                            if (UIComponent(_loc_2).id == "clickCatcher")
                            {
                                productModel.selectConfiguration(null, true);
                                return;
                            }
                            _loc_2 = _loc_2.parent;
                        }
                    }
                    return;
                }// end function
                ;
                    }
                    parent.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent) : void
                {
                    var _loc_2:*;
                    if (param1.target is DisplayObject)
                    {
                        _loc_2 = param1.target as DisplayObject;
                        while (_loc_2)
                        {
                            
                            if (_loc_2 is ConfigurationViewer)
                            {
                                return;
                            }
                            if (_loc_2 != _this)
                            {
                                if (_loc_2 is UIComponent)
                                {
                                }
                            }
                            if (UIComponent(_loc_2).id == "clickCatcher")
                            {
                                productModel.selectConfiguration(null, true);
                                return;
                            }
                            _loc_2 = _loc_2.parent;
                        }
                    }
                    return;
                }// end function
                );
                }
                return;
            }// end function
            ;
            }
            EventUtil.registerOnetimeListeners(this, [FlexEvent.CREATION_COMPLETE], [function (param1:FlexEvent) : void
            {
                var e:* = param1;
                if (parent)
                {
                    with ({})
                    {
                        {}.mouseClick = function (param1:MouseEvent) : void
                {
                    var _loc_2:*;
                    if (param1.target is DisplayObject)
                    {
                        _loc_2 = param1.target as DisplayObject;
                        while (_loc_2)
                        {
                            
                            if (_loc_2 is ConfigurationViewer)
                            {
                                return;
                            }
                            if (_loc_2 != _this)
                            {
                                if (_loc_2 is UIComponent)
                                {
                                }
                            }
                            if (UIComponent(_loc_2).id == "clickCatcher")
                            {
                                productModel.selectConfiguration(null, true);
                                return;
                            }
                            _loc_2 = _loc_2.parent;
                        }
                    }
                    return;
                }// end function
                ;
                    }
                    parent.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent) : void
                {
                    var _loc_2:*;
                    if (param1.target is DisplayObject)
                    {
                        _loc_2 = param1.target as DisplayObject;
                        while (_loc_2)
                        {
                            
                            if (_loc_2 is ConfigurationViewer)
                            {
                                return;
                            }
                            if (_loc_2 != _this)
                            {
                                if (_loc_2 is UIComponent)
                                {
                                }
                            }
                            if (UIComponent(_loc_2).id == "clickCatcher")
                            {
                                productModel.selectConfiguration(null, true);
                                return;
                            }
                            _loc_2 = _loc_2.parent;
                        }
                    }
                    return;
                }// end function
                );
                }
                return;
            }// end function
            ]);
            return;
        }// end function

        public function init() : void
        {
            if (this.productModel.state == ModelState.INITIALIZED)
            {
                this._productChanged = true;
                this.checkComponentComplete();
                invalidateProperties();
            }
            return;
        }// end function

        public function get view() : IProductTypeView
        {
            return this.productModel.currentView;
        }// end function

        public function set view(param1:IProductTypeView) : void
        {
            if (this.productModel.currentView == param1)
            {
                return;
            }
            this.productModel.currentView = param1;
            return;
        }// end function

        public function get isOnBrightFabric() : Boolean
        {
            return this._isOnBrightFabric;
        }// end function

        public function set isOnBrightFabric(param1:Boolean) : void
        {
            this._isOnBrightFabric = param1;
            this._isOnBrightFabricChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function getConfigurationViewer(param1:IConfigurationModel) : ConfigurationViewer
        {
            var _loc_2:PrintAreaViewer;
            var _loc_3:ConfigurationViewer;
            for each (_loc_2 in this.printAreas)
            {
                
                for each (_loc_3 in _loc_2.configurations)
                {
                    
                    if (_loc_3.configuration == param1)
                    {
                        return _loc_3;
                    }
                }
            }
            return null;
        }// end function

        public function get autoCorrection() : Boolean
        {
            return this._autoCorrection;
        }// end function

        public function set autoCorrection(param1:Boolean) : void
        {
            if (param1 == this._autoCorrection)
            {
                return;
            }
            this._autoCorrection = param1;
            this._autoCorrectionChanged = true;
            invalidateProperties();
            return;
        }// end function

        private function updateIsOnBrightFabric() : void
        {
            var _loc_1:PrintAreaViewer;
            if (!this.productModel.currentAppearance)
            {
                return;
            }
            this.isOnBrightFabric = this.productModel.isBrightAppearance();
            for each (_loc_1 in this._printAreas)
            {
                
                _loc_1.isOnBrightFabric = this.isOnBrightFabric;
            }
            return;
        }// end function

        private function createConfigurationViewersOnViewChange() : void
        {
            var _loc_1:IConfigurationModel;
            var _loc_2:ConfigurationViewer;
            var _loc_3:ConfigurationViewer;
            this.initializingViews.clear();
            for each (_loc_1 in this.productModel.getConfigurationsForView(this.productModel.currentView))
            {
                
                _loc_3 = this.createConfigurationViewerInternal(_loc_1);
                this.addConfigurationViewerToPrintAreaContainer(_loc_3);
                this.initializingViews.add(_loc_3);
            }
            for each (_loc_2 in this.initializingViews.toArray().slice())
            {
                
                _loc_2.init();
            }
            return;
        }// end function

        private function createConfigurationViewer(param1:IConfigurationModel) : void
        {
            var _loc_2:ConfigurationViewer;
            if (this._printAreas[param1.printArea.id])
            {
                _loc_2 = this.createConfigurationViewerInternal(param1);
                this.addConfigurationViewerToPrintAreaContainer(_loc_2);
                _loc_2.init();
            }
            return;
        }// end function

        private function createConfigurationViewerInternal(param1:IConfigurationModel) : ConfigurationViewer
        {
            var _loc_2:* = new ConfigurationViewer(param1, this.viewScale, this._autoCorrection, this.isOnBrightFabric, this.productModel.isConfigurationSelected(param1));
            _loc_2.addEventListener(Event.REMOVED_FROM_STAGE, this.configurationViewer_removedFromStageHandler);
            _loc_2.addEventListener(ApplicationEvent.COMPONENT_COMPLETE, this.configurationViewer_completeHandler);
            return _loc_2;
        }// end function

        private function addConfigurationViewerToPrintAreaContainer(param1:ConfigurationViewer) : void
        {
            var _loc_2:* = PrintAreaViewer(this._printAreas[param1.configuration.printArea.id]);
            if (_loc_2)
            {
                _loc_2.addConfigurationViewer(param1);
            }
            else
            {
                log.warn("print area container not found for pa id " + param1.configuration.printArea.id);
            }
            return;
        }// end function

        private function updateAutoCorrection() : void
        {
            var _loc_1:IConfigurationModel;
            var _loc_2:ConfigurationViewer;
            for each (_loc_1 in this.productModel.configurations)
            {
                
                _loc_2 = this.getConfigurationViewer(_loc_1);
                if (_loc_2)
                {
                    _loc_2.autoCorrection = this.autoCorrection;
                }
            }
            return;
        }// end function

        private function checkComponentComplete() : void
        {
            var _loc_1:int;
            var _loc_2:int;
            if (this._isProductTypeViewerComplete)
            {
                this.productTypeViewer.visible = true;
            }
            if (this._isProductTypeViewerComplete)
            {
            }
            if (this.initializingViews.size == 0)
            {
                if (!stage)
                {
                    callLater(this.checkComponentComplete);
                    return;
                }
                stage.addEventListener(MouseEvent.CLICK, this.stage_clickHandler);
                endEffectsStarted();
                _loc_1 = numChildren;
                _loc_2 = _loc_1 - 1;
                while (_loc_2-- > 0)
                {
                    
                    if (getChildAt(_loc_2) is PrintAreaViewer)
                    {
                        getChildAt(_loc_2).visible = true;
                    }
                }
                if (!this._componentComplete)
                {
                    this._componentComplete = true;
                    dispatchEvent(new ApplicationEvent(ApplicationEvent.COMPONENT_COMPLETE, true));
                    this.displayProductTypeAlert();
                }
            }
            else
            {
                _loc_1 = numChildren;
                _loc_2 = _loc_1 - 1;
                while (_loc_2-- > 0)
                {
                    
                    if (getChildAt(_loc_2) is PrintAreaViewer)
                    {
                        getChildAt(_loc_2).visible = false;
                    }
                }
            }
            return;
        }// end function

        private function displayProductTypeAlert() : void
        {
            var _loc_2:ProductTypeAttribute;
            var _loc_1:String;
            if (this.productModel.productType.attributes.length > 0)
            {
                for each (_loc_2 in this.productModel.productType.attributes)
                {
                    
                    if (_loc_2.description)
                    {
                    }
                    if (_loc_2.description != "")
                    {
                        _loc_1 = _loc_2.description;
                        break;
                    }
                }
            }
            if (_loc_1)
            {
                Alert.show(_loc_1, resourceManager.getString("confomat7", "messages_system.PRODUCTTPYE_NOTICE_HEADLINE"));
            }
            return;
        }// end function

        private function createPrintAreas() : void
        {
            var _loc_4:IPrintArea;
            var _loc_1:* = numChildren;
            var _loc_2:* = _loc_1 - 1;
            while (_loc_2-- > 0)
            {
                
                if (getChildAt(_loc_2) is PrintAreaViewer)
                {
                    removeChildAt(_loc_2);
                }
            }
            this.viewScale = this.productModel.currentView.width / width;
            this._printAreas = new Dictionary();
            var _loc_3:* = this.productModel.getPrintAreasForView(this.productModel.currentView);
            for each (_loc_4 in _loc_3)
            {
                
                this._printAreas[_loc_4.id] = new PrintAreaViewer(_loc_4, this.viewScale, this.productModel.getPrintAreaOffset(_loc_4).x, this.productModel.getPrintAreaOffset(_loc_4).y);
                addChild(this._printAreas[_loc_4.id]);
                this._printAreas[_loc_4.id].visible = false;
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this._productChanged)
            {
                this._productChanged = false;
                this._productTypeAppearanceChanged = true;
                this._viewChanged = true;
            }
            if (this._productTypeChanged)
            {
                this._productTypeChanged = false;
                this._productTypeAppearanceChanged = true;
                this._viewChanged = true;
                this.displayProductTypeAlert();
            }
            if (this._viewChanged)
            {
                this._viewChanged = false;
                this.createPrintAreas();
                this.createConfigurationViewersOnViewChange();
            }
            if (this._autoCorrectionChanged)
            {
            }
            if (this.productModel)
            {
            }
            if (this.productModel.state == ModelState.INITIALIZED)
            {
                this._autoCorrectionChanged = false;
                this.updateAutoCorrection();
            }
            if (this._productTypeAppearanceChanged)
            {
                this._productTypeAppearanceChanged = false;
                this.updateIsOnBrightFabric();
            }
            if (this._isOnBrightFabricChanged)
            {
                this._isOnBrightFabricChanged = false;
                this.updateIsOnBrightFabric();
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = parent.height;
            measuredMinHeight = parent.height;
            measuredHeight = _loc_1;
            var _loc_1:* = parent.width;
            measuredMinWidth = parent.width;
            measuredWidth = _loc_1;
            setActualSize(measuredHeight, measuredWidth);
            return;
        }// end function

        public function get printAreas() : Dictionary
        {
            return this._printAreas;
        }// end function

        public function get autoPrefetchViews() : Boolean
        {
            if (!this.productTypeViewer)
            {
                return false;
            }
            return this.productTypeViewer.autoPrefetchViews;
        }// end function

        public function set autoPrefetchViews(param1:Boolean) : void
        {
            if (!this.productTypeViewer)
            {
                return;
            }
            this.productTypeViewer.autoPrefetchViews = param1;
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.productTypeViewer = new ProductTypeViewer();
            this.productTypeViewer.width = width;
            this.productTypeViewer.height = height;
            this.productTypeViewer.autoPrefetchViews = false;
            this.productTypeViewer.addEventListener(ApplicationEvent.COMPONENT_COMPLETE, this.productTypeViewer_completeHandler);
            this.productTypeViewer.visible = false;
            endEffectsStarted();
            addChild(this.productTypeViewer);
            return;
        }// end function

        public function bus_configurationAddedHandler(param1:ConfigurationEvent) : void
        {
            this.createConfigurationViewer(param1.configuration);
            return;
        }// end function

        public function bus_productInitializedHandler() : void
        {
            this._productChanged = true;
            invalidateProperties();
            this.checkComponentComplete();
            return;
        }// end function

        public function bus_productChangedHandler(param1:ProductEvent) : void
        {
            this._productChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function bus_viewChangedHandler(param1:Event) : void
        {
            this._viewChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function bus_appearanceChangedHandler(param1:ProductTypeEvent) : void
        {
            this._productTypeAppearanceChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function bus_productTypeChangedHandler() : void
        {
            this._productTypeChanged = true;
            invalidateProperties();
            return;
        }// end function

        private function productTypeViewer_completeHandler(param1:ApplicationEvent) : void
        {
            this._isProductTypeViewerComplete = true;
            this.checkComponentComplete();
            return;
        }// end function

        private function configurationViewer_completeHandler(param1:ApplicationEvent) : void
        {
            this.initializingViews.remove(param1.target);
            this.checkComponentComplete();
            return;
        }// end function

        private function configurationViewer_removedFromStageHandler(param1:Event) : void
        {
            ConfigurationViewer(param1.target).removeEventListener(Event.REMOVED_FROM_STAGE, this.configurationViewer_removedFromStageHandler);
            this.selectedConfiguration = null;
            return;
        }// end function

        private function stage_clickHandler(param1:MouseEvent) : void
        {
            stage.removeEventListener(MouseEvent.CLICK, this.stage_clickHandler);
            this.productModel.removeExampleConfigurations();
            return;
        }// end function

    }
}
