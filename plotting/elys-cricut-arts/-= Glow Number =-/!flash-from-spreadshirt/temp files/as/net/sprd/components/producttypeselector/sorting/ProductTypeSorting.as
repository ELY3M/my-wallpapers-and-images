package net.sprd.components.producttypeselector.sorting
{
    import net.sprd.entities.*;

    public class ProductTypeSorting extends Object
    {
        public static const SORT_NATURAL:uint = 0;
        public static const SORT_ASCENDING:uint = 1;
        public static const SORT_DESCENDING:uint = 2;

        public function ProductTypeSorting()
        {
            return;
        }// end function

        public static function filterByAppearance(param1:Array, param2:Array) : Array
        {
            var productTypes:* = param1;
            var appearances:* = param2;
            return productTypes.filter(function (param1:IProductType, param2:int, param3:Array) : Boolean
            {
                var _loc_4:*;
                for each (_loc_4 in param1.net.sprd.entities:IProductType::appearances)
                {
                    
                    if (appearances.indexOf(_loc_4) > -1)
                    {
                        return true;
                    }
                }
                return false;
            }// end function
            );
        }// end function

        public static function filterBySize(param1:Array, param2:String) : Array
        {
            var productTypes:* = param1;
            var sizeName:* = param2;
            return productTypes.filter(function (param1:IProductType, param2:int, param3:Array) : Boolean
            {
                var _loc_4:*;
                for each (_loc_4 in param1.sizes)
                {
                    
                    if (_loc_4.name == sizeName)
                    {
                        return true;
                    }
                }
                return false;
            }// end function
            );
        }// end function

        public static function sortByPrice(param1:Array, param2:uint) : Array
        {
            var productTypes:* = param1;
            var sortOrder:* = param2;
            if (sortOrder == SORT_DESCENDING)
            {
                with ({})
                {
                    {}.compare = function (param1:IProductType, param2:IProductType) : Number
            {
                if (param1.price.amount > param2.price.amount)
                {
                    return -1;
                }
                if (param1.price.amount < param2.price.amount)
                {
                    return 1;
                }
                return 0;
            }// end function
            ;
                }
                productTypes.sort(function (param1:IProductType, param2:IProductType) : Number
            {
                if (param1.price.amount > param2.price.amount)
                {
                    return -1;
                }
                if (param1.price.amount < param2.price.amount)
                {
                    return 1;
                }
                return 0;
            }// end function
            );
            }
            if (sortOrder == SORT_ASCENDING)
            {
                with ({})
                {
                    {}.compare = function (param1:IProductType, param2:IProductType) : Number
            {
                if (param1.price.amount > param2.price.amount)
                {
                    return 1;
                }
                if (param1.price.amount < param2.price.amount)
                {
                    return -1;
                }
                return 0;
            }// end function
            ;
                }
                productTypes.sort(function (param1:IProductType, param2:IProductType) : Number
            {
                if (param1.price.amount > param2.price.amount)
                {
                    return 1;
                }
                if (param1.price.amount < param2.price.amount)
                {
                    return -1;
                }
                return 0;
            }// end function
            );
            }
            return productTypes;
        }// end function

    }
}
