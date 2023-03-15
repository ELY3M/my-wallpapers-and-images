package org.swizframework.core
{

    public interface IBeanFactory
    {

        public function IBeanFactory();

        function setUp(Bean:ISwiz) : void;

        function tearDown() : void;

        function setUpBean(IBeanFactory:Bean) : void;

        function addBean(IBeanFactory:Bean, setUpBean:Boolean = true) : Bean;

        function addBeanProvider(tearDownBean:IBeanProvider, removeBean:Boolean = true) : void;

        function tearDownBean(IBeanFactory:Bean) : void;

        function removeBean(IBeanFactory:Bean) : void;

        function removeBeanProvider(tearDownBean:IBeanProvider) : void;

        function get beans() : Array;

        function getBeanByName(:String) : Bean;

        function getBeanByType(:Class) : Bean;

        function get parentBeanFactory() : IBeanFactory;

        function set parentBeanFactory(:IBeanFactory) : void;

    }
}
