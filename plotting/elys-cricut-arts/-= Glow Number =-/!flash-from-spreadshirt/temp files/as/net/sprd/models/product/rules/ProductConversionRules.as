package net.sprd.models.product.rules
{
    import flash.geom.*;
    import net.sprd.common.graphics.*;
    import net.sprd.entities.*;
    import net.sprd.models.common.*;
    import net.sprd.models.product.*;

    public class ProductConversionRules extends Object
    {

        public function ProductConversionRules()
        {
            return;
        }// end function

        public static function canChangeProductType(param1:IProductModel, param2:IProductType) : ProductTypeUsageConstraints
        {
            var _loc_6:IProductTypeView;
            var _loc_7:Array;
            var _loc_8:IPrintArea;
            var _loc_9:IConfigurationModel;
            var _loc_10:IPrintType;
            var _loc_3:* = new ProductTypeUsageConstraints();
            if (!param2)
            {
                return _loc_3;
            }
            var _loc_4:* = param1.productType;
            var _loc_5:* = PrintTypeRules.getPrintTypesForViewAndAppearance(param2.defaultView, param2.defaultAppearance);
            for each (_loc_6 in _loc_4.views)
            {
                
                _loc_7 = param1.getConfigurationsForView(_loc_6);
                if (_loc_7.length == 0)
                {
                    continue;
                }
                _loc_8 = ProductTypeRules.getPrintAreaForPerspective(param2, _loc_6.perspective);
                if (!_loc_8)
                {
                    _loc_3.addMissingView(_loc_6);
                    continue;
                }
                for each (_loc_9 in _loc_7)
                {
                    
                    _loc_10 = PrintTypeRules.findReplacementPrintType(_loc_9.printType, _loc_9.bitmap, _loc_5);
                    if (!_loc_10)
                    {
                        _loc_3.addMissingPrintType(_loc_9.printType);
                        continue;
                    }
                    if (!doesConfigurationFitPrintArea(_loc_9, _loc_10, _loc_8))
                    {
                        _loc_3.addUnfittingConfiguration(_loc_9);
                    }
                }
            }
            return _loc_3;
        }// end function

        public static function canChangeProductTypeColor(param1:IProductModel, param2:IProductTypeAppearance) : ProductTypeUsageConstraints
        {
            var _loc_5:IConfigurationModel;
            var _loc_6:IPrintType;
            var _loc_3:* = new ProductTypeUsageConstraints();
            var _loc_4:* = PrintTypeRules.getPrintTypesForViewAndAppearance(param1.currentView, param2);
            for each (_loc_5 in param1.configurations)
            {
                
                _loc_6 = PrintTypeRules.findReplacementPrintType(_loc_5.printType, _loc_5.bitmap, _loc_4);
                if (!_loc_6)
                {
                    _loc_3.addMissingPrintType(_loc_5.printType);
                }
            }
            return _loc_3;
        }// end function

        public static function doesConfigurationFitPrintArea(param1:IConfigurationModel, param2:IPrintType = null, param3:IPrintArea = null) : Boolean
        {
            var _loc_7:Point;
            var _loc_8:Number;
            var _loc_9:Matrix;
            if (!param2)
            {
                param2 = param1.printType;
            }
            if (!param3)
            {
                param3 = param1.printArea;
            }
            var _loc_4:* = ConfigurationSizeRules.maximumConfigurationBounds(param1, param2);
            if (param1.rotation > 0)
            {
                _loc_7 = GeometryUtil.center(_loc_4);
                _loc_8 = UnitUtil.deg2rad(param1.rotation);
                _loc_9 = GeometryUtil.rotationMatrix(_loc_7.x, _loc_7.y, _loc_8);
                _loc_4 = GeometryUtil.getBounds(_loc_4, _loc_9);
            }
            _loc_4.x = 0;
            _loc_4.y = 0;
            var _loc_5:* = ConfigurationSizeRules.minimumConfigurationBounds(param1, param2);
            if (param1.rotation > 0)
            {
                _loc_7 = GeometryUtil.center(_loc_5);
                _loc_8 = UnitUtil.deg2rad(param1.rotation);
                _loc_9 = GeometryUtil.rotationMatrix(_loc_7.x, _loc_7.y, _loc_8);
                _loc_5 = GeometryUtil.getBounds(_loc_5, _loc_9);
            }
            _loc_5.x = 0;
            _loc_5.y = 0;
            var _loc_6:* = new Rectangle(0, 0, param3.width, param3.height);
            BoundsUtil.trimBoundsProportionally(_loc_4, _loc_6);
            if (!_loc_4.containsRect(_loc_5))
            {
                return false;
            }
            return true;
        }// end function

    }
}
