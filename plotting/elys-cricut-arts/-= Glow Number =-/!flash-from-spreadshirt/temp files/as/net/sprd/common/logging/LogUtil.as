package net.sprd.common.logging
{
    import flash.utils.*;

    public class LogUtil extends Object
    {

        public function LogUtil()
        {
            return;
        }// end function

        public static function getLogName(param1:Object) : String
        {
            if (param1 is Class)
            {
                return getQualifiedClassName(param1);
            }
            return param1.toString();
        }// end function

        public static function buildLogMessage(param1:String, param2:Array) : String
        {
            var _loc_4:*;
            var _loc_5:Error;
            if (param2 == null)
            {
                return param1;
            }
            var _loc_3:int;
            while (_loc_3++ < param2.length)
            {
                
                _loc_4 = param2[_loc_3];
                if (_loc_4 is Error)
                {
                    _loc_5 = _loc_4 as Error;
                    _loc_4 = "\n" + _loc_5.getStackTrace();
                }
                param1 = param1.replace(new RegExp("\\{" + _loc_3 + "\\}", "g"), _loc_4);
            }
            return param1;
        }// end function

    }
}
