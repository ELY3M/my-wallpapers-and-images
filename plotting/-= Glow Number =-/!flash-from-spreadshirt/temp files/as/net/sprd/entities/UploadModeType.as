package net.sprd.entities
{

    public class UploadModeType extends Object
    {
        public static const UPLOAD_MODE_COMMUNITY:String = "communityMode";
        public static const UPLOAD_MODE_PRIVATE:String = "privateMode";

        public function UploadModeType()
        {
            throw new Error("Enumerations are not eligible for instantiation.");
        }// end function

        public static function valueExists(param1:String) : Boolean
        {
            if (param1 != UPLOAD_MODE_COMMUNITY)
            {
            }
            return param1 == UPLOAD_MODE_PRIVATE;
        }// end function

    }
}
