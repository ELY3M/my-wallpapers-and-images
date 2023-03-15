package org.swizframework.core
{

    public interface ISwizAware extends ISwizInterface
    {

        public function ISwizAware();

        function set swiz(ISwizInterface:ISwiz) : void;

    }
}
