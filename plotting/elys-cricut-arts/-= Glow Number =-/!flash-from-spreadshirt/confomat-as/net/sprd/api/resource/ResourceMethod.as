package net.sprd.api.resource
{

    public class ResourceMethod extends Object
    {
        public static const GET:String = "GET";
        public static const PUT:String = "PUT";
        public static const POST:String = "POST";
        public static const DELETE:String = "DELETE";

        public function ResourceMethod()
        {
            throw new Error("Enumerations are not eligible for instanciation!");
        }// end function

    }
}
