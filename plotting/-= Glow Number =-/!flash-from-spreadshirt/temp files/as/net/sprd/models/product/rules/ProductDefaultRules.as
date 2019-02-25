package net.sprd.models.product.rules
{
    import flash.geom.*;
    import net.sprd.api.*;
    import net.sprd.common.colors.*;
    import net.sprd.entities.*;
    import net.sprd.graphics.svg.*;
    import net.sprd.models.common.*;
    import net.sprd.models.product.*;
    import net.sprd.models.product.errors.*;

    public class ProductDefaultRules extends Object
    {

        public function ProductDefaultRules()
        {
            return;
        }// end function

        public static function getDefaultDesignSize(param1:IDesign, param2:IPrintArea, param3:IPrintType) : Rectangle
        {
            var _loc_4:* = param2.defaultPositioningBox;
            var _loc_5:* = new Rectangle(0, 0, param2.width - 0.01, param2.height - 0.01);
            var _loc_6:* = new Rectangle(0, 0, param3.net.sprd.entities:IPrintType::width - 0.01, param3.net.sprd.entities:IPrintType::height - 0.01);
            var _loc_7:* = ConfigurationSizeRules.metricBounds(param1, param3);
            _loc_7 = BoundsUtil.trimBoundsProportionally(_loc_7, _loc_6);
            _loc_7 = BoundsUtil.trimBoundsProportionally(_loc_7, _loc_5);
            var _loc_8:* = ConfigurationSizeRules.minimumDesignBounds(param1, param3);
            if (_loc_8.containsRect(_loc_7))
            {
                _loc_8.containsRect(_loc_7);
            }
            if (!_loc_8.equals(_loc_7))
            {
                throw new ConfigurationSizeError("Design is too big", ConfigurationSizeError.TOO_BIG);
            }
            var _loc_9:* = ConfigurationSizeRules.maximumDesignBounds(param1, param3);
            if (!_loc_9.containsRect(_loc_7))
            {
            }
            if (!_loc_9.equals(_loc_7))
            {
                throw new ConfigurationSizeError("Design can not be enlarged as required", ConfigurationSizeError.TOO_SMALL);
            }
            return _loc_7;
        }// end function

        public static function getDefaultFontStyle() : IFontStyle
        {
            var _loc_2:IQueryResult;
            var _loc_3:IFontFamily;
            var _loc_1:* = IFontStyle(API.em.get("15", APIRegistry.FONT_STYLE));
            if (_loc_1)
            {
                return _loc_1;
            }
            _loc_2 = API.em.getQueryResult(Query.findAll(APIRegistry.FONT_FAMILY));
            if (_loc_2.items.length > 0)
            {
                _loc_3 = IFontFamily(_loc_2.items[0]);
                if (_loc_3.styles)
                {
                }
                if (_loc_3.styles.length > 0)
                {
                    return IFontStyle(API.em.get(_loc_3.styles[0], APIRegistry.FONT_STYLE));
                }
            }
            return null;
        }// end function

        public static function getDefaultFontSize(param1:IFontStyle, param2:String) : int
        {
            if (param2 != "125")
            {
            }
            if (param2 != "126")
            {
            }
            return param2 == "127" ? (5) : (25);
        }// end function

        public static function getDefaultRGBColor(param1:Boolean) : uint
        {
            return param1 ? (ColorUtil.getIntegerColor("#000000")) : (ColorUtil.getIntegerColor("#FFFFFF"));
        }// end function

        public static function getDefaultConfigurationPosition(param1:Number, param2:Number, param3:String, param4:IPrintArea) : Point
        {
            var _loc_5:Point;
            if (param3 == ConfigurationType.TEXT)
            {
                return new Point(param4.defaultPositioningBox.x, param4.defaultPositioningBox.y + 4);
            }
            _loc_5 = new Point();
            switch(param4.defaultPositioningHorizontalAlignment)
            {
                case TextAnchor.START:
                {
                    _loc_5.x = param4.defaultPositioningBox.x;
                    break;
                }
                case TextAnchor.MIDDLE:
                {
                    _loc_5.x = param4.defaultPositioningBox.x + 0.5 * (param4.defaultPositioningBox.width - param1);
                    break;
                }
                case TextAnchor.END:
                {
                    _loc_5.x = param4.defaultPositioningBox.x + param4.defaultPositioningBox.width - param1;
                    break;
                }
                default:
                {
                    throw new Error("Unknown value \'" + param4.defaultPositioningHorizontalAlignment + "\' for print area " + param4.id);
                    break;
                }
            }
            switch(param4.defaultPositioningVerticalAlignment)
            {
                case TextAnchor.START:
                {
                    _loc_5.y = param4.defaultPositioningBox.y;
                    break;
                }
                case TextAnchor.MIDDLE:
                {
                    _loc_5.y = param4.defaultPositioningBox.y + 0.5 * (param4.defaultPositioningBox.height - param2);
                    break;
                }
                case TextAnchor.END:
                {
                    _loc_5.y = param4.defaultPositioningBox.y + param4.defaultPositioningBox.height - param2;
                    break;
                }
                default:
                {
                    throw new Error("Unknown value \'" + param4.defaultPositioningVerticalAlignment + "\' for print area " + param4.id);
                    break;
                }
            }
            return _loc_5;
        }// end function

        public static function getDefaultConfigurationPositionWithoutConflicts(param1:Number, param2:Number, param3:String, param4:IProductModel, param5:IPrintArea) : Point
        {
            var _loc_10:IConfigurationModel;
            var _loc_6:* = getDefaultConfigurationPosition(param1, param2, param3, param5);
            var _loc_7:Boolean;
            var _loc_8:int;
            var _loc_9:int;
            for each (_loc_10 in param4.configurations)
            {
                
                _loc_8 = Math.max(_loc_8, _loc_10.offset.x);
                _loc_9 = Math.max(_loc_9, _loc_10.offset.y);
                if (_loc_10.printArea == param5)
                {
                    if (_loc_10.offset.equals(_loc_6))
                    {
                        _loc_7 = true;
                    }
                }
            }
            if (_loc_7)
            {
                return new Point(_loc_8 + 10, _loc_9 + 10);
            }
            return _loc_6;
        }// end function

        public static function getDefaultConfigurationColors(param1:IConfigurationModel, param2:IProductModel) : Array
        {
            var _loc_4:uint;
            var _loc_5:Array;
            var _loc_6:uint;
            var _loc_7:Color;
            var _loc_8:int;
            var _loc_9:Color;
            var _loc_3:Array;
            if (param1.type == ConfigurationType.TEXT)
            {
                _loc_3 = new Array();
                _loc_5 = param2.getConfigurationsOnCurrentView();
                if (_loc_5.length > 0)
                {
                    _loc_4 = IConfigurationModel(_loc_5[0]).rgbColors[0];
                }
                if (!_loc_4)
                {
                    _loc_4 = param1.rgbColors[0];
                }
                _loc_6 = 0;
                while (_loc_6++ < param1.rgbColors.length)
                {
                    
                    _loc_3[_loc_6] = _loc_4;
                }
            }
            else
            {
                _loc_3 = param1.rgbColors.concat();
            }
            if (_loc_3.length == 1)
            {
                _loc_7 = Color.fromHex(ColorUtil.getIntegerColor(param2.currentAppearance.colors[0]));
                _loc_8 = -1;
                while (++_loc_8 < _loc_3.length)
                {
                    
                    _loc_9 = Color.fromHex(_loc_3[_loc_8]);
                    if (ColorUtil.isEqualShade(_loc_7, _loc_9, 10))
                    {
                        _loc_3[_loc_8] = 16777215 - _loc_3[_loc_8];
                    }
                }
            }
            return _loc_3;
        }// end function

        public static function getDefaultGeometry(param1:IConfigurationModel, param2:IPrintArea, param3:String = "") : ConfigurationGeometry
        {
            var _loc_4:* = ConfigurationSizeRules.getGeometry(param1, param2);
            switch(param3)
            {
                case ConfigurationModelConstants.ABSOLUTE_CENTER:
                {
                    _loc_4.percentX = (param2.width - param1.width) / 2 * 100 / param2.width;
                    _loc_4.percentY = (param2.height - param1.height) / 2 * 100 / param2.height;
                    break;
                }
                case ConfigurationModelConstants.HORIZONTAL_CENTER:
                {
                    _loc_4.percentX = (param2.width - param1.width) / 2 * 100 / param2.width;
                    break;
                }
                case ConfigurationModelConstants.VERTICAL_CENTER:
                {
                    _loc_4.percentY = (param2.height - param1.height) / 2 * 100 / param2.height;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_4;
        }// end function

    }
}
