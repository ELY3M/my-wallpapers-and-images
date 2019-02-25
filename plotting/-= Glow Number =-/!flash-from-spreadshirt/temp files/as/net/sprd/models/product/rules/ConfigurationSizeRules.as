package net.sprd.models.product.rules
{
    import flash.geom.*;
    import flash.text.engine.*;
    import flashx.textLayout.edit.*;
    import flashx.textLayout.elements.*;
    import net.sprd.common.graphics.*;
    import net.sprd.entities.*;
    import net.sprd.models.common.*;
    import net.sprd.models.product.*;
    import net.sprd.models.product.texthandling.*;
    import net.sprd.text.*;

    public class ConfigurationSizeRules extends Object
    {

        public function ConfigurationSizeRules()
        {
            return;
        }// end function

        public static function maximumDesignBounds(param1:IDesign, param2:IPrintType) : Rectangle
        {
            var _loc_5:Number;
            var _loc_3:* = new Rectangle(0, 0, param1.width, param1.height);
            if (!isBitmapDesign(param1))
            {
                _loc_5 = Math.min(int.MAX_VALUE / _loc_3.width, int.MAX_VALUE / _loc_3.height);
                _loc_3.width = _loc_3.width * _loc_5;
                _loc_3.height = _loc_3.height * _loc_5;
            }
            else
            {
                _loc_3 = metricBounds(param1, param2);
            }
            var _loc_4:* = new Rectangle(0, 0, param2.net.sprd.entities:IPrintType::width, param2.net.sprd.entities:IPrintType::height);
            _loc_3 = BoundsUtil.trimBoundsProportionally(_loc_3, _loc_4);
            return _loc_3;
        }// end function

        public static function minimumDesignBounds(param1:IDesign, param2:IPrintType) : Rectangle
        {
            var _loc_4:Number;
            var _loc_3:* = new Rectangle(0, 0, param1.width, param1.height);
            if (param2.colorSpace != ColorSpace.CMYK)
            {
            }
            if (param2.colorSpace == ColorSpace.RGB)
            {
                _loc_4 = Math.min(5 / _loc_3.width, 5 / _loc_3.height);
                _loc_3.width = _loc_3.width * _loc_4;
                _loc_3.height = _loc_3.height * _loc_4;
            }
            if (param2.colorSpace == ColorSpace.PRINTCOLORS)
            {
            }
            if (param1.minScale < 100)
            {
                _loc_3.width = param1.width * (param1.minScale / 100);
                _loc_3.height = param1.height * (param1.minScale / 100);
            }
            return _loc_3;
        }// end function

        public static function minimumTextBounds(param1:TextFlow, param2:IPrintType) : Rectangle
        {
            var _loc_8:ParagraphElement;
            var _loc_9:uint;
            var _loc_10:SpanElement;
            var _loc_11:ITextLayoutFormat;
            var _loc_12:IFontFamily;
            var _loc_13:Boolean;
            var _loc_14:Boolean;
            var _loc_15:IFontStyle;
            var _loc_16:Number;
            var _loc_3:* = param1.flowComposer.getControllerAt(0);
            if (!_loc_3)
            {
                return new Rectangle(0, 0, 5, 5);
            }
            if (param2.colorSpace != ColorSpace.CMYK)
            {
            }
            if (param2.colorSpace == ColorSpace.RGB)
            {
                return new Rectangle(0, 0, 5, 5);
            }
            var _loc_4:* = new Rectangle(0, 0, _loc_3.compositionWidth, _loc_3.compositionHeight);
            var _loc_5:* = int.MAX_VALUE;
            var _loc_6:* = FontManager.getInstance();
            var _loc_7:uint;
            while (_loc_7++ < param1.numChildren)
            {
                
                _loc_8 = ParagraphElement(param1.getChildAt(_loc_7));
                _loc_9 = 0;
                while (_loc_9++ < _loc_8.numChildren)
                {
                    
                    _loc_10 = SpanElement(_loc_8.getChildAt(_loc_9));
                    _loc_11 = _loc_10.computedFormat;
                    _loc_12 = _loc_6.getFontFamilyFromEmbbededName(_loc_11.fontFamily);
                    if (!_loc_12)
                    {
                        return null;
                    }
                    _loc_13 = _loc_11.fontWeight == FontWeight.BOLD;
                    _loc_14 = _loc_11.fontStyle == FontPosture.ITALIC;
                    _loc_15 = _loc_6.getFontStyle(_loc_12.id, _loc_13, _loc_14);
                    if (!_loc_15)
                    {
                        continue;
                    }
                    _loc_5 = Math.min(_loc_5, _loc_15.minSize / _loc_11.fontSize);
                }
            }
            if (_loc_4.width > _loc_4.height)
            {
                _loc_16 = _loc_4.height / _loc_4.width;
                _loc_4.width = _loc_4.width * _loc_5;
                _loc_4.height = _loc_4.width * _loc_16;
            }
            else
            {
                _loc_16 = _loc_4.width / _loc_4.height;
                _loc_4.height = _loc_4.height * _loc_5;
                _loc_4.width = _loc_4.height * _loc_16;
            }
            return _loc_4;
        }// end function

        public static function maximumTextBounds(param1:TextFlow, param2:IPrintType) : Rectangle
        {
            return new Rectangle(0, 0, param2.width, param2.height);
        }// end function

        public static function maximumConfigurationBounds(param1:IConfigurationModel, param2:IPrintType) : Rectangle
        {
            var _loc_3:Rectangle;
            if (param1.type == ConfigurationType.DESIGN)
            {
                _loc_3 = maximumDesignBounds(param1.design, param2);
            }
            else
            {
                _loc_3 = maximumTextBounds(param1.textFlow, param2);
            }
            return _loc_3;
        }// end function

        public static function minimumConfigurationBounds(param1:IConfigurationModel, param2:IPrintType) : Rectangle
        {
            var _loc_3:Rectangle;
            if (param1.type == ConfigurationType.DESIGN)
            {
                _loc_3 = minimumDesignBounds(param1.design, param2);
            }
            else
            {
                _loc_3 = minimumTextBounds(param1.textFlow, param2);
            }
            return _loc_3;
        }// end function

        public static function calculateMinimumFontSize(param1:IConfigurationModel) : Number
        {
            var _loc_3:SelectionState;
            var _loc_2:Number;
            if (param1.type != ConfigurationType.TEXT)
            {
                return null;
            }
            if (param1.printType.colorSpace == ColorSpace.PRINTCOLORS)
            {
                _loc_3 = new SelectionState(param1.textFlow, 0, param1.textFlow.textLength);
                _loc_2 = TextFlowUtil.computeEffectiveMinimumFontSize(param1.textFlow, _loc_3, 0);
            }
            else
            {
                _loc_2 = 5;
            }
            return _loc_2;
        }// end function

        public static function calculateMaximumFontSize(param1:IConfigurationModel) : Number
        {
            return Math.min(UnitUtil.pt2mm(240), param1.printType.height);
        }// end function

        public static function metricBounds(param1:IDesign, param2:IPrintType) : Rectangle
        {
            var _loc_3:* = new Rectangle(0, 0, param1.width, param1.height);
            if (param2.colorSpace != ColorSpace.PRINTCOLORS)
            {
            }
            if (isBitmapDesign(param1))
            {
                _loc_3.width = UnitUtil.inch2mm(param1.width / param2.resolution);
                _loc_3.height = UnitUtil.inch2mm(param1.height / param2.resolution);
            }
            return _loc_3;
        }// end function

        public static function isBitmapDesign(param1:IDesign) : Boolean
        {
            return param1.colors.length == 0;
        }// end function

        public static function getGeometry(param1:IConfigurationModel, param2:IPrintArea) : ConfigurationGeometry
        {
            var _loc_3:* = new ConfigurationGeometry();
            var _loc_4:* = new Rectangle(param1.offset.x, param1.offset.y, param1.width, param1.height);
            _loc_4 = GeometryUtil.getBounds(_loc_4, GeometryUtil.rotationMatrix(param1.width / 2, param1.height / 2, UnitUtil.deg2rad(param1.rotation)));
            _loc_3.percentX = param1.offset.x * 100 / param2.net.sprd.entities:IPrintArea::width;
            _loc_3.percentY = param1.offset.y * 100 / param2.net.sprd.entities:IPrintArea::height;
            _loc_3.ratioWidth = _loc_4.width / param2.net.sprd.entities:IPrintArea::width;
            _loc_3.ratioHeight = _loc_4.height / param2.net.sprd.entities:IPrintArea::height;
            _loc_3.untransformedWidth = param1.width;
            _loc_3.untransformedHeight = param1.height;
            _loc_3.rotation = param1.rotation;
            return _loc_3;
        }// end function

        public static function getConfigurationBounds(param1:IPrintArea, param2:ConfigurationGeometry) : Rectangle
        {
            var _loc_5:Rectangle;
            var _loc_6:Number;
            var _loc_7:Rectangle;
            var _loc_8:Matrix;
            var _loc_9:Point;
            var _loc_3:* = new Rectangle();
            _loc_3.width = param2.ratioWidth * param1.net.sprd.entities:IPrintArea::width;
            _loc_3.height = _loc_3.width * (param2.untransformedHeight / param2.untransformedWidth);
            _loc_3.x = param1.net.sprd.entities:IPrintArea::width * param2.percentX / 100;
            _loc_3.y = param1.net.sprd.entities:IPrintArea::height * param2.percentY / 100;
            var _loc_4:* = param2.ratioHeight * param1.net.sprd.entities:IPrintArea::height;
            if (param2.rotation > 0)
            {
                _loc_5 = new Rectangle(0, 0, param2.untransformedWidth, param2.untransformedHeight);
                _loc_5 = GeometryUtil.getBounds(_loc_5, GeometryUtil.rotationMatrix(param2.untransformedWidth / 2, param2.untransformedHeight / 2, UnitUtil.deg2rad(param2.rotation)));
                _loc_6 = _loc_5.width / _loc_3.width;
                _loc_7 = new Rectangle();
                _loc_7.width = param2.untransformedWidth / _loc_6;
                _loc_7.height = param2.untransformedHeight / _loc_6;
                _loc_8 = new Matrix();
                _loc_8.scale(1, 1);
                _loc_9 = _loc_8.transformPoint(new Point(_loc_3.x, _loc_3.y));
                _loc_7.x = _loc_9.x;
                _loc_7.y = _loc_9.y;
                _loc_3 = _loc_7.clone();
            }
            return _loc_3;
        }// end function

    }
}
