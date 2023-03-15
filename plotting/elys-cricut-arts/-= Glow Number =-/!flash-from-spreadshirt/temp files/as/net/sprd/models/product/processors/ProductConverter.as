package net.sprd.models.product.processors
{
    import flash.geom.*;
    import net.sprd.common.graphics.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.entities.*;
    import net.sprd.entities.impl.*;
    import net.sprd.models.common.*;
    import net.sprd.models.product.*;
    import net.sprd.models.product.errors.*;
    import net.sprd.models.product.rules.*;

    public class ProductConverter extends Object
    {
        private static var log:ILogger = LogContext.getLogger(this);

        public function ProductConverter()
        {
            return;
        }// end function

        public static function convertConfigurationsToProductType(param1:IProductModel) : void
        {
            var _loc_3:String;
            var _loc_4:IPrintArea;
            var _loc_6:IConfigurationModel;
            var _loc_7:IProductTypeView;
            if (param1.previousProductType)
            {
            }
            if (param1.previousProductType.id == param1.productTypeID)
            {
                return;
            }
            var _loc_2:* = param1.previousProductType.views.slice();
            var _loc_5:* = param1.configurations.concat();
            for each (_loc_6 in _loc_5)
            {
                
                _loc_3 = "";
                _loc_4 = null;
                for each (_loc_7 in _loc_2)
                {
                    
                    if (_loc_7.printAreas.indexOf(_loc_6.printArea.id) > -1)
                    {
                        _loc_3 = _loc_7.perspective;
                        break;
                    }
                }
                _loc_4 = ProductTypeRules.getPrintAreaForPerspective(param1.productType, _loc_3);
                if (_loc_4)
                {
                }
                if (!ProductTypeRules.isPrintAreaOnView(_loc_4, param1.views))
                {
                    param1.removeConfiguration(_loc_6);
                    continue;
                }
                if (!convertConfigurationToNewAppearance(_loc_6, _loc_4, true))
                {
                    continue;
                }
                if (!ProductConversionRules.doesConfigurationFitPrintArea(_loc_6, _loc_6.printType, _loc_4))
                {
                    param1.removeConfiguration(_loc_6);
                    continue;
                }
                convertConfigurationToPrintArea(_loc_6.printArea, _loc_4, _loc_6);
            }
            return;
        }// end function

        public static function convertConfigurationsToNewAppearance(param1:IProductModel) : void
        {
            var _loc_2:IConfigurationModel;
            for each (_loc_2 in param1.configurations)
            {
                
                convertConfigurationToNewAppearance(_loc_2, _loc_2.printArea, true);
            }
            return;
        }// end function

        private static function convertConfigurationToNewAppearance(param1:IConfigurationModel, param2:IPrintArea, param3:Boolean) : Boolean
        {
            var _loc_4:* = PrintTypeRules.getUsableConfigurationPrintTypes(param1, param2, param3);
            var _loc_5:* = PrintTypeRules.findReplacementPrintType(param1.printType, param1.bitmap, _loc_4);
            if (_loc_5)
            {
                param1.printType = _loc_5;
                return true;
            }
            param1.product.removeConfiguration(param1);
            return false;
        }// end function

        private static function convertConfigurationToPrintArea(param1:IPrintArea, param2:IPrintArea, param3:IConfigurationModel) : void
        {
            var scale:Number;
            var shrinkScale:Number;
            var diffW:Number;
            var diffH:Number;
            var success:Boolean;
            var sourcePrintArea:* = param1;
            var targetPrintArea:* = param2;
            var config:* = param3;
            var oldGeom:* = ConfigurationSizeRules.getGeometry(config, sourcePrintArea);
            var newBounds:* = ConfigurationSizeRules.getConfigurationBounds(targetPrintArea, oldGeom);
            var newWidth:* = newBounds.width;
            var newHeight:* = newBounds.height;
            var newX:* = newBounds.x;
            var newY:* = newBounds.y;
            var sizeTestRect:* = new Rectangle(0, 0, newWidth, newHeight);
            sizeTestRect = GeometryUtil.getBounds(sizeTestRect, GeometryUtil.rotationMatrix(newWidth / 2, newHeight / 2, UnitUtil.deg2rad(oldGeom.rotation)));
            sizeTestRect.x = 0;
            sizeTestRect.y = 0;
            var printAreaBounds:* = new Rectangle(0, 0, targetPrintArea.width, targetPrintArea.height);
            BoundsUtil.trimBoundsProportionally(sizeTestRect, printAreaBounds);
            if (sizeTestRect.width < newWidth)
            {
                shrinkScale = sizeTestRect.width / newWidth;
                sizeTestRect.width = newWidth * shrinkScale;
                sizeTestRect.height = newHeight * shrinkScale;
                newWidth = sizeTestRect.width;
                newHeight = sizeTestRect.height;
            }
            var minBounds:* = ConfigurationSizeRules.minimumConfigurationBounds(config, config.printType);
            var maxBounds:* = ConfigurationSizeRules.maximumConfigurationBounds(config, config.printType);
            if (minBounds.containsRect(sizeTestRect))
            {
                diffW = minBounds.width - sizeTestRect.width;
                diffH = minBounds.height - sizeTestRect.height;
                scale;
                if (diffW < diffH)
                {
                    scale = (sizeTestRect.width + diffW) / sizeTestRect.width;
                }
                else
                {
                    scale = (sizeTestRect.height + diffH) / sizeTestRect.height;
                }
                newWidth = newWidth * scale;
                newHeight = newHeight * scale;
                newX = newX - diffW / 2;
                newY = newY - diffH / 2;
                sizeTestRect.width = sizeTestRect.width * scale;
                sizeTestRect.height = sizeTestRect.height * scale;
            }
            if (sizeTestRect.containsRect(maxBounds))
            {
                diffW = sizeTestRect.width - maxBounds.width;
                diffH = sizeTestRect.height - maxBounds.height;
                scale;
                if (diffW > diffH)
                {
                    scale = (sizeTestRect.width - diffW) / sizeTestRect.width;
                }
                else
                {
                    scale = (sizeTestRect.height - diffH) / sizeTestRect.height;
                }
                sizeTestRect.width = sizeTestRect.width * scale;
                sizeTestRect.height = sizeTestRect.height * scale;
                newWidth = newWidth * scale;
                newHeight = newHeight * scale;
                newX = newX + diffW / 2;
                newY = newY + diffH / 2;
            }
            var positionTestRect:* = new Rectangle(newX, newY, newWidth, newHeight);
            positionTestRect = GeometryUtil.getBounds(positionTestRect, GeometryUtil.rotationMatrix(newX + newWidth / 2, newY + newHeight / 2, UnitUtil.deg2rad(config.rotation)));
            if (positionTestRect.bottom > printAreaBounds.bottom)
            {
                newY = newY - (positionTestRect.bottom - printAreaBounds.bottom);
            }
            if (positionTestRect.top < printAreaBounds.top)
            {
                newY = printAreaBounds.top;
            }
            if (positionTestRect.right > printAreaBounds.right)
            {
                newX = newX - (positionTestRect.right - printAreaBounds.right);
            }
            if (positionTestRect.left < printAreaBounds.left)
            {
                newX = printAreaBounds.left;
            }
            config.allowConstraintError = true;
            scale = Math.min(newWidth / config.width, newHeight / config.height);
            if (scale < 1)
            {
                success;
                do
                {
                    
                    try
                    {
                        config.centerScale = new Point(scale, scale);
                        config.offset.x = newX;
                        config.offset.y = newY;
                        success;
                    }
                    catch (e:FontResizeError)
                    {
                        scale = scale * 1.05;
                    }
                    if (!success)
                    {
                    }
                }while (scale < 1)
            }
            else
            {
                config.centerScale = new Point(scale, scale);
                config.offset.x = newX;
                config.offset.y = newY;
            }
            config.allowConstraintError = false;
            config.printArea = targetPrintArea;
            return;
        }// end function

        public static function convertPrintTypes(param1:IProductModel, param2:IConfigurationModel) : void
        {
            var _loc_4:IConfigurationModel;
            var _loc_3:* = param2.printType;
            if (!_loc_3)
            {
                log.error("No reference print type was given for print type adjustment");
                return;
            }
            for each (_loc_4 in param1.getConfigurationsOnCurrentView())
            {
                
                if (_loc_4 == param2)
                {
                    continue;
                }
                if (_loc_4.doesFitIntoPrintTypeMaxBounds(param2.printType))
                {
                    _loc_4.printType = param2.printType;
                    convertPrintColors(param1, param2);
                }
            }
            return;
        }// end function

        public static function convertPrintColors(param1:IProductModel, param2:IConfigurationModel) : void
        {
            var _loc_3:IConfigurationModel;
            var _loc_4:Array;
            var _loc_5:uint;
            var _loc_6:uint;
            for each (_loc_3 in param1.getConfigurationsOnCurrentView())
            {
                
                if (_loc_3 == param2)
                {
                    continue;
                }
                _loc_4 = _loc_3.rgbColors.concat();
                if (param2.printType.id == PrintType.SPECIALFLEX)
                {
                    _loc_5 = param2.rgbColors[0];
                    _loc_6 = 0;
                    while (_loc_6++ < _loc_3.rgbColors.length)
                    {
                        
                        _loc_4[_loc_6] = _loc_5;
                    }
                }
                _loc_3.rgbColors = _loc_4;
            }
            return;
        }// end function

    }
}
