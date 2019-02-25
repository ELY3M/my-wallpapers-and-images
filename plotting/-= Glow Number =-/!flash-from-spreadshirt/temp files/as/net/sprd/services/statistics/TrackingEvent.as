package net.sprd.services.statistics
{

    public class TrackingEvent extends Object
    {
        public var events:Array;
        public var props:Object;
        public var evars:Object;
        private var _oneTimeIdentifier:String;

        public function TrackingEvent(param1:String = null, param2:Array = null, param3:Object = null, param4:Object = null)
        {
            this._oneTimeIdentifier = param1;
            this.events = param2 ? (param2) : ([]);
            this.props = param3 ? (param3) : ({});
            this.evars = param4 ? (param4) : ({});
            return;
        }// end function

        public function get oneTimeIdentifier() : String
        {
            return this._oneTimeIdentifier;
        }// end function

        public function getTrackingInfo() : TrackingInfo
        {
            return new TrackingInfo(this.events, this.props, this.evars);
        }// end function

        public function toString() : String
        {
            var _loc_2:String;
            var _loc_3:String;
            var _loc_1:String;
            for each (_loc_2 in this.events)
            {
                
                _loc_1 = _loc_1 + (" " + _loc_2);
            }
            for (_loc_3 in this.props)
            {
                
                _loc_1 = _loc_1 + (" " + _loc_3);
            }
            for (_loc_3 in this.evars)
            {
                
                _loc_1 = _loc_1 + (" " + _loc_3);
            }
            return _loc_1;
        }// end function

    }
}
