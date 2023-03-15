package net.sprd.graphics.svg.transformations
{
    import flash.display.*;
    import flash.geom.*;
    import net.sprd.common.graphics.*;

    public class Rotation extends Object implements ISVGTransformation
    {
        private var _rotationPoint:Point;
        private var _angle:Number;

        public function Rotation(param1:Number = 0, param2:Number = 0, param3:Number = 0)
        {
            this._rotationPoint = new Point(param2, param3);
            this._angle = param1;
            return;
        }// end function

        public function transform(param1:DisplayObject) : DisplayObject
        {
            param1.transform.matrix = this.matrix;
            return param1;
        }// end function

        public function get angle() : Number
        {
            return this._angle;
        }// end function

        public function set angle(param1:Number) : void
        {
            this._angle = param1;
            return;
        }// end function

        public function get rotationPoint() : Point
        {
            return this._rotationPoint;
        }// end function

        public function set rotationPoint(param1:Point) : void
        {
            this._rotationPoint = param1;
            return;
        }// end function

        public function get matrix() : Matrix
        {
            return new RotationMatrix(UnitUtil.mm2pixel(this._rotationPoint.x), UnitUtil.mm2pixel(this._rotationPoint.y), UnitUtil.deg2rad(this._angle));
        }// end function

        public function clone() : ISVGTransformation
        {
            return new Rotation(this.angle, this.rotationPoint.x, this.rotationPoint.y);
        }// end function

        public function get svgAttribute() : String
        {
            return "rotate( " + this._angle + " , " + this._rotationPoint.x + " , " + this._rotationPoint.y + "  )";
        }// end function

    }
}
