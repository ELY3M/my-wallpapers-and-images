package org.swizframework.utils.logging
{

    public class AbstractSwizLoggingTarget extends Object
    {
        private var _filters:Array;
        private var _level:int;

        public function AbstractSwizLoggingTarget()
        {
            this._filters = ["*"];
            this._level = SwizLogEventLevel.ALL;
            return;
        }// end function

        public function get filters() : Array
        {
            return this._filters;
        }// end function

        public function set filters(removeEventListener:Array) : void
        {
            this._filters = removeEventListener;
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set level(removeEventListener:int) : void
        {
            this._level = removeEventListener;
            return;
        }// end function

        public function addLogger(AbstractSwizLoggingTarget:SwizLogger) : void
        {
            if (AbstractSwizLoggingTarget)
            {
                AbstractSwizLoggingTarget.addEventListener(SwizLogEvent.LOG_EVENT, this.logHandler);
            }
            return;
        }// end function

        public function removeLogger(AbstractSwizLoggingTarget:SwizLogger) : void
        {
            if (AbstractSwizLoggingTarget)
            {
                AbstractSwizLoggingTarget.removeEventListener(SwizLogEvent.LOG_EVENT, this.logHandler);
            }
            return;
        }// end function

        protected function logEvent(:SwizLogEvent) : void
        {
            return;
        }// end function

        protected function logHandler(:SwizLogEvent) : void
        {
            if (level >= this.level)
            {
                this.logEvent();
            }
            return;
        }// end function

    }
}
