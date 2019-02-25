package net.sprd.entities
{

    public interface IProductTypeAppearance extends IBaseEntity
    {

        public function IProductTypeAppearance();

        function get name() : String;

        function get colors() : Array;

        function addColor(param1:String) : void;

        function get printTypes() : Array;

        function addPrintType(param1:String) : void;

        function get previewURI() : String;

        function set previewURI(param1:String) : void;

    }
}
