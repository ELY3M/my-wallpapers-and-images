package net.sprd.entities
{
    import net.sprd.common.colors.*;
    import net.sprd.valueObjects.*;

    public interface IPrintColor extends IBaseEntity
    {

        public function IPrintColor();

        function get name() : String;

        function set name(param1:String) : void;

        function get hexCode() : String;

        function set hexCode(param1:String) : void;

        function get color() : Color;

        function get isSimplifiedFill() : Boolean;

        function set isSimplifiedFill(param1:Boolean) : void;

        function get weight() : Number;

        function set weight(param1:Number) : void;

        function get iconURI() : String;

        function set iconURI(param1:String) : void;

        function get printableAbove() : Array;

        function addPrintableAbove(param1:String) : void;

        function set price(param1:Money) : void;

        function get price() : Money;

    }
}
