package net.sprd.api.resource
{

    public class ResourceLoadingState extends Object
    {
        public static const CREATED:int = 0;
        public static const LOADING:int = 1;
        public static const LOADED:int = 2;
        public static const ERROR:int = 3;

        public function ResourceLoadingState()
        {
            return;
        }// end function

    }
}
