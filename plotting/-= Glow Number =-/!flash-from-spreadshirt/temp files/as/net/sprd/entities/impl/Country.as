package net.sprd.entities.impl
{

    public class Country extends BaseEntity implements ICountry
    {
        private var _isoCode:String;
        private var _thousandsSeparator:String;
        private var _decimalPoint:String;
        private var _lengthUnit:String;
        private var _lengthUnitFactor:Number;
        private var _currency:String;

        public function Country()
        {
            return;
        }// end function

        public function get isoCode() : String
        {
            return this._isoCode;
        }// end function

        public function set isoCode(param1:String) : void
        {
            this._isoCode = param1;
            return;
        }// end function

        public function get thousandsSeparator() : String
        {
            return this._thousandsSeparator;
        }// end function

        public function set thousandsSeparator(param1:String) : void
        {
            this._thousandsSeparator = param1;
            return;
        }// end function

        public function get decimalPoint() : String
        {
            return this._decimalPoint;
        }// end function

        public function set decimalPoint(param1:String) : void
        {
            this._decimalPoint = param1;
            return;
        }// end function

        public function get lengthUnit() : String
        {
            return this._lengthUnit;
        }// end function

        public function set lengthUnit(param1:String) : void
        {
            this._lengthUnit = param1;
            return;
        }// end function

        public function get lengthUnitFactor() : Number
        {
            return this._lengthUnitFactor;
        }// end function

        public function set lengthUnitFactor(param1:Number) : void
        {
            this._lengthUnitFactor = param1;
            return;
        }// end function

        public function get currency() : String
        {
            return this._currency;
        }// end function

        public function set currency(param1:String) : void
        {
            this._currency = param1;
            return;
        }// end function

    }
}
