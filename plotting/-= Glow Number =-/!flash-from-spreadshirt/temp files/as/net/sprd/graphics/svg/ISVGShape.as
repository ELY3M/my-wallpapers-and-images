package net.sprd.graphics.svg
{
    import net.sprd.graphics.svg.transformations.*;

    public interface ISVGShape extends IEventDispatcher
    {

        public function ISVGShape();

        function get x() : Number;

        function set x(param1:Number) : void;

        function get y() : Number;

        function set y(param1:Number) : void;

        function get width() : Number;

        function set width(param1:Number) : void;

        function get height() : Number;

        function set height(param1:Number) : void;

        function get borderColor() : Number;

        function set borderColor(param1:Number) : void;

        function get borderThickness() : uint;

        function set borderThickness(param1:uint) : void;

        function get fillColor() : Number;

        function set fillColor(param1:Number) : void;

        function get printColors() : Array;

        function addPrintColor(param1:String) : void;

        function set printColors(param1:Array) : void;

        function get rgbColors() : Array;

        function set rgbColors(param1:Array) : void;

        function addRGBColor(param1:uint) : void;

        function get transformations() : Array;

        function set transformations(param1:Array) : void;

        function addTransformation(param1:ISVGTransformation) : void;

        function get modified() : Boolean;

        function markModified(param1:Boolean = true) : void;

        function clone(param1:ISVGShape = null) : ISVGShape;

        function equals(param1:ISVGShape) : Boolean;

    }
}
