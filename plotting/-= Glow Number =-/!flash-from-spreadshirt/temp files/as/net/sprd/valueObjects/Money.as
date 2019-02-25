package net.sprd.valueObjects
{
    import flash.errors.*;

    public class Money extends Object
    {
        private var _amount:Number;
        private var _currencyID:String;

        public function Money(param1:Number, param2:String)
        {
            if (isNaN(param1))
            {
                throw new IllegalOperationError("Money amount has to be a number, " + "but value is \'" + param1 + "\'.");
            }
            this._amount = param1;
            if (!param2)
            {
                throw new IllegalOperationError("Currency of a money is not allowed to be \'null\'!");
            }
            this._currencyID = param2;
            return;
        }// end function

        public function get amount() : Number
        {
            return this._amount;
        }// end function

        public function get currencyID() : String
        {
            return this._currencyID;
        }// end function

        public function get currency() : Currency
        {
            return Currency.create(this._currencyID);
        }// end function

    }
}
