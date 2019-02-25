package net.sprd.entities
{
    import flash.geom.*;

    public interface IProductTypeView extends IBaseEntity
    {

        public function IProductTypeView();

        function get name() : String;

        function get width() : Number;

        function set width(param1:Number) : void;

        function get height() : Number;

        function set height(param1:Number) : void;

        function get perspective() : String;

        function set perspective(param1:String) : void;

        function get printAreas() : Array;

        function addPrintAreaOffset(param1:String, param2:Point) : void;

        function getPrintAreaOffset(param1:String) : Point;

    }
}
