package net.sprd.graphics.svg.transformations
{
    import flash.display.*;
    import flash.geom.*;

    public interface ISVGTransformation
    {

        public function ISVGTransformation();

        function transform(param1:DisplayObject) : DisplayObject;

        function get matrix() : Matrix;

        function get svgAttribute() : String;

        function clone() : ISVGTransformation;

    }
}
