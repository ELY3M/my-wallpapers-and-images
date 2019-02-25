package net.sprd.models.product
{
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import flashx.textLayout.edit.*;
    import flashx.textLayout.formats.*;
    import net.sprd.api.*;
    import net.sprd.api.utils.*;
    import net.sprd.common.colors.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.entities.*;
    import net.sprd.entities.impl.*;
    import net.sprd.events.*;
    import net.sprd.models.basket.*;
    import net.sprd.models.common.*;
    import net.sprd.models.product.errors.*;
    import net.sprd.models.product.processors.*;
    import net.sprd.models.product.rules.*;
    import net.sprd.services.externalapi.*;
    import net.sprd.services.statistics.*;
    import net.sprd.valueObjects.*;
    import org.swizframework.events.*;

    public class ProductModel extends EventDispatcher implements IProductModel
    {
        private var _product:IProduct;
        private var _productType:IProductType;
        private var _currentAppearance:IProductTypeAppearance;
        private var _currentView:IProductTypeView;
        private var _currentSize:IProductTypeSize;
        private var _configurations:Array;
        private var _pendingConfigurations:Dictionary;
        private var _selectedConfiguration:IConfigurationModel;
        private var _printTypes:Array;
        public var bus:IEventDispatcher;
        private var _previousProductType:IProductType;
        private var _state:uint = 0;
        private var _configurationLoadingState:uint = 0;
        private var detectors:Dictionary;
        public var statistics:IStatistics;
        public var externalAPI:IExternalAPI;
        public var productModel:IProductModel;
        private var autoCorrection:Boolean = false;
        private static const log:ILogger = LogContext.getLogger(this);
        public static const FALLBACK_PRODUCT_TYPE_EU:String = "6";
        public static const FALLBACK_PRODUCT_TYPE_US:String = "109";

        public function ProductModel()
        {
            this._product = new Product();
            this._productType = new ProductType();
            this._configurations = [];
            this._printTypes = [];
            this.detectors = new Dictionary();
            this.setDefaults();
            return;
        }// end function

        private function setDefaults() : void
        {
            this.setProductTypeDefaults();
            this.setProductDefaults();
            return;
        }// end function

        private function setProductDefaults() : void
        {
            var _loc_1:IConfigurationModel;
            for each (_loc_1 in this._configurations)
            {
                
                this.bus.dispatchEvent(new BeanEvent(BeanEvent.TEAR_DOWN_BEAN, _loc_1));
            }
            this._configurationLoadingState = ModelState.CREATED;
            this._pendingConfigurations = null;
            this._selectedConfiguration = null;
            return;
        }// end function

        private function setProductTypeDefaults() : void
        {
            this._productType = new ProductType();
            this._previousProductType = null;
            this._printTypes = [];
            this._currentView = null;
            this._currentAppearance = null;
            this._currentSize = null;
            this.detectors = new Dictionary();
            return;
        }// end function

        public function initializeProduct(param1:String, param2:String = null, param3:String = null, param4:String = null, param5:IDesign = null, param6:Array = null, param7:Array = null, param8:String = null, param9:String = null, param10:String = null, param11:Function = null, param12:Function = null) : void
        {
            var productID:* = param1;
            var appearanceID:* = param2;
            var sizeID:* = param3;
            var viewID:* = param4;
            var design:* = param5;
            var designRGBColors:* = param6;
            var designPrintColorIds:* = param7;
            var text:* = param8;
            var textRGBColor:* = param9;
            var textPrintColorId:* = param10;
            var completeHandler:* = param11;
            var errorHandler:* = param12;
            if (this._state == ModelState.CREATED)
            {
                API.em.load(productID, APIRegistry.PRODUCT, function (param1:Event) : void
            {
                var _loc_2:* = IProduct(param1.target);
                if (viewID == null)
                {
                }
                if (_loc_2.defaultView)
                {
                    viewID = _loc_2.defaultView;
                }
                initializeProductInternal(_loc_2, appearanceID ? (appearanceID) : (_loc_2.productTypeAppearance), sizeID, viewID, design, designRGBColors, designPrintColorIds, text, textRGBColor, textPrintColorId, completeHandler, errorHandler, null, false, true);
                return;
            }// end function
            , errorHandler);
            }
            else if (this._state == ModelState.INITIALIZED)
            {
                this.evictCurrentProductEntities();
                API.em.load(productID, APIRegistry.PRODUCT, function (param1:Event) : void
            {
                var e1:* = param1;
                var product:* = IProduct(e1.target);
                initializeProductInternal(product, product.productTypeAppearance, sizeID, viewID, design, designRGBColors, designPrintColorIds, text, textRGBColor, textPrintColorId, completeHandler, errorHandler, function () : void
                {
                    setProductDefaults();
                    return;
                }// end function
                , true, true);
                return;
            }// end function
            , errorHandler);
            }
            return;
        }// end function

        public function initializeProductFromMemento(param1:IProduct, param2:String, param3:String, param4:String, param5:Function = null, param6:Function = null) : void
        {
            var product:* = param1;
            var appearanceID:* = param2;
            var sizeID:* = param3;
            var viewID:* = param4;
            var completeHandler:* = param5;
            var errorHandler:* = param6;
            if (this._state == ModelState.CREATED)
            {
                try
                {
                    if (product)
                    {
                    }
                    if (!this.fixMemento(product))
                    {
                        if (errorHandler)
                        {
                            log.warn("Cannot load product from memento.");
                            this.errorHandler();
                        }
                        return;
                    }
                    this.initializeProductInternal(product, appearanceID, sizeID, viewID, null, null, null, null, null, null, completeHandler, errorHandler, null, false);
                }
                catch (e:Error)
                {
                    bus.dispatchEvent(new ProductEvent(ProductEvent.ERROR, product));
                    if (errorHandler)
                    {
                        log.warn("Cannot load product from memento: " + e.toString());
                        this.errorHandler();
                    }
                }
            }
            else
            {
                throw new Error("Not implemented yet!");
            }
            return;
        }// end function

        public function initializeProductFromProductType(param1:String, param2:String = null, param3:String = null, param4:String = null, param5:IDesign = null, param6:Array = null, param7:Array = null, param8:String = null, param9:String = null, param10:String = null, param11:Function = null, param12:Function = null) : void
        {
            var productTypeId:* = param1;
            var appearanceId:* = param2;
            var sizeId:* = param3;
            var viewId:* = param4;
            var design:* = param5;
            var designRGBColors:* = param6;
            var designPrintColorIds:* = param7;
            var text:* = param8;
            var textRGBColor:* = param9;
            var textPrintColorId:* = param10;
            var completeHandler:* = param11;
            var errorHandler:* = param12;
            if (this._state == ModelState.CREATED)
            {
                this._product = new Product();
                this._product.productType = productTypeId;
                this.initializeProductInternal(this._product, appearanceId, sizeId, viewId, design, designRGBColors, designPrintColorIds, text, textRGBColor, textPrintColorId, completeHandler, errorHandler, null, false, true);
            }
            else if (this._state == ModelState.INITIALIZED)
            {
                this.evictCurrentProductEntities();
                this._product = new Product();
                this._product.productType = productTypeId;
                this.initializeProductInternal(this._product, appearanceId, sizeId, viewId, design, designRGBColors, designPrintColorIds, text, textRGBColor, textPrintColorId, completeHandler, errorHandler, function () : void
            {
                setProductDefaults();
                return;
            }// end function
            , false, true);
            }
            return;
        }// end function

        public function loadProduct(param1:IProduct, param2:Function = null, param3:Function = null) : void
        {
            var product:* = param1;
            var completeHandler:* = param2;
            var errorHandler:* = param3;
            if (!product)
            {
                return;
            }
            API.em.load(product.id, APIRegistry.PRODUCT, function (param1:Event) : void
            {
                var c:IConfiguration;
                var e1:* = param1;
                with ({})
                {
                    {}.complete = function (param1:Event = null) : void
                {
                    var e:* = param1;
                    with ({})
                    {
                        {}.complete = function (param1:Event = null) : void
                    {
                        var _loc_2:IConfigurationModel;
                        product.markModified(false);
                        for each (_loc_2 in configurations)
                        {
                            
                            _loc_2.net.sprd.models.product:IConfigurationModel::markModified(false);
                        }
                        if (completeHandler)
                        {
                            completeHandler(param1);
                        }
                        return;
                    }// end function
                    ;
                    }
                    initializeProductInternal(product, product.productTypeAppearance, null, product.defaultView, null, null, null, null, null, null, function (param1:Event = null) : void
                    {
                        var _loc_2:IConfigurationModel;
                        product.markModified(false);
                        for each (_loc_2 in configurations)
                        {
                            
                            _loc_2.net.sprd.models.product:IConfigurationModel::markModified(false);
                        }
                        if (completeHandler)
                        {
                            completeHandler(param1);
                        }
                        return;
                    }// end function
                    , errorHandler);
                    return;
                }// end function
                ;
                }
                API.em.startBatch(function (param1:Event = null) : void
                {
                    var e:* = param1;
                    with ({})
                    {
                        {}.complete = function (param1:Event = null) : void
                    {
                        var _loc_2:IConfigurationModel;
                        product.markModified(false);
                        for each (_loc_2 in configurations)
                        {
                            
                            _loc_2.net.sprd.models.product:IConfigurationModel::markModified(false);
                        }
                        if (completeHandler)
                        {
                            completeHandler(param1);
                        }
                        return;
                    }// end function
                    ;
                    }
                    initializeProductInternal(product, product.productTypeAppearance, null, product.defaultView, null, null, null, null, null, null, function (param1:Event = null) : void
                    {
                        var _loc_2:IConfigurationModel;
                        product.markModified(false);
                        for each (_loc_2 in configurations)
                        {
                            
                            _loc_2.net.sprd.models.product:IConfigurationModel::markModified(false);
                        }
                        if (completeHandler)
                        {
                            completeHandler(param1);
                        }
                        return;
                    }// end function
                    , errorHandler);
                    return;
                }// end function
                , errorHandler);
                var _loc_3:int;
                var _loc_4:* = product.configurations;
                while (_loc_4 in _loc_3)
                {
                    
                    c = _loc_4[_loc_3];
                    if (c.type == ConfigurationType.DESIGN)
                    {
                        API.em.load(c.designId, APIRegistry.DESIGN);
                    }
                }
                API.em.commitBatch();
                return;
            }// end function
            , errorHandler);
            return;
        }// end function

        private function initializeProductInternal(param1:IProduct, param2:String, param3:String, param4:String, param5:IDesign = null, param6:Array = null, param7:Array = null, param8:String = null, param9:String = null, param10:String = null, param11:Function = null, param12:Function = null, param13:Function = null, param14:Boolean = false, param15:Boolean = false) : void
        {
            var product:* = param1;
            var appearanceID:* = param2;
            var sizeID:* = param3;
            var viewID:* = param4;
            var design:* = param5;
            var designRGBColors:* = param6;
            var designPrintColorIds:* = param7;
            var text:* = param8;
            var textRGBColor:* = param9;
            var textPrintColorId:* = param10;
            var completeHandler:* = param11;
            var errorHandler:* = param12;
            var postInitializeHandler:* = param13;
            var reset:* = param14;
            var autoCorrection:* = param15;
            var that:IProductModel;
            this.loadProductType(product.productType, null, appearanceID, viewID, sizeID, function (param1:String) : void
            {
                var id:* = param1;
                try
                {
                    _product = product;
                    _product.markModified();
                    copyProductTypeSettingsToProduct();
                    _state = ModelState.INITIALIZED;
                    bus.dispatchEvent(new ProductEvent(ProductEvent.INITIALIZED, _product));
                    if (postInitializeHandler)
                    {
                        postInitializeHandler();
                    }
                    initializeConfigurations(design, designRGBColors, designPrintColorIds, text, textRGBColor, textPrintColorId, autoCorrection);
                    if (completeHandler)
                    {
                        completeHandler();
                    }
                }
                catch (e:Error)
                {
                    log.warn("Error loading product: " + e.getStackTrace());
                    if (errorHandler)
                    {
                        errorHandler();
                    }
                }
                return;
            }// end function
            , function (param1:String = null) : void
            {
                if (errorHandler)
                {
                    errorHandler();
                }
                return;
            }// end function
            , reset);
            return;
        }// end function

        private function evictCurrentProductEntities() : void
        {
            var _loc_1:IConfigurationModel;
            for each (_loc_1 in this._configurations)
            {
                
                if (_loc_1.configuration)
                {
                    API.em.evict(_loc_1.configuration);
                }
            }
            API.em.evict(this._product);
            return;
        }// end function

        private function fixMemento(param1:IProduct) : Boolean
        {
            param1.id = IdentityGenerator.createID();
            if (param1.name == null)
            {
                param1.name = "x";
            }
            if (param1.user == null)
            {
                param1.user = ConfomatConfiguration.userID;
            }
            return true;
        }// end function

        public function canChangeProductType(param1:IProductType) : ProductTypeUsageConstraints
        {
            return ProductConversionRules.canChangeProductType(this, param1);
        }// end function

        public function changeProductType(param1:String, param2:String = null, param3:String = null, param4:String = null, param5:Boolean = true, param6:Function = null, param7:Function = null) : void
        {
            var that:IProductModel;
            var id:* = param1;
            var appearanceId:* = param2;
            var viewId:* = param3;
            var sizeId:* = param4;
            var convertConfigurations:* = param5;
            var completeHandler:* = param6;
            var errorHandler:* = param7;
            if (id == this.productTypeID)
            {
                return;
            }
            if (this._state != ModelState.CREATED)
            {
                that;
                with ({})
                {
                    {}.productType_completeHandler = function (param1:String) : void
            {
                _state = ModelState.INITIALIZED;
                if (convertConfigurations)
                {
                    ProductConverter.convertConfigurationsToProductType(that);
                }
                bus.dispatchEvent(new ProductTypeEvent(ProductTypeEvent.CHANGED, _productType));
                if (completeHandler)
                {
                    completeHandler();
                }
                return;
            }// end function
            ;
                }
                with ({})
                {
                    {}.productType_errorHandler = function (param1:String) : void
            {
                if (errorHandler)
                {
                    errorHandler();
                }
                return;
            }// end function
            ;
                }
                this.loadProductType(id, this.defaultProductTypeId, appearanceId, viewId, sizeId, function (param1:String) : void
            {
                _state = ModelState.INITIALIZED;
                if (convertConfigurations)
                {
                    ProductConverter.convertConfigurationsToProductType(that);
                }
                bus.dispatchEvent(new ProductTypeEvent(ProductTypeEvent.CHANGED, _productType));
                if (completeHandler)
                {
                    completeHandler();
                }
                return;
            }// end function
            , function (param1:String) : void
            {
                if (errorHandler)
                {
                    errorHandler();
                }
                return;
            }// end function
            );
            }
            else
            {
                log.error("Product not initialized yet!");
                if (errorHandler)
                {
                    this.errorHandler();
                }
            }
            return;
        }// end function

        public function get state() : uint
        {
            return this._state;
        }// end function

        public function get currentProductID() : String
        {
            return this._product.id;
        }// end function

        public function get productTypeID() : String
        {
            if (this._productType == null)
            {
                return null;
            }
            return this._productType.id;
        }// end function

        public function get name() : String
        {
            return this._productType.net.sprd.entities:IProductType::name;
        }// end function

        public function get description() : String
        {
            return this._productType.description;
        }// end function

        public function get brand() : String
        {
            return this._productType.brand;
        }// end function

        public function get allowsFreeColorSelection() : Boolean
        {
            return this._product.allowsFreeColorSelection;
        }// end function

        public function set allowsFreeColorSelection(param1:Boolean) : void
        {
            this._product.allowsFreeColorSelection = param1;
            return;
        }// end function

        public function get isExample() : Boolean
        {
            return this._product.isExample;
        }// end function

        public function set isExample(param1:Boolean) : void
        {
            this._product.isExample = param1;
            return;
        }// end function

        public function canChangeAppearance(param1:IProductTypeAppearance) : ProductTypeUsageConstraints
        {
            return ProductConversionRules.canChangeProductTypeColor(this, param1);
        }// end function

        public function get currentAppearance() : IProductTypeAppearance
        {
            return this._currentAppearance;
        }// end function

        public function set currentAppearance(param1:IProductTypeAppearance) : void
        {
            var _loc_2:IProductTypeSize;
            if (this._productType.appearances.indexOf(param1) == -1)
            {
                this._currentAppearance = this._productType.defaultAppearance;
            }
            else
            {
                this._currentAppearance = param1;
            }
            ProductConverter.convertConfigurationsToNewAppearance(this);
            this.copyProductTypeSettingsToProduct();
            this.bus.dispatchEvent(new ProductTypeEvent(ProductTypeEvent.APPEARANCE_CHANGED, this._productType));
            if (this._currentSize)
            {
                _loc_2 = ProductTypeRules.findMatchingSize(this._currentSize.net.sprd.entities:IProductTypeSize::name, this.productType.sizes);
                this.currentSize = this.isOnStock(this._currentAppearance, _loc_2) ? (_loc_2) : (null);
            }
            return;
        }// end function

        public function isBrightAppearance() : Boolean
        {
            return ProductTypeRules.isBright(this.currentAppearance);
        }// end function

        public function get defaultAppearance() : IProductTypeAppearance
        {
            return this._productType.defaultAppearance;
        }// end function

        public function get defaultProductTypeId() : String
        {
            return ConfomatConfiguration.platform == ConfomatConfiguration.PLATFORM_NA ? (FALLBACK_PRODUCT_TYPE_US) : (FALLBACK_PRODUCT_TYPE_EU);
        }// end function

        public function get currentSize() : IProductTypeSize
        {
            return this._currentSize;
        }// end function

        public function set currentSize(param1:IProductTypeSize) : void
        {
            if (param1 == this._currentSize)
            {
                return;
            }
            if (param1 != null)
            {
            }
            if (this.productType.sizes.indexOf(param1) <= -1)
            {
                throw new Error("Size does not belong to product type.");
            }
            this._currentSize = param1;
            this.bus.dispatchEvent(new ProductTypeEvent(ProductTypeEvent.SIZE_CHANGED, this._productType, false, false));
            return;
        }// end function

        public function get currentView() : IProductTypeView
        {
            return this._currentView;
        }// end function

        public function set currentView(param1:IProductTypeView) : void
        {
            if (this._currentView == param1)
            {
                return;
            }
            if (this.selectedConfiguration)
            {
                this.selectConfiguration(null);
            }
            if (this.productType.views.indexOf(param1) <= -1)
            {
                this._currentView = this.productType.defaultView;
            }
            else
            {
                this._currentView = param1;
            }
            this.bus.dispatchEvent(new ProductTypeEvent(ProductTypeEvent.VIEW_CHANGED, this._productType, false, false));
            return;
        }// end function

        public function get previousProductType() : IProductType
        {
            return this._previousProductType;
        }// end function

        public function get productType() : IProductType
        {
            return this._productType;
        }// end function

        public function get product() : IProduct
        {
            return this._product;
        }// end function

        public function get appearances() : Array
        {
            return this._productType.appearances;
        }// end function

        public function get sizes() : Array
        {
            return this.productType.sizes;
        }// end function

        public function get views() : Array
        {
            return this.productType.views;
        }// end function

        public function get printTypes() : Array
        {
            return this._printTypes;
        }// end function

        public function getPossiblePrintTypesForDesign(param1:IDesign) : Array
        {
            var design:* = param1;
            return this.getCurrentPrintTypes().filter(function (param1:IPrintType, param2:int, param3:Array) : Boolean
            {
                return design.printTypes.indexOf(param1.id) != -1;
            }// end function
            );
        }// end function

        public function getCurrentPrintTypes() : Array
        {
            return PrintTypeRules.getPrintTypesForViewAndAppearance(this.currentView, this.currentAppearance);
        }// end function

        public function get preferredPrintType() : IPrintType
        {
            var _loc_1:* = this.getConfigurationsOnCurrentView();
            return _loc_1.length > 0 ? (_loc_1[0].printType) : (null);
        }// end function

        public function getPreferredPrintTypeForPrintColorSpace(param1:Boolean) : IPrintType
        {
            var _loc_3:IConfigurationModel;
            var _loc_2:* = this.getConfigurationsOnCurrentView();
            if (_loc_2.length > 0)
            {
                for each (_loc_3 in _loc_2)
                {
                    
                    if (param1)
                    {
                    }
                    if (_loc_3.printType.colorSpace == ColorSpace.PRINTCOLORS)
                    {
                        return _loc_3.printType;
                    }
                    if (!param1)
                    {
                    }
                    if (_loc_3.printType.colorSpace != ColorSpace.PRINTCOLORS)
                    {
                        return _loc_3.printType;
                    }
                }
            }
            return null;
        }// end function

        public function isOnStock(param1:IProductTypeAppearance, param2:IProductTypeSize = null) : Boolean
        {
            if (!param2)
            {
                return this.isAppearanceOnStock(param1);
            }
            return ProductTypeRules.isOnStock(this._productType, param2, param1);
        }// end function

        public function isAppearanceOnStock(param1:IProductTypeAppearance) : Boolean
        {
            return ProductTypeRules.isAppearanceOnStock(this._productType, param1, this.sizes);
        }// end function

        public function getPrintAreasForView(param1:IProductTypeView) : Array
        {
            return ProductTypeRules.getPrintAreasForView(param1);
        }// end function

        public function getPrintAreaOffset(param1:IPrintArea) : Point
        {
            return this.currentView.getPrintAreaOffset(param1.id);
        }// end function

        public function get configurations() : Array
        {
            if (this._configurationLoadingState != ModelState.INITIALIZED)
            {
                return [];
            }
            return this._configurations;
        }// end function

        public function get selectedConfiguration() : IConfigurationModel
        {
            return this._selectedConfiguration;
        }// end function

        public function selectConfiguration(param1:IConfigurationModel, param2:Boolean = false) : void
        {
            var _loc_3:int;
            if (!param2)
            {
            }
            if (this.selectedConfiguration == param1)
            {
                return;
            }
            if (param1)
            {
            }
            if (!param1.isChangeable)
            {
                return;
            }
            this._selectedConfiguration = param1;
            if (param1)
            {
                _loc_3 = this._configurations.indexOf(param1);
                if (_loc_3 == -1)
                {
                    log.warn("Selected configuration which is not in the model: " + param1.configurationID);
                }
                else if (_loc_3 != this._configurations.length - 1)
                {
                    this._configurations.splice(_loc_3, 1);
                    this._configurations.push(param1);
                    this._product.configurations.splice(_loc_3, 1);
                    this._product.configurations.push(param1.configuration);
                    this.bus.dispatchEvent(new ProductEvent(ProductEvent.Z_ORDER_CHANGED, this.product));
                }
            }
            this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.SELECTION_CHANGED, param1));
            return;
        }// end function

        public function isConfigurationSelected(param1:IConfigurationModel) : Boolean
        {
            return this._selectedConfiguration == param1;
        }// end function

        public function addTextConfiguration(param1:String, param2:Number, param3:Number, param4:String, param5:IFontStyle, param6:Boolean, param7:Boolean = false, param8:Function = null, param9:Function = null) : void
        {
            var configuration:IConfigurationModel;
            var text:* = param1;
            var size:* = param2;
            var rgbColor:* = param3;
            var printColorId:* = param4;
            var font:* = param5;
            var adjustOffset:* = param6;
            var defaultConfiguration:* = param7;
            var completeHandler:* = param8;
            var errorHandler:* = param9;
            try
            {
                configuration = this.createTextConfigurationInternal(text, size, rgbColor, printColorId, font, adjustOffset, defaultConfiguration);
                if (configuration)
                {
                    this.addConfigurationInternal(configuration);
                    if (completeHandler)
                    {
                        this.completeHandler(configuration);
                    }
                }
                else
                {
                    this.errorHandler();
                }
            }
            catch (e:Error)
            {
                if (errorHandler)
                {
                    this.errorHandler();
                }
            }
            return;
        }// end function

        public function canAddDesign(param1:IDesign) : ConfigurationUsageConstraints
        {
            return ProductCreator.constraintsForDesignConfiguration(this, param1);
        }// end function

        public function addDesignConfiguration(param1:IDesign, param2:Array, param3:Array, param4:String, param5:Boolean, param6:Boolean = true, param7:Function = null, param8:Function = null) : void
        {
            var configuration:IConfigurationModel;
            var design:* = param1;
            var rgbColors:* = param2;
            var printColorIds:* = param3;
            var preferredPrintTypeId:* = param4;
            var adjustOffset:* = param5;
            var addToCache:* = param6;
            var completeHandler:* = param7;
            var errorHandler:* = param8;
            try
            {
                configuration = this.createDesignConfigurationInternal(design, rgbColors, printColorIds, preferredPrintTypeId, adjustOffset, addToCache);
                if (configuration)
                {
                    this.addConfigurationInternal(configuration);
                    if (completeHandler)
                    {
                        this.completeHandler(configuration);
                    }
                }
                else if (errorHandler)
                {
                    this.errorHandler();
                }
            }
            catch (e:Error)
            {
                log.warn("Could not add configuration for design " + design.id + ".: " + e.message + "\n" + e.getStackTrace());
                if (errorHandler)
                {
                    this.errorHandler();
                }
            }
            return;
        }// end function

        private function createDesignConfigurationInternal(param1:IDesign, param2:Array, param3:Array, param4:String, param5:Boolean, param6:Boolean = true, param7:Boolean = false) : IConfigurationModel
        {
            var constraints:ConfigurationUsageConstraints;
            var result:IConfigurationModel;
            var defaultSize:Rectangle;
            var offset:Point;
            var printType:IPrintType;
            var design:* = param1;
            var rgbColors:* = param2;
            var printColorIds:* = param3;
            var preferredPrintTypeId:* = param4;
            var adjustOffset:* = param5;
            var addToCache:* = param6;
            var autoCorrection:* = param7;
            try
            {
                constraints = ProductCreator.constraintsForDesignConfiguration(this, design);
                if (!constraints.isUsable)
                {
                    return null;
                }
                if (!constraints.printArea)
                {
                    throw new PrintAreaNotAvailableError();
                }
                result = new ConfigurationModel();
                this.createConfigurationBean(result);
                result.type = ConfigurationType.DESIGN;
                result.autoCorrection = autoCorrection;
                result.designId = design.id;
                if (printColorIds)
                {
                }
                if (printColorIds.length > 0)
                {
                }
                if (printColorIds[0] != null)
                {
                    result.printType = PrintTypeRules.getPrintTypeForPrintColor(this, printColorIds[0]);
                    if (!result.printType)
                    {
                        result.printType = constraints.printType;
                    }
                }
                else if (preferredPrintTypeId == null)
                {
                    result.printType = constraints.printType;
                }
                else
                {
                    printType = IPrintType(API.em.get(preferredPrintTypeId, APIRegistry.PRINT_TYPE));
                    if (constraints.possiblePrintTypes.indexOf(printType) > -1)
                    {
                        result.printType = printType;
                    }
                    else
                    {
                        result.printType = constraints.printType;
                    }
                }
                result.printArea = constraints.printArea;
                defaultSize = ProductDefaultRules.getDefaultDesignSize(design, result.printArea, result.printType);
                offset = adjustOffset ? (ProductDefaultRules.getDefaultConfigurationPositionWithoutConflicts(defaultSize.width, defaultSize.height, result.type, this, result.printArea)) : (ProductDefaultRules.getDefaultConfigurationPosition(defaultSize.width, defaultSize.height, result.type, result.printArea));
                result.initializeFromSVG(ProductCreator.createDesignSVG(result.printType, PrintTypeRules.getPrintColors(PrintTypeRules.adjustRGBColors(design.colors, rgbColors, printColorIds), result.printType), design), offset, defaultSize.width, defaultSize.height, this, addToCache);
                return result;
            }
            catch (e:Error)
            {
                log.error("Create design config error: " + e.errorID + ":" + e.getStackTrace());
            }
            return null;
        }// end function

        private function createTextConfigurationInternal(param1:String, param2:Number, param3:Number, param4:String, param5:IFontStyle, param6:Boolean, param7:Boolean = false, param8:Boolean = false) : IConfigurationModel
        {
            var printArea:IPrintArea;
            var config:ConfigurationModel;
            var defaultBox:SVGRect;
            var offset:Point;
            var format:TextLayoutFormat;
            var text:* = param1;
            var size:* = param2;
            var rgbColor:* = param3;
            var printColorId:* = param4;
            var font:* = param5;
            var adjustOffset:* = param6;
            var defaultConfiguration:* = param7;
            var autoCorrection:* = param8;
            try
            {
                if (!font)
                {
                    font = ProductDefaultRules.getDefaultFontStyle();
                    if (!font)
                    {
                        throw new FontNotAvailableError();
                    }
                }
                if (!size)
                {
                    size = ProductDefaultRules.getDefaultFontSize(font, this.productType.id);
                }
                size = Math.max(font.minSize, size);
                if (printColorId)
                {
                    rgbColor = PrintTypeRules.getRGBColorForPrintColorId(printColorId);
                }
                if (!rgbColor)
                {
                    rgbColor = ProductDefaultRules.getDefaultRGBColor(this.isBrightAppearance());
                }
                printArea = this.getPrintAreasForView(this.currentView)[0];
                if (!printArea)
                {
                    throw new PrintAreaNotAvailableError();
                }
                config = new ConfigurationModel();
                this.createConfigurationBean(config);
                config.type = ConfigurationType.TEXT;
                config.isDefaultConfiguration = defaultConfiguration;
                config.autoCorrection = autoCorrection;
                config.printType = PrintTypeRules.findMatchingPrintType(this.preferredPrintType, this.getCurrentPrintTypes());
                config.printArea = printArea;
                defaultBox = printArea.defaultPositioningBox;
                offset = adjustOffset ? (ProductDefaultRules.getDefaultConfigurationPositionWithoutConflicts(defaultBox.width, defaultBox.height, config.type, this, printArea)) : (ProductDefaultRules.getDefaultConfigurationPosition(defaultBox.width, defaultBox.height, config.type, printArea));
                config.initializeFromSVG(ProductCreator.createDefaultSVGText(text, printArea.defaultPositioningHorizontalAlignment, size, rgbColor, font), offset, defaultBox.width, defaultBox.height, this);
                format = new TextLayoutFormat();
                format.color = ProductDefaultRules.getDefaultConfigurationColors(config, this)[0];
                EditManager(config.textFlow.interactionManager).applyLeafFormat(format);
                return config;
            }
            catch (e:Error)
            {
                log.error("Create text config error: " + e.errorID + ":" + e.getStackTrace());
            }
            return null;
        }// end function

        private function addConfigurationInternal(param1:IConfigurationModel) : void
        {
            if (this._configurationLoadingState != ModelState.INITIALIZED)
            {
                return;
            }
            if (!this.currentPrintArea.allowsDesign)
            {
            }
            if (param1.type != ConfigurationType.DESIGN)
            {
                if (!this.currentPrintArea.allowsText)
                {
                }
            }
            if (param1.type == ConfigurationType.TEXT)
            {
                log.warn("Configuration with type \'" + param1.type + "\' is not allowed on this printare");
                return;
            }
            this._configurations.push(param1);
            this._product.configurations.push(param1.configuration);
            this._product.markModified(true);
            this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.ADDED, param1));
            this.selectConfiguration(param1);
            return;
        }// end function

        public function addConfiguration(param1:IConfiguration) : void
        {
            var _loc_2:* = new ConfigurationModel(param1.id);
            this.createConfigurationBean(_loc_2);
            _loc_2.initializeFromDeserializedConfiguration(param1, this);
            _loc_2.autoCorrection = this.autoCorrection;
            this._configurations.push(_loc_2);
            this._product.configurations.push(param1);
            this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.ADDED, _loc_2));
            this.selectConfiguration(_loc_2);
            return;
        }// end function

        public function removeConfiguration(param1:IConfigurationModel) : int
        {
            if (this._configurationLoadingState != ModelState.INITIALIZED)
            {
                return -1;
            }
            return this.removeConfigurationInternalWithEvent(param1);
        }// end function

        public function removeExampleConfigurations() : void
        {
            var _loc_1:IConfigurationModel;
            if (this._configurationLoadingState != ModelState.INITIALIZED)
            {
                return;
            }
            if (this.isExample)
            {
                for each (_loc_1 in this.configurations)
                {
                    
                    if (_loc_1.textOfferedForDeletion)
                    {
                        this.removeConfigurationInternalWithEvent(_loc_1);
                    }
                }
                this.isExample = false;
            }
            return;
        }// end function

        private function removeConfigurationInternalWithEvent(param1:IConfigurationModel) : int
        {
            var _loc_2:* = this._configurations.indexOf(param1);
            if (_loc_2 == -1)
            {
                return -1;
            }
            if (this.selectedConfiguration == param1)
            {
                this.selectConfiguration(null);
            }
            this.removeConfigurationInternal(_loc_2);
            this.bus.dispatchEvent(new BeanEvent(BeanEvent.TEAR_DOWN_BEAN, param1));
            this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.REMOVED, param1));
            return _loc_2;
        }// end function

        private function removeConfigurationInternal(param1:int) : void
        {
            this._configurations.splice(param1, 1);
            this._product.configurations.splice(param1, 1);
            this._product.markModified(true);
            return;
        }// end function

        public function getConfigurationsForView(param1:IProductTypeView) : Array
        {
            var _loc_3:IPrintArea;
            var _loc_2:Array;
            for each (_loc_3 in ProductTypeRules.getPrintAreasForView(param1))
            {
                
                _loc_2 = _loc_2.concat(this.getConfigurationsForPrintArea(_loc_3.id));
            }
            return _loc_2;
        }// end function

        public function getConfigurationsForPrintArea(param1:String) : Array
        {
            var id:* = param1;
            return this.configurations.filter(function (param1:IConfigurationModel, param2:int, param3:Array) : Boolean
            {
                if (param1.printArea)
                {
                }
                return param1.printArea.id == id;
            }// end function
            );
        }// end function

        public function getConfigurationsOnCurrentView() : Array
        {
            var _loc_1:* = this.currentPrintArea;
            return _loc_1 ? (this.getConfigurationsForPrintArea(_loc_1.id)) : ([]);
        }// end function

        public function get currentPrintArea() : IPrintArea
        {
            return this.currentView ? (this.getPrintAreasForView(this.currentView)[0]) : (null);
        }// end function

        public function getConstraintViolationDetector(param1:IPrintArea) : IConstraintViolationDetector
        {
            var _loc_2:* = this.detectors[param1];
            if (_loc_2 == null)
            {
                _loc_2 = new DefaultConstraintViolationDetector(this, param1);
                this.detectors[param1] = _loc_2;
            }
            return _loc_2;
        }// end function

        public function hasError() : String
        {
            var _loc_1:IConfigurationModel;
            var _loc_2:ConstraintViolationInfo;
            var _loc_3:String;
            for each (_loc_1 in this.configurations)
            {
                
                _loc_2 = _loc_1.getCurrentConstraintViolationInfo();
                if (_loc_2.invalid)
                {
                    _loc_3 = TrackingErrorCodes.PRODUCT_CREATION;
                    if (_loc_2.maxBoundViolation)
                    {
                        _loc_3 = TrackingErrorCodes.MAX_BOUND;
                    }
                    else if (_loc_2.minBoundViolation)
                    {
                        _loc_3 = TrackingErrorCodes.MIN_BOUND;
                    }
                    else if (_loc_2.boundaryCollision)
                    {
                        _loc_3 = TrackingErrorCodes.HARD_BOUNDARY;
                    }
                    else
                    {
                        if (true)
                        {
                        }
                        if (_loc_2.configurationCollisions.net.sprd.common.collections:IWithSize::size > 0)
                        {
                            _loc_3 = TrackingErrorCodes.CONFIGURATION_OVERLAP;
                        }
                    }
                    return _loc_3;
                }
            }
            return null;
        }// end function

        public function saveIfModified(param1:Function = null, param2:Function = null) : void
        {
            var config:IConfigurationModel;
            var modifiedConfigurations:Array;
            var oldId:String;
            var c:IConfigurationModel;
            var configuration:IConfigurationModel;
            var d:ConstraintViolationInfo;
            var errorCode:String;
            var completeHandler:* = param1;
            var faultHandler:* = param2;
            var _loc_4:int;
            var _loc_5:* = this.configurations;
            while (_loc_5 in _loc_4)
            {
                
                config = _loc_5[_loc_4];
                if (config.canBeRemoved)
                {
                    this.removeConfiguration(config);
                }
            }
            modifiedConfigurations = this.configurations.filter(function (param1:IConfigurationModel, param2:int, param3:Array) : Boolean
            {
                return param1.modified;
            }// end function
            );
            if (this.currentAppearance)
            {
            }
            if (this._product.productTypeAppearance != this.currentAppearance.id)
            {
                this._product.productTypeAppearance = this.currentAppearance.id;
                this._product.markModified(true);
            }
            if (!this._product.modified)
            {
            }
            if (modifiedConfigurations.length == 0)
            {
                EventUtil.registerOnetimeListeners(this._product, [Event.COMPLETE], [completeHandler]);
                this._product.dispatchEvent(new Event(Event.COMPLETE));
                if (ConfomatConfiguration.mode == ConfomatModes.ADMIN)
                {
                    this.externalAPI.onProductUpdated(this._product.id, this._product.id, this.currentAppearance.id, this.currentSize ? (this.currentSize.id) : (null));
                }
            }
            else
            {
                if (ConfomatConfiguration.mode != ConfomatModes.ADMIN)
                {
                    var _loc_4:int;
                    var _loc_5:* = this.configurations;
                    while (_loc_5 in _loc_4)
                    {
                        
                        configuration = _loc_5[_loc_4];
                        d = configuration.getCurrentConstraintViolationInfo();
                        if (d.invalid)
                        {
                            errorCode = TrackingErrorCodes.PRODUCT_CREATION;
                            if (d.maxBoundViolation)
                            {
                                errorCode = TrackingErrorCodes.MAX_BOUND;
                            }
                            else if (d.minBoundViolation)
                            {
                                errorCode = TrackingErrorCodes.MIN_BOUND;
                            }
                            else if (d.boundaryCollision)
                            {
                                errorCode = TrackingErrorCodes.HARD_BOUNDARY;
                            }
                            else
                            {
                                if (true)
                                {
                                }
                                if (d.configurationCollisions.net.sprd.common.collections:IWithSize::size > 0)
                                {
                                    errorCode = TrackingErrorCodes.CONFIGURATION_OVERLAP;
                                }
                            }
                            EventUtil.registerOnetimeListeners(this._product, [IOErrorEvent.IO_ERROR], [faultHandler]);
                            this._product.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR, false, false, errorCode));
                            return;
                        }
                    }
                }
                oldId = this._product.id;
                this._product.name = this._productType.name;
                var _loc_4:int;
                var _loc_5:* = modifiedConfigurations;
                while (_loc_5 in _loc_4)
                {
                    
                    c = _loc_5[_loc_4];
                    c.updateSVGContent();
                }
                this._product.isExample = false;
                this._product.token = ExternalAPI.getToken();
                this._product.defaultView = this.currentView.id;
                this.bus.dispatchEvent(new ProductEvent(ProductEvent.SAVE_STARTED, this._product));
                with ({})
                {
                    {}.fault = function (param1:Event) : void
            {
                bus.dispatchEvent(new ProductEvent(ProductEvent.SAVE_FAULT, _product));
                if (faultHandler)
                {
                    faultHandler(param1);
                }
                return;
            }// end function
            ;
                }
                API.em.save(this._product, function (param1:Event) : void
            {
                var _loc_2:IConfigurationModel;
                bus.dispatchEvent(new ProductEvent(ProductEvent.SAVE_COMPLETED, _product));
                if (completeHandler)
                {
                    completeHandler(param1);
                }
                for each (_loc_2 in modifiedConfigurations)
                {
                    
                    _loc_2.configuration.markModified(false);
                }
                externalAPI.onProductUpdated(oldId, _product.id, currentAppearance.id, currentSize ? (currentSize.id) : (null));
                return;
            }// end function
            , function (param1:Event) : void
            {
                bus.dispatchEvent(new ProductEvent(ProductEvent.SAVE_FAULT, _product));
                if (faultHandler)
                {
                    faultHandler(param1);
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        public function get modified() : Boolean
        {
            var modifiedConfigurations:* = this.configurations.filter(function (param1:IConfigurationModel, param2:int, param3:Array) : Boolean
            {
                if (param1.modified)
                {
                }
                return !param1.canBeRemoved;
            }// end function
            );
            if (true)
            {
            }
            if (modifiedConfigurations.length <= 0)
            {
                if (this.currentAppearance)
                {
                }
            }
            return this._product.productTypeAppearance != this.currentAppearance.id;
        }// end function

        public function get basePrice() : Money
        {
            return this._productType.price;
        }// end function

        public function get price() : Money
        {
            var _loc_4:IConfigurationModel;
            var _loc_1:* = this.basePrice;
            if (!_loc_1)
            {
                return _loc_1;
            }
            if (this.productTypeID == "42")
            {
                return _loc_1;
            }
            var _loc_2:* = _loc_1.amount;
            var _loc_3:int;
            while (_loc_3++ < this.configurations.length)
            {
                
                _loc_4 = this.configurations[_loc_3];
                _loc_2 = _loc_2 + _loc_4.price.amount;
            }
            return new Money(_loc_2, _loc_1.currencyID);
        }// end function

        private function loadProductType(param1:String, param2:String, param3:String, param4:String, param5:String, param6:Function, param7:Function, param8:Boolean = false) : void
        {
            var productTypeLoadComplete:Function;
            var id:* = param1;
            var fallbackId:* = param2;
            var appearanceId:* = param3;
            var viewId:* = param4;
            var sizeId:* = param5;
            var completeHandler:* = param6;
            var errorHandler:* = param7;
            var reset:* = param8;
            if (id == null)
            {
                this.errorHandler();
                return;
            }
            productTypeLoadComplete = function (param1:Event) : void
            {
                var e1:* = param1;
                var query:* = Query.findAll(APIRegistry.PRINT_TYPE, 0, 1000);
                var fetchPlan:* = APIRegistry.getFetchPlan(APIRegistry.PRINT_TYPE);
                fetchPlan.partial = false;
                API.em.find(query, function (param1:Event) : void
                {
                    updateProductType(IProductType(e1.target).id, appearanceId, viewId, sizeId, reset);
                    completeHandler(IBaseEntity(e1.target).id);
                    return;
                }// end function
                , function (param1:Event) : void
                {
                    errorHandler(IBaseEntity(e1.target).id);
                    return;
                }// end function
                , fetchPlan);
                return;
            }// end function
            ;
            var productTypeLoadFault:* = function (param1:Event) : void
            {
                var e:* = param1;
                if (fallbackId)
                {
                    API.em.load(fallbackId, APIRegistry.PRODUCT_TYPE, productTypeLoadComplete, function (param1:Event) : void
                {
                    errorHandler(fallbackId);
                    return;
                }// end function
                );
                }
                else
                {
                    errorHandler(id);
                }
                return;
            }// end function
            ;
            API.em.load(id, APIRegistry.PRODUCT_TYPE, productTypeLoadComplete, productTypeLoadFault);
            return;
        }// end function

        private function updateProductType(param1:String, param2:String, param3:String, param4:String, param5:Boolean) : void
        {
            var _loc_7:IProductTypeAppearance;
            if (param5)
            {
                this.setProductTypeDefaults();
            }
            this._previousProductType = this._productType;
            this._productType = IProductType(API.em.get(param1, APIRegistry.PRODUCT_TYPE));
            this.updatePrintTypes();
            var _loc_6:* = this._productType.getAppearanceById(param2);
            if (_loc_6)
            {
                this._currentAppearance = _loc_6;
            }
            else if (this._currentAppearance)
            {
                this._currentAppearance = ProductTypeRules.findMatchingAppearance(this._currentAppearance, this._productType.appearances);
            }
            if (!this._currentAppearance)
            {
                this._currentAppearance = this._productType.defaultAppearance;
            }
            if (!this.isAppearanceOnStock(this._currentAppearance))
            {
            }
            if (ConfomatConfiguration.mode != ConfomatModes.ADMIN)
            {
                _loc_7 = ProductTypeRules.findFirstAppearanceOnStock(this._productType, this.appearances, this.sizes);
                if (_loc_7 != null)
                {
                    this._currentAppearance = _loc_7;
                }
            }
            if (param4)
            {
            }
            if (this.productType.getSizeById(param4))
            {
                this._currentSize = this.productType.getSizeById(param4);
            }
            else if (this._currentSize)
            {
                this._currentSize = ProductTypeRules.findMatchingSize(this._currentSize.net.sprd.entities:IProductTypeSize::name, this.sizes);
            }
            if (this._productType.sizes.length == 1)
            {
                this._currentSize = this._productType.sizes[0];
            }
            if (!this.isOnStock(this._currentAppearance, this._currentSize))
            {
                this._currentSize = null;
            }
            if (param3)
            {
                this._currentView = this.productType.getViewById(param3);
            }
            else if (this._currentView)
            {
                this._currentView = ProductTypeRules.findMatchingView(this._currentView, this.views);
            }
            if (!this._currentView)
            {
                this._currentView = this.productType.defaultView;
            }
            this.copyProductTypeSettingsToProduct();
            return;
        }// end function

        private function updatePrintTypes() : void
        {
            var color:IProductTypeAppearance;
            var printTypeID:String;
            this._printTypes = [];
            var printTypes:Array;
            var _loc_2:int;
            var _loc_3:* = this.appearances;
            while (_loc_3 in _loc_2)
            {
                
                color = _loc_3[_loc_2];
                printTypes = printTypes.concat(color.net.sprd.entities:IProductTypeAppearance::printTypes);
            }
            printTypes.forEach(function (param1, param2:Number, param3:Array) : void
            {
                if (!param1)
                {
                    return;
                }
                var _loc_4:* = param2 + 1;
                while (_loc_4++ < param3.length)
                {
                    
                    while (param3[_loc_4] == param1)
                    {
                        
                        param3.splice(_loc_4, 1);
                    }
                }
                return;
            }// end function
            );
            var _loc_2:int;
            var _loc_3:* = printTypes;
            while (_loc_3 in _loc_2)
            {
                
                printTypeID = _loc_3[_loc_2];
                this._printTypes.push(IPrintType(API.em.load(printTypeID, APIRegistry.PRINT_TYPE)));
            }
            return;
        }// end function

        private function copyProductTypeSettingsToProduct() : void
        {
            this._product.productType = this._productType.id;
            if (this._currentAppearance)
            {
                this._product.productTypeAppearance = this._currentAppearance.id;
            }
            return;
        }// end function

        private function initializeConfigurations(param1:IDesign = null, param2:Array = null, param3:Array = null, param4:String = null, param5:String = null, param6:String = null, param7:Boolean = false) : void
        {
            var _loc_10:IConfiguration;
            var _loc_11:IConfigurationModel;
            this._configurations = [];
            this._pendingConfigurations = new Dictionary();
            var _loc_8:IConfigurationModel;
            var _loc_9:IConfigurationModel;
            if (param1)
            {
                _loc_8 = this.createDesignConfigurationInternal(param1, param2, param3, null, true, true, param7);
            }
            if (param4)
            {
                _loc_9 = this.createTextConfigurationInternal(param4, null, ColorUtil.getIntegerColor(param5), param6, null, true, false, param7);
            }
            for each (_loc_10 in this._product.configurations)
            {
                
                _loc_11 = new ConfigurationModel(_loc_10.id);
                this.createConfigurationBean(_loc_11);
                _loc_11.autoCorrection = param7;
                this._configurations.push(_loc_11);
                this._pendingConfigurations[_loc_11] = 1;
            }
            if (_loc_8)
            {
                this._configurations.push(_loc_8);
                this._product.configurations.push(_loc_8.configuration);
                this._pendingConfigurations[_loc_8] = 1;
            }
            if (_loc_9)
            {
                this._configurations.push(_loc_9);
                this._product.configurations.push(_loc_9.configuration);
                this._pendingConfigurations[_loc_9] = 1;
            }
            for each (_loc_11 in this._configurations)
            {
                
                _loc_11.initializeFromDeserializedConfiguration(this._product.getConfigurationById(_loc_11.configurationID), this);
            }
            this.checkPendingConfigurations();
            return;
        }// end function

        public function bus_configurationInitialized(param1:ConfigurationEvent) : void
        {
            if (this._configurationLoadingState != ModelState.INITIALIZED)
            {
                if (this._configurations.indexOf(param1.configuration) != -1)
                {
                    delete this._pendingConfigurations[param1.configuration];
                    this.checkPendingConfigurations();
                }
            }
            return;
        }// end function

        private function checkPendingConfigurations() : void
        {
            var _loc_1:int;
            if (!this.hasPendingConfigurations())
            {
                _loc_1 = this._configurations.length - 1;
                while (_loc_1-- >= 0)
                {
                    
                    if (IConfigurationModel(this._configurations[_loc_1]).state == ModelState.ERROR)
                    {
                        this.removeConfigurationInternal(_loc_1);
                    }
                }
                this._configurationLoadingState = ModelState.INITIALIZED;
                ProductConverter.convertConfigurationsToNewAppearance(this);
                this.copyProductTypeSettingsToProduct();
                this.bus.dispatchEvent(new ProductEvent(ProductEvent.CONFIGURATIONS_INITIALIZED, this._product));
                if (!this.isExample)
                {
                    this.selectConfiguration(this.configurations[this.configurations.length - 1], true);
                }
            }
            return;
        }// end function

        private function hasPendingConfigurations() : Boolean
        {
            var _loc_1:*;
            for each (_loc_1 in this._pendingConfigurations)
            {
                
                return true;
            }
            return false;
        }// end function

        private function createConfigurationBean(param1:IConfigurationModel) : void
        {
            this.bus.dispatchEvent(new BeanEvent(BeanEvent.SET_UP_BEAN, param1));
            return;
        }// end function

    }
}
