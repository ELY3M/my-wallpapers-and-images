package org.swizframework.reflection
{

    public interface IMetadataTag
    {

        public function IMetadataTag();

        function get name() : String;

        function set name(Boolean:String) : void;

        function get args() : Array;

        function set args(Boolean:Array) : void;

        function get host() : IMetadataHost;

        function set host(Boolean:IMetadataHost) : void;

        function get asTag() : String;

        function hasArg(IMetadataTag:String) : Boolean;

        function getArg(IMetadataTag:String) : MetadataArg;

        function copyFrom(:IMetadataTag) : void;

        function toString() : String;

    }
}
