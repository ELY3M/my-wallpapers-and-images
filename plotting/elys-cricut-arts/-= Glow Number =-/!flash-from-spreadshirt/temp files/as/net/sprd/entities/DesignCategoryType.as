package net.sprd.entities
{

    public class DesignCategoryType extends Object
    {
        public static const MY_DESIGNS:String = "MY_DESIGNS";
        public static const OWN:String = "OWN";
        public static const UPLOADED:String = "UPLOADED";
        public static const BESTSELLER:String = "BESTSELLER";
        public static const MARKETPLACE:String = "MARKETPLACE";
        public static const SHOP:String = "SHOP";
        public static const SHOP_CUSTOM:String = "SHOP_CUSTOM";

        public function DesignCategoryType()
        {
            throw new Error("Enumerations are not eligible for instantiation.");
        }// end function

    }
}
