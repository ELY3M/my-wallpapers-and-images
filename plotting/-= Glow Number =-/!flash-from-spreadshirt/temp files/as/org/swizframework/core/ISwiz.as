package org.swizframework.core
{
    import flash.events.*;
    import flash.system.*;

    public interface ISwiz
    {

        public function ISwiz();

        function get catchViews() : Boolean;

        function set catchViews(ISwizConfig:Boolean) : void;

        function get dispatcher() : IEventDispatcher;

        function set dispatcher(ISwizConfig:IEventDispatcher) : void;

        function get globalDispatcher() : IEventDispatcher;

        function set globalDispatcher(ISwizConfig:IEventDispatcher) : void;

        function get domain() : ApplicationDomain;

        function set domain(ISwizConfig:ApplicationDomain) : void;

        function get config() : ISwizConfig;

        function set config(ISwizConfig:ISwizConfig) : void;

        function get beanProviders() : Array;

        function set beanProviders(ISwizConfig:Array) : void;

        function get beanFactory() : IBeanFactory;

        function set beanFactory(ISwizConfig:IBeanFactory) : void;

        function get processors() : Array;

        function set customProcessors(ISwizConfig:Array) : void;

        function get parentSwiz() : ISwiz;

        function set parentSwiz(:ISwiz) : void;

        function get loggingTargets() : Array;

        function set loggingTargets(ISwizConfig:Array) : void;

        function init() : void;

        function tearDown() : void;

        function registerWindow(:IEventDispatcher, :ISwiz = null) : void;

    }
}
