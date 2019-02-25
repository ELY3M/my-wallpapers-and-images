package net.sprd.models.product.errors
{

    public class ConfigurationSizeError extends Error
    {
        public static const TOO_BIG:uint = 200;
        public static const TOO_SMALL:uint = 201;

        public function ConfigurationSizeError(param1 = "", param2 = 0)
        {
            super(param1, param2);
            return;
        }// end function

    }
}
