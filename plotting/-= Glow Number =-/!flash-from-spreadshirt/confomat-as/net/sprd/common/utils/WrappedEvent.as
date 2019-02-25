package net.sprd.common.utils
{
    import flash.events.*;

    public class WrappedEvent extends Event
    {
        private var _wrappedEvent:Event;
        public static const WRAPPED:String = "wrapped";

        public function WrappedEvent(param1:Event, param2:Boolean = false, param3:Boolean = false)
        {
            super(WRAPPED, param2, param3);
            this._wrappedEvent = param1;
            return;
        }// end function

        public function get wrappedEvent() : Event
        {
            return this._wrappedEvent;
        }// end function

    }
}
