package org.swizframework.reflection
{

    public class MetadataHostMethod extends BaseMetadataHost
    {
        protected var _returnType:Class;
        protected var _parameters:Array;

        public function MetadataHostMethod()
        {
            this._parameters = [];
            return;
        }// end function

        public function get returnType() : Class
        {
            return this._returnType;
        }// end function

        public function set returnType(parameters:Class) : void
        {
            this._returnType = parameters;
            return;
        }// end function

        public function get parameters() : Array
        {
            return this._parameters;
        }// end function

    }
}
