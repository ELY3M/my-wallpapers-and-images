package net.sprd.models.basket
{

    public class TrackingErrorCodes extends Object
    {
        public static const PRODUCT_CREATION:String = "-100";
        public static const HARD_BOUNDARY:String = "-101";
        public static const CONFIGURATION_OVERLAP:String = "-102";
        public static const MAX_BOUND:String = "-103";
        public static const MIN_BOUND:String = "-104";
        public static const MISSING_PARAMETERS:String = "-1";
        public static const NO_SIZE_SELECTED:String = "1";
        public static const NO_COLOR_SELECTED:String = "2";
        public static const QUANTITY_EXCEEDS_ARBITRARY_LIMIT:String = "4";
        public static const PRODUCTCOLOR_NOT_ALLOWED_WITH_PRINTTYPE:String = "5";
        public static const PRODUCT_STOCKOUT:String = "6";
        public static const UNKNOWN_ERROR:String = "7";
        public static const PRODUCTTYPE_PRINTTYPE_NOT_SUPPORTED:String = "8";
        public static const PRODUCT_CONFIGURATION_INVALID:String = "9";
        public static const OUT_OF_STOCK:Object = "10";
        public static const HTTP_STATUS_400:String = "400";
        public static const HTTP_STATUS_401:String = "401";
        public static const HTTP_STATUS_403:String = "403";
        public static const HTTP_STATUS_404:String = "404";
        public static const HTTP_STATUS_500:String = "500";
        public static const DESIGN_RELOAD_ERROR:String = "-201";
        public static const DESIGN_RELOAD_ZERO_WIDTH:String = "-202";
        public static const DESIGN_RELOAD_ZERO_WIDTH_NOT_FIXABLE:String = "-203";
        public static const DESIGN_UPLOAD_ERROR:String = "-204";
        public static const DESIGN_SAVE_ERROR:String = "-205";
        public static const DESIGN_UPLOAD_TIMEOUT:String = "-206";
        public static const DEEPLINK_WARNING:String = "-311";
        public static const DEEPLINK_ERROR:String = "-301";
        public static const DEEPLINK_ERROR_DEFAULT_DESIGN:String = "-302";
        public static const DEEPLINK_ERROR_BASKET_ITEM:String = "-303";
        public static const DEEPLINK_ERROR_PRODUCT:String = "-304";
        public static const DEEPLINK_ERROR_DEPARTMENT:String = "-305";
        public static const DEEPLINK_ERROR_PRODUCTTYPE:String = "-306";
        public static const DEEPLINK_ERROR_DESIGN_CATEGORY:String = "-307";

        public function TrackingErrorCodes()
        {
            return;
        }// end function

    }
}
