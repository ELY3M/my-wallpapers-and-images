package net.sprd.graphics.svg
{
    import net.sprd.common.colors.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.graphics.svg.segments.*;
    import net.sprd.graphics.svg.transformations.*;

    public class SVGParser extends Object
    {
        static const svg:Object = http://www.w3.org/2000/svg;
        static const xlink:Object = http://www.w3.org/1999/xlink;
        private static const log:ILogger = LogContext.getLogger(this);
        private static var knownTransforms:Array = ["matrix", "translate", "scale", "rotate", "skewX", "skewY"];

        public function SVGParser()
        {
            return;
        }// end function

        public static function parse(param1:XML) : Array
        {
            var _loc_3:XML;
            var _loc_4:ISVGShape;
            var _loc_5:Array;
            var _loc_6:ISVGTransformation;
            var _loc_2:* = new Array();
            for each (_loc_3 in param1.*)
            {
                
                _loc_4 = parseNode(_loc_3);
                if (_loc_4 != null)
                {
                    _loc_5 = parseTransformations(_loc_3.@transform);
                    for each (_loc_6 in _loc_5)
                    {
                        
                        _loc_4.addTransformation(_loc_6);
                    }
                    _loc_2.push(_loc_4);
                }
            }
            return _loc_2;
        }// end function

        private static function parseNode(param1:XML) : ISVGShape
        {
            var _loc_2:ISVGShape;
            switch(param1.localName())
            {
                case "rect":
                {
                    _loc_2 = parseRect(param1);
                    break;
                }
                case "circle":
                {
                    _loc_2 = parseCircle(param1);
                    break;
                }
                case "text":
                {
                    _loc_2 = parseText(param1);
                    break;
                }
                case "image":
                {
                    _loc_2 = parseImage(param1);
                    break;
                }
                case "path":
                {
                    _loc_2 = parsePath(param1);
                    break;
                }
                default:
                {
                    log.warn("No renderer for " + param1.name());
                    break;
                }
            }
            return _loc_2;
        }// end function

        private static function parseRect(param1:XML) : ISVGShape
        {
            var _loc_2:* = param1.@width;
            var _loc_3:* = param1.@height;
            var _loc_4:* = param1.@x;
            var _loc_5:* = param1.@y;
            var _loc_6:* = new SVGRect(_loc_4, _loc_5, _loc_2, _loc_3);
            return _loc_6;
        }// end function

        private static function parseCircle(param1:XML) : ISVGShape
        {
            var _loc_2:* = param1.@cx;
            var _loc_3:* = param1.@cy;
            var _loc_4:* = param1.@r;
            return new SVGCircle(_loc_2, _loc_3, _loc_4);
        }// end function

        private static function parseImage(param1:XML) : ISVGShape
        {
            var _loc_7:Array;
            var _loc_8:String;
            var _loc_2:* = parseFloat(param1.@width);
            var _loc_3:* = parseFloat(param1.@height);
            var _loc_4:* = isNaN(parseFloat(param1.@x)) ? (0) : (parseFloat(param1.@x));
            var _loc_5:* = isNaN(parseFloat(param1.@y)) ? (0) : (parseFloat(param1.@y));
            var _loc_6:* = new SVGImage(_loc_4, _loc_5, _loc_2, _loc_3);
            _loc_6.href = param1.@href;
            _loc_6.imageId = param1.@designId;
            if (param1.hasOwnProperty("@printColorIds"))
            {
                _loc_6.printColors = param1.@printColorIds.split(" ");
            }
            if (param1.hasOwnProperty("@printColorRGBs"))
            {
                _loc_7 = param1.@printColorRGBs.split(" ");
                _loc_6.rgbColors = [];
                for each (_loc_8 in _loc_7)
                {
                    
                    if (_loc_8.length > 0)
                    {
                        _loc_6.addRGBColor(ColorUtil.getIntegerColor(_loc_8));
                    }
                }
            }
            return _loc_6;
        }// end function

        private static function parseText(param1:XML) : ISVGShape
        {
            var _loc_4:XML;
            var _loc_5:String;
            var _loc_2:* = new SVGText();
            var _loc_3:String;
            for each (_loc_4 in param1.*)
            {
                
                if (_loc_4.nodeKind() == "text")
                {
                    _loc_3 = _loc_3 + _loc_4.toString();
                    continue;
                }
                if (_loc_4.tspan)
                {
                    _loc_2.addTSpan(SVGText(parseText(_loc_4)));
                }
            }
            _loc_5 = String(param1.@fill).replace("#", "0x");
            _loc_2.text = replaceReservedXMLCharacters(_loc_3);
            _loc_2.x = param1.@x ? (parseFloat(param1.@x)) : (NaN);
            _loc_2.y = param1.@y ? (parseFloat(param1.@y)) : (NaN);
            _loc_2.width = param1.@width ? (parseFloat(param1.@width)) : (NaN);
            _loc_2.height = param1.@height ? (parseFloat(param1.@height)) : (NaN);
            _loc_2.fillColor = _loc_5 ? (parseInt(_loc_5)) : (NaN);
            _loc_2.textAnchor = param1["@text-anchor"];
            _loc_2.fontStyle = param1["@font-style"];
            _loc_2.fontSize = parseFloat(param1["@font-size"]);
            _loc_2.fontWeight = param1["@font-weight"];
            _loc_2.fontFamily = param1["@font-family"];
            _loc_2.fontFamilyID = param1.@fontFamilyId;
            _loc_2.fontID = param1.@fontId;
            _loc_2.lineWidth = param1.@lineWidth ? (parseFloat(param1.@lineWidth)) : (NaN);
            if (param1.hasOwnProperty("@printColorId"))
            {
                _loc_2.printColors = [param1.@printColorId];
            }
            if (_loc_2.fillColor != NaN)
            {
                _loc_2.rgbColors = [_loc_2.fillColor];
            }
            return _loc_2;
        }// end function

        private static function replaceReservedXMLCharacters(param1:String) : String
        {
            if (param1)
            {
                param1 = param1.replace("&amp;", "&");
                param1 = param1.replace("&quot;", "\"");
                param1 = param1.replace("&lt;", "<");
                param1 = param1.replace("&gt;", ">");
                return param1;
            }
            return param1;
        }// end function

        private static function parsePath(param1:XML) : ISVGShape
        {
            var _loc_7:IPathSegment;
            var _loc_8:String;
            var _loc_9:IPathSegment;
            var _loc_10:uint;
            var _loc_11:Array;
            var _loc_12:uint;
            var _loc_13:uint;
            var _loc_14:uint;
            var _loc_2:* = new SVGPath();
            var _loc_3:* = param1.@d;
            _loc_3 = _loc_3.replace(/,/g, " ");
            var _loc_4:Array;
            var _loc_5:* = new RegExp("[A-Za-z][ 0-9,\\., \\-]*", "gi");
            var _loc_6:* = _loc_3.match(_loc_5);
            for each (_loc_8 in _loc_6)
            {
                
                _loc_10 = 0;
                _loc_11 = _loc_8.substring(1, _loc_8.length - 1).split(" ");
                switch(_loc_8.charAt(0))
                {
                    case "M":
                    {
                        _loc_12 = Math.floor(_loc_11.length / 2);
                        _loc_10 = 0;
                        while (_loc_10++ < _loc_12)
                        {
                            
                            _loc_9 = new MoveTo(parseFloat(_loc_11[2 * _loc_10]), parseFloat(_loc_11[2 * _loc_10 + 1]));
                            _loc_9.isRelative = false;
                            _loc_2.addSegment(_loc_9);
                        }
                        _loc_7 = _loc_9;
                        break;
                    }
                    case "L":
                    {
                        _loc_13 = Math.floor(_loc_11.length / 2);
                        _loc_10 = 0;
                        while (_loc_10++ < _loc_13)
                        {
                            
                            _loc_9 = new LineTo(parseFloat(_loc_11[2 * _loc_10]), parseFloat(_loc_11[2 * _loc_10 + 1]));
                            _loc_9.isRelative = false;
                            _loc_2.addSegment(_loc_9);
                        }
                        break;
                    }
                    case "Q":
                    {
                        _loc_14 = Math.floor(_loc_11.length / 4);
                        _loc_10 = 0;
                        while (_loc_10++ < _loc_14)
                        {
                            
                            _loc_9 = new QuadraticBezier(parseFloat(_loc_11[4 * _loc_10]), parseFloat(_loc_11[4 * _loc_10 + 1]), parseFloat(_loc_11[4 * _loc_10 + 2]), parseFloat(_loc_11[4 * _loc_10 + 3]));
                            _loc_9.isRelative = false;
                            _loc_2.addSegment(_loc_9);
                        }
                        break;
                    }
                    case "C":
                    {
                        _loc_14 = Math.floor(_loc_11.length / 6);
                        _loc_10 = 0;
                        while (_loc_10++ < _loc_14)
                        {
                            
                            _loc_9 = new LineTo(parseFloat(_loc_11[4 * _loc_10 + 4]), parseFloat(_loc_11[4 * _loc_10 + 5]));
                            _loc_9.isRelative = false;
                            _loc_2.addSegment(_loc_9);
                        }
                        break;
                    }
                    case "Z":
                    {
                        _loc_9 = new Close();
                        _loc_2.addSegment(_loc_9);
                        break;
                    }
                    default:
                    {
                        log.warn("Path segment not supported: " + _loc_8);
                        break;
                    }
                }
            }
            return _loc_2;
        }// end function

        public static function parseTransformations(param1:String) : Array
        {
            var _loc_5:String;
            var _loc_6:RegExp;
            var _loc_7:RegExp;
            var _loc_8:String;
            var _loc_9:Array;
            var _loc_10:ISVGTransformation;
            if (param1)
            {
            }
            if (param1.length == 0)
            {
                return [];
            }
            var _loc_2:* = new Array();
            var _loc_3:* = new RegExp("(" + knownTransforms.join("|") + ")[( \\d,.-]*\\)", "g");
            var _loc_4:* = param1.match(_loc_3);
            for each (_loc_5 in _loc_4)
            {
                
                _loc_6 = /[-\d.]+/gi;
                _loc_7 = new RegExp(knownTransforms.join("|"));
                _loc_8 = _loc_7.exec(_loc_5);
                _loc_9 = _loc_5.match(_loc_6);
                switch(_loc_8)
                {
                    case "rotate":
                    {
                        _loc_10 = new Rotation(_loc_9[0], _loc_9[1], _loc_9[2]);
                        break;
                    }
                    case "scale":
                    {
                        _loc_10 = new Scale(parseFloat(_loc_9[0]), parseFloat(_loc_9[1]));
                        break;
                    }
                    case "translate":
                    {
                        _loc_10 = new Translate(_loc_9[0], _loc_9[1]);
                        break;
                    }
                    default:
                    {
                        log.warn("Transformation \'" + _loc_8 + "\' not supported.");
                        break;
                    }
                }
                if (_loc_10 != null)
                {
                    _loc_2.push(_loc_10);
                }
                _loc_10 = null;
            }
            return _loc_2;
        }// end function

    }
}
