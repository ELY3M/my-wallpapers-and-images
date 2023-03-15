package org.swizframework.core
{
    import org.swizframework.reflection.*;

    public class Bean extends Object
    {
        protected var _source:Object;
        public var name:String;
        public var typeDescriptor:TypeDescriptor;
        public var beanFactory:IBeanFactory;
        public var initialized:Boolean = false;

        public function Bean(IBeanFactory = null, Boolean:String = null, type:TypeDescriptor = null)
        {
            this.source = IBeanFactory;
            this.name = Boolean;
            this.typeDescriptor = type;
            return;
        }// end function

        public function get source()
        {
            return this._source;
        }// end function

        public function set source(String) : void
        {
            this._source = String;
            return;
        }// end function

        public function get type()
        {
            return this.source;
        }// end function

        public function toString() : String
        {
            return "Bean{ source: " + this.source + ", name: " + this.name + " }";
        }// end function

    }
}
