package net.sprd.models.product.rules
{
    import net.sprd.api.*;
    import net.sprd.common.colors.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.entities.*;

    public class ProductTypeRules extends Object
    {
        private static const log:ILogger = LogContext.getLogger(this);
        private static const BRIGHTNESS_THRESHOLD:Number = 60;

        public function ProductTypeRules()
        {
            return;
        }// end function

        public static function getPrintAreasForView(param1:IProductTypeView) : Array
        {
            var _loc_3:String;
            var _loc_2:Array;
            if (!param1)
            {
                return _loc_2;
            }
            for each (_loc_3 in param1.printAreas)
            {
                
                _loc_2.push(IPrintArea(API.em.get(_loc_3, APIRegistry.PRINT_AREA)));
            }
            return _loc_2;
        }// end function

        public static function getPrintAreaForPerspective(param1:IProductType, param2:String) : IPrintArea
        {
            var _loc_3:IProductTypeView;
            for each (_loc_3 in param1.views)
            {
                
                if (_loc_3.perspective == param2)
                {
                }
                if (_loc_3.printAreas.length > 0)
                {
                    return getPrintAreasForView(_loc_3)[0];
                }
            }
            return null;
        }// end function

        public static function isPrintAreaOnView(param1:IPrintArea, param2:Array) : Boolean
        {
            var _loc_4:IProductTypeView;
            var _loc_3:Array;
            for each (_loc_4 in param2)
            {
                
                _loc_3 = _loc_3.concat(_loc_4.printAreas);
            }
            if (_loc_3.indexOf(param1.id) == -1)
            {
                log.fatal("Print area does not exist");
                return false;
            }
            return true;
        }// end function

        public static function isBright(param1:IProductTypeAppearance) : Boolean
        {
            var _loc_2:* = Color.fromHex(ColorUtil.getIntegerColor(param1.colors[0]));
            return _loc_2.brightness > BRIGHTNESS_THRESHOLD;
        }// end function

        public static function findMatchingSize(param1:String, param2:Array) : IProductTypeSize
        {
            var _loc_3:IProductTypeSize;
            for each (_loc_3 in param2)
            {
                
                if (param1)
                {
                }
                if (_loc_3.name == param1)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        public static function findMatchingAppearance(param1:IProductTypeAppearance, param2:Array) : IProductTypeAppearance
        {
            if (param1.colors.length == 0)
            {
                return null;
            }
            var _loc_3:* = findMatchingAppearanceByHexValueComparison(param1, param2);
            if (_loc_3)
            {
                return _loc_3;
            }
            return findMatchingAppearanceByColorDistance(param1, param2);
        }// end function

        public static function findMatchingAppearanceByHexValueComparison(param1:IProductTypeAppearance, param2:Array) : IProductTypeAppearance
        {
            var _loc_3:IProductTypeAppearance;
            for each (_loc_3 in param2)
            {
                
                if (param1.colors.length > 0)
                {
                }
                if (_loc_3.colors.length > 0)
                {
                }
                if (param1.colors[0] == _loc_3.colors[0])
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        public static function findMatchingAppearanceByColorDistance(param1:IProductTypeAppearance, param2:Array) : IProductTypeAppearance
        {
            var _loc_6:IProductTypeAppearance;
            var _loc_7:Color;
            var _loc_8:Number;
            var _loc_3:* = int.MAX_VALUE;
            var _loc_4:IProductTypeAppearance;
            var _loc_5:* = Color.fromHex(ColorUtil.getIntegerColor(param1.colors[0]));
            for each (_loc_6 in param2)
            {
                
                if (_loc_6.colors.length > 0)
                {
                    _loc_7 = Color.fromHex(ColorUtil.getIntegerColor(_loc_6.colors[0]));
                    _loc_8 = ColorUtil.getColorDistance(_loc_7, _loc_5);
                    if (ColorUtil.isEqualShade(_loc_7, _loc_5))
                    {
                        ColorUtil.isEqualShade(_loc_7, _loc_5);
                    }
                    if (_loc_8 < _loc_3)
                    {
                        _loc_3 = _loc_8;
                        _loc_4 = _loc_6;
                    }
                }
            }
            return _loc_4;
        }// end function

        public static function findMatchingView(param1:IProductTypeView, param2:Array) : IProductTypeView
        {
            var _loc_3:IProductTypeView;
            for each (_loc_3 in param2)
            {
                
                if (param1.perspective == _loc_3.perspective)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        public static function findFirstAppearanceOnStock(param1:IProductType, param2:Array, param3:Array) : IProductTypeAppearance
        {
            var _loc_4:IProductTypeAppearance;
            for each (_loc_4 in param2)
            {
                
                if (isAppearanceOnStock(param1, _loc_4, param3))
                {
                    return _loc_4;
                }
            }
            return null;
        }// end function

        public static function isAppearanceOnStock(param1:IProductType, param2:IProductTypeAppearance, param3:Array) : Boolean
        {
            var _loc_4:IProductTypeSize;
            for each (_loc_4 in param3)
            {
                
                if (isOnStock(param1, _loc_4, param2))
                {
                    return true;
                }
            }
            return false;
        }// end function

        public static function isOnStock(param1:IProductType, param2:IProductTypeSize, param3:IProductTypeAppearance) : Boolean
        {
            if (param1)
            {
            }
            if (param2)
            {
            }
            if (!param3)
            {
                return false;
            }
            return param1.isOnStock(param2.id, param3.id);
        }// end function

    }
}
