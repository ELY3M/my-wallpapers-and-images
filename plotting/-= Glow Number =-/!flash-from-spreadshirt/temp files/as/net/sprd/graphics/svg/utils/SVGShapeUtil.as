package net.sprd.graphics.svg.utils
{
    import __AS3__.vec.*;
    import flash.display.*;
    import net.sprd.graphics.svg.*;
    import net.sprd.graphics.svg.segments.*;

    public class SVGShapeUtil extends Object
    {

        public function SVGShapeUtil()
        {
            return;
        }// end function

        public static function toGraphicsData(param1:ISVGShape, param2:Number = 1) : Vector.<IGraphicsData>
        {
            var _loc_8:IPathSegment;
            var _loc_3:* = new GraphicsPath();
            var _loc_4:* = new Vector.<IGraphicsData>;
            var _loc_5:* = toSVGPath(param1);
            _loc_4.push(_loc_3);
            var _loc_6:int;
            var _loc_7:int;
            while (_loc_7++ < _loc_5.segments.length)
            {
                
                _loc_8 = _loc_5.segments[_loc_7];
                switch(_loc_8.type)
                {
                    case PathSegment.MOVETO:
                    {
                        _loc_3.moveTo(_loc_8.endPoint.x * param2, _loc_8.endPoint.y * param2);
                        break;
                    }
                    case PathSegment.LINETO:
                    {
                        _loc_3.lineTo(_loc_8.endPoint.x * param2, _loc_8.endPoint.y * param2);
                        break;
                    }
                    case PathSegment.CURVETO_QUADRATIC:
                    {
                        _loc_3.curveTo(QuadraticBezier(_loc_8).control.x * param2, QuadraticBezier(_loc_8).control.y * param2, _loc_8.endPoint.x * param2, _loc_8.endPoint.y * param2);
                        break;
                    }
                    case PathSegment.CLOSE:
                    {
                        _loc_3.lineTo(_loc_5.segments[_loc_6].endPoint.x * param2, _loc_5.segments[_loc_6].endPoint.y * param2);
                        _loc_3 = new GraphicsPath();
                        _loc_4.push(_loc_3);
                        _loc_6 = _loc_7 + 1;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return _loc_4;
        }// end function

        public static function toSVGPath(param1:ISVGShape) : SVGPath
        {
            if (param1 is SVGPath)
            {
                return SVGPath(param1);
            }
            if (param1 is SVGRect)
            {
                return convertRect(SVGRect(param1));
            }
            if (param1 is SVGLine)
            {
                return convertLine(SVGLine(param1));
            }
            throw new Error("No known transformation possible for " + param1);
        }// end function

        private static function convertRect(param1:SVGRect) : SVGPath
        {
            var _loc_2:IPathSegment;
            var _loc_3:* = new SVGPath();
            _loc_2 = new MoveTo(param1.x, param1.y);
            _loc_3.addSegment(_loc_2);
            _loc_2 = new LineTo(param1.x + param1.width, param1.y);
            _loc_3.addSegment(_loc_2);
            _loc_2 = new LineTo(param1.x + param1.width, param1.y + param1.height);
            _loc_3.addSegment(_loc_2);
            _loc_2 = new LineTo(param1.x, param1.y + param1.height);
            _loc_3.addSegment(_loc_2);
            _loc_3.addSegment(new Close());
            return _loc_3;
        }// end function

        private static function convertLine(param1:SVGLine) : SVGPath
        {
            var _loc_2:IPathSegment;
            var _loc_3:* = new SVGPath();
            _loc_2 = new MoveTo(param1.start.x, param1.start.y);
            _loc_3.addSegment(_loc_2);
            _loc_2 = new LineTo(param1.end.x, param1.end.y);
            _loc_3.addSegment(_loc_2);
            return _loc_3;
        }// end function

    }
}
