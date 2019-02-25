package org.swizframework.processors
{
    import flash.events.*;
    import flash.utils.*;
    import mx.binding.utils.*;
    import mx.utils.*;
    import org.swizframework.core.*;
    import org.swizframework.metadata.*;
    import org.swizframework.reflection.*;
    import org.swizframework.utils.logging.*;
    import org.swizframework.utils.services.*;

    public class InjectProcessor extends BaseMetadataProcessor
    {
        protected var logger:SwizLogger;
        protected var injectByProperty:Dictionary;
        protected var sharedServiceHelper:IServiceHelper;
        protected var sharedURLRequestHelper:IURLRequestHelper;
        protected var sharedMockDelegateHelper:MockDelegateHelper;
        static const INJECT:String = "Inject";
        static const AUTOWIRE:String = "Autowire";

        public function InjectProcessor(InjectMetadataTag:Array = null)
        {
            this.logger = SwizLogger.getLogger(this);
            this.injectByProperty = new Dictionary();
            super(InjectMetadataTag == null ? ([INJECT, AUTOWIRE]) : (InjectMetadataTag), InjectMetadataTag);
            return;
        }// end function

        override public function get priority() : int
        {
            return ProcessorPriority.INJECT;
        }// end function

        override public function setUpMetadataTag(getDestinationPropertyName:IMetadataTag, indexOf:Bean) : void
        {
            var _loc_4:Bean;
            var _loc_5:Object;
            var _loc_6:*;
            var _loc_7:String;
            var _loc_8:Boolean;
            var _loc_9:Object;
            var _loc_10:String;
            var _loc_3:* = getDestinationPropertyName as InjectMetadataTag;
            if (_loc_3.name == AUTOWIRE)
            {
                this.logger.warn("[Autowire] has been deprecated in favor of [Inject]. Please update {0} accordingly.", indexOf);
            }
            if (_loc_3.source == null)
            {
                this.addInjectByType(_loc_3, indexOf);
            }
            else
            {
                _loc_4 = this.getBeanByName(_loc_3.source.split(".")[0]);
                if (_loc_4 == null)
                {
                    if (_loc_3.required)
                    {
                        throw new Error("InjectionProcessorError: bean not found: " + _loc_3.source);
                    }
                    this.logger.warn("InjectProcessor could not fulfill {0} tag on {1}", _loc_3.asTag, indexOf);
                    return;
                }
                _loc_5 = _loc_3.destination == null ? (indexOf.source) : (this.getDestinationObject(indexOf.source, _loc_3.destination));
                _loc_6 = this.getDestinationPropertyName(_loc_3);
                _loc_7 = _loc_3.source.substr(_loc_3.source.indexOf(".") + 1);
                if (_loc_3.bind)
                {
                }
                if (ChangeWatcher.canWatch(_loc_4.source, _loc_7))
                {
                    ChangeWatcher.canWatch(_loc_4.source, _loc_7);
                }
                _loc_8 = !(_loc_6 is QName);
                if (_loc_3.source.indexOf(".") < 0)
                {
                    this.setDestinationValue(_loc_3, indexOf, _loc_4.source);
                }
                else if (!_loc_8)
                {
                    _loc_9 = this.getDestinationObject(_loc_4.source, _loc_7);
                    this.setDestinationValue(_loc_3, indexOf, _loc_9[_loc_3.source.split(".").pop()]);
                    if (_loc_6 is QName)
                    {
                    }
                    if (_loc_3.bind == true)
                    {
                        _loc_10 = "Cannot create a binding for " + getDestinationPropertyName.asTag + " because " + _loc_3.source.split(".").pop() + " is not public. ";
                        _loc_10 = _loc_10 + "Add bind=false to your Inject tag or make the property public.";
                        throw new Error(_loc_10);
                    }
                }
                else
                {
                    this.addPropertyBinding(_loc_5, _loc_6, _loc_4.source, _loc_3.source.split(".").slice(1), _loc_3.twoWay);
                }
            }
            this.logger.debug("InjectProcessor set up {0} on {1}", getDestinationPropertyName.toString(), indexOf.toString());
            return;
        }// end function

        override public function tearDownMetadataTag(getDestinationPropertyName:IMetadataTag, indexOf:Bean) : void
        {
            var _loc_3:* = getDestinationPropertyName as InjectMetadataTag;
            if (_loc_3.source != null)
            {
                if (_loc_3.source.indexOf(".") > -1)
                {
                    this.removeInjectByProperty(_loc_3, indexOf);
                }
                else
                {
                    this.removeInjectByName(_loc_3, indexOf);
                }
            }
            else
            {
                this.removeInjectByType(_loc_3, indexOf);
            }
            this.logger.debug("InjectProcessor tore down {0} on {1}", getDestinationPropertyName.toString(), indexOf.toString());
            return;
        }// end function

        protected function getDestinationObject(asTag:Object, bindProperty:String) : Object
        {
            var _loc_3:* = bindProperty.split(".");
            var _loc_4:* = asTag;
            while (_loc_3.length > 1)
            {
                
                _loc_4 = _loc_4[_loc_3.shift()];
            }
            return _loc_4;
        }// end function

        protected function getDestinationPropertyName(substr:InjectMetadataTag)
        {
            if (substr.destination == null)
            {
                return substr.host.name;
            }
            return substr.destination.split(".").pop();
        }// end function

        protected function removeInjectByProperty(substr:InjectMetadataTag, indexOf:Bean) : void
        {
            var _loc_3:* = this.getBeanByName(substr.source.split(".")[0]);
            this.removePropertyBinding(indexOf, _loc_3, substr);
            this.setDestinationValue(substr, indexOf, null);
            return;
        }// end function

        protected function removeInjectByName(substr:InjectMetadataTag, indexOf:Bean) : void
        {
            this.setDestinationValue(substr, indexOf, null);
            return;
        }// end function

        protected function addInjectByType(substr:InjectMetadataTag, indexOf:Bean) : void
        {
            var _loc_3:* = substr.host is MetadataHostMethod;
            var _loc_4:* = _loc_3 ? (MethodParameter(MetadataHostMethod(substr.host).parameters[0]).type) : (substr.host.type);
            if (_loc_4 == null)
            {
            }
            if (substr.host is MetadataHostClass)
            {
                _loc_4 = swiz.domain.getDefinition(substr.host.name) as Class;
            }
            var _loc_5:* = this.getBeanByType(_loc_4);
            if (_loc_5)
            {
                this.setDestinationValue(substr, indexOf, _loc_5.source);
            }
            else
            {
                switch(_loc_4)
                {
                    case ServiceHelper:
                    case IServiceHelper:
                    {
                        if (this.sharedServiceHelper == null)
                        {
                            this.sharedServiceHelper = new ServiceHelper();
                            ISwizAware(this.sharedServiceHelper).org.swizframework.core:ISwizAware::swiz = swiz;
                        }
                        this.setDestinationValue(substr, indexOf, this.sharedServiceHelper);
                        return;
                    }
                    case URLRequestHelper:
                    case IURLRequestHelper:
                    {
                        if (this.sharedURLRequestHelper == null)
                        {
                            this.sharedURLRequestHelper = new URLRequestHelper();
                            ISwizAware(this.sharedURLRequestHelper).org.swizframework.core:ISwizAware::swiz = swiz;
                        }
                        this.setDestinationValue(substr, indexOf, this.sharedURLRequestHelper);
                        return;
                    }
                    case MockDelegateHelper:
                    {
                        if (this.sharedMockDelegateHelper == null)
                        {
                            this.sharedMockDelegateHelper = new MockDelegateHelper();
                        }
                        this.setDestinationValue(substr, indexOf, this.sharedMockDelegateHelper);
                        return;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (substr.required)
                {
                    throw new Error("InjectProcessor Error: bean of type " + _loc_4.toString() + " not found!");
                }
                this.logger.warn("Bean of type {0} not found, injection queues have been removed!", _loc_4.toString());
            }
            return;
        }// end function

        protected function removeInjectByType(substr:InjectMetadataTag, indexOf:Bean) : void
        {
            this.setDestinationValue(substr, indexOf, null);
            return;
        }// end function

        protected function setDestinationValue(substr:InjectMetadataTag, indexOf:Bean, ) : void
        {
            var _loc_7:Function;
            var _loc_4:* = substr.host is MetadataHostMethod;
            var _loc_5:* = substr.destination == null ? (indexOf.source) : (this.getDestinationObject(indexOf.source, substr.destination));
            var _loc_6:* = this.getDestinationPropertyName(substr);
            if (_loc_4)
            {
                _loc_7 = _loc_5[_loc_6] as Function;
                _loc_7.apply(_loc_5, []);
            }
            else
            {
                _loc_5[_loc_6] = ;
            }
            return;
        }// end function

        protected function getBeanByName(bind:String) : Bean
        {
            return beanFactory.org.swizframework.core:IBeanFactory::getBeanByName(bind);
        }// end function

        protected function getBeanByType(EventDispatcher:Class) : Bean
        {
            return beanFactory.org.swizframework.core:IBeanFactory::getBeanByType(EventDispatcher);
        }// end function

        protected function addPropertyBinding(asTag:Object, slice:String, domain:Object, :Array, sharedMockDelegateHelper:Boolean = false) : void
        {
            var cw:ChangeWatcher;
            var uid:String;
            var sourcePropName:String;
            var destObject:* = asTag;
            var destPropName:* = slice;
            var sourceObject:* = domain;
            var sourcePropertyChain:* = ;
            var twoWay:* = sharedMockDelegateHelper;
            uid = UIDUtil.getUID(destObject);
            if (true)
            {
            }
            this.injectByProperty[uid] = [];
            try
            {
                if (destObject[destPropName] is Function)
                {
                    this.injectByProperty[uid].push(BindingUtils.bindSetter(destObject[destPropName], sourceObject, sourcePropertyChain));
                }
                else
                {
                    this.injectByProperty[uid].push(BindingUtils.bindProperty(destObject, destPropName, sourceObject, sourcePropertyChain));
                }
            }
            catch (error:ReferenceError)
            {
                injectByProperty[uid].push(BindingUtils.bindProperty(destObject, destPropName, sourceObject, sourcePropertyChain));
                if (twoWay)
                {
                    logger.error("Cannot create twoWay binding for {0} property on {1} because it is write-only.", destPropName, destObject);
                    return;
                }
            }
            if (twoWay)
            {
                if (destObject[destPropName] is Function)
                {
                    this.logger.error("Cannot create twoWay binding for {0} method on {1} because methods cannot be binding sources.", destPropName, destObject);
                    return;
                }
                while (sourcePropertyChain.length > 1)
                {
                    
                    sourceObject = sourceObject[sourcePropertyChain.shift()];
                }
                sourcePropName = sourcePropertyChain[0];
                if (ChangeWatcher.canWatch(destObject, destPropName))
                {
                    this.injectByProperty[uid].push(BindingUtils.bindProperty(sourceObject, sourcePropName, destObject, destPropName));
                }
                else
                {
                    this.logger.error("Cannot create twoWay binding for {0} property on {1} because it is not bindable.", destPropName, destObject);
                }
            }
            return;
        }// end function

        protected function removePropertyBinding(name:Bean, QName:Bean, substr:InjectMetadataTag) : void
        {
            var _loc_6:ChangeWatcher;
            var _loc_4:* = substr.destination == null ? (name.source) : (this.getDestinationObject(name.source, substr.destination));
            var _loc_5:* = UIDUtil.getUID(_loc_4);
            for each (_loc_6 in this.injectByProperty[_loc_5])
            {
                
                _loc_6.unwatch();
            }
            delete this.injectByProperty[_loc_5];
            return;
        }// end function

    }
}
