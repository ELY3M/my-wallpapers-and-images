package net.sprd.common.logging
{

    public class LogLevel extends Object
    {
        private var _level:uint;
        private var _name:String;
        public static const TRACE:LogLevel = new LogLevel(0, "TRACE");
        public static const DEBUG:LogLevel = new LogLevel(1, "DEBUG");
        public static const INFO:LogLevel = new LogLevel(2, "INFO");
        public static const WARN:LogLevel = new LogLevel(3, "WARN");
        public static const ERROR:LogLevel = new LogLevel(4, "ERROR");
        public static const FATAL:LogLevel = new LogLevel(5, "FATAL");

        public function LogLevel(param1:uint, param2:String)
        {
            this._level = param1;
            this._name = param2;
            return;
        }// end function

        public function get level() : uint
        {
            return this._level;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function toString() : String
        {
            return this.name;
        }// end function

    }
}
