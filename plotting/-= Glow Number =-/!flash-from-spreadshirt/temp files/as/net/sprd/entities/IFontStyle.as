package net.sprd.entities
{

    public interface IFontStyle extends IBaseEntity
    {

        public function IFontStyle();

        function get name() : String;

        function set name(param1:String) : void;

        function get weight() : String;

        function set weight(param1:String) : void;

        function get style() : String;

        function set style(param1:String) : void;

        function get minSize() : Number;

        function set minSize(param1:Number) : void;

        function get fontFamily() : String;

        function set fontFamily(param1:String) : void;

        function get fontFilePath() : String;

        function set fontFilePath(param1:String) : void;

    }
}
