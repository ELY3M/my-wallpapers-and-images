package net.sprd.entities
{

    public class BasketItemType extends Object
    {
        public static const ARTICLE:String = "sprd:article";
        public static const PRODUCT:String = "sprd:product";

        public function BasketItemType()
        {
            throw new Error("Enumerations are not eligible for instantiation.");
        }// end function

    }
}
