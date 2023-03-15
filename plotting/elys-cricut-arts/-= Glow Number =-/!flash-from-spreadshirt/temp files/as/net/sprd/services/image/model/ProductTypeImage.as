package net.sprd.services.image.model
{

    public class ProductTypeImage extends CachedImage
    {
        private var _productTypeId:String;
        private var _viewId:String;
        private var _appearanceId:String;

        public function ProductTypeImage(param1:String, param2:String, param3:String)
        {
            this._productTypeId = param1;
            this._viewId = param2;
            this._appearanceId = param3;
            return;
        }// end function

        public function get productTypeId() : String
        {
            return this._productTypeId;
        }// end function

        public function get viewId() : String
        {
            return this._viewId;
        }// end function

        public function get appearanceId() : String
        {
            return this._appearanceId;
        }// end function

    }
}
