package net.sprd.common.actions
{

    public class ActionState extends Object
    {
        public static const CREATED:uint = 0;
        public static const EXECUTING:uint = 1;
        public static const COMPLETED:uint = 2;
        public static const ABORTED:uint = 3;

        public function ActionState()
        {
            return;
        }// end function

    }
}
