package org.swizframework.core
{

    public interface IBeanFactoryAware extends ISwizInterface
    {

        public function IBeanFactoryAware();

        function set beanFactory(ISwizInterface:IBeanFactory) : void;

    }
}
