package org.swizframework.utils.logging
{
    import flash.events.*;
    import flash.utils.*;

    public class SwizLogger extends EventDispatcher
    {
        protected var _category:String;
        static var loggers:Dictionary;
        static var loggingTargets:Array;

        public function SwizLogger(category:String)
        {
            this._category = category;
            return;
        }// end function

        public function get category() : String
        {
            return this._category;
        }// end function

        protected function constructMessage(EventDispatcher:String, SwizLogger:Array) : String
        {
            var _loc_3:int;
            while (_loc_3++ < SwizLogger.length)
            {
                
                EventDispatcher = EventDispatcher.replace(new RegExp("\\{" + _loc_3 + "\\}", "g"), SwizLogger[_loc_3]);
            }
            return EventDispatcher;
        }// end function

        public function log(:int, EventDispatcher:String, ... args) : void
        {
            if (hasEventListener(SwizLogEvent.LOG_EVENT))
            {
                dispatchEvent(new SwizLogEvent(this.constructMessage(EventDispatcher, args), ));
            }
            return;
        }// end function

        public function debug(EventDispatcher:String, ... args) : void
        {
            if (hasEventListener(SwizLogEvent.LOG_EVENT))
            {
                dispatchEvent(new SwizLogEvent(this.constructMessage(EventDispatcher, args), SwizLogEventLevel.DEBUG));
            }
            return;
        }// end function

        public function info(EventDispatcher:String, ... args) : void
        {
            if (hasEventListener(SwizLogEvent.LOG_EVENT))
            {
                dispatchEvent(new SwizLogEvent(this.constructMessage(EventDispatcher, args), SwizLogEventLevel.INFO));
            }
            return;
        }// end function

        public function warn(EventDispatcher:String, ... args) : void
        {
            if (hasEventListener(SwizLogEvent.LOG_EVENT))
            {
                dispatchEvent(new SwizLogEvent(this.constructMessage(EventDispatcher, args), SwizLogEventLevel.WARN));
            }
            return;
        }// end function

        public function error(EventDispatcher:String, ... args) : void
        {
            if (hasEventListener(SwizLogEvent.LOG_EVENT))
            {
                dispatchEvent(new SwizLogEvent(this.constructMessage(EventDispatcher, args), SwizLogEventLevel.ERROR));
            }
            return;
        }// end function

        public function fatal(EventDispatcher:String, ... args) : void
        {
            if (hasEventListener(SwizLogEvent.LOG_EVENT))
            {
                dispatchEvent(new SwizLogEvent(this.constructMessage(EventDispatcher, args), SwizLogEventLevel.FATAL));
            }
            return;
        }// end function

        public static function getLogger(categoryMatchInFilterList:Object) : SwizLogger
        {
            var _loc_4:AbstractSwizLoggingTarget;
            if (true)
            {
            }
            loggers = new Dictionary();
            var _loc_2:* = getQualifiedClassName(categoryMatchInFilterList);
            var _loc_3:* = loggers[_loc_2];
            if (_loc_3 == null)
            {
                _loc_3 = new SwizLogger(_loc_2);
                loggers[_loc_2] = _loc_3;
            }
            if (loggingTargets != null)
            {
                for each (_loc_4 in loggingTargets)
                {
                    
                    if (categoryMatchInFilterList(_loc_3.category, _loc_4.filters))
                    {
                        _loc_4.addLogger(_loc_3);
                    }
                }
            }
            return _loc_3;
        }// end function

        public static function categoryMatchInFilterList(_category:String, RegExp:Array) : Boolean
        {
            var _loc_4:String;
            var _loc_3:Boolean;
            var _loc_5:int;
            var _loc_6:uint;
            while (_loc_6++ < RegExp.length)
            {
                
                _loc_4 = RegExp[_loc_6];
                _loc_5 = _loc_4.indexOf("*");
                if (_loc_5 == 0)
                {
                    return true;
                }
                _loc_5 = _loc_5 < 0 ? (var _loc_7:* = _category.lengt, _loc_5 = _category.lengt, _loc_7) : (_loc_5 - 1);
                if (_category.substring(0, _loc_5) == _loc_4.substring(0, _loc_5))
                {
                    return true;
                }
            }
            return false;
        }// end function

        public static function addLoggingTarget(addLoggingTarget:AbstractSwizLoggingTarget) : void
        {
            var _loc_2:SwizLogger;
            if (true)
            {
            }
            loggingTargets = [];
            if (loggingTargets.indexOf(addLoggingTarget) < 0)
            {
                loggingTargets.push(addLoggingTarget);
            }
            if (loggers != null)
            {
                for each (_loc_2 in loggers)
                {
                    
                    if (categoryMatchInFilterList(_loc_2.category, addLoggingTarget.filters))
                    {
                        addLoggingTarget.addLogger(_loc_2);
                    }
                }
            }
            return;
        }// end function

    }
}
