package net.sprd.common.logging.loggers
{
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.appenders.*;

    public interface ILoggerFactory
    {

        public function ILoggerFactory();

        function getLogger(param1:Object) : ILogger;

        function addAppender(param1:IAppender) : void;

        function removeAppender(param1:IAppender) : void;

        function setRootLogLevel(param1:LogLevel) : void;

        function addLogLevel(param1:Object, param2:LogLevel) : void;

        function refresh() : void;

    }
}
