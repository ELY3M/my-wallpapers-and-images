package net.sprd.entities
{
    import net.sprd.valueObjects.*;

    public interface IPrintType extends IBaseEntity
    {

        public function IPrintType();

        function get name() : String;

        function set name(param1:String) : void;

        function get description() : String;

        function set description(param1:String) : void;

        function get width() : Number;

        function set width(param1:Number) : void;

        function get height() : Number;

        function set height(param1:Number) : void;

        function get resolution() : Number;

        function set resolution(param1:Number) : void;

        function get printColors() : Array;

        function addPrintColor(param1:String) : void;

        function removePrintColor(param1:String) : void;

        function get scalability() : uint;

        function set scalability(param1:uint) : void;

        function get colorSpace() : uint;

        function set colorSpace(param1:uint) : void;

        function get weight() : Number;

        function set weight(param1:Number) : void;

        function get printableAlongWith() : Array;

        function addPrintableAlongWith(param1:String) : void;

        function get printableAbove() : Array;

        function addPrintableAbove(param1:String) : void;

        function get maxPrintColorLayers() : uint;

        function set maxPrintColorLayers(param1:uint) : void;

        function get price() : Money;

        function set price(param1:Money) : void;

        function get lifeCycleState() : int;

        function set lifeCycleState(param1:int) : void;

    }
}
