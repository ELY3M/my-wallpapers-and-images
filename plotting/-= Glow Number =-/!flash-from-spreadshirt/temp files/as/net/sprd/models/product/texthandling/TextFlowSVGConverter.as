package net.sprd.models.product.texthandling
{
    import flash.display.*;
    import flash.text.engine.*;
    import flashx.textLayout.edit.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;
    import mx.utils.*;
    import net.sprd.api.*;
    import net.sprd.common.colors.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.entities.*;
    import net.sprd.graphics.svg.*;
    import net.sprd.graphics.svg.transformations.*;
    import net.sprd.models.product.rules.*;
    import net.sprd.text.*;

    public class TextFlowSVGConverter extends Object
    {
        private static const log:ILogger = LogContext.getLogger(this);
        private static var fm:FontManager = FontManager.getInstance();

        public function TextFlowSVGConverter()
        {
            return;
        }// end function

        public static function widthFromSVG(param1:SVGText) : Number
        {
            var _loc_2:ISVGTransformation;
            var _loc_3:SVGText;
            if (param1.tspans.length > 0)
            {
            }
            if (!isNaN(param1.tspans[0].lineWidth))
            {
                return param1.tspans[0].lineWidth;
            }
            for each (_loc_2 in param1.transformations)
            {
                
                if (_loc_2 is Rotation)
                {
                    if (Rotation(_loc_2).rotationPoint.x > 0)
                    {
                        return Rotation(_loc_2).rotationPoint.x * 2;
                    }
                }
            }
            for each (_loc_3 in param1.tspans)
            {
                
                if (_loc_3.textAnchor)
                {
                    if (_loc_3.textAnchor == TextAnchor.MIDDLE)
                    {
                    }
                    if (!isNaN(_loc_3.x))
                    {
                    }
                    if (_loc_3.x != 0)
                    {
                        return _loc_3.x * 2;
                    }
                    if (_loc_3.textAnchor == TextAnchor.END)
                    {
                    }
                    if (!isNaN(_loc_3.x))
                    {
                    }
                    if (_loc_3.x != 0)
                    {
                        return _loc_3.x;
                    }
                }
            }
            return param1.width;
        }// end function

        public static function convertFromSVG(param1:SVGText) : TextFlow
        {
            var _loc_5:ParagraphElement;
            var _loc_6:SVGText;
            var _loc_2:* = new Configuration();
            _loc_2.focusedSelectionFormat = new SelectionFormat();
            var _loc_7:* = new SelectionFormat(16777215, 1, BlendMode.DIFFERENCE, 16777215, 0);
            _loc_2.inactiveSelectionFormat = new SelectionFormat(16777215, 1, BlendMode.DIFFERENCE, 16777215, 0);
            _loc_2.unfocusedSelectionFormat = _loc_7;
            var _loc_3:* = new TextFlow(_loc_2);
            _loc_3.fontLookup = FontLookup.EMBEDDED_CFF;
            addAttributesToFlowElement(_loc_3, param1);
            var _loc_4:* = int.MIN_VALUE;
            if (param1.tspans.length > 0)
            {
                for each (_loc_6 in param1.tspans)
                {
                    
                    if (_loc_5)
                    {
                        if (_loc_6.y)
                        {
                        }
                    }
                    if (_loc_6.y != _loc_4)
                    {
                        _loc_4 = _loc_6.y;
                        _loc_5 = addParagraph(_loc_3, _loc_6);
                        continue;
                    }
                    addSpan(_loc_5, _loc_6);
                }
            }
            else
            {
                addParagraph(_loc_3, param1);
            }
            return _loc_3;
        }// end function

        public static function convertToSVG(param1:TextFlow, param2:IPrintType, param3:Number, param4:Number) : SVGText
        {
            var _loc_8:ParagraphElement;
            var _loc_9:int;
            var _loc_10:TextFlowLine;
            var _loc_11:SVGText;
            var _loc_12:Boolean;
            var _loc_13:int;
            var _loc_14:SpanElement;
            var _loc_15:int;
            var _loc_16:Number;
            var _loc_17:String;
            var _loc_18:SVGText;
            var _loc_5:* = param1.flowComposer;
            var _loc_6:* = new SVGText();
            _loc_6.width = param3;
            _loc_6.height = param4;
            var _loc_7:int;
            while (_loc_7++ < param1.numChildren)
            {
                
                _loc_8 = ParagraphElement(param1.getChildAt(_loc_7));
                _loc_9 = _loc_8.getAbsoluteStart();
                _loc_10 = _loc_5.findLineAtPosition(_loc_9);
                _loc_11 = new SVGText(_loc_10.x, _loc_10.y + _loc_10.ascent, null);
                _loc_12 = true;
                addAttributesToSVGText(_loc_11, _loc_8, param3, param2, true);
                _loc_6.addTSpan(_loc_11);
                _loc_13 = 0;
                while (_loc_13++ < _loc_8.numChildren)
                {
                    
                    _loc_14 = SpanElement(_loc_8.getChildAt(_loc_13));
                    _loc_15 = 0;
                    while (_loc_15 < _loc_14.textLength)
                    {
                        
                        if (_loc_14.getAbsoluteStart() + _loc_15 >= _loc_10.absoluteStart + _loc_10.textLength)
                        {
                            _loc_10 = _loc_5.findLineAtPosition(_loc_14.getAbsoluteStart() + _loc_15);
                            _loc_11 = new SVGText(_loc_10.x, _loc_10.y + _loc_10.ascent, null);
                            addAttributesToSVGText(_loc_11, _loc_8, param3, param2, true);
                            _loc_6.addTSpan(_loc_11);
                            _loc_12 = true;
                        }
                        _loc_16 = Math.min(_loc_10.absoluteStart + _loc_10.textLength - _loc_14.getAbsoluteStart(), _loc_14.textLength);
                        _loc_17 = _loc_14.text.substr(_loc_15, _loc_16 - _loc_15);
                        if (_loc_12)
                        {
                            addAttributesToSVGText(_loc_11, _loc_14, param3, param2, false);
                            _loc_11.text = _loc_17;
                            _loc_12 = false;
                        }
                        else
                        {
                            _loc_18 = new SVGText(NaN, NaN, _loc_17);
                            _loc_6.addTSpan(_loc_18);
                            addAttributesToSVGText(_loc_18, _loc_14, param3, param2, false);
                        }
                        _loc_15 = _loc_16;
                    }
                }
            }
            stripEmptySpaces(_loc_6);
            return _loc_6;
        }// end function

        public static function trimRight(param1:String) : String
        {
            if (param1 == null)
            {
                return "";
            }
            var _loc_2:* = param1.length - 1;
            while (StringUtil.isWhitespace(param1.charAt(_loc_2--)))
            {
                
            }
            if (_loc_2 >= 0)
            {
                return param1.slice(0, _loc_2 + 1);
            }
            return "";
        }// end function

        private static function stripEmptySpaces(param1:SVGText) : void
        {
            var _loc_4:SVGText;
            var _loc_2:Boolean;
            var _loc_3:* = param1.tspans.length - 1;
            while (_loc_3-- >= 0)
            {
                
                _loc_4 = param1.tspans[_loc_3];
                if (_loc_2)
                {
                    _loc_4.text = trimRight(_loc_4.text);
                    if (_loc_4.text.length == 0)
                    {
                    }
                    if (isNaN(_loc_4.x))
                    {
                        param1.tspans.splice(_loc_3, 1);
                    }
                    else
                    {
                        _loc_2 = false;
                    }
                }
                if (!isNaN(_loc_4.x))
                {
                    _loc_2 = true;
                }
            }
            return;
        }// end function

        private static function addAttributesToSVGText(param1:SVGText, param2:FlowElement, param3:Number, param4:IPrintType, param5:Boolean) : void
        {
            var _loc_9:IFontStyle;
            var _loc_6:* = param2.computedFormat;
            var _loc_7:* = fm.getFontFamilyFromEmbbededName(_loc_6.fontFamily);
            param1.fontSize = _loc_6.fontSize;
            param1.fillColor = _loc_6.color;
            var _loc_8:* = PrintTypeRules.getPrintColorForRGBColor(param4, Color.fromHex(ColorUtil.getIntegerColor(_loc_6.color)));
            if (_loc_8)
            {
                param1.addPrintColor(_loc_8.id);
            }
            if (_loc_7)
            {
                param1.fontFamilyID = _loc_7.id;
                _loc_9 = fm.getFontStyle(_loc_7.id, _loc_6.fontWeight == FontWeight.BOLD, _loc_6.fontStyle == FontPosture.ITALIC);
                if (_loc_9)
                {
                    param1.fontFamily = _loc_9.name;
                    param1.fontID = _loc_9.id;
                    param1.fontWeight = _loc_9.weight;
                    param1.fontStyle = _loc_9.style;
                }
            }
            if (param5)
            {
                switch(param2.textAlign)
                {
                    case TextAlign.LEFT:
                    {
                        param1.textAnchor = TextAnchor.START;
                        param1.x = 0;
                        break;
                    }
                    case TextAlign.CENTER:
                    {
                        param1.textAnchor = TextAnchor.MIDDLE;
                        param1.x = param3 / 2;
                        break;
                    }
                    case TextAlign.RIGHT:
                    {
                        param1.textAnchor = TextAnchor.END;
                        param1.x = param3;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                param1.lineWidth = param3;
            }
            return;
        }// end function

        private static function addParagraph(param1:TextFlow, param2:SVGText) : ParagraphElement
        {
            var _loc_4:int;
            var _loc_5:SVGText;
            var _loc_3:* = new ParagraphElement();
            param1.addChild(_loc_3);
            addAttributesToFlowElement(_loc_3, param2);
            if (param2.text)
            {
                addSpan(_loc_3, param2);
            }
            else
            {
                _loc_4 = 0;
                while (_loc_4++ < param2.tspans.length)
                {
                    
                    _loc_5 = param2.tspans[_loc_4];
                    addSpan(_loc_3, _loc_5);
                }
            }
            return _loc_3;
        }// end function

        private static function addSpan(param1:ParagraphElement, param2:SVGText) : void
        {
            var _loc_3:* = new SpanElement();
            _loc_3.text = param2.text;
            addAttributesToFlowElement(_loc_3, param2);
            param1.addChild(_loc_3);
            return;
        }// end function

        private static function addAttributesToFlowElement(param1:FlowElement, param2:SVGText) : void
        {
            var _loc_3:IFontFamily;
            var _loc_4:IBaseEntity;
            if (param2.fontSize)
            {
                param1.fontSize = param2.fontSize;
            }
            if (!param2.fontFamilyID)
            {
                param2.fontFamilyID = "5";
            }
            if (param2.fontFamilyID)
            {
                _loc_3 = API.em.get(param2.fontFamilyID, APIRegistry.FONT_FAMILY) as IFontFamily;
                if (!_loc_3)
                {
                    log.warn("Font family not loaded: " + param2.fontFamilyID);
                }
                else
                {
                    param1.fontFamily = _loc_3.getEmbeddedFontName();
                }
            }
            if (param2.fontStyle)
            {
                param1.fontStyle = param2.fontStyle;
            }
            if (param2.fontWeight)
            {
                param1.fontWeight = param2.fontWeight;
            }
            if (param2.printColors.length > 0)
            {
                _loc_4 = API.em.get(param2.printColors[0], APIRegistry.PRINT_COLOR);
                if (_loc_4)
                {
                    param1.color = ColorUtil.getIntegerColor(IPrintColor(_loc_4).hexCode);
                }
                else
                {
                    param1.color = param2.fillColor;
                }
            }
            else if (!isNaN(param2.fillColor))
            {
                param1.color = param2.fillColor;
            }
            if (param2.textAnchor)
            {
                switch(param2.textAnchor)
                {
                    case TextAnchor.START:
                    {
                        param1.textAlign = TextAlign.LEFT;
                        break;
                    }
                    case TextAnchor.MIDDLE:
                    {
                        param1.textAlign = TextAlign.CENTER;
                        break;
                    }
                    case TextAnchor.END:
                    {
                        param1.textAlign = TextAlign.RIGHT;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

    }
}
