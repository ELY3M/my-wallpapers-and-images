package org.swizframework.events
{
    import flash.events.*;

    public class ChainEvent extends Event
    {
        public static const CHAIN_START:String = "chainStart";
        public static const CHAIN_STEP_COMPLETE:String = "chainStepComplete";
        public static const CHAIN_STEP_ERROR:String = "chainStepError";
        public static const CHAIN_COMPLETE:String = "chainComplete";
        public static const CHAIN_FAIL:String = "chainFail";

        public function ChainEvent(:String, :Boolean = false, :Boolean = false)
        {
            super(, , );
            return;
        }// end function

    }
}
