package org.swizframework.reflection
{

    public class MetadataArg extends Object
    {
        public var key:String;
        public var value:String;

        public function MetadataArg(toString:String, MetadataArg:String)
        {
            this.key = toString;
            this.value = MetadataArg;
            return;
        }// end function

        public function toString() : String
        {
            var _loc_1:String;
            _loc_1 = _loc_1 + (this.key + " = " + this.value + "\n");
            return _loc_1;
        }// end function

    }
}
