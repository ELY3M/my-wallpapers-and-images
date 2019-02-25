package net.sprd.components.common
{
    import mx.resources.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.services.statistics.*;

    public class ConfomatErrorDialog extends Object
    {
        public var statistics:IStatistics;
        private static const log:ILogger = LogContext.getLogger(this);

        public function ConfomatErrorDialog()
        {
            return;
        }// end function

        public function error(param1:String, param2:String, param3:String, param4:Function = null, param5:String = null) : void
        {
            var _loc_6:* = ResourceManager.getInstance().getString("confomat7", "messages_system.error_headline");
            if (param5)
            {
                _loc_6 = param5;
            }
            if (!param1)
            {
                param1 = "";
            }
            else
            {
                param1 = param1.substr(0, 1000);
            }
            var _loc_7:* = new ErrorDialog();
            _loc_7.show(param1, _loc_6, param4);
            if (true)
            {
            }
            if (param3)
            {
                this.statistics.track(T.getGenericErrorEvent(param2, param3));
            }
            return;
        }// end function

    }
}
