package net.sprd.entities
{

    public interface IShopApplication extends IBaseEntity
    {

        public function IShopApplication();

        function get uploadMode() : String;

        function set uploadMode(param1:String) : void;

        function get showDesignGallery() : Boolean;

        function set showDesignGallery(param1:Boolean) : void;

        function get showProductTypeGallery() : Boolean;

        function set showProductTypeGallery(param1:Boolean) : void;

        function get showAddText() : Boolean;

        function set showAddText(param1:Boolean) : void;

        function get showDesignSearch() : Boolean;

        function set showDesignSearch(param1:Boolean) : void;

        function get showMarketPlaceDesigns() : Boolean;

        function set showMarketPlaceDesigns(param1:Boolean) : void;

        function get showDesignUpload() : Boolean;

        function set showDesignUpload(param1:Boolean) : void;

        function get showSaveAndShare() : Boolean;

        function set showSaveAndShare(param1:Boolean) : void;

        function get showSaveAndShareEmail() : Boolean;

        function set showSaveAndShareEmail(param1:Boolean) : void;

        function get showPrices() : Boolean;

        function set showPrices(param1:Boolean) : void;

    }
}
