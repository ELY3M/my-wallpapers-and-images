package org.swizframework.reflection
{

    public class Constant extends Object
    {
        public var name:String;
        public var value:String;

        public function Constant(Constant:String, Object:String)
        {
            this.name = Constant;
            this.value = Object;
            return;
        }// end function

    }
}
