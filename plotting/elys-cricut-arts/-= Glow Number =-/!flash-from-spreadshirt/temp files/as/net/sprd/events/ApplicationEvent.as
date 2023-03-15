package net.sprd.events
{
    import flash.events.*;

    public class ApplicationEvent extends Event
    {
        public static const COUNTRY_CHANGED:String = "countryChanged";
        public static const NO_SIZE_SELECTED:String = "noSizeSelected";
        public static const COMPONENT_UNAVAILABLE:String = "componentUnavailable";
        public static const COMPONENT_COMPLETE:String = "componentComplete";

        public function ApplicationEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new ApplicationEvent(type, bubbles, cancelable);
            return _loc_1;
        }// end function

        override public function toString() : String
        {
            return formatToString("ApplicationEvent", "type", "bubbles", "cancelable", "eventPhase");
        }// end function

    }
}
