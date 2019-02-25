package net.sprd.models.product
{
    import flash.geom.*;
    import net.sprd.entities.*;
    import net.sprd.valueObjects.*;

    public interface IProductModel extends IEventDispatcher
    {

        public function IProductModel();

        function get state() : uint;

        function initializeProduct(param1:String, param2:String = null, param3:String = null, param4:String = null, param5:IDesign = null, param6:Array = null, param7:Array = null, param8:String = null, param9:String = null, param10:String = null, param11:Function = null, param12:Function = null) : void;

        function initializeProductFromProductType(param1:String, param2:String = null, param3:String = null, param4:String = null, param5:IDesign = null, param6:Array = null, param7:Array = null, param8:String = null, param9:String = null, param10:String = null, param11:Function = null, param12:Function = null) : void;

        function initializeProductFromMemento(param1:IProduct, param2:String, param3:String, param4:String, param5:Function = null, param6:Function = null) : void;

        function canChangeProductType(param1:IProductType) : ProductTypeUsageConstraints;

        function changeProductType(param1:String, param2:String = null, param3:String = null, param4:String = null, param5:Boolean = true, param6:Function = null, param7:Function = null) : void;

        function get currentProductID() : String;

        function get productTypeID() : String;

        function get defaultAppearance() : IProductTypeAppearance;

        function get defaultProductTypeId() : String;

        function get previousProductType() : IProductType;

        function get productType() : IProductType;

        function get product() : IProduct;

        function get configurations() : Array;

        function addTextConfiguration(param1:String, param2:Number, param3:Number, param4:String, param5:IFontStyle, param6:Boolean, param7:Boolean = false, param8:Function = null, param9:Function = null) : void;

        function canAddDesign(param1:IDesign) : ConfigurationUsageConstraints;

        function addDesignConfiguration(param1:IDesign, param2:Array, param3:Array, param4:String, param5:Boolean, param6:Boolean = true, param7:Function = null, param8:Function = null) : void;

        function removeConfiguration(param1:IConfigurationModel) : int;

        function removeExampleConfigurations() : void;

        function getConfigurationsForView(param1:IProductTypeView) : Array;

        function getConfigurationsForPrintArea(param1:String) : Array;

        function getConfigurationsOnCurrentView() : Array;

        function getConstraintViolationDetector(param1:IPrintArea) : IConstraintViolationDetector;

        function saveIfModified(param1:Function = null, param2:Function = null) : void;

        function get modified() : Boolean;

        function get basePrice() : Money;

        function get price() : Money;

        function selectConfiguration(param1:IConfigurationModel, param2:Boolean = false) : void;

        function get selectedConfiguration() : IConfigurationModel;

        function isConfigurationSelected(param1:IConfigurationModel) : Boolean;

        function get name() : String;

        function get description() : String;

        function get brand() : String;

        function isOnStock(param1:IProductTypeAppearance, param2:IProductTypeSize = null) : Boolean;

        function isAppearanceOnStock(param1:IProductTypeAppearance) : Boolean;

        function get preferredPrintType() : IPrintType;

        function getPreferredPrintTypeForPrintColorSpace(param1:Boolean) : IPrintType;

        function getPossiblePrintTypesForDesign(param1:IDesign) : Array;

        function getCurrentPrintTypes() : Array;

        function get isExample() : Boolean;

        function get appearances() : Array;

        function canChangeAppearance(param1:IProductTypeAppearance) : ProductTypeUsageConstraints;

        function get currentAppearance() : IProductTypeAppearance;

        function set currentAppearance(param1:IProductTypeAppearance) : void;

        function isBrightAppearance() : Boolean;

        function get views() : Array;

        function get currentView() : IProductTypeView;

        function set currentView(param1:IProductTypeView) : void;

        function get printTypes() : Array;

        function get currentPrintArea() : IPrintArea;

        function getPrintAreasForView(param1:IProductTypeView) : Array;

        function getPrintAreaOffset(param1:IPrintArea) : Point;

        function get sizes() : Array;

        function get currentSize() : IProductTypeSize;

        function set currentSize(param1:IProductTypeSize) : void;

        function loadProduct(param1:IProduct, param2:Function = null, param3:Function = null) : void;

    }
}
