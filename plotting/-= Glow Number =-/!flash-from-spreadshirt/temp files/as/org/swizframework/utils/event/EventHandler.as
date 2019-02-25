package org.swizframework.utils.event
{
    import flash.events.*;
    import flash.utils.*;
    import mx.rpc.*;
    import org.swizframework.metadata.*;
    import org.swizframework.reflection.*;
    import org.swizframework.utils.async.*;

    public class EventHandler extends Object
    {
        protected var _metadataTag:EventHandlerMetadataTag;
        protected var _method:Function;
        protected var _eventClass:Class;

        public function EventHandler(getRequiredParameterCount:EventHandlerMetadataTag, getParameterCount:Function, getParameterType:Class)
        {
            this._metadataTag = getRequiredParameterCount;
            this._method = getParameterCount;
            this._eventClass = getParameterType;
            return;
        }// end function

        public function get metadataTag() : EventHandlerMetadataTag
        {
            return this._metadataTag;
        }// end function

        public function get method() : Function
        {
            return this._method;
        }// end function

        public function get eventClass() : Class
        {
            return this._eventClass;
        }// end function

        public function handleEvent(host:Event) : void
        {
            if (this.eventClass != null)
            {
            }
            if (!(host is this.eventClass))
            {
                return;
            }
            var _loc_2:*;
            if (this.metadataTag.properties != null)
            {
                if (this.validateEvent(host, this.metadataTag.properties))
                {
                    _loc_2 = this.method.apply(null, this.getEventArgs(host, this.metadataTag.properties));
                }
            }
            else if (this.getRequiredParameterCount() <= 1)
            {
                if (this.getParameterCount() > 0)
                {
                }
                if (host is this.getParameterType(0))
                {
                    _loc_2 = this.method.apply(null, [host]);
                }
                else
                {
                    _loc_2 = this.method.apply();
                }
            }
            else
            {
                throw new Error("Unable to handle event: " + this.metadataTag.host.name + "() requires " + this.getRequiredParameterCount() + " parameters, and no properties were specified.");
            }
            if (host is IAsynchronousEvent)
            {
            }
            if (IAsynchronousEvent(host).step != null)
            {
                if (_loc_2 is IAsynchronousOperation)
                {
                    IAsynchronousEvent(host).step.addAsynchronousOperation(_loc_2 as IAsynchronousOperation);
                }
                else if (_loc_2 is AsyncToken)
                {
                    IAsynchronousEvent(host).step.addAsynchronousOperation(new AsyncTokenOperation(_loc_2 as AsyncToken));
                }
            }
            if (this.metadataTag.stopPropagation)
            {
                host.stopPropagation();
            }
            if (this.metadataTag.stopImmediatePropagation)
            {
                host.stopImmediatePropagation();
            }
            return;
        }// end function

        protected function validateEvent(host:Event, IAsynchronousEvent:Array) : Boolean
        {
            var _loc_3:String;
            for each (_loc_3 in IAsynchronousEvent)
            {
                
                if (!(_loc_3 in host))
                {
                    throw new Error("Unable to handle event: " + _loc_3 + " does not exist as a property of " + getQualifiedClassName(host) + ".");
                }
            }
            return true;
        }// end function

        protected function getEventArgs(host:Event, IAsynchronousEvent:Array) : Array
        {
            var _loc_4:String;
            var _loc_3:Array;
            for each (_loc_4 in IAsynchronousEvent)
            {
                
                _loc_3[_loc_3.length] = host[_loc_4];
            }
            return _loc_3;
        }// end function

        protected function getParameterCount() : int
        {
            return (this.metadataTag.host as MetadataHostMethod).parameters.length;
        }// end function

        protected function getRequiredParameterCount() : int
        {
            var _loc_3:MethodParameter;
            var _loc_1:int;
            var _loc_2:* = (this.metadataTag.host as MetadataHostMethod).parameters;
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3.optional)
                {
                    break;
                }
            }
            return _loc_1++;
        }// end function

        protected function getParameterType(:int) : Class
        {
            var _loc_2:* = (this.metadataTag.host as MetadataHostMethod).parameters;
            if ( < _loc_2.length)
            {
                return (_loc_2[] as MethodParameter).type;
            }
            return null;
        }// end function

    }
}
