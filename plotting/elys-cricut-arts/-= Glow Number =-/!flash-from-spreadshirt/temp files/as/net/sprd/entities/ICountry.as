package net.sprd.entities
{

    public interface ICountry extends IBaseEntity
    {

        public function ICountry();

        function get isoCode() : String;

        function set isoCode(param1:String) : void;

        function get thousandsSeparator() : String;

        function set thousandsSeparator(param1:String) : void;

        function get decimalPoint() : String;

        function set decimalPoint(param1:String) : void;

        function get lengthUnit() : String;

        function set lengthUnit(param1:String) : void;

        function get lengthUnitFactor() : Number;

        function set lengthUnitFactor(param1:Number) : void;

        function get currency() : String;

        function set currency(param1:String) : void;

    }
}
