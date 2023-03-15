package net.sprd.components.designupload
{
    import flash.events.*;

    public class DesignUploadEvent extends Event
    {
        public static const DESIGNS_COMPLETE:String = "designsComplete";
        public static const DESIGNS_ERROR:String = "designsError";
        public static const UPLOAD_COMPLETE:String = "uploadComplete";

        public function DesignUploadEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

    }
}
