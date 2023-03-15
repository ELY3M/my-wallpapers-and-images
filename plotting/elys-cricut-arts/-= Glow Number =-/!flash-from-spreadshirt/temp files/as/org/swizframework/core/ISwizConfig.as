package org.swizframework.core
{

    public interface ISwizConfig
    {

        public function ISwizConfig();

        function get strict() : Boolean;

        function set strict(uint:Boolean) : void;

        function get setUpEventType() : String;

        function set setUpEventType(uint:String) : void;

        function get setUpEventPriority() : int;

        function set setUpEventPriority(uint:int) : void;

        function get setUpEventPhase() : uint;

        function set setUpEventPhase(uint:uint) : void;

        function get tearDownEventType() : String;

        function set tearDownEventType(uint:String) : void;

        function get tearDownEventPriority() : int;

        function set tearDownEventPriority(uint:int) : void;

        function get tearDownEventPhase() : uint;

        function set tearDownEventPhase(uint:uint) : void;

        function get eventPackages() : Array;

        function set eventPackages(uint) : void;

        function get viewPackages() : Array;

        function set viewPackages(uint) : void;

        function get defaultFaultHandler() : Function;

        function set defaultFaultHandler(:Function) : void;

        function get defaultDispatcher() : String;

        function set defaultDispatcher(:String) : void;

    }
}
