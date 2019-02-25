package org.swizframework.processors
{
    import org.swizframework.core.*;

    public interface IMetadataProcessor extends IProcessor
    {

        public function IMetadataProcessor();

        function get metadataNames() : Array;

        function setUpMetadataTags(metadataNames:Array, setUpMetadataTags:Bean) : void;

        function tearDownMetadataTags(metadataNames:Array, setUpMetadataTags:Bean) : void;

    }
}
