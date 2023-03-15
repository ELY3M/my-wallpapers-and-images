package net.sprd.models.common
{
    import flash.geom.*;
    import mx.formatters.*;
    import net.sprd.entities.*;

    public class DimensionFormatter extends Formatter
    {
        public var country:ICountry;
        private var _precision:uint = 0;

        public function DimensionFormatter()
        {
            return;
        }// end function

        public function get precision() : uint
        {
            return this._precision;
        }// end function

        public function set precision(param1:uint) : void
        {
            this._precision = param1 > 20 ? (20) : (param1);
            return;
        }// end function

        override public function format(param1:Object) : String
        {
            if (!(!param1 is Rectangle))
            {
            }
            if (!this.country)
            {
                return "";
            }
            var _loc_2:* = new NumberFormatter();
            _loc_2.rounding = NumberBaseRoundType.NEAREST;
            _loc_2.precision = this._precision;
            _loc_2.decimalSeparatorTo = this.country.decimalPoint;
            _loc_2.thousandsSeparatorTo = this.country.thousandsSeparator;
            var _loc_3:* = parseFloat(_loc_2.format(param1.width * this.country.lengthUnitFactor));
            var _loc_4:* = parseFloat(_loc_2.format(param1.height * this.country.lengthUnitFactor));
            return _loc_3 + this.country.lengthUnit + " x " + _loc_4 + this.country.lengthUnit;
        }// end function

    }
}
