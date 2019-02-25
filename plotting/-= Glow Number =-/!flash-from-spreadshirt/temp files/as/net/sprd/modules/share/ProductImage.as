package net.sprd.modules.share
{
    import net.sprd.services.image.model.*;

    public class ProductImage extends CachedImage
    {
        private var _productId:String;
        private var _viewId:String;

        public function ProductImage(param1:String, param2:String)
        {
            this.smoothBitmapContent = true;
            this._productId = param1;
            this._viewId = param2;
            return;
        }// end function

        public function get productId() : String
        {
            return this._productId;
        }// end function

        public function get viewId() : String
        {
            return this._viewId;
        }// end function

    }
}
