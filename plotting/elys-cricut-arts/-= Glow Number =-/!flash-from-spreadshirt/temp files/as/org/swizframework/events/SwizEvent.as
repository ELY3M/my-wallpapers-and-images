package org.swizframework.events
{
    import flash.events.*;
    import org.swizframework.core.*;

    public class SwizEvent extends Event
    {
        public var swiz:ISwiz;
        public static const CREATED:String = "swizCreated";
        public static const LOAD_COMPLETE:String = "loadComplete";
        public static const DESTROYED:String = "swizDestroyed";

        public function SwizEvent(clone:String, SwizEvent:ISwiz = null)
        {
            super(clone, true, true);
            this.swiz = SwizEvent;
            return;
        }// end function

        override public function clone() : Event
        {
            return new SwizEvent(type, this.swiz);
        }// end function

    }
}
