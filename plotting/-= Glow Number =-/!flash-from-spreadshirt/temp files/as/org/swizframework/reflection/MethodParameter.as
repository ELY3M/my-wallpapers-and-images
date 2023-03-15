package org.swizframework.reflection
{

    public class MethodParameter extends Object
    {
        public var index:int;
        public var type:Class;
        public var optional:Boolean;

        public function MethodParameter(int:int, Class:Class, Boolean:Boolean)
        {
            this.index = int;
            this.type = Class;
            this.optional = Boolean;
            return;
        }// end function

    }
}
