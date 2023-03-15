package net.sprd.valueObjects
{
    import flash.utils.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;

    public class Currency extends Object
    {
        private var _id:String;
        private var _name:String;
        private var _isoCode:String;
        private var _symbol:String;
        private var _precision:uint;
        private var _pattern:String;
        private static const log:ILogger = LogContext.getLogger(this);
        private static var _instances:Dictionary;
        private static var _allowCreation:Boolean;
        public static const SYMBOL_ALIGNMENT_LEFT:String = "left";
        public static const SYMBOL_ALIGNMENT_RIGHT:String = "right";

        public function Currency(param1:String, param2:String, param3:String, param4:String, param5:uint, param6:String)
        {
            if (!_allowCreation)
            {
                throw new Error("Currencies are not allowed to be instantiated directly " + "and can only be accessed through Currency.create(...rest)");
            }
            if (param1)
            {
            }
            if (param2 != "")
            {
            }
            if (param3 != "")
            {
            }
            if (param4 != "")
            {
            }
            if (param5 >= 0)
            {
            }
            if (param6 == "")
            {
                throw new Error("New currency could not be instantiated because of " + "missing required attributes. Given attributes: " + _loc_7);
            }
            this._id = param1;
            this._name = param2;
            this._isoCode = param3;
            this._symbol = param4;
            this._precision = param5;
            this._pattern = param6;
            return;
        }// end function

        public function get id() : String
        {
            return this._id;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get isoCode() : String
        {
            return this._isoCode;
        }// end function

        public function get symbol() : String
        {
            return this._symbol;
        }// end function

        public function get precision() : uint
        {
            return this._precision;
        }// end function

        public function alignSymbol() : String
        {
            return this._pattern.indexOf("$") == 0 ? (SYMBOL_ALIGNMENT_LEFT) : (SYMBOL_ALIGNMENT_RIGHT);
        }// end function

        public static function create(param1:String, param2:String = "", param3:String = "", param4:String = "", param5:uint = 0, param6:String = "") : Currency
        {
            var id:* = param1;
            var name:* = param2;
            var isoCode:* = param3;
            var symbol:* = param4;
            var precision:* = param5;
            var pattern:* = param6;
            if (!_instances)
            {
                _instances = new Dictionary(true);
            }
            if (!_instances[id])
            {
                try
                {
                    _allowCreation = true;
                    _instances[id] = new Currency(id, name, isoCode, symbol, precision, pattern);
                }
                catch (e:Error)
                {
                    log.warn(e.message);
                    var _loc_9:*;
                    ;
                    
                    
                    return _loc_9;
                }
                finally
                {
                    _allowCreation = false;
                }
            }
            return _instances[id] as Currency;
        }// end function

        public static function clear() : void
        {
            _instances = null;
            return;
        }// end function

    }
}
