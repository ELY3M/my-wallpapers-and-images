package org.swizframework.core
{
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;
    import org.swizframework.events.*;
    import org.swizframework.processors.*;
    import org.swizframework.reflection.*;
    import org.swizframework.utils.*;
    import org.swizframework.utils.logging.*;

    public class BeanFactory extends EventDispatcher implements IBeanFactory
    {
        protected var logger:SwizLogger;
        protected const ignoredClasses:RegExp;
        protected var swiz:ISwiz;
        protected var _parentBeanFactory:IBeanFactory;
        protected var _beans:Array;
        protected var removedDisplayObjects:Array;
        protected var isListeningForEnterFrame:Boolean = false;
        public var waitForSetup:Boolean = false;

        public function BeanFactory()
        {
            this.logger = SwizLogger.getLogger(this);
            this.ignoredClasses = /^mx\.|^spark\.|^flash\.|^fl\.|__/;
            this._beans = [];
            this.removedDisplayObjects = [];
            return;
        }// end function

        public function get beans() : Array
        {
            return this._beans;
        }// end function

        public function setUp(ISwiz:ISwiz) : void
        {
            var _loc_2:IBeanProvider;
            this.swiz = ISwiz;
            ISwiz.dispatcher.addEventListener(BeanEvent.ADD_BEAN, this.handleBeanEvent);
            ISwiz.dispatcher.addEventListener(BeanEvent.SET_UP_BEAN, this.handleBeanEvent);
            ISwiz.dispatcher.addEventListener(BeanEvent.TEAR_DOWN_BEAN, this.handleBeanEvent);
            ISwiz.dispatcher.addEventListener(BeanEvent.REMOVE_BEAN, this.handleBeanEvent);
            for each (_loc_2 in ISwiz.beanProviders)
            {
                
                this.addBeanProvider(_loc_2, false);
            }
            this.runFactoryProcessors();
            this.completeBeanFactorySetup();
            return;
        }// end function

        public function completeBeanFactorySetup() : void
        {
            var _loc_1:Bean;
            if (this.waitForSetup)
            {
                return;
            }
            this.logger.info("BeanFactory completing setup");
            for each (_loc_1 in this.beans)
            {
                
                if (!(_loc_1 is Prototype))
                {
                    this.setUpBean(_loc_1);
                }
            }
            this.logger.info("BeanFactory initialized");
            if (this.swiz.catchViews == false)
            {
                return;
            }
            this.swiz.dispatcher.addEventListener(this.swiz.config.setUpEventType, this.setUpEventHandler, this.swiz.config.setUpEventPhase == EventPhase.CAPTURING_PHASE, this.swiz.config.setUpEventPriority, true);
            this.logger.debug("Set up event type set to {0}", this.swiz.config.setUpEventType);
            this.logger.debug("Set up event phase set to {0}", this.swiz.config.setUpEventPhase == EventPhase.CAPTURING_PHASE ? ("capture phase") : ("bubbling phase"));
            this.logger.debug("Set up event priority set to {0}", this.swiz.config.setUpEventPriority);
            if ("systemManager" in this.swiz.dispatcher)
            {
            }
            if (this.swiz.dispatcher["systemManager"] != null)
            {
            }
            if (!this.swiz.dispatcher["systemManager"].hasEventListener(this.swiz.config.setUpEventType))
            {
                this.swiz.dispatcher["systemManager"].addEventListener(this.swiz.config.setUpEventType, this.setUpEventHandlerSysMgr, this.swiz.config.setUpEventPhase == EventPhase.CAPTURING_PHASE, this.swiz.config.setUpEventPriority, true);
                this.swiz.dispatcher["systemManager"].addEventListener(this.swiz.config.tearDownEventType, this.tearDownEventHandler, this.swiz.config.tearDownEventPhase == EventPhase.CAPTURING_PHASE, this.swiz.config.tearDownEventPriority, true);
            }
            this.swiz.dispatcher.addEventListener(this.swiz.config.tearDownEventType, this.tearDownEventHandler, this.swiz.config.tearDownEventPhase == EventPhase.CAPTURING_PHASE, this.swiz.config.tearDownEventPriority, true);
            this.logger.debug("Tear down event type set to {0}", this.swiz.config.tearDownEventType);
            this.logger.debug("Tear down event phase set to {0}", this.swiz.config.tearDownEventPhase == EventPhase.CAPTURING_PHASE ? ("capture phase") : ("bubbling phase"));
            this.logger.debug("Tear down event priority set to {0}", this.swiz.config.tearDownEventPriority);
            if (this.swiz.dispatcher)
            {
                if (this.swiz.dispatcher is DisplayObject)
                {
                    SwizManager.setUp(DisplayObject(this.swiz.dispatcher));
                }
                else
                {
                    this.setUpBean(this.createBeanFromSource(this.swiz.dispatcher));
                }
            }
            this.swiz.dispatcher.dispatchEvent(new SwizEvent(SwizEvent.LOAD_COMPLETE, this.swiz));
            return;
        }// end function

        public function tearDown() : void
        {
            var _loc_1:IBeanProvider;
            for each (_loc_1 in this.swiz.beanProviders)
            {
                
                this.removeBeanProvider(_loc_1);
            }
            this.swiz.dispatcher.removeEventListener(BeanEvent.ADD_BEAN, this.handleBeanEvent);
            this.swiz.dispatcher.removeEventListener(BeanEvent.SET_UP_BEAN, this.handleBeanEvent);
            this.swiz.dispatcher.removeEventListener(BeanEvent.TEAR_DOWN_BEAN, this.handleBeanEvent);
            this.swiz.dispatcher.removeEventListener(BeanEvent.REMOVE_BEAN, this.handleBeanEvent);
            this.swiz.dispatcher.removeEventListener(this.swiz.config.setUpEventType, this.setUpEventHandler, this.swiz.config.setUpEventPhase == EventPhase.CAPTURING_PHASE);
            this.swiz.dispatcher.removeEventListener(this.swiz.config.tearDownEventType, this.tearDownEventHandler, this.swiz.config.tearDownEventPhase == EventPhase.CAPTURING_PHASE);
            if ("systemManager" in this.swiz.dispatcher)
            {
            }
            if (this.swiz.dispatcher["systemManager"] != null)
            {
            }
            if (this.swiz.dispatcher["systemManager"].hasEventListener(this.swiz.config.setUpEventType))
            {
                this.swiz.dispatcher["systemManager"].removeEventListener(this.swiz.config.setUpEventType, this.setUpEventHandlerSysMgr, this.swiz.config.setUpEventPhase == EventPhase.CAPTURING_PHASE);
                this.swiz.dispatcher["systemManager"].removeEventListener(this.swiz.config.tearDownEventType, this.tearDownEventHandler, this.swiz.config.tearDownEventPhase == EventPhase.CAPTURING_PHASE);
            }
            this.logger.info("BeanFactory torn down");
            return;
        }// end function

        protected function createBeanFromSource(_beans:Object, toString:String = null) : Bean
        {
            var _loc_3:* = this.getBeanForSource(_beans);
            if (_loc_3 == null)
            {
                _loc_3 = constructBean(_beans, toString, this.swiz.domain);
            }
            return _loc_3;
        }// end function

        protected function getBeanForSource(_beans:Object) : Bean
        {
            var _loc_2:Bean;
            for each (_loc_2 in this.beans)
            {
                
                if (_loc_2 is Prototype)
                {
                    if (Prototype(_loc_2).singleton != false)
                    {
                    }
                }
                if (Prototype(_loc_2).initialized == false)
                {
                    continue;
                    continue;
                }
                if (_loc_2.source === _beans)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function addBeanProvider(waitForSetup:IBeanProvider, target:Boolean = true) : void
        {
            var _loc_3:Bean;
            for each (_loc_3 in waitForSetup.beans)
            {
                
                this.addBean(_loc_3, false);
            }
            if (target)
            {
                for each (_loc_3 in waitForSetup.beans)
                {
                    
                    if (!(_loc_3 is Prototype))
                    {
                        this.setUpBean(_loc_3);
                    }
                }
            }
            return;
        }// end function

        public function addBean(ApplicationDomain:Bean, ENTER_FRAME:Boolean = true) : Bean
        {
            ApplicationDomain.beanFactory = this;
            this.beans.push(ApplicationDomain);
            if (ENTER_FRAME)
            {
            }
            if (!(ApplicationDomain is Prototype))
            {
                this.setUpBean(ApplicationDomain);
            }
            return ApplicationDomain;
        }// end function

        public function removeBeanProvider(waitForSetup:IBeanProvider) : void
        {
            var _loc_2:Bean;
            for each (_loc_2 in waitForSetup.beans)
            {
                
                this.removeBean(_loc_2);
            }
            return;
        }// end function

        public function removeBean(ApplicationDomain:Bean) : void
        {
            if (this.beans.indexOf(ApplicationDomain) > -1)
            {
                this.beans.splice(this.beans.indexOf(ApplicationDomain), 1);
            }
            this.tearDownBean(ApplicationDomain);
            ApplicationDomain.beanFactory = null;
            ApplicationDomain.typeDescriptor = null;
            ApplicationDomain.source = null;
            ApplicationDomain = null;
            return;
        }// end function

        public function getBeanByName(typeDescriptor:String) : Bean
        {
            var _loc_3:Bean;
            var _loc_2:Bean;
            for each (_loc_3 in this.beans)
            {
                
                if (_loc_3.name == typeDescriptor)
                {
                    _loc_2 = _loc_3;
                    break;
                }
            }
            if (_loc_2 != null)
            {
            }
            if (!(_loc_2 is Prototype))
            {
            }
            if (!_loc_2.initialized)
            {
                this.setUpBean(_loc_2);
            }
            else
            {
                if (_loc_2 == null)
                {
                }
                if (this.parentBeanFactory != null)
                {
                    _loc_2 = this.parentBeanFactory.getBeanByName(typeDescriptor);
                }
            }
            return _loc_2;
        }// end function

        public function getBeanByType(getBeanByType:Class) : Bean
        {
            var _loc_2:Bean;
            var _loc_4:Bean;
            var _loc_3:* = getQualifiedClassName(getBeanByType);
            for each (_loc_4 in this.beans)
            {
                
                if (_loc_4.typeDescriptor.satisfiesType(_loc_3))
                {
                    if (_loc_2 != null)
                    {
                        throw new Error("AmbiguousReferenceError. More than one bean was found with type: " + getBeanByType);
                    }
                    _loc_2 = _loc_4;
                }
            }
            if (_loc_2 != null)
            {
            }
            if (!(_loc_2 is Prototype))
            {
            }
            if (!_loc_2.initialized)
            {
                this.setUpBean(_loc_2);
            }
            else
            {
                if (_loc_2 == null)
                {
                }
                if (this.parentBeanFactory != null)
                {
                    _loc_2 = this.parentBeanFactory.getBeanByType(getBeanByType);
                }
            }
            return _loc_2;
        }// end function

        public function set parentBeanFactory(enterFrameHandler:IBeanFactory) : void
        {
            this._parentBeanFactory = enterFrameHandler;
            return;
        }// end function

        public function get parentBeanFactory() : IBeanFactory
        {
            return this._parentBeanFactory;
        }// end function

        public function runFactoryProcessors() : void
        {
            var _loc_1:IProcessor;
            for each (_loc_1 in this.swiz.processors)
            {
                
                if (_loc_1 is IFactoryProcessor)
                {
                    IFactoryProcessor(_loc_1).setUpFactory(this);
                }
            }
            return;
        }// end function

        public function setUpBean(ApplicationDomain:Bean) : void
        {
            var _loc_2:IProcessor;
            var _loc_3:IMetadataProcessor;
            var _loc_4:Array;
            var _loc_5:String;
            if (ApplicationDomain.initialized)
            {
                return;
            }
            this.logger.debug("BeanFactory::setUpBean( {0} )", ApplicationDomain);
            ApplicationDomain.initialized = true;
            for each (_loc_2 in this.swiz.processors)
            {
                
                if (_loc_2 is IFactoryProcessor)
                {
                    continue;
                }
                if (_loc_2 is IMetadataProcessor)
                {
                    _loc_3 = IMetadataProcessor(_loc_2);
                    _loc_4 = [];
                    for each (_loc_5 in _loc_3.metadataNames)
                    {
                        
                        _loc_4 = _loc_4.concat(ApplicationDomain.typeDescriptor.getMetadataTagsByName(_loc_5));
                    }
                    _loc_3.setUpMetadataTags(_loc_4, ApplicationDomain);
                }
                if (_loc_2 is IBeanProcessor)
                {
                    IBeanProcessor(_loc_2).setUpBean(ApplicationDomain);
                }
            }
            return;
        }// end function

        public function tearDownBean(ApplicationDomain:Bean) : void
        {
            var _loc_2:IProcessor;
            var _loc_3:IMetadataProcessor;
            var _loc_4:Array;
            var _loc_5:String;
            for each (_loc_2 in this.swiz.processors)
            {
                
                if (_loc_2 is IFactoryProcessor)
                {
                    continue;
                }
                if (_loc_2 is IMetadataProcessor)
                {
                    _loc_3 = IMetadataProcessor(_loc_2);
                    _loc_4 = [];
                    for each (_loc_5 in _loc_3.metadataNames)
                    {
                        
                        _loc_4 = _loc_4.concat(ApplicationDomain.typeDescriptor.getMetadataTagsByName(_loc_5));
                    }
                    _loc_3.tearDownMetadataTags(_loc_4, ApplicationDomain);
                }
                if (_loc_2 is IBeanProcessor)
                {
                    IBeanProcessor(_loc_2).tearDownBean(ApplicationDomain);
                }
            }
            ApplicationDomain.initialized = false;
            return;
        }// end function

        protected function handleBeanEvent(:BeanEvent) : void
        {
            var _loc_2:* = this.getBeanForSource(source);
            switch(type)
            {
                case BeanEvent.ADD_BEAN:
                {
                    if (_loc_2)
                    {
                        this.logger.warn("{0} already exists as a bean. Ignoring ADD_BEAN request.", source.toString());
                    }
                    else
                    {
                        this.addBean(constructBean(source, beanName, this.swiz.domain));
                    }
                    break;
                }
                case BeanEvent.SET_UP_BEAN:
                {
                    if (_loc_2)
                    {
                        if (_loc_2.initialized)
                        {
                            this.logger.warn("{0} is already set up as a bean. Ignoring SET_UP_BEAN request.", source.toString());
                        }
                        else
                        {
                            this.setUpBean(_loc_2);
                        }
                    }
                    else
                    {
                        this.setUpBean(constructBean(source, beanName, this.swiz.domain));
                    }
                    break;
                }
                case BeanEvent.TEAR_DOWN_BEAN:
                {
                    if (_loc_2)
                    {
                        this.tearDownBean(_loc_2);
                    }
                    else
                    {
                        this.tearDownBean(constructBean(source, null, this.swiz.domain));
                    }
                    break;
                }
                case BeanEvent.REMOVE_BEAN:
                {
                    if (_loc_2)
                    {
                        this.removeBean(_loc_2);
                    }
                    else
                    {
                        this.logger.warn("Could not find bean with {0} as its source. Ignoring REMOVE_BEAN request.", source.toString());
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function isPotentialInjectionTarget(:Object) : Boolean
        {
            var _loc_3:String;
            var _loc_2:* = getQualifiedClassName();
            if (!this.swiz.domain.hasDefinition(_loc_2))
            {
                return false;
            }
            if (this.swiz.config.viewPackages.length > 0)
            {
                for each (_loc_3 in this.swiz.config.viewPackages)
                {
                    
                    if (_loc_2.indexOf(_loc_3) == 0)
                    {
                    }
                    if (_loc_2.indexOf("__") < 0)
                    {
                        return true;
                    }
                }
                return false;
            }
            else
            {
                return !this.ignoredClasses.test(_loc_2);
            }
        }// end function

        protected function setUpEventHandler(:Event) : void
        {
            var _loc_2:int;
            if (target is ISetUpValidator)
            {
            }
            if (!ISetUpValidator(target).allowSetUp())
            {
                return;
            }
            if (this.isPotentialInjectionTarget(target))
            {
                _loc_2 = this.removedDisplayObjects.indexOf(target);
                if (_loc_2 != -1)
                {
                    this.removedDisplayObjects.splice(_loc_2, 1);
                    if (this.removedDisplayObjects.length == 0)
                    {
                        this.swiz.dispatcher.removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
                        this.isListeningForEnterFrame = false;
                    }
                    return;
                }
                SwizManager.setUp(DisplayObject(target));
            }
            return;
        }// end function

        protected function setUpEventHandlerSysMgr(:Event) : void
        {
            if (!Sprite(this.swiz.dispatcher).contains(DisplayObject(target)))
            {
                this.setUpEventHandler();
            }
            return;
        }// end function

        protected function tearDownEventHandler(:Event) : void
        {
            if (target is ITearDownValidator)
            {
            }
            if (!ITearDownValidator(target).allowTearDown())
            {
                return;
            }
            if (!this.isPotentialInjectionTarget(target))
            {
                return;
            }
            if (SwizManager.wiredViews[target])
            {
                this.addRemovedDisplayObject(DisplayObject(target));
            }
            if (target is ModuleTypeUtil.MODULE_TYPE)
            {
                this.addRemovedDisplayObject(DisplayObject(target));
            }
            return;
        }// end function

        protected function addRemovedDisplayObject(:DisplayObject) : void
        {
            if (this.removedDisplayObjects.indexOf() == -1)
            {
                this.removedDisplayObjects.push();
            }
            if (!this.isListeningForEnterFrame)
            {
                this.swiz.dispatcher.addEventListener(Event.ENTER_FRAME, this.enterFrameHandler, false, 0, true);
                this.isListeningForEnterFrame = true;
            }
            return;
        }// end function

        protected function enterFrameHandler(:Event) : void
        {
            this.swiz.dispatcher.removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
            this.isListeningForEnterFrame = false;
            var _loc_2:* = DisplayObject(this.removedDisplayObjects.shift());
            while (_loc_2)
            {
                
                SwizManager.tearDown(_loc_2);
                _loc_2 = DisplayObject(this.removedDisplayObjects.shift());
            }
            return;
        }// end function

        public static function constructBean(getTypeDescriptor, typeDescriptor:String, String:ApplicationDomain) : Bean
        {
            var _loc_4:Bean;
            if (getTypeDescriptor is Bean)
            {
                _loc_4 = Bean(getTypeDescriptor);
            }
            else
            {
                _loc_4 = new Bean();
                _loc_4.source = getTypeDescriptor;
            }
            if (true)
            {
            }
            _loc_4.name = typeDescriptor;
            _loc_4.typeDescriptor = TypeCache.getTypeDescriptor(_loc_4.type, String);
            return _loc_4;
        }// end function

    }
}
