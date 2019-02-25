package org.swizframework.events
{
    import flash.events.*;

    public class BeanEvent extends Event
    {
        public var source:Object;
        public var beanName:String;
        public static const ADD_BEAN:String = "addBean";
        public static const SET_UP_BEAN:String = "setUpBean";
        public static const TEAR_DOWN_BEAN:String = "tearDownBean";
        public static const REMOVE_BEAN:String = "removeBean";

        public function BeanEvent(BeanEvent:String, Object = null, :String = null)
        {
            super(BeanEvent, true, true);
            this.source = Object;
            this.beanName = ;
            return;
        }// end function

        override public function clone() : Event
        {
            return new BeanEvent(type, this.source);
        }// end function

    }
}
