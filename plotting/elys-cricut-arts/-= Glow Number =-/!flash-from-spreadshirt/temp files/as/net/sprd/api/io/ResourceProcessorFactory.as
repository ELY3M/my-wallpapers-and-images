package net.sprd.api.io
{
    import net.sprd.api.io.xml.*;
    import net.sprd.api.resource.*;

    public class ResourceProcessorFactory extends Object
    {
        private static var processors:Object = {};

        public function ResourceProcessorFactory()
        {
            return;
        }// end function

        public static function create(param1:Resource) : IResourceProcessor
        {
            return processors[param1.encoding];
        }// end function

        processors[ResourceEncoding.XML] = new XMLResourceProcessor();
    }
}
