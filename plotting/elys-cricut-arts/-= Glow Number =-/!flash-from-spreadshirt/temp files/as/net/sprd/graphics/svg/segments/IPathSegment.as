package net.sprd.graphics.svg.segments
{
    import flash.display.*;
    import flash.geom.*;

    public interface IPathSegment
    {

        public function IPathSegment();

        function draw(param1:Graphics) : void;

        function get type() : String;

        function get isRelative() : Boolean;

        function set isRelative(param1:Boolean) : void;

        function get startPoint() : Point;

        function set startPoint(param1:Point) : void;

        function get endPoint() : Point;

        function get svgString() : String;

        function clone(param1:IPathSegment = null) : IPathSegment;

    }
}
