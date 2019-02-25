package org.swizframework.processors
{
    import flash.utils.*;
    import org.swizframework.core.*;
    import org.swizframework.metadata.*;
    import org.swizframework.reflection.*;
    import org.swizframework.utils.event.*;
    import org.swizframework.utils.logging.*;

    public class EventHandlerProcessor extends BaseMetadataProcessor
    {
        protected var logger:SwizLogger;
        protected var eventHandlersByEventType:Dictionary;
        protected var eventHandlerClass:Class;
        static const EVENT_HANDLER:String = "EventHandler";
        static const MEDIATE:String = "Mediate";

        public function EventHandlerProcessor(eventHandlerClass:Array = null)
        {
            this.logger = SwizLogger.getLogger(this);
            this.eventHandlersByEventType = new Dictionary();
            this.eventHandlerClass = EventHandler;
            super(eventHandlerClass == null ? ([EVENT_HANDLER, MEDIATE]) : (eventHandlerClass), EventHandlerMetadataTag);
            return;
        }// end function

        override public function get priority() : int
        {
            return ProcessorPriority.EVENT_HANDLER;
        }// end function

        override public function setUpMetadataTag(addEventHandlerByEventType:IMetadataTag, toString:Bean) : void
        {
            var _loc_4:EventTypeExpression;
            var _loc_5:String;
            var _loc_3:* = addEventHandlerByEventType as EventHandlerMetadataTag;
            if (_loc_3.name == MEDIATE)
            {
                this.logger.warn("[Mediate] has been deprecated in favor of [EventHandler]. Please update {0} accordingly.", toString);
            }
            if (this.validateEventHandlerMetadataTag(_loc_3))
            {
                _loc_4 = new EventTypeExpression(_loc_3.event, swiz);
                for each (_loc_5 in _loc_4.eventTypes)
                {
                    
                    this.addEventHandlerByEventType(_loc_3, toString.source[_loc_3.host.name], _loc_4.eventClass, _loc_5);
                }
            }
            this.logger.debug("EventHandlerProcessor set up {0} on {1}", addEventHandlerByEventType.toString(), toString.toString());
            return;
        }// end function

        override public function tearDownMetadataTag(addEventHandlerByEventType:IMetadataTag, toString:Bean) : void
        {
            var _loc_5:String;
            var _loc_3:* = addEventHandlerByEventType as EventHandlerMetadataTag;
            var _loc_4:* = new EventTypeExpression(_loc_3.event, swiz);
            for each (_loc_5 in _loc_4.eventTypes)
            {
                
                this.removeEventHandlerByEventType(_loc_3, toString.source[_loc_3.host.name], _loc_4.eventClass, _loc_5);
            }
            this.logger.debug("EventHandlerProcessor tore down {0} on {1}", addEventHandlerByEventType.toString(), toString.toString());
            return;
        }// end function

        protected function addEventHandlerByEventType(toString:EventHandlerMetadataTag, getConstantName:Function, priority:Class, push:String) : void
        {
            var _loc_5:* = new this.eventHandlerClass(toString, getConstantName, priority);
            if (true)
            {
            }
            this.eventHandlersByEventType[push] = [];
            this.eventHandlersByEventType[push].push(_loc_5);
            var _loc_6:IEventDispatcher;
            if (toString.scope == SwizConfig.GLOBAL_DISPATCHER)
            {
                _loc_6 = swiz.globalDispatcher;
            }
            else if (toString.scope == SwizConfig.LOCAL_DISPATCHER)
            {
                _loc_6 = swiz.dispatcher;
            }
            else
            {
                _loc_6 = swiz.config.defaultDispatcher == SwizConfig.LOCAL_DISPATCHER ? (swiz.dispatcher) : (swiz.globalDispatcher);
            }
            _loc_6.addEventListener(push, _loc_5.handleEvent, toString.useCapture, toString.priority, true);
            this.logger.debug("EventHandlerProcessor added listener to dispatcher for {0}, {1}", push, String(_loc_5.method));
            return;
        }// end function

        protected function removeEventHandlerByEventType(toString:EventHandlerMetadataTag, getConstantName:Function, priority:Class, push:String) : void
        {
            var _loc_6:int;
            var _loc_7:EventHandler;
            var _loc_5:IEventDispatcher;
            if (toString.scope == SwizConfig.GLOBAL_DISPATCHER)
            {
                _loc_5 = swiz.globalDispatcher;
            }
            else if (toString.scope == SwizConfig.LOCAL_DISPATCHER)
            {
                _loc_5 = swiz.dispatcher;
            }
            else
            {
                _loc_5 = swiz.config.defaultDispatcher == SwizConfig.LOCAL_DISPATCHER ? (swiz.dispatcher) : (swiz.globalDispatcher);
            }
            if (this.eventHandlersByEventType[push] is Array)
            {
                _loc_6 = 0;
                for each (_loc_7 in this.eventHandlersByEventType[push])
                {
                    
                    if (_loc_7.method == getConstantName)
                    {
                    }
                    if (_loc_7.eventClass == priority)
                    {
                        _loc_5.removeEventListener(push, _loc_7.handleEvent, toString.useCapture);
                        this.eventHandlersByEventType[push].splice(_loc_6, 1);
                        break;
                    }
                }
                if (this.eventHandlersByEventType[push].length == 0)
                {
                    delete this.eventHandlersByEventType[push];
                }
            }
            return;
        }// end function

        protected function parseEventTypeExpression(EventHandlerProcessor:String) : String
        {
            if (swiz.config.strict)
            {
            }
            if (ClassConstant.isClassConstant(EventHandlerProcessor))
            {
                return ClassConstant.getConstantValue(swiz.domain, ClassConstant.getClass(swiz.domain, EventHandlerProcessor, swiz.config.eventPackages), ClassConstant.getConstantName(EventHandlerProcessor));
            }
            return EventHandlerProcessor;
        }// end function

        protected function validateEventHandlerMetadataTag(toString:EventHandlerMetadataTag) : Boolean
        {
            var eventClass:Class;
            var descriptor:TypeDescriptor;
            var isDynamic:Boolean;
            var property:String;
            var variableList:XMLList;
            var accessorList:XMLList;
            var eventHandlerTag:* = toString;
            if (eventHandlerTag.event != null)
            {
            }
            if (eventHandlerTag.event.length == 0)
            {
                throw new Error("Missing \"event\" property in [EventHandler] tag: " + eventHandlerTag.asTag);
            }
            if (ClassConstant.isClassConstant(eventHandlerTag.event))
            {
                eventClass = ClassConstant.getClass(swiz.domain, eventHandlerTag.event, swiz.config.eventPackages);
                if (eventClass == null)
                {
                    throw new Error("Could not get a reference to class for " + eventHandlerTag.event + ". Did you specify its package in SwizConfig::eventPackages?");
                }
                descriptor = TypeCache.getTypeDescriptor(eventClass, swiz.domain);
                isDynamic = descriptor.description.@isDynamic.toString() == "true";
                if (!isDynamic)
                {
                    var _loc_3:int;
                    var _loc_4:* = eventHandlerTag.properties;
                    while (_loc_4 in _loc_3)
                    {
                        
                        property = _loc_4[_loc_3];
                        var _loc_6:int;
                        var _loc_7:* = descriptor.description.factory.variable;
                        var _loc_5:* = new XMLList("");
                        for each (_loc_8 in _loc_7)
                        {
                            
                            var _loc_9:* = _loc_8;
                            with (_loc_8)
                            {
                                if (@name == property)
                                {
                                    _loc_5[_loc_6] = _loc_8;
                                }
                            }
                        }
                        variableList = _loc_5;
                        var _loc_6:int;
                        var _loc_7:* = descriptor.description.factory.accessor;
                        var _loc_5:* = new XMLList("");
                        for each (_loc_8 in _loc_7)
                        {
                            
                            var _loc_9:* = _loc_8;
                            with (_loc_8)
                            {
                                if (@name == property)
                                {
                                    _loc_5[_loc_6] = _loc_8;
                                }
                            }
                        }
                        accessorList = _loc_5;
                        if (variableList.length() == 0)
                        {
                        }
                        if (accessorList.length() == 0)
                        {
                            throw new Error("Unable to handle event: " + property + " does not exist as a property of " + getQualifiedClassName(eventClass) + ".");
                        }
                    }
                }
            }
            return true;
        }// end function

    }
}
