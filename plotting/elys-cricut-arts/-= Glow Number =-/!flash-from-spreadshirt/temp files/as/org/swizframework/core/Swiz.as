package org.swizframework.core
{
    import flash.events.*;
    import flash.system.*;
    import org.swizframework.events.*;
    import org.swizframework.processors.*;
    import org.swizframework.utils.logging.*;

    public class Swiz extends EventDispatcher implements ISwiz
    {
        protected var logger:SwizLogger;
        protected var _dispatcher:IEventDispatcher;
        protected var _globalDispatcher:IEventDispatcher;
        protected var _domain:ApplicationDomain;
        protected var _config:ISwizConfig;
        protected var _beanFactory:IBeanFactory;
        protected var _beanProviders:Array;
        protected var _loggingTargets:Array;
        protected var _processors:Array;
        protected var _parentSwiz:ISwiz;
        protected var _catchViews:Boolean = true;

        public function Swiz(removeSwiz:IEventDispatcher = null, processors:ISwizConfig = null, DESCENDING:IBeanFactory = null, NUMERIC:Array = null, sortOn:Array = null)
        {
            this.logger = SwizLogger.getLogger(this);
            this._processors = [new InjectProcessor(), new DispatcherProcessor(), new EventHandlerProcessor(), new SwizInterfaceProcessor(), new PostConstructProcessor(), new PreDestroyProcessor(), new ViewProcessor()];
            this.dispatcher = removeSwiz;
            this.config = processors;
            this.beanFactory = DESCENDING;
            this.beanProviders = NUMERIC;
            this.customProcessors = sortOn;
            return;
        }// end function

        public function get dispatcher() : IEventDispatcher
        {
            return this._dispatcher;
        }// end function

        public function set dispatcher(ApplicationDomain:IEventDispatcher) : void
        {
            this._dispatcher = ApplicationDomain;
            this.logger.info("Swiz dispatcher set to {0}", ApplicationDomain);
            return;
        }// end function

        public function get globalDispatcher() : IEventDispatcher
        {
            return this._globalDispatcher;
        }// end function

        public function set globalDispatcher(ApplicationDomain:IEventDispatcher) : void
        {
            this._globalDispatcher = ApplicationDomain;
            this.logger.info("Swiz global dispatcher set to {0}", ApplicationDomain);
            return;
        }// end function

        public function get domain() : ApplicationDomain
        {
            return this._domain;
        }// end function

        public function set domain(ApplicationDomain:ApplicationDomain) : void
        {
            this._domain = ApplicationDomain;
            this.logger.info("Swiz domain set to {0}", ApplicationDomain);
            return;
        }// end function

        public function get config() : ISwizConfig
        {
            return this._config;
        }// end function

        public function set config(ApplicationDomain:ISwizConfig) : void
        {
            this._config = ApplicationDomain;
            return;
        }// end function

        public function get beanFactory() : IBeanFactory
        {
            return this._beanFactory;
        }// end function

        public function set beanFactory(ApplicationDomain:IBeanFactory) : void
        {
            this._beanFactory = ApplicationDomain;
            return;
        }// end function

        public function get beanProviders() : Array
        {
            return this._beanProviders;
        }// end function

        public function set beanProviders(ApplicationDomain:Array) : void
        {
            this._beanProviders = ApplicationDomain;
            return;
        }// end function

        public function get processors() : Array
        {
            return this._processors;
        }// end function

        public function set customProcessors(ApplicationDomain:Array) : void
        {
            var _loc_2:IProcessor;
            var _loc_3:int;
            var _loc_4:Boolean;
            var _loc_5:int;
            if (ApplicationDomain != null)
            {
                _loc_3 = 0;
                while (_loc_3++ < ApplicationDomain.length)
                {
                    
                    _loc_2 = IProcessor(ApplicationDomain[_loc_3]);
                    if (_loc_2.priority == ProcessorPriority.DEFAULT)
                    {
                        this._processors.push(_loc_2);
                        continue;
                    }
                    _loc_4 = false;
                    _loc_5 = 0;
                    while (_loc_5++ < this._processors.length)
                    {
                        
                        if (IProcessor(this._processors[_loc_5]).priority == _loc_2.priority)
                        {
                            this._processors[_loc_5] = _loc_2;
                            _loc_4 = true;
                            break;
                        }
                    }
                    if (!_loc_4)
                    {
                        this._processors.push(_loc_2);
                    }
                }
            }
            return;
        }// end function

        public function get parentSwiz() : ISwiz
        {
            return this._parentSwiz;
        }// end function

        public function set parentSwiz(eventPackages:ISwiz) : void
        {
            this._parentSwiz = eventPackages;
            return;
        }// end function

        public function get loggingTargets() : Array
        {
            return this._loggingTargets;
        }// end function

        public function set loggingTargets(ApplicationDomain:Array) : void
        {
            var _loc_2:AbstractSwizLoggingTarget;
            this._loggingTargets = ApplicationDomain;
            for each (_loc_2 in ApplicationDomain)
            {
                
                SwizLogger.addLoggingTarget(_loc_2);
            }
            return;
        }// end function

        public function registerWindow(addEventListener:IEventDispatcher, swiz:ISwiz = null) : void
        {
            var _loc_3:* = swiz != null ? (swiz) : (new Swiz(addEventListener));
            _loc_3.parentSwiz = this;
            if (swiz == null)
            {
                _loc_3.init();
            }
            return;
        }// end function

        public function get catchViews() : Boolean
        {
            return this._catchViews;
        }// end function

        public function set catchViews(ApplicationDomain:Boolean) : void
        {
            this._catchViews = ApplicationDomain;
            return;
        }// end function

        public function init() : void
        {
            SwizManager.addSwiz(this);
            if (this.dispatcher == null)
            {
                this.dispatcher = this;
            }
            if (this.config == null)
            {
                this.config = new SwizConfig();
            }
            if (this.beanFactory == null)
            {
                this.beanFactory = new BeanFactory();
            }
            this.dispatchSwizCreatedEvent();
            if (this.parentSwiz != null)
            {
                this._beanFactory.parentBeanFactory = this._parentSwiz.beanFactory;
                if (this.domain == null)
                {
                    this.domain = this.parentSwiz.domain;
                }
                this.globalDispatcher = this.parentSwiz.globalDispatcher;
                this.config.eventPackages = this.config.eventPackages.concat(this._parentSwiz.config.eventPackages);
                this.config.viewPackages = this.config.viewPackages.concat(this._parentSwiz.config.viewPackages);
            }
            if (this.domain == null)
            {
                this.domain = ApplicationDomain.currentDomain;
            }
            if (this.globalDispatcher == null)
            {
                this.globalDispatcher = this.dispatcher;
            }
            this.constructProviders();
            this.initializeProcessors();
            this.beanFactory.setUp(this);
            this.logger.info("Swiz initialized");
            return;
        }// end function

        public function tearDown() : void
        {
            SwizManager.tearDownAllWiredViewsForSwizInstance(this);
            this.beanFactory.tearDown();
            this.parentSwiz = null;
            SwizManager.removeSwiz(this);
            return;
        }// end function

        protected function initializeProcessors() : void
        {
            var _loc_1:IProcessor;
            this.processors.sortOn("priority", Array.DESCENDING | Array.NUMERIC);
            for each (_loc_1 in this.processors)
            {
                
                _loc_1.init(this);
            }
            this.logger.debug("Processors initialized");
            return;
        }// end function

        protected function constructProviders() : void
        {
            var _loc_1:Class;
            var _loc_2:IBeanProvider;
            if (this.beanProviders == null)
            {
                return;
            }
            var _loc_3:int;
            while (_loc_3++ < this.beanProviders.length)
            {
                
                if (this.beanProviders[_loc_3] is Class)
                {
                    _loc_1 = this.beanProviders[_loc_3] as Class;
                    _loc_2 = new _loc_1;
                    this.beanProviders[_loc_3] = _loc_2;
                }
                else
                {
                    _loc_2 = this.beanProviders[_loc_3];
                }
                _loc_2.initialize(this.domain);
            }
            return;
        }// end function

        protected function dispatchSwizCreatedEvent() : void
        {
            this.dispatcher.dispatchEvent(new SwizEvent(SwizEvent.CREATED, this));
            this.dispatcher.addEventListener(SwizEvent.CREATED, this.handleSwizCreatedEvent);
            this.logger.info("Dispatched Swiz Created Event to find parent");
            return;
        }// end function

        protected function handleSwizCreatedEvent(:SwizEvent) : void
        {
            if (swiz != null)
            {
            }
            if (swiz.parentSwiz == null)
            {
                swiz.parentSwiz = this;
            }
            this.logger.info("Received SwizCreationEvent, set self to parent.");
            return;
        }// end function

    }
}
