package net.sprd.common.logging.appenders
{
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;

    public interface IAppender
    {

        public function IAppender();

        function get threshold() : LogLevel;

        function set threshold(param1:LogLevel) : void;

        function registerLogger(param1:ILogger) : void;

        function unregisterLogger(param1:ILogger) : void;

    }
}
