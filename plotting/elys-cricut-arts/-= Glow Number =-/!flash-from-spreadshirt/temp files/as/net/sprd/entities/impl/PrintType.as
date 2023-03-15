package net.sprd.entities.impl
{
    import net.sprd.common.collections.*;
    import net.sprd.valueObjects.*;

    public class PrintType extends BaseEntity implements IPrintType
    {
        private var _name:String;
        private var _lifeCycleState:int = 1;
        private var _description:String;
        private var _width:Number = 10000;
        private var _height:Number = 10000;
        private var _resolution:Number;
        private var _printColors:ICollection;
        private var _scalability:uint;
        private var _colorSpace:uint;
        private var _weight:Number;
        private var _printableAlongWith:Array;
        private var _printableAbove:Array;
        private var _maxPrintColorLayer:uint;
        private var _price:Money;
        public static const FLOCK:String = "2";
        public static const FLEX:String = "14";
        public static const SPECIALFLEX:String = "16";

        public function PrintType()
        {
            this._printableAlongWith = [];
            this._printableAbove = [];
            this._price = new Money(0, "1");
            this._printColors = new ArrayList();
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

        public function get description() : String
        {
            return this._description;
        }// end function

        public function set description(param1:String) : void
        {
            this._description = param1;
            return;
        }// end function

        public function get width() : Number
        {
            return this._width;
        }// end function

        public function set width(param1:Number) : void
        {
            this._width = param1;
            return;
        }// end function

        public function get height() : Number
        {
            return this._height;
        }// end function

        public function set height(param1:Number) : void
        {
            this._height = param1;
            return;
        }// end function

        public function get resolution() : Number
        {
            return this._resolution;
        }// end function

        public function set resolution(param1:Number) : void
        {
            this._resolution = param1;
            return;
        }// end function

        public function get printColors() : Array
        {
            return this._printColors.toArray();
        }// end function

        public function addPrintColor(param1:String) : void
        {
            this._printColors.add(param1);
            return;
        }// end function

        public function removePrintColor(param1:String) : void
        {
            this._printColors.remove(param1);
            return;
        }// end function

        public function get scalability() : uint
        {
            return this._scalability;
        }// end function

        public function set scalability(param1:uint) : void
        {
            this._scalability = param1;
            return;
        }// end function

        public function get colorSpace() : uint
        {
            return this._colorSpace;
        }// end function

        public function set colorSpace(param1:uint) : void
        {
            this._colorSpace = param1;
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

        public function get printableAlongWith() : Array
        {
            return this._printableAlongWith;
        }// end function

        public function addPrintableAlongWith(param1:String) : void
        {
            this._printableAlongWith.push(param1);
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

        public function get maxPrintColorLayers() : uint
        {
            return this._maxPrintColorLayer;
        }// end function

        public function set maxPrintColorLayers(param1:uint) : void
        {
            this._maxPrintColorLayer = param1;
            return;
        }// end function

        public function get price() : Money
        {
            return this._price;
        }// end function

        public function set price(param1:Money) : void
        {
            this._price = param1;
            return;
        }// end function

        public function get lifeCycleState() : int
        {
            return this._lifeCycleState;
        }// end function

        public function set lifeCycleState(param1:int) : void
        {
            this._lifeCycleState = param1;
            return;
        }// end function

    }
}
