package net.sprd.entities
{

    public class EntityState extends Object
    {
        public static const CREATED:int = 0;
        public static const LOADING:int = 1;
        public static const PARTIAL:int = 2;
        public static const LOADED:int = 3;
        public static const ERROR:int = 4;
        public static const DELETED:int = 5;

        public function EntityState()
        {
            return;
        }// end function

    }
}
