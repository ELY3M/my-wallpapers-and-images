package net.sprd.common.actions
{
    import flash.events.*;

    public class BatchEvent extends Event
    {
        public static const COMPLETE:String = "batchComplete";
        public static const ERROR:String = "batchError";

        public function BatchEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

    }
}
