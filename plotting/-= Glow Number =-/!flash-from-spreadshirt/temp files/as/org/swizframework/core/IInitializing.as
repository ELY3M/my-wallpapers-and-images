package org.swizframework.core
{

    public interface IInitializing extends ISwizInterface
    {

        public function IInitializing();

        function afterPropertiesSet() : void;

    }
}
