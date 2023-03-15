package net.sprd.entities
{
    import net.sprd.graphics.svg.*;

    public interface IPrintArea extends IBaseEntity
    {

        public function IPrintArea();

        function get appearanceColorIndex() : uint;

        function set appearanceColorIndex(param1:uint) : void;

        function get width() : Number;

        function set width(param1:Number) : void;

        function get height() : Number;

        function set height(param1:Number) : void;

        function get hardBoundary() : ISVGShape;

        function get softBoundary() : ISVGShape;

        function get defaultPositioningBox() : SVGRect;

        function get defaultPositioningHorizontalAlignment() : String;

        function get defaultPositioningVerticalAlignment() : String;

        function get defaultPositioningCanRotate() : int;

        function get defaultView() : String;

        function set defaultView(param1:String) : void;

        function get allowsText() : Boolean;

        function set allowsText(param1:Boolean) : void;

        function get allowsDesign() : Boolean;

        function set allowsDesign(param1:Boolean) : void;

        function get excludedPrintTypes() : Array;

        function excludePrintType(param1:String) : void;

        function includePrintType(param1:String) : void;

    }
}
