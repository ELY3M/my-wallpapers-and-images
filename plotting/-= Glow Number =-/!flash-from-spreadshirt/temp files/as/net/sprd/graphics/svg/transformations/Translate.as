package net.sprd.graphics.svg.transformations
{
    import flash.display.*;
    import flash.geom.*;

    public class Translate extends Object implements ISVGTransformation
    {
        private var _tx:Number;
        private var _ty:Number;

        public function Translate(param1:Number = 0, param2:Number = 0)
        {
            this._tx = param1;
            this._ty = param2;
            return;
        }// end function

        public function transform(param1:DisplayObject) : DisplayObject
        {
            param1.transform.matrix = this.matrix;
            return param1;
        }// end function

        public function get tx() : Number
        {
            return this._tx;
        }// end function

        public function get ty() : Number
        {
            return this._ty;
        }// end function

        public function get translation() : Point
        {
            return new Point(this._tx, this._ty);
        }// end function

        public function get matrix() : Matrix
        {
            var _loc_1:* = new Matrix();
            _loc_1.translate(this._tx, this._ty);
            return _loc_1;
        }// end function

        public function get svgAttribute() : String
        {
            return "translate ( " + this._tx + ", " + this._ty + " )";
        }// end function

        public function clone() : ISVGTransformation
        {
            return new Translate(this.tx, this.ty);
        }// end function

    }
}
