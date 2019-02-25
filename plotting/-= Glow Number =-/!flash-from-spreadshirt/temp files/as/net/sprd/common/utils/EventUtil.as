package net.sprd.common.utils
{
    import flash.events.*;
    import net.sprd.common.collections.*;

    public class EventUtil extends Object
    {

        public function EventUtil()
        {
            return;
        }// end function

        public static function callOnEvent(param1:Function, param2:IEventDispatcher, param3:String, param4:Boolean = false) : void
        {
            var f:* = param1;
            var dispatcher:* = param2;
            var type:* = param3;
            var condition:* = param4;
            if (condition)
            {
                this.f();
            }
            else
            {
                registerOnetimeListeners(dispatcher, [type], [function (param1:Event) : void
            {
                f();
                return;
            }// end function
            ]);
            }
            return;
        }// end function

        public static function collectAndEvents(param1:IEventDispatcher, param2:Array, param3:Event) : void
        {
            var done:Boolean;
            var incoming:ISortedSet;
            var type:String;
            var target:* = param1;
            var eventTypes:* = param2;
            var dispatch:* = param3;
            done;
            incoming = new SortedSet(null, eventTypes);
            var _loc_5:int;
            var _loc_6:* = incoming;
            while (_loc_6 in _loc_5)
            {
                
                type = _loc_6[_loc_5];
                target.addEventListener(type, function (param1:Event) : void
            {
                if (done)
                {
                    return;
                }
                incoming.remove(param1.type);
                if (incoming.size == 0)
                {
                    target.dispatchEvent(dispatch);
                    done = true;
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        public static function collectXorEvents(param1:IEventDispatcher, param2:Array) : void
        {
            var done:Boolean;
            var type:String;
            var target:* = param1;
            var eventTypes:* = param2;
            done;
            var _loc_4:int;
            var _loc_5:* = eventTypes;
            while (_loc_5 in _loc_4)
            {
                
                type = _loc_5[_loc_4];
                target.addEventListener(type, function (param1:Event) : void
            {
                if (done)
                {
                    return;
                }
                target.dispatchEvent(new WrappedEvent(param1));
                done = true;
                return;
            }// end function
            );
            }
            return;
        }// end function

        public static function registerOnetimeListeners(param1:IEventDispatcher, param2:Array, param3:Array) : void
        {
            var _loc_6:Function;
            var _loc_4:Array;
            var _loc_5:int;
            while (_loc_5++ < param2.length)
            {
                
                _loc_6 = registerListener(param1, param2[_loc_5], param3[_loc_5], param2, _loc_4);
                _loc_4[_loc_5] = _loc_6;
                param1.addEventListener(param2[_loc_5], _loc_6);
            }
            return;
        }// end function

        private static function registerListener(param1:IEventDispatcher, param2:String, param3:Function, param4:Array, param5:Array) : Function
        {
            var dispatcher:* = param1;
            var type:* = param2;
            var listener:* = param3;
            var types:* = param4;
            var innerListeners:* = param5;
            return function (param1:Event) : void
            {
                var _loc_2:*;
                while (_loc_2++ < innerListeners.length)
                {
                    
                    dispatcher.removeEventListener(types[_loc_2], innerListeners[_loc_2]);
                }
                if (listener)
                {
                    listener(param1);
                }
                return;
            }// end function
            ;
        }// end function

    }
}
