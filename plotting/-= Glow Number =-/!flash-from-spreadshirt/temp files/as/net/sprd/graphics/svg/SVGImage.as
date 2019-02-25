package net.sprd.graphics.svg
{

    public class SVGImage extends SVGShape
    {
        private var _imageId:String;
        private var _href:String;

        public function SVGImage(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0)
        {
            this.x = param1;
            this.y = param2;
            this.width = param3;
            this.height = param4;
            return;
        }// end function

        public function get href() : String
        {
            return this._href;
        }// end function

        public function set href(param1:String) : void
        {
            if (this._href == param1)
            {
                return;
            }
            this._href = param1;
            markModified();
            return;
        }// end function

        public function get imageId() : String
        {
            return this._imageId;
        }// end function

        public function set imageId(param1:String) : void
        {
            if (this._imageId == param1)
            {
                return;
            }
            this._imageId = param1;
            markModified();
            return;
        }// end function

        override public function clone(param1:ISVGShape = null) : ISVGShape
        {
            var _loc_2:* = param1 ? (SVGImage(param1)) : (new SVGImage());
            super.clone(_loc_2);
            _loc_2.imageId = this.imageId;
            _loc_2.href = this.href;
            return _loc_2;
        }// end function

        override public function equals(param1:ISVGShape) : Boolean
        {
            if (!param1 is SVGImage)
            {
                return false;
            }
            var _loc_2:* = SVGImage(param1);
            if (super.equals(param1))
            {
                super.equals(param1);
            }
            if (this.imageId == _loc_2.imageId)
            {
            }
            return this.href == _loc_2.href;
        }// end function

    }
}
