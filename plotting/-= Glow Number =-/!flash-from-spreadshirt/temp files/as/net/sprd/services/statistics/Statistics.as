package net.sprd.services.statistics
{
    import com.omniture.*;
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import mx.core.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;

    public class Statistics extends EventDispatcher implements IStatistics
    {
        private static const log:ILogger = LogContext.getLogger(this);
        private static var appMeasurement:AppMeasurement;
        private static var trackedEvents:Object = {};

        public function Statistics(param1:Boolean = false, param2:Stage = null)
        {
            if (param1)
            {
                bootstrapAppMeasurement(param2);
            }
            return;
        }// end function

        public function bootstrap() : void
        {
            bootstrapAppMeasurement();
            return;
        }// end function

        public function track(param1:TrackingEvent) : void
        {
            var propName:String;
            var evarName:String;
            var event:* = param1;
            if (event is NullEvent)
            {
                return;
            }
            if (event.oneTimeIdentifier)
            {
                if (trackedEvents[event.oneTimeIdentifier])
                {
                    return;
                }
                trackedEvents[event.oneTimeIdentifier] = true;
            }
            var info:* = event.getTrackingInfo();
            if (ConfomatConfiguration.mode == ConfomatModes.ADMIN)
            {
                return;
            }
            var _loc_3:int;
            var _loc_4:* = info.props;
            while (_loc_4 in _loc_3)
            {
                
                propName = _loc_4[_loc_3];
                appMeasurement[propName] = info.props[propName];
            }
            var _loc_3:int;
            var _loc_4:* = info.evars;
            while (_loc_4 in _loc_3)
            {
                
                evarName = _loc_4[_loc_3];
                appMeasurement[evarName] = info.evars[evarName];
            }
            appMeasurement.events = info.events ? (info.events.join(",")) : ("");
            try
            {
                appMeasurement.trackLink(appMeasurement.parent.loaderInfo.url, "o", null);
            }
            catch (e:Error)
            {
                log.warn("Error in tracking: " + e);
            }
            appMeasurement.clearVars();
            return;
        }// end function

        private static function bootstrapAppMeasurement(param1:DisplayObjectContainer = null) : void
        {
            if (appMeasurement)
            {
                return;
            }
            appMeasurement = new AppMeasurement();
            if (!param1)
            {
                param1 = FlexGlobals.topLevelApplication.parent;
            }
            param1.addChild(appMeasurement);
            appMeasurement.debugTracking = false;
            appMeasurement.trackLocal = true;
            appMeasurement.trackClickMap = true;
            appMeasurement.delayTracking = 500;
            appMeasurement.movieID = "Confomat";
            var _loc_2:* = ExternalInterface.call("eval", "requiredMajorVersion");
            var _loc_3:* = ExternalInterface.call("eval", "s_account");
            if (_loc_3)
            {
                appMeasurement.account = _loc_3;
                appMeasurement.visitorNamespace = ExternalInterface.call("eval", "s.visitorNamespace");
                appMeasurement.charSet = ExternalInterface.call("eval", "s.charSet");
                appMeasurement.dc = ExternalInterface.call("eval", "s.dc");
                appMeasurement.trackingServer = ExternalInterface.call("eval", "s.trackingServer");
                appMeasurement.trackingServerSecure = ExternalInterface.call("eval", "s.trackingServerSecure");
                appMeasurement.currencyCode = ExternalInterface.call("eval", "s.currencyCode");
                appMeasurement.pageName = ExternalInterface.call("eval", "s.pageName");
            }
            return;
        }// end function

    }
}
