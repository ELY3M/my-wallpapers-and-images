package net.sprd.components.common.categoryselector
{

    public interface ICategoryProvider
    {

        public function ICategoryProvider();

        function get topCategories() : Array;

        function get subCategories() : Array;

        function get selectedTopCategory();

        function selectTopCategory(param1:String) : Boolean;

        function selectSubCategory(param1:String) : void;

    }
}
