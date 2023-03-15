package net.sprd.entities.impl
{
    import net.sprd.common.colors.*;
    import net.sprd.valueObjects.*;

    public class PrintColor extends BaseEntity implements IPrintColor
    {
        private var _name:String;
        private var _hexCode:String;
        private var _color:Color;
        private var _isSimplifiedFill:Boolean;
        private var _weight:Number;
        private var _printableAbove:Array;
        private var _price:Money;
        private var _iconURI:String;

        public function PrintColor()
        {
            this._printableAbove = [];
            this._price = new Money(0, "1");
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function get hexCode() : String
        {
            return this._hexCode;
        }// end function

        public function set hexCode(param1:String) : void
        {
            this._hexCode = param1;
            this._color = Color.fromHex(ColorUtil.getIntegerColor(this._hexCode));
            return;
        }// end function

        public function get color() : Color
        {
            return this._color;
        }// end function

        public function get isSimplifiedFill() : Boolean
        {
            return this._isSimplifiedFill;
        }// end function

        public function set isSimplifiedFill(param1:Boolean) : void
        {
            this._isSimplifiedFill = param1;
            return;
        }// end function

        public function get iconURI() : String
        {
            return this._iconURI;
        }// end function

        public function set iconURI(param1:String) : void
        {
            this._iconURI = param1;
            return;
        }// end function

        public function get weight() : Number
        {
            return this._weight;
        }// end function

        public function set weight(param1:Number) : void
        {
            this._weight = param1;
            return;
        }// end function

        public function get printableAbove() : Array
        {
            return this._printableAbove;
        }// end function

        public function addPrintableAbove(param1:String) : void
        {
            this._printableAbove.push(param1);
            return;
        }// end function

        public function set price(param1:Money) : void
        {
            this._price = param1;
            return;
        }// end function

        public function get price() : Money
        {
            return this._price;
        }// end function

    }
}
