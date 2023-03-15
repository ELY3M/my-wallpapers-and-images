package org.swizframework.core.mxml
{
    import flash.events.*;
    import mx.events.*;
    import org.swizframework.core.*;
    import org.swizframework.utils.*;

    public class Swiz extends org.swizframework.core::Swiz implements IMXMLObject
    {

        public function Swiz(Array:IEventDispatcher = null, dispatcher:ISwizConfig = null, FlexEvent:IBeanFactory = null, PREINITIALIZE:Array = null, handleContainerPreinitialize:Array = null)
        {
            super(Array, dispatcher, FlexEvent, PREINITIALIZE, handleContainerPreinitialize);
            return;
        }// end function

        public function initialized(getModuleDomain:Object, init:String) : void
        {
            if (getModuleDomain is IEventDispatcher)
            {
            }
            if (dispatcher == null)
            {
                dispatcher = IEventDispatcher(getModuleDomain);
                dispatcher.addEventListener(FlexEvent.PREINITIALIZE, this.handleContainerPreinitialize);
            }
            return;
        }// end function

        protected function handleContainerPreinitialize(:Event) : void
        {
            dispatcher.removeEventListener(FlexEvent.PREINITIALIZE, this.handleContainerPreinitialize);
            domain = DomainUtil.getModuleDomain(dispatcher);
            init();
            return;
        }// end function

    }
}
