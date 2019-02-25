package net.sprd.models.common
{
    import mx.formatters.*;
    import mx.validators.*;
    import net.sprd.valueObjects.*;

    public class CurrencyFormatterFactory extends Object
    {

        public function CurrencyFormatterFactory()
        {
            return;
        }// end function

        public static function createCurrencyFormatter(param1:Currency) : CurrencyFormatter
        {
            var _loc_2:* = new CurrencyFormatter();
            if (param1)
            {
                _loc_2.alignSymbol = param1.alignSymbol() == Currency.SYMBOL_ALIGNMENT_LEFT ? (CurrencyValidatorAlignSymbol.LEFT) : (CurrencyValidatorAlignSymbol.RIGHT);
                _loc_2.currencySymbol = param1.symbol;
                _loc_2.precision = param1.precision;
                _loc_2.thousandsSeparatorTo = ConfomatConfiguration.country ? (ConfomatConfiguration.country.thousandsSeparator) : (".");
                _loc_2.decimalSeparatorTo = ConfomatConfiguration.country ? (ConfomatConfiguration.country.decimalPoint) : (",");
            }
            else
            {
                _loc_2.alignSymbol = null;
                _loc_2.currencySymbol = "";
                _loc_2.precision = null;
                _loc_2.thousandsSeparatorTo = null;
                _loc_2.decimalSeparatorTo = null;
            }
            return _loc_2;
        }// end function

    }
}
