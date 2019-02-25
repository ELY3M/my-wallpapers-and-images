package net.sprd.models.product
{
    import mx.resources.*;
    import net.sprd.entities.*;

    public class ConfigurationUsageConstraints extends Object
    {
        private var _tooLarge:Boolean;
        private var _tooSmall:Boolean;
        private var _missingPrintType:Boolean;
        private var _missingPrintArea:Boolean;
        private var _printAreaDisallowedConfiguration:Boolean;
        public var printType:IPrintType;
        public var printArea:IPrintArea;
        public var possiblePrintTypes:Array;

        public function ConfigurationUsageConstraints()
        {
            return;
        }// end function

        public function get isUsable() : Boolean
        {
            if (true)
            {
            }
            if (true)
            {
            }
            if (true)
            {
            }
            if (true)
            {
            }
            return !this._printAreaDisallowedConfiguration;
        }// end function

        public function get printAreaDisallowedConfiguration() : Boolean
        {
            return this._printAreaDisallowedConfiguration;
        }// end function

        public function set printAreaDisallowedConfiguration(param1:Boolean) : void
        {
            this._printAreaDisallowedConfiguration = param1;
            return;
        }// end function

        public function get isTooLarge() : Boolean
        {
            return this._tooLarge;
        }// end function

        public function set isTooLarge(param1:Boolean) : void
        {
            this._tooLarge = param1;
            return;
        }// end function

        public function get isTooSmall() : Boolean
        {
            return this._tooSmall;
        }// end function

        public function set isTooSmall(param1:Boolean) : void
        {
            this._tooSmall = param1;
            return;
        }// end function

        public function get missingPrintType() : Boolean
        {
            return this._missingPrintType;
        }// end function

        public function set missingPrintType(param1:Boolean) : void
        {
            this._missingPrintType = param1;
            return;
        }// end function

        public function get missingPrintArea() : Boolean
        {
            return this._missingPrintArea;
        }// end function

        public function set missingPrintArea(param1:Boolean) : void
        {
            this._missingPrintArea = param1;
            return;
        }// end function

        public function toString() : String
        {
            var _loc_1:* = ResourceManager.getInstance();
            var _loc_2:String;
            if (this._tooLarge)
            {
                _loc_2 = _loc_1.getString("confomat7", "messages_system.design_too_large_for_printarea");
            }
            if (this._tooSmall)
            {
                _loc_2 = _loc_1.getString("confomat7", "messages_system.design_too_small_for_printtype");
            }
            if (this._missingPrintType)
            {
                _loc_2 = _loc_1.getString("confomat7", "messages_system.configuration_conflict_printtypes");
            }
            if (this._missingPrintArea)
            {
                _loc_2 = _loc_1.getString("confomat7", "messages_system.product_view_has_no_printarea");
            }
            if (this._printAreaDisallowedConfiguration)
            {
                _loc_2 = _loc_1.getString("confomat7", "messages_system.printarea_disallow_designs");
            }
            return _loc_2;
        }// end function

    }
}
