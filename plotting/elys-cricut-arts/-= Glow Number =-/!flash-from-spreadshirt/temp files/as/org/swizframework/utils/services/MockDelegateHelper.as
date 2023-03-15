package org.swizframework.utils.services
{
    import flash.events.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.managers.*;
    import mx.rpc.*;
    import mx.rpc.events.*;

    public class MockDelegateHelper extends Object
    {
        public var calls:Dictionary;
        public var fault:Fault;
        public var showBusyCursor:Boolean;

        public function MockDelegateHelper(Boolean:Boolean = false)
        {
            this.showBusyCursor = Boolean;
            this.calls = new Dictionary();
            return;
        }// end function

        public function createMockResult(sendMockResult:Object, addEventListener:int = 10) : AsyncToken
        {
            var _loc_3:* = new AsyncToken();
            _loc_3.data = sendMockResult;
            var _loc_4:* = new Timer(addEventListener, 1);
            _loc_4.addEventListener(TimerEvent.TIMER, this.sendMockResult);
            _loc_4.start();
            this.calls[_loc_4] = _loc_3;
            if (this.showBusyCursor)
            {
                CursorManager.setBusyCursor();
            }
            return _loc_3;
        }// end function

        protected function sendMockResult(createMockFault:TimerEvent) : void
        {
            var _loc_3:AsyncToken;
            var _loc_4:Object;
            if (this.showBusyCursor)
            {
                CursorManager.removeBusyCursor();
            }
            var _loc_2:* = Timer(createMockFault.target);
            _loc_2.removeEventListener(TimerEvent.TIMER, this.sendMockResult);
            if (this.calls[_loc_2] is AsyncToken)
            {
                _loc_3 = AsyncToken(this.calls[_loc_2]);
                delete this.calls[_loc_2];
                _loc_4 = _loc_3.data ? (_loc_3.data) : (new Object());
                var _loc_5:* = _loc_3;
                _loc_5.mx_internal::applyResult(ResultEvent.createEvent(_loc_4, _loc_3));
            }
            _loc_2 = null;
            return;
        }// end function

        public function createMockFault(:Fault = null, addEventListener:int = 10) : AsyncToken
        {
            var _loc_3:* = new AsyncToken();
            _loc_3.data = ;
            var _loc_4:* = new Timer(addEventListener, 1);
            _loc_4.addEventListener(TimerEvent.TIMER, this.sendMockFault);
            _loc_4.start();
            this.calls[_loc_4] = _loc_3;
            if (this.showBusyCursor)
            {
                CursorManager.setBusyCursor();
            }
            return _loc_3;
        }// end function

        protected function sendMockFault(createMockFault:TimerEvent) : void
        {
            var _loc_3:AsyncToken;
            var _loc_4:Fault;
            if (this.showBusyCursor)
            {
                CursorManager.removeBusyCursor();
            }
            var _loc_2:* = Timer(createMockFault.target);
            _loc_2.removeEventListener(TimerEvent.TIMER, this.sendMockFault);
            if (this.calls[_loc_2] is AsyncToken)
            {
                _loc_3 = this.calls[_loc_2];
                delete this.calls[_loc_2];
                _loc_4 = _loc_3.data ? (_loc_3.data) : (null);
                var _loc_5:* = _loc_3;
                _loc_5.mx_internal::applyFault(FaultEvent.createEvent(_loc_4, _loc_3));
            }
            _loc_2 = null;
            return;
        }// end function

    }
}
