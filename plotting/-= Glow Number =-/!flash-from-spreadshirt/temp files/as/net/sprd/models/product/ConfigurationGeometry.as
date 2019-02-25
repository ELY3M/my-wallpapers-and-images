package net.sprd.models.product
{

    public class ConfigurationGeometry extends Object
    {
        private var _percentX:Number;
        private var _percentY:Number;
        private var _ratioWidth:Number;
        private var _ratioHeight:Number;
        private var _rawWidth:Number;
        private var _rawHeight:Number;
        private var _rotation:Number;

        public function ConfigurationGeometry()
        {
            return;
        }// end function

        public function get percentY() : Number
        {
            return this._percentY;
        }// end function

        public function set percentY(param1:Number) : void
        {
            this._percentY = param1;
            return;
        }// end function

        public function get percentX() : Number
        {
            return this._percentX;
        }// end function

        public function set percentX(param1:Number) : void
        {
            this._percentX = param1;
            return;
        }// end function

        public function get ratioHeight() : Number
        {
            return this._ratioHeight;
        }// end function

        public function set ratioHeight(param1:Number) : void
        {
            this._ratioHeight = param1;
            return;
        }// end function

        public function get ratioWidth() : Number
        {
            return this._ratioWidth;
        }// end function

        public function set ratioWidth(param1:Number) : void
        {
            this._ratioWidth = param1;
            return;
        }// end function

        public function get untransformedWidth() : Number
        {
            return this._rawWidth;
        }// end function

        public function set untransformedWidth(param1:Number) : void
        {
            this._rawWidth = param1;
            return;
        }// end function

        public function get untransformedHeight() : Number
        {
            return this._rawHeight;
        }// end function

        public function set untransformedHeight(param1:Number) : void
        {
            this._rawHeight = param1;
            return;
        }// end function

        public function get rotation() : Number
        {
            return this._rotation;
        }// end function

        public function set rotation(param1:Number) : void
        {
            this._rotation = param1;
            return;
        }// end function

    }
}
