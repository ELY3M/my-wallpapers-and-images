package net.sprd.graphics.svg.transformations
{
    import flash.display.*;
    import flash.geom.*;

    public class Scale extends Object implements ISVGTransformation
    {
        private var _sx:Number;
        private var _sy:Number;

        public function Scale(param1:Number = 0, param2:Number = 0)
        {
            this._sx = param1;
            this._sy = param2;
            return;
        }// end function

        public function get sx() : Number
        {
            return this._sx;
        }// end function

        public function get sy() : Number
        {
            return this._sy;
        }// end function

        public function transform(param1:DisplayObject) : DisplayObject
        {
            param1.transform.matrix = this.matrix;
            return param1;
        }// end function

        public function get matrix() : Matrix
        {
            var _loc_1:* = new Matrix();
            _loc_1.scale(this._sx, this._sy);
            return _loc_1;
        }// end function

        public function get svgAttribute() : String
        {
            return "scale( " + this._sx + " , " + this._sy + "  )";
        }// end function

        public function clone() : ISVGTransformation
        {
            return new Scale(this.sx, this.sy);
        }// end function

    }
}
