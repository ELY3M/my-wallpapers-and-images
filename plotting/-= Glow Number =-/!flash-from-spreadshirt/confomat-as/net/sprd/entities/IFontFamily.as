package net.sprd.entities
{

    public interface IFontFamily extends IBaseEntity
    {

        public function IFontFamily();

        function get name() : String;

        function set name(param1:String) : void;

        function get deprecated() : Boolean;

        function get styles() : Array;

        function addStyle(param1:String) : void;

        function getEmbeddedFontName() : String;

    }
}
