package net.sprd.entities.impl
{
    import net.sprd.entities.*;

    public class ShopApplication extends BaseEntity implements IShopApplication
    {
        private var _uploadMode:String = "privateMode";
        private var _showDesignGallery:Boolean = true;
        private var _showProductTypeGallery:Boolean = true;
        private var _showAddText:Boolean = true;
        private var _showDesignSearch:Boolean = true;
        private var _showMarketPlaceDesigns:Boolean = true;
        private var _showDesignUpload:Boolean = true;
        private var _showSaveAndShare:Boolean = true;
        private var _shareByEmail:Boolean = true;
        private var _showPrices:Boolean = true;

        public function ShopApplication()
        {
            return;
        }// end function

        public function get uploadMode() : String
        {
            return this._uploadMode;
        }// end function

        public function set uploadMode(param1:String) : void
        {
            if (UploadModeType.valueExists(param1))
            {
                this._uploadMode = param1;
            }
            else
            {
                throw new Error("uploadMode cannot be set to: " + param1);
            }
            return;
        }// end function

        public function get showPrices() : Boolean
        {
            return this._showPrices;
        }// end function

        public function set showPrices(param1:Boolean) : void
        {
            this._showPrices = param1;
            return;
        }// end function

        public function get showDesignGallery() : Boolean
        {
            return this._showDesignGallery;
        }// end function

        public function set showDesignGallery(param1:Boolean) : void
        {
            this._showDesignGallery = param1;
            return;
        }// end function

        public function get showProductTypeGallery() : Boolean
        {
            return this._showProductTypeGallery;
        }// end function

        public function set showProductTypeGallery(param1:Boolean) : void
        {
            this._showProductTypeGallery = param1;
            return;
        }// end function

        public function get showAddText() : Boolean
        {
            return this._showAddText;
        }// end function

        public function set showAddText(param1:Boolean) : void
        {
            this._showAddText = param1;
            return;
        }// end function

        public function get showDesignSearch() : Boolean
        {
            return this._showDesignSearch;
        }// end function

        public function set showDesignSearch(param1:Boolean) : void
        {
            this._showDesignSearch = param1;
            return;
        }// end function

        public function get showMarketPlaceDesigns() : Boolean
        {
            return this._showMarketPlaceDesigns;
        }// end function

        public function set showMarketPlaceDesigns(param1:Boolean) : void
        {
            this._showMarketPlaceDesigns = param1;
            return;
        }// end function

        public function get showDesignUpload() : Boolean
        {
            return this._showDesignUpload;
        }// end function

        public function set showDesignUpload(param1:Boolean) : void
        {
            this._showDesignUpload = param1;
            return;
        }// end function

        public function set showSaveAndShare(param1:Boolean) : void
        {
            this._showSaveAndShare = param1;
            return;
        }// end function

        public function get showSaveAndShare() : Boolean
        {
            return this._showSaveAndShare;
        }// end function

        public function get showSaveAndShareEmail() : Boolean
        {
            return this._shareByEmail;
        }// end function

        public function set showSaveAndShareEmail(param1:Boolean) : void
        {
            this._shareByEmail = param1;
            return;
        }// end function

    }
}
