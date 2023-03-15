package net.sprd.services.statistics
{
    import flash.geom.*;
    import flash.system.*;

    public class T extends Object
    {

        public function T()
        {
            return;
        }// end function

        public static function getAdd2BasketEvent() : TrackingEvent
        {
            return new TrackingEvent("add2Basket", ["event3"]);
        }// end function

        public static function getGenericErrorEvent(param1:String, param2:String) : TrackingEvent
        {
            return new TrackingEvent(null, null, {prop42:param1}, {eVar42:param1 + ":" + param2});
        }// end function

        public static function getFirstClickEvent(param1:Point) : TrackingEvent
        {
            return new TrackingEvent("firstClick", ["event16"], null, {eVar46:formatDimension(param1)});
        }// end function

        public static function getAdded2BasketEvent(param1:Number) : TrackingEvent
        {
            return new TrackingEvent("added2Basket", ["scAdd"], null, {eVar49:roundTime(param1)});
        }// end function

        public static function getProductCreatedEvent(param1:Number) : TrackingEvent
        {
            return new TrackingEvent("productCreated", null, {prop13:roundTime(param1)});
        }// end function

        public static function getGotoCheckoutEvent() : TrackingEvent
        {
            return new TrackingEvent(null, null, null, {eVar33:"Designer - Checkout Button"});
        }// end function

        public static function getDesignAnotherProductEvent() : TrackingEvent
        {
            return new TrackingEvent(null, null, null, {eVar33:"Designer - Create other Product " + "Button"});
        }// end function

        public static function getFinishLoadingEvent(param1:Number, param2:int, param3:Point) : TrackingEvent
        {
            return new TrackingEvent("finishLoading", ["event2"], {prop44:formatDimension(param3) + "::" + Capabilities.version, prop43:roundTime(param1)});
        }// end function

        public static function getTrackDeeplinkEvent(param1:String) : TrackingEvent
        {
            return new TrackingEvent("deeplink", null, null, {eVar45:param1});
        }// end function

        public static function getPreloaderStartEvent() : TrackingEvent
        {
            return new TrackingEvent("preloaderStart", ["event18"], null, null);
        }// end function

        public static function getPreloaderCompleteEvent() : TrackingEvent
        {
            return new TrackingEvent("preloaderComplete", ["event19"], null, null);
        }// end function

        private static function roundTime(param1:Number) : Number
        {
            return Math.round(2 * param1) / 2;
        }// end function

        private static function formatDimension(param1:Point) : String
        {
            return param1.x + "x" + param1.y;
        }// end function

        public static function getSaveAndShare_SaveEvent() : TrackingEvent
        {
            return new TrackingEvent(null, null, null, {eVar33:"Confomat - Save button"});
        }// end function

        public static function getSaveAndShare_eMailEvent() : TrackingEvent
        {
            return new TrackingEvent(null, null, null, {eVar33:"Confomat - eMail button"});
        }// end function

        public static function getSaveAndShare_eMailTryEvent() : TrackingEvent
        {
            return new TrackingEvent(null, null, null, {eVar33:"Confomat - eMail button try"});
        }// end function

        public static function getSaveAndShare_eMailFailedEvent(param1:String) : TrackingEvent
        {
            return new TrackingEvent(null, null, null, {eVar33:"Confomat - eMail failed"});
        }// end function

        public static function getSaveAndShare_eMailSuccessEvent() : TrackingEvent
        {
            return new TrackingEvent(null, null, null, {eVar33:"Confomat - eMail success"});
        }// end function

        public static function getSaveAndShare_FacebookEvent() : TrackingEvent
        {
            return new TrackingEvent(null, null, null, {eVar33:"Confomat - Facebook button"});
        }// end function

        public static function getSaveAndShare_TwitterEvent() : TrackingEvent
        {
            return new TrackingEvent(null, null, null, {eVar33:"Confomat - Twitter button"});
        }// end function

        public static function getSaveAndShare_EmbedEvent() : TrackingEvent
        {
            return new TrackingEvent(null, null, null, {eVar33:"Confomat - Embed button"});
        }// end function

        public static function getSaveAndShare_EmbedURLEvent() : TrackingEvent
        {
            return new TrackingEvent(null, null, null, {eVar33:"Confomat - copy plain URL"});
        }// end function

        public static function getSaveAndShare_EmbedHTMLEvent() : TrackingEvent
        {
            return new TrackingEvent(null, null, null, {eVar33:"Confomat - copy embed code"});
        }// end function

        public static function getSaveAndShare_LoginTryEvent() : TrackingEvent
        {
            return new TrackingEvent(null, null, null, {eVar33:"Confomat - Login button try"});
        }// end function

        public static function getSaveAndShare_LoginFailedEvent() : TrackingEvent
        {
            return new TrackingEvent(null, null, null, {eVar33:"Confomat - Login failed"});
        }// end function

        public static function getSaveAndShare_LoginSuccessEvent() : TrackingEvent
        {
            return new TrackingEvent(null, null, null, {eVar33:"Confomat - Login success"});
        }// end function

        public static function getSaveAndShare_openShare() : TrackingEvent
        {
            return new TrackingEvent(null, null, null, {eVar33:"Confomat - Open save & share button"});
        }// end function

        public static function getSaveAndShare_closeShare() : TrackingEvent
        {
            return new TrackingEvent(null, null, null, {eVar33:"Confomat - Close save & share button"});
        }// end function

    }
}
