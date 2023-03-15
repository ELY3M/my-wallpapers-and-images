package net.sprd.models.product.processors
{
    import net.sprd.common.colors.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.entities.*;
    import net.sprd.graphics.svg.*;
    import net.sprd.models.product.*;
    import net.sprd.models.product.errors.*;
    import net.sprd.models.product.rules.*;

    public class ProductCreator extends Object
    {
        private static const log:ILogger = LogContext.getLogger(this);

        public function ProductCreator()
        {
            return;
        }// end function

        public static function constraintsForDesignConfiguration(param1:IProductModel, param2:IDesign) : ConfigurationUsageConstraints
        {
            var result:ConfigurationUsageConstraints;
            var checkSizingPossible:Function;
            var product:* = param1;
            var design:* = param2;
            result = new ConfigurationUsageConstraints();
            if (product.currentPrintArea)
            {
            }
            if (product.currentPrintArea.allowsDesign)
            {
            }
            if (product.currentView)
            {
                if (product.currentView)
                {
                }
            }
            if (product.currentView.printAreas.length == 0)
            {
                result.printAreaDisallowedConfiguration = true;
            }
            var possiblePrintTypes:* = product.getPossiblePrintTypesForDesign(design);
            if (possiblePrintTypes.length == 0)
            {
                result.missingPrintType = true;
            }
            else
            {
                result.printArea = product.getPrintAreasForView(product.currentView)[0];
                if (!result.printArea)
                {
                    result.missingPrintArea = true;
                }
                else
                {
                    checkSizingPossible = function (param1:IPrintType, param2, param3) : Boolean
            {
                var printType:* = param1;
                var i:* = param2;
                var a:* = param3;
                try
                {
                    ProductDefaultRules.getDefaultDesignSize(design, result.printArea, printType);
                }
                catch (e:ConfigurationSizeError)
                {
                    switch(e.errorID)
                    {
                        case ConfigurationSizeError.TOO_BIG:
                        {
                            result.isTooLarge = true;
                            return false;
                        }
                        case ConfigurationSizeError.TOO_SMALL:
                        {
                            result.isTooSmall = true;
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
            ;
                    result.possiblePrintTypes = possiblePrintTypes.filter(checkSizingPossible);
                    result.printType = PrintTypeRules.findMatchingPrintType(product.preferredPrintType, result.possiblePrintTypes);
                }
            }
            return result;
        }// end function

        public static function createDesignSVG(param1:IPrintType, param2:Array, param3:IDesign) : SVGImage
        {
            var _loc_5:IPrintColor;
            var _loc_4:* = new SVGImage();
            _loc_4.width = param3.width;
            _loc_4.height = param3.height;
            _loc_4.imageId = param3.imageId;
            for each (_loc_5 in param2)
            {
                
                _loc_4.addRGBColor(ColorUtil.getIntegerColor(_loc_5.hexCode));
                if (param1.colorSpace == ColorSpace.PRINTCOLORS)
                {
                    _loc_4.addPrintColor(_loc_5.id);
                }
            }
            return _loc_4;
        }// end function

        public static function createDefaultSVGText(param1:String, param2:String, param3:Number, param4:Number, param5:IFontStyle) : ISVGShape
        {
            var _loc_6:* = new SVGText();
            _loc_6.fontSize = param3;
            _loc_6.fontFamilyID = param5.fontFamily;
            _loc_6.fontID = param5.id;
            _loc_6.fillColor = param4;
            var _loc_7:* = new SVGText();
            _loc_7.x = 0;
            _loc_7.y = 0;
            _loc_7.textAnchor = param2;
            _loc_6.addTSpan(_loc_7);
            var _loc_8:* = new SVGText();
            _loc_8.text = param1;
            _loc_7.addTSpan(_loc_8);
            return _loc_6;
        }// end function

    }
}
