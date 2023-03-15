package net.sprd.api.resource
{

    public class ResourceContext extends Object
    {
        public static const USER:String = "user";
        public static const SHOP:String = "shop";
        public static const NONE:String = "none";

        public function ResourceContext()
        {
            throw new Error("Enumerations are not eligible for instanciation!");
        }// end function

    }
}
