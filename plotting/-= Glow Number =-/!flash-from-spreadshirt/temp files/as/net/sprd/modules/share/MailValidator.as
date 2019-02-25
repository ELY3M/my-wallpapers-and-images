package net.sprd.modules.share
{

    public class MailValidator extends Object
    {
        private static var pattern:RegExp = new RegExp("^[a-z0-9!#$%&\'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&\'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$", "i");

        public function MailValidator()
        {
            return;
        }// end function

        public static function isValid(param1:String) : Boolean
        {
            return pattern.test(param1);
        }// end function

    }
}
