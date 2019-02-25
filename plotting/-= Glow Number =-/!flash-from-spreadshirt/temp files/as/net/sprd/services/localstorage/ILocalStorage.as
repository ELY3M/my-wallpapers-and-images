package net.sprd.services.localstorage
{

    public interface ILocalStorage
    {

        public function ILocalStorage();

        function get uploadedDesigns() : Array;

        function set uploadedDesigns(param1:Array) : void;

        function get productMemento() : Object;

        function get agreedUploadDisclaimer() : Boolean;

        function set agreedUploadDisclaimer(param1:Boolean) : void;

        function setProductMemento(param1:Object, param2:String, param3:String, param4:String) : void;

        function clearProductMemento() : void;

        function get appearance() : String;

        function get size() : String;

        function get view() : String;

    }
}
