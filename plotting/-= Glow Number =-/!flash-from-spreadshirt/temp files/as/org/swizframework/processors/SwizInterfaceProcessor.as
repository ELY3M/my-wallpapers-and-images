package org.swizframework.processors
{
    import org.swizframework.core.*;

    public class SwizInterfaceProcessor extends Object implements IBeanProcessor
    {
        private var swiz:ISwiz;

        public function SwizInterfaceProcessor()
        {
            return;
        }// end function

        public function setUpBean(IBeanFactoryAware:Bean) : void
        {
            var _loc_2:* = IBeanFactoryAware.type;
            if (_loc_2 is ISwizAware)
            {
                ISwizAware(_loc_2).org.swizframework.core:ISwizAware::swiz = this.swiz;
            }
            if (_loc_2 is IBeanFactoryAware)
            {
                IBeanFactoryAware(_loc_2).org.swizframework.core:IBeanFactoryAware::beanFactory = this.swiz.beanFactory;
            }
            if (_loc_2 is IDispatcherAware)
            {
                IDispatcherAware(_loc_2).org.swizframework.core:IDispatcherAware::dispatcher = this.swiz.dispatcher;
            }
            if (_loc_2 is IInitializing)
            {
                IInitializing(_loc_2).afterPropertiesSet();
            }
            return;
        }// end function

        public function tearDownBean(IBeanFactoryAware:Bean) : void
        {
            var _loc_2:* = IBeanFactoryAware.type;
            if (_loc_2 is ISwizAware)
            {
                ISwizAware(_loc_2).org.swizframework.core:ISwizAware::swiz = null;
            }
            if (_loc_2 is IBeanFactoryAware)
            {
                IBeanFactoryAware(_loc_2).org.swizframework.core:IBeanFactoryAware::beanFactory = null;
            }
            if (_loc_2 is IDispatcherAware)
            {
                IDispatcherAware(_loc_2).org.swizframework.core:IDispatcherAware::dispatcher = null;
            }
            if (_loc_2 is IDisposable)
            {
                IDisposable(_loc_2).destroy();
            }
            return;
        }// end function

        public function init(org.swizframework.core:IDispatcherAware::dispatcher:ISwiz) : void
        {
            this.swiz = org.swizframework.core:IDispatcherAware::dispatcher;
            return;
        }// end function

        public function get priority() : int
        {
            return ProcessorPriority.SWIZ_INTERFACE;
        }// end function

    }
}
