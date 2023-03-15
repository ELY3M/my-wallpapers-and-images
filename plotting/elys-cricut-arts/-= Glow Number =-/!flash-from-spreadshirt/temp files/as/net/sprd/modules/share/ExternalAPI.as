package net.sprd.modules.share
{
    import flash.external.*;
    import flash.system.*;

    public class ExternalAPI extends Object
    {
        private static const IS_AUTHENTICATED:String = "confomatContext.isUserAuthenticated";
        private static const FIRE_EVENT:String = "confomat.fire";
        private static const GENERATE_PRODUCT_URL:String = "confomatContext.getProductUrl";
        private static const OPEN_POPUP:String = "confomatContext.openPopup";
        private static const USER_LOGGED_IN:String = "userLoggedIn";
        private static const UPDATE_POPUP:String = "confomatContext.updatePopup";
        private static const CLOSE_POPUP:String = "confomatContext.closePopup";

        public function ExternalAPI()
        {
            ExternalInterface.addCallback("isAuthenticated", isAuthenticated);
            Security.allowDomain("*");
            return;
        }// end function

        public static function isAuthenticated() : Boolean
        {
            if (ExternalInterface.available)
            {
                try
                {
                    return ExternalInterface.call(IS_AUTHENTICATED) == "true";
                }
                catch (ex:Error)
                {
                }
            }
            return false;
        }// end function

        public static function userLoggedIn() : void
        {
            try
            {
                ExternalInterface.call(FIRE_EVENT, USER_LOGGED_IN);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public static function getProductURL(param1:String, param2:String) : String
        {
            var productId:* = param1;
            var viewID:* = param2;
            if (ExternalInterface.available)
            {
                try
                {
                    return ExternalInterface.call(GENERATE_PRODUCT_URL, productId, viewID);
                }
                catch (e:Error)
                {
                }
            }
            return null;
        }// end function

        public static function openPopup(param1:String, param2:String, param3, param4) : Boolean
        {
            var URL:* = param1;
            var windowName:* = param2;
            var width:* = param3;
            var height:* = param4;
            if (ExternalInterface.available)
            {
                try
                {
                    return ExternalInterface.call(OPEN_POPUP, URL, windowName, width, height) == "true";
                }
                catch (e:Error)
                {
                }
            }
            return false;
        }// end function

        public static function relocatePopup(param1:String) : Boolean
        {
            var URL:* = param1;
            if (ExternalInterface.available)
            {
                try
                {
                    return ExternalInterface.call(UPDATE_POPUP, URL) == "true";
                }
                catch (e:Error)
                {
                }
            }
            return false;
        }// end function

        public static function closePopup() : void
        {
            if (ExternalInterface.available)
            {
                try
                {
                    ExternalInterface.call(CLOSE_POPUP);
                }
                catch (e:Error)
                {
                }
            }
            return;
        }// end function

    }
}
