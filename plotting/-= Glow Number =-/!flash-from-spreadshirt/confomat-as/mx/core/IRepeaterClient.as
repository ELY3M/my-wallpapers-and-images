package mx.core
{

    public interface IRepeaterClient
    {

        public function IRepeaterClient();

        function get instanceIndices() : Array;

        function set instanceIndices(instanceIndices:Array) : void;

        function get isDocument() : Boolean;

        function get repeaterIndices() : Array;

        function set repeaterIndices(instanceIndices:Array) : void;

        function get repeaters() : Array;

        function set repeaters(instanceIndices:Array) : void;

        function initializeRepeaterArrays(:IRepeaterClient) : void;

    }
}
