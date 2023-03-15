package net.sprd.models.product.processors
{
    import flash.utils.*;
    import net.sprd.entities.*;
    import net.sprd.events.*;
    import net.sprd.models.product.*;
    import net.sprd.models.product.errors.*;
    import net.sprd.models.product.rules.*;

    public class PrintTypeEqualizer extends Object
    {
        public const triggerPrintTypeConversion:Array;
        public const convertablePrintTypes:Array;
        public var productModel:IProductModel;
        private var printTypeBeforeConversion:Dictionary;
        private var changedFromEqualizer:Boolean;

        public function PrintTypeEqualizer()
        {
            this.triggerPrintTypeConversion = ["17", "1"];
            this.convertablePrintTypes = ["14", "2", "1", "17"];
            this.printTypeBeforeConversion = new Dictionary();
            return;
        }// end function

        private function getPreferedPrintTypeForConfiguration(param1:IConfigurationModel, param2:IPrintArea, param3:IPrintType) : IPrintType
        {
            var design:IDesign;
            var possiblePrintTypes:Array;
            var pt:IPrintType;
            var config:* = param1;
            var printArea:* = param2;
            var preferedPrintType:* = param3;
            if (config.type == ConfigurationType.DESIGN)
            {
                design = config.design;
                possiblePrintTypes = this.productModel.getPossiblePrintTypesForDesign(design);
                possiblePrintTypes = possiblePrintTypes.filter(function (param1:IPrintType, param2, param3) : Boolean
            {
                var printType:* = param1;
                var i:* = param2;
                var a:* = param3;
                try
                {
                    ProductDefaultRules.getDefaultDesignSize(design, printArea, printType);
                }
                catch (e:ConfigurationSizeError)
                {
                    switch(e.errorID)
                    {
                        case ConfigurationSizeError.TOO_BIG:
                        {
                            return false;
                        }
                        case ConfigurationSizeError.TOO_SMALL:
                        {
                            return false;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                return true;
            }// end function
            );
                var _loc_5:int;
                var _loc_6:* = possiblePrintTypes;
                while (_loc_6 in _loc_5)
                {
                    
                    pt = _loc_6[_loc_5];
                    if (pt.id == preferedPrintType.id)
                    {
                        return pt;
                    }
                }
                if (possiblePrintTypes.length > 0)
                {
                    return possiblePrintTypes[0];
                }
                return null;
            }
            else
            {
                return preferedPrintType;
            }
        }// end function

        private function checkConfigurations(param1:IPrintArea, param2:IPrintType, param3:IConfigurationModel) : void
        {
            var otherConfiguration:IConfigurationModel;
            var preferedPrintType:IPrintType;
            var possiblePrintTypesForViewAndAppearance:*;
            var printType:IPrintType;
            var configuration:IConfigurationModel;
            var canSwitchToPrintType:Boolean;
            var printArea:* = param1;
            var targetPrintType:* = param2;
            var exclude:* = param3;
            if (printArea)
            {
            }
            if (!this.productModel)
            {
                return;
            }
            with ({})
            {
                {}.callback = function (param1:IConfigurationModel, param2:int, param3:Array) : Boolean
            {
                return param1 != exclude;
            }// end function
            ;
            }
            var configurationsOnTargetPrintArea:* = this.productModel.getConfigurationsForPrintArea(printArea.id).filter(function (param1:IConfigurationModel, param2:int, param3:Array) : Boolean
            {
                return param1 != exclude;
            }// end function
            );
            if (exclude)
            {
            }
            if (this.triggerPrintTypeConversion.indexOf(exclude.printType.id) != -1)
            {
                possiblePrintTypesForViewAndAppearance = PrintTypeRules.getPrintTypesForViewAndAppearance(this.productModel.currentView, this.productModel.currentAppearance);
                if (!preferedPrintType)
                {
                }
                if (possiblePrintTypesForViewAndAppearance.length > 0)
                {
                    preferedPrintType = possiblePrintTypesForViewAndAppearance[0];
                }
                with ({})
                {
                    {}.callback = function (param1:IConfigurationModel, param2:int, param3:Array) : Boolean
            {
                var _loc_4:* = param1.printType;
                if (printTypeBeforeConversion[param1])
                {
                    _loc_4 = printTypeBeforeConversion[param1];
                }
                else
                {
                    _loc_4 = getPreferedPrintTypeForConfiguration(param1, printArea, preferedPrintType);
                }
                return triggerPrintTypeConversion.indexOf(_loc_4.id) != -1;
            }// end function
            ;
                }
                if (configurationsOnTargetPrintArea.filter(function (param1:IConfigurationModel, param2:int, param3:Array) : Boolean
            {
                var _loc_4:* = param1.printType;
                if (printTypeBeforeConversion[param1])
                {
                    _loc_4 = printTypeBeforeConversion[param1];
                }
                else
                {
                    _loc_4 = getPreferedPrintTypeForConfiguration(param1, printArea, preferedPrintType);
                }
                return triggerPrintTypeConversion.indexOf(_loc_4.id) != -1;
            }// end function
            ).length == 0)
                {
                    var _loc_5:int;
                    var _loc_6:* = configurationsOnTargetPrintArea;
                    while (_loc_6 in _loc_5)
                    {
                        
                        otherConfiguration = _loc_6[_loc_5];
                        printType = this.printTypeBeforeConversion[otherConfiguration];
                        if (!printType)
                        {
                            printType = this.getPreferedPrintTypeForConfiguration(otherConfiguration, printArea, preferedPrintType);
                        }
                        if (printType)
                        {
                        }
                        if (otherConfiguration.printType.id != printType.id)
                        {
                            if (PrintTypeRules.doesConfigurationFitIntoPrintTypeMaxBounds(otherConfiguration, printType))
                            {
                                this.changedFromEqualizer = true;
                                otherConfiguration.printType = printType;
                                this.changedFromEqualizer = false;
                            }
                        }
                    }
                }
            }
            else
            {
                if (!targetPrintType)
                {
                    var _loc_5:int;
                    var _loc_6:* = configurationsOnTargetPrintArea;
                    while (_loc_6 in _loc_5)
                    {
                        
                        configuration = _loc_6[_loc_5];
                        if (this.triggerPrintTypeConversion.indexOf(configuration.printType.id) != -1)
                        {
                            targetPrintType = configuration.printType;
                            break;
                        }
                    }
                }
                if (targetPrintType)
                {
                    if (this.triggerPrintTypeConversion.indexOf(targetPrintType.id) != -1)
                    {
                        canSwitchToPrintType;
                        var _loc_5:int;
                        var _loc_6:* = configurationsOnTargetPrintArea;
                        while (_loc_6 in _loc_5)
                        {
                            
                            otherConfiguration = _loc_6[_loc_5];
                            if (otherConfiguration.printType.id != targetPrintType.id)
                            {
                                if (this.convertablePrintTypes.indexOf(otherConfiguration.printType.id) == -1)
                                {
                                    canSwitchToPrintType;
                                    break;
                                }
                                with ({})
                                {
                                    {}.callback = function (param1:IPrintType, param2:int, param3:Array) : Boolean
            {
                return param1.id == targetPrintType.id;
            }// end function
            ;
                                }
                                if (PrintTypeRules.getUsableConfigurationPrintTypes(otherConfiguration, otherConfiguration.printArea, true).filter(function (param1:IPrintType, param2:int, param3:Array) : Boolean
            {
                return param1.id == targetPrintType.id;
            }// end function
            ).length == 0)
                                {
                                    canSwitchToPrintType;
                                    break;
                                }
                                if (!PrintTypeRules.doesConfigurationFitIntoPrintTypeMaxBounds(otherConfiguration, targetPrintType))
                                {
                                    canSwitchToPrintType;
                                    break;
                                }
                            }
                        }
                        if (canSwitchToPrintType)
                        {
                            var _loc_5:int;
                            var _loc_6:* = configurationsOnTargetPrintArea;
                            while (_loc_6 in _loc_5)
                            {
                                
                                otherConfiguration = _loc_6[_loc_5];
                                if (otherConfiguration.printType.id != targetPrintType.id)
                                {
                                    this.printTypeBeforeConversion[otherConfiguration] = otherConfiguration.printType;
                                }
                                this.changedFromEqualizer = true;
                                otherConfiguration.printType = targetPrintType;
                                this.changedFromEqualizer = false;
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        public function bus_ConfigurationAdded(param1:ConfigurationEvent) : void
        {
            if (param1)
            {
            }
            if (param1.configuration)
            {
                this.checkConfigurations(param1.configuration.printArea, param1.configuration.printType, null);
            }
            return;
        }// end function

        public function bus_ConfigurationRemoved(param1:ConfigurationEvent) : void
        {
            if (param1)
            {
            }
            if (param1.configuration)
            {
                this.checkConfigurations(param1.configuration.printArea, null, param1.configuration);
            }
            return;
        }// end function

        public function bus_ConfigurationPrintTypeChanged(param1:ConfigurationEvent) : void
        {
            if (param1)
            {
            }
            if (param1.configuration)
            {
            }
            if (!this.changedFromEqualizer)
            {
                this.printTypeBeforeConversion[param1.configuration] = param1.configuration.printType;
            }
            return;
        }// end function

    }
}
