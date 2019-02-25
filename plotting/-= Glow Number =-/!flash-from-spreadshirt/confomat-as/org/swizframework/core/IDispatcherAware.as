package org.swizframework.core
{
    import flash.events.*;

    public interface IDispatcherAware extends ISwizInterface
    {

        public function IDispatcherAware();

        function set dispatcher(ISwizInterface:IEventDispatcher) : void;

    }
}
