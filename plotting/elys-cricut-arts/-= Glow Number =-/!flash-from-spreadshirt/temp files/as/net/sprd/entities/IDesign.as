package net.sprd.entities
{
    import net.sprd.valueObjects.*;

    public interface IDesign extends IBaseEntity
    {

        public function IDesign();

        function get name() : String;

        function set name(param1:String) : void;

        function get description() : String;

        function set description(param1:String) : void;

        function get user() : String;

        function set user(param1:String) : void;

        function get hasFixedColors() : Boolean;

        function set hasFixedColors(param1:Boolean) : void;

        function get allowsText() : Boolean;

        function set allowsText(param1:Boolean) : void;

        function get isObligatory() : Boolean;

        function set isObligatory(param1:Boolean) : void;

        function get isMovable() : Boolean;

        function set isMovable(param1:Boolean) : void;

        function get targetView() : String;

        function set targetView(param1:String) : void;

        function get minScale() : Number;

        function set minScale(param1:Number) : void;

        function get isVisible() : Boolean;

        function set isVisible(param1:Boolean) : void;

        function get width() : Number;

        function set width(param1:Number) : void;

        function get height() : Number;

        function set height(param1:Number) : void;

        function get colors() : Array;

        function addColor(param1:uint, param2:uint, param3:uint) : void;

        function get printTypes() : Array;

        function addPrintType(param1:String) : void;

        function removePrintType(param1:String) : void;

        function get price() : Money;

        function set price(param1:Money) : void;

        function get age() : Date;

        function set age(param1:Date) : void;

        function get imageId() : String;

        function set imageId(param1:String) : void;

        function get isVectorDesign() : Boolean;

    }
}
