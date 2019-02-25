package net.sprd.entities
{
    import flash.geom.*;
    import net.sprd.graphics.svg.*;

    public interface IConfiguration extends IBaseEntity
    {

        public function IConfiguration();

        function get type() : String;

        function set type(param1:String) : void;

        function get printArea() : String;

        function set printArea(param1:String) : void;

        function get printType() : String;

        function set printType(param1:String) : void;

        function get svgContent() : ISVGShape;

        function set svgContent(param1:ISVGShape) : void;

        function get isChangeable() : Boolean;

        function set isChangeable(param1:Boolean) : void;

        function get offset() : Point;

        function set offset(param1:Point) : void;

        function get designId() : String;

        function set designId(param1:String) : void;

        function clone() : IConfiguration;

    }
}
