package net.sprd.services.statistics
{

    public class TrackingInfo extends Object
    {
        public var events:Array;
        public var props:Object;
        public var evars:Object;

        public function TrackingInfo(param1:Array = null, param2:Object = null, param3:Object = null)
        {
            this.events = param1 ? (param1) : ([]);
            this.props = param2 ? (param2) : ({});
            this.evars = param3 ? (param3) : ({});
            return;
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
