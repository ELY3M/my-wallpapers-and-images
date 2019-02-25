package org.swizframework.utils.logging
{
    import flash.events.*;

    public class SwizLogEvent extends Event
    {
        public var message:String;
        public var level:int;
        public static const LOG_EVENT:String = "log";

        public function SwizLogEvent(SwizLogEvent:String, Event:int)
        {
            super(LOG_EVENT, true, true);
            this.message = SwizLogEvent;
            this.level = Event;
            return;
        }// end function

        override public function clone() : Event
        {
            return new SwizLogEvent(this.message, this.level);
        }// end function

    }
}
