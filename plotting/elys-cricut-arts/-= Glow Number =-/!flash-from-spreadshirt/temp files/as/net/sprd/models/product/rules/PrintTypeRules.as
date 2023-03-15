package net.sprd.models.product.rules
{
    import flash.geom.*;
    import mx.resources.*;
    import net.sprd.api.*;
    import net.sprd.common.colors.*;
    import net.sprd.entities.*;
    import net.sprd.models.product.*;

    public class PrintTypeRules extends Object
    {
        private static const digiColorsSetup:Array = [{name:"black", hexCode:"#000000"}, {name:"white", hexCode:"#FFFFFF"}, {name:"yellow", hexCode:"#fff500"}, {name:"yellow_gold", hexCode:"#fcd816"}, {name:"orange", hexCode:"#e35110"}, {name:"dark_red", hexCode:"#b5263c"}, {name:"crimson", hexCode:"#982544"}, {name:"magenta", hexCode:"#c82e7f"}, {name:"navy", hexCode:"#141754"}, {name:"purple", hexCode:"#521973"}, {name:"royal_blue", hexCode:"#192f97"}, {name:"light_blue", hexCode:"#0091d3"}, {name:"petrol", hexCode:"#00739B"}, {name:"bright_green", hexCode:"#379e2a"}, {name:"pink", hexCode:"#e7c9d9"}, {name:"green", hexCode:"#008751"}, {name:"chocolate", hexCode:"#644237"}, {name:"silver_grey", hexCode:"#929694"}, {name:"sand", hexCode:"#e0b075"}, {name:"sky_blue", hexCode:"#9dc8d9"}, {name:"sunshine", hexCode:"#ffcb4f"}];
        private static var _digiColors:Array;
        private static const specialColors:Array = [95, 93, 91, 92, 94, 97, 98, 99, 100, 101, 137, 136, 163, 140, 164, 90, 73, 72, 181, 177, 178, 141, 179, 180, 142];

        public function PrintTypeRules()
        {
            return;
        }// end function

        public static function canPrintAbove(param1:IPrintType, param2:IPrintType) : Boolean
        {
            return param1.printableAbove.indexOf(param2.id) != -1;
        }// end function

        public static function printColorsFromPrintType(param1:IPrintType) : Array
        {
            var _loc_3:String;
            var _loc_2:Array;
            for each (_loc_3 in param1.printColors)
            {
                
                _loc_2.push(IPrintColor(API.em.get(_loc_3, APIRegistry.PRINT_COLOR)));
            }
            return _loc_2;
        }// end function

        public static function canPrintColorAbove(param1:String, param2:String) : Boolean
        {
            var _loc_3:* = API.em.get(param1, APIRegistry.PRINT_COLOR) as IPrintColor;
            if (!_loc_3)
            {
                return false;
            }
            return _loc_3.net.sprd.entities:IPrintColor::printableAbove.indexOf(param2) != -1;
        }// end function

        public static function getRGBColorsForPrintColorIds(param1:Array) : Array
        {
            var _loc_3:String;
            var _loc_2:Array;
            for each (_loc_3 in param1)
            {
                
                _loc_2.push(getRGBColorForPrintColorId(_loc_3));
            }
            return _loc_2;
        }// end function

        public static function getRGBColorForPrintColorId(param1:String) : uint
        {
            var _loc_2:* = IPrintColor(API.em.get(param1, APIRegistry.PRINT_COLOR));
            return _loc_2 ? (ColorUtil.getIntegerColor(_loc_2.hexCode)) : (ProductDefaultRules.getDefaultRGBColor(true));
        }// end function

        public static function getPrintColors(param1:Array, param2:IPrintType) : Array
        {
            var _loc_4:String;
            var _loc_5:Color;
            var _loc_3:Array;
            for each (_loc_4 in param1)
            {
                
                _loc_5 = Color.fromHexString(_loc_4);
                if (param2.colorSpace == ColorSpace.PRINTCOLORS)
                {
                    _loc_3.push(getPrintColorForRGBColor(param2, _loc_5));
                    continue;
                }
                _loc_3.push(getClosestPrintColorForRGBColor(digiColors, _loc_5));
            }
            return _loc_3;
        }// end function

        public static function adjustRGBColors(param1:Array, param2:Array, param3:Array) : Array
        {
            var _loc_5:int;
            var _loc_6:int;
            var _loc_7:IPrintColor;
            var _loc_4:* = param1.slice();
            if (param2)
            {
                _loc_5 = 0;
                do
                {
                    
                    if (param2[_loc_5])
                    {
                        _loc_4[_loc_5] = param2[_loc_5];
                    }
                    if (_loc_5++ < param2.length)
                    {
                    }
                }while (_loc_5 < _loc_4.length)
            }
            if (param3)
            {
                _loc_6 = 0;
                do
                {
                    
                    if (param3[_loc_6])
                    {
                        _loc_7 = IPrintColor(API.em.get(param3[_loc_6], APIRegistry.PRINT_COLOR));
                        if (_loc_7)
                        {
                            _loc_4[_loc_6] = _loc_7.hexCode;
                        }
                    }
                    if (_loc_6++ < param3.length)
                    {
                    }
                }while (_loc_6 < _loc_4.length)
            }
            return _loc_4;
        }// end function

        public static function getPrintColorForRGBColor(param1:IPrintType, param2:Color) : IPrintColor
        {
            var _loc_3:IPrintColor;
            if (param1.colorSpace != ColorSpace.PRINTCOLORS)
            {
                return _loc_3;
            }
            return getClosestPrintColorForRGBColor(getPrintColorsForPrintType(param1), param2);
        }// end function

        public static function getPrintColorsForPrintType(param1:IPrintType) : Array
        {
            var _loc_3:String;
            var _loc_2:Array;
            for each (_loc_3 in param1.printColors)
            {
                
                _loc_2.push(API.em.get(_loc_3, APIRegistry.PRINT_COLOR));
            }
            return _loc_2;
        }// end function

        public static function getValidRGBColorsForPrintType(param1:IPrintType, param2:Array) : Array
        {
            var _loc_5:uint;
            var _loc_3:* = param1.colorSpace == ColorSpace.PRINTCOLORS ? (getPrintColorsForPrintType(param1)) : (digiColors);
            var _loc_4:Array;
            for each (_loc_5 in param2)
            {
                
                _loc_4.push(ColorUtil.getIntegerColor(getClosestPrintColorForRGBColor(_loc_3, Color.fromHex(_loc_5)).hexCode));
            }
            return _loc_4;
        }// end function

        public static function getPrintColorIdsForRGBColors(param1:IPrintType, param2:Array) : Array
        {
            var _loc_4:uint;
            var _loc_3:Array;
            for each (_loc_4 in param2)
            {
                
                _loc_3.push(getPrintColorForRGBColor(param1, Color.fromHex(_loc_4)).id);
            }
            return _loc_3;
        }// end function

        public static function getClosestPrintColorForRGBColor(param1:Array, param2:Color) : IPrintColor
        {
            var _loc_3:IPrintColor;
            var _loc_5:IPrintColor;
            var _loc_6:Number;
            var _loc_4:* = int.MAX_VALUE;
            for each (_loc_5 in param1)
            {
                
                if (param2.hex == _loc_5.color.hex)
                {
                    return _loc_5;
                }
                _loc_6 = ColorUtil.getColorDistance(_loc_5.color, param2);
                if (_loc_6 < _loc_4)
                {
                    _loc_4 = _loc_6;
                    _loc_3 = _loc_5;
                }
            }
            return _loc_3;
        }// end function

        public static function get digiColors() : Array
        {
            var _loc_1:Object;
            var _loc_2:IPrintColor;
            if (!_digiColors)
            {
                _digiColors = [];
                for each (_loc_1 in digiColorsSetup)
                {
                    
                    _loc_2 = IPrintColor(API.em.create(APIRegistry.PRINT_COLOR));
                    _loc_2.name = ResourceManager.getInstance().getString("confomat7", "printtype_section.color_" + _loc_1.name);
                    _loc_2.hexCode = _loc_1.hexCode;
                    _digiColors.push(_loc_2);
                }
            }
            return _digiColors;
        }// end function

        public static function isSpecialColor(param1:IPrintColor) : Boolean
        {
            return specialColors.indexOf(parseInt(param1.id)) > -1;
        }// end function

        public static function getPrintTypeForPrintColor(param1:IProductModel, param2:String) : IPrintType
        {
            var _loc_4:IPrintType;
            var _loc_5:String;
            var _loc_3:* = getPrintTypesForViewAndAppearance(param1.currentView, param1.currentAppearance);
            for each (_loc_4 in _loc_3)
            {
                
                for each (_loc_5 in _loc_4.printColors)
                {
                    
                    if (_loc_5 == param2)
                    {
                        return _loc_4;
                    }
                }
            }
            return null;
        }// end function

        public static function getPrintTypesForViewAndAppearance(param1:IProductTypeView, param2:IProductTypeAppearance) : Array
        {
            var _loc_6:String;
            var _loc_7:IPrintType;
            var _loc_3:Array;
            if (param1)
            {
            }
            if (!param2)
            {
                return _loc_3;
            }
            var _loc_4:* = ProductTypeRules.getPrintAreasForView(param1);
            var _loc_5:Array;
            if (_loc_4.length > 0)
            {
                _loc_5 = IPrintArea(_loc_4[0]).excludedPrintTypes;
            }
            for each (_loc_6 in param2.printTypes)
            {
                
                _loc_7 = IPrintType(API.em.get(_loc_6, APIRegistry.PRINT_TYPE));
                if (_loc_7.state == EntityState.ERROR)
                {
                    continue;
                }
                if (_loc_7.state !== EntityState.LOADED)
                {
                    throw new Error("Print type " + _loc_7.id + " is not yet loaded.");
                }
                if (_loc_5.indexOf(_loc_7.id) > -1)
                {
                    continue;
                }
                _loc_3.push(_loc_7);
            }
            _loc_3.sort(sortByWeight);
            return _loc_3;
        }// end function

        public static function findMatchingPrintType(param1:IPrintType, param2:Array) : IPrintType
        {
            var _loc_3:IPrintType;
            var _loc_4:IPrintType;
            if (param1)
            {
                for each (_loc_4 in param2)
                {
                    
                    if (_loc_4 == param1)
                    {
                        _loc_3 = _loc_4;
                        break;
                    }
                }
                if (!_loc_3)
                {
                    for each (_loc_4 in param2)
                    {
                        
                        if (_loc_4.colorSpace == param1.colorSpace)
                        {
                        }
                        if (param1.printableAlongWith.indexOf(_loc_4.id) > -1)
                        {
                            _loc_3 = _loc_4;
                            break;
                        }
                    }
                }
                if (!_loc_3)
                {
                    for each (_loc_4 in param2)
                    {
                        
                        if (param1.printableAlongWith.indexOf(_loc_4.id) > -1)
                        {
                            _loc_3 = _loc_4;
                            break;
                        }
                    }
                }
            }
            if (!_loc_3)
            {
                _loc_3 = param2[0];
            }
            return _loc_3;
        }// end function

        public static function findReplacementPrintType(param1:IPrintType, param2:Boolean, param3:Array) : IPrintType
        {
            var other:IPrintType;
            var printType:* = param1;
            var bitmap:* = param2;
            var possiblePrintTypes:* = param3;
            if (possiblePrintTypes.length == 0)
            {
                return null;
            }
            possiblePrintTypes.sort(sortByWeight);
            if (printType)
            {
                if (possiblePrintTypes.indexOf(printType) != -1)
                {
                    return printType;
                }
                var _loc_5:int;
                var _loc_6:* = possiblePrintTypes;
                while (_loc_6 in _loc_5)
                {
                    
                    other = _loc_6[_loc_5];
                    if (other.colorSpace == printType.colorSpace)
                    {
                        return other;
                    }
                }
            }
            if (bitmap)
            {
                return possiblePrintTypes.filter(function (param1:IPrintType, param2, param3) : Boolean
            {
                return param1.colorSpace != ColorSpace.PRINTCOLORS;
            }// end function
            )[0];
            }
            return possiblePrintTypes[0];
        }// end function

        public static function findPossibleConfigurationPrintTypes(param1:IConfigurationModel) : Array
        {
            var _loc_4:IConfigurationModel;
            var _loc_5:IPrintType;
            var _loc_6:uint;
            var _loc_2:Array;
            if (param1.type == ConfigurationType.DESIGN)
            {
                _loc_2 = param1.product.getPossiblePrintTypesForDesign(param1.design);
            }
            else
            {
                _loc_2 = param1.product.getCurrentPrintTypes();
            }
            var _loc_3:Array;
            for each (_loc_4 in param1.product.getConfigurationsOnCurrentView())
            {
                
                if (_loc_4 != param1)
                {
                }
                if (_loc_3.indexOf(_loc_4.printType) == -1)
                {
                    _loc_3.push(_loc_4.printType);
                }
            }
            for each (_loc_5 in _loc_3)
            {
                
                _loc_6 = 0;
                while (_loc_6++ < _loc_2.length)
                {
                    
                    if (_loc_5.printableAlongWith.indexOf(_loc_2[_loc_6].id) == -1)
                    {
                        _loc_2.splice(_loc_6, 1);
                        break;
                    }
                }
            }
            return _loc_2;
        }// end function

        public static function getUsableConfigurationPrintTypes(param1:IConfigurationModel, param2:IPrintArea, param3:Boolean) : Array
        {
            var _loc_5:IPrintType;
            var _loc_4:Array;
            for each (_loc_5 in param1.product.printTypes)
            {
                
                if (param3)
                {
                }
                if (param1.getPossiblePrintTypes().indexOf(_loc_5) != -1)
                {
                }
                if (param1.product.currentAppearance.printTypes.indexOf(_loc_5.id) != -1)
                {
                }
                if (param2.excludedPrintTypes.indexOf(_loc_5.id) == -1)
                {
                    _loc_4.push(_loc_5);
                }
            }
            return _loc_4;
        }// end function

        public static function doesConfigurationFitIntoPrintTypeMaxBounds(param1:IConfigurationModel, param2:IPrintType) : Boolean
        {
            var _loc_3:* = ConfigurationSizeRules.maximumConfigurationBounds(param1, param2);
            var _loc_4:* = ConfigurationSizeRules.minimumConfigurationBounds(param1, param2);
            if (_loc_4)
            {
            }
            if (!_loc_3)
            {
                return false;
            }
            var _loc_5:* = new Rectangle(0, 0, param1.width, param1.height);
            if (_loc_5.containsRect(_loc_4))
            {
            }
            if (!_loc_3.containsRect(_loc_5))
            {
                return false;
            }
            return true;
        }// end function

        private static function sortByWeight(param1:IPrintType, param2:IPrintType) : Number
        {
            if (param1.weight > param2.weight)
            {
                return 1;
            }
            if (param1.weight < param2.weight)
            {
                return -1;
            }
            return 0;
        }// end function

    }
}
