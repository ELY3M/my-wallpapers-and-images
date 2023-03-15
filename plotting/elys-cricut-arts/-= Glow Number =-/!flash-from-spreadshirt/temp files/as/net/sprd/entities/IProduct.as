package net.sprd.entities
{

    public interface IProduct extends IBaseEntity
    {

        public function IProduct();

        function get name() : String;

        function set name(param1:String) : void;

        function get user() : String;

        function set user(param1:String) : void;

        function get productType() : String;

        function set productType(param1:String) : void;

        function get productTypeAppearance() : String;

        function set productTypeAppearance(param1:String) : void;

        function get allowsFreeColorSelection() : Boolean;

        function set allowsFreeColorSelection(param1:Boolean) : void;

        function get isExample() : Boolean;

        function set isExample(param1:Boolean) : void;

        function get configurations() : Array;

        function addConfiguration(param1:IConfiguration) : void;

        function getConfigurationById(param1:String) : IConfiguration;

        function get defaultView() : String;

        function set defaultView(param1:String) : void;

        function clone() : IProduct;

        function get token() : String;

        function set token(param1:String) : void;

    }
}
