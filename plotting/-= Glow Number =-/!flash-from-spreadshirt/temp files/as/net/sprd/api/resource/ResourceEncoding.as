package net.sprd.api.resource
{

    public class ResourceEncoding extends Object
    {
        public static const XML:String = "xml";
        public static const JSON:String = "json";

        public function ResourceEncoding()
        {
            throw new Error("Enumerations are not eligible for instanciation!");
        }// end function

    }
}
