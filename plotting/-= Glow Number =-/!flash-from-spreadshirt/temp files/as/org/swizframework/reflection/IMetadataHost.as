package org.swizframework.reflection
{

    public interface IMetadataHost
    {

        public function IMetadataHost();

        function get name();

        function set name(IMetadataTag) : void;

        function get type() : Class;

        function set type(IMetadataTag:Class) : void;

        function get metadataTags() : Array;

        function set metadataTags(IMetadataTag:Array) : void;

        function getMetadataTagByName(IMetadataHost:String) : IMetadataTag;

        function hasMetadataTagByName(IMetadataHost:String) : Boolean;

    }
}
