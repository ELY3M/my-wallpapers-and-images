package net.sprd.common.utils
{

    public class StringUtil extends Object
    {

        public function StringUtil()
        {
            return;
        }// end function

        public static function ucfirst(param1:String) : String
        {
            if (!param1)
            {
                return param1;
            }
            return param1.substr(0, 1).toUpperCase() + param1.substr(1);
        }// end function

        public static function ucwords(param1:String) : String
        {
            var str:* = param1;
            if (!str)
            {
                return str;
            }
            var words:* = str.split(" ");
            words.forEach(function (param1, param2:int, param3:Array) : void
            {
                param3[param2] = ucfirst(param1 as String);
                return;
            }// end function
            );
            return words.join(" ");
        }// end function

    }
}
