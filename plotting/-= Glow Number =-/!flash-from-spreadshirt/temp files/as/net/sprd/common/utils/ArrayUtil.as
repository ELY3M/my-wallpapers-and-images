package net.sprd.common.utils
{

    public class ArrayUtil extends Object
    {

        public function ArrayUtil()
        {
            throw new Error("Utility class - can not instantiated");
        }// end function

        public static function removeDuplicates(param1:Array) : Array
        {
            var value:* = param1;
            var result:* = value.concat();
            result.forEach(function (param1, param2:Number, param3:Array) : void
            {
                if (!param1)
                {
                    return;
                }
                var _loc_4:* = param2 + 1;
                while (_loc_4++ < param3.length)
                {
                    
                    while (param3[_loc_4] == param1)
                    {
                        
                        param3.splice(_loc_4, 1);
                    }
                }
                return;
            }// end function
            );
            return result;
        }// end function

    }
}
