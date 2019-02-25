package net.sprd.components.producttypeselector
{
    import flash.events.*;
    import mx.resources.*;
    import net.sprd.api.*;
    import net.sprd.api.plan.*;
    import net.sprd.common.collections.*;
    import net.sprd.common.colors.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.components.producttypeselector.sorting.*;
    import net.sprd.entities.*;
    import net.sprd.entities.impl.*;

    public class ProductTypeSelectorModel extends EventDispatcher implements ICategoryProvider, IPageable
    {
        private var ALL_DEPARTMENTS:IProductTypeDepartment;
        private var ALL_CATEGORIES:IProductTypeCategory;
        private var _productTypesLoaded:Boolean;
        private var _categoriesLoaded:Boolean;
        private var _topCategories:Array;
        private var _subCategories:DictionaryMap;
        private var _selectedProductType:IProductType;
        private var _selectedTopCategory:String;
        private var _selectedSubCategory:String;
        private var _sortedProductTypes:Array;
        private var _sizeNames:Array;
        private var _pages:Array;
        private var _currentPage:uint;
        private var _preferredColors:Array;
        private var _priceSortDirection:uint;
        private var _preferredSize:String;
        private static const log:ILogger = LogContext.getLogger(this);
        public static const PRODUCTTYPE_SELECTION_CHANGED:String = "productTypeSelectionChanged";
        public static const TOP_CATEGORY_CHANGED:String = "topCategoryChanged";
        public static const SUB_CATEGORY_CHANGED:String = "subCategoryChanged";
        public static const PAGE_CHANGED:String = "pageChanged";
        public static const SIZES_CHANGED:String = "sizesChanged";
        public static const CATEGORIES_CHANGED:String = "categoriesChanged";
        private static const ITEMS_PER_PAGE:uint = 9;
        private static const BLACK:int = 0;
        private static const WHITE:int = 16777215;
        private static const NEARLY_WHITE:int = 16777214;
        private static const SORT_COLORS:Array = [WHITE, NEARLY_WHITE, BLACK, 2833734, 12130326, 14803429, 6703919, 6723891, 16774400, 706527, 16469633];
        private static const STANDARD_SIZE_NAMES:Array = ["-", "S", "M", "L", "XL", "XXL", "3XL"];
        private static const SIZE_SORT_ORDER:Array = ["1", "2", "3", "4", "5", "6", "38", "94", "102", "113", "114", "115", "20", "21", "22", "45", "116", "117", "118", "119", "120", "74", "75", "76", "85", "86", "87", "88", "89", "90", "91", "92", "93", "95", "96", "97", "98", "99", "100", "101", "109", "110", "111", "112", "105", "106", "107", "108", "122", "123", "121", "104", "77", "78", "79", "80", "103", "39", "40", "44", "71", "72", "73", "68", "69", "70", "81", "84", "82", "83", "29", "25", "26", "33", "34", "11", "12", "13", "14", "41", "42", "43", "15", "16", "17", "18", "19", "27", "28", "35", "36", "37", "7", "8", "9", "10", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "46"];

        public function ProductTypeSelectorModel()
        {
            this._topCategories = [];
            this._subCategories = new DictionaryMap();
            this._sortedProductTypes = [];
            this._pages = [];
            this._preferredColors = [];
            this._priceSortDirection = ProductTypeSorting.SORT_NATURAL;
            super(this);
            this._currentPage = 0;
            var _loc_1:* = ResourceManager.getInstance();
            this.ALL_DEPARTMENTS = new ProductTypeDepartment();
            this.ALL_DEPARTMENTS.id = "allDepartments";
            this.ALL_CATEGORIES = new ProductTypeCategory();
            this.ALL_CATEGORIES.id = "allCategories";
            _loc_1.addEventListener(Event.CHANGE, this.rm_update);
            this.rm_update(null);
            return;
        }// end function

        private function rm_update(param1:Event) : void
        {
            var _loc_2:* = ResourceManager.getInstance();
            this.ALL_DEPARTMENTS.name = _loc_2.getString("confomat7", "product_gallery.label_department");
            this.ALL_CATEGORIES.net.sprd.entities:IProductTypeCategory::name = _loc_2.getString("confomat7", "product_gallery.label_producttype_category");
            return;
        }// end function

        public function load() : void
        {
            this.loadEntities();
            return;
        }// end function

        public function get selectedProductType() : IProductType
        {
            return this._selectedProductType;
        }// end function

        public function get preferredColors() : Array
        {
            return this._preferredColors;
        }// end function

        public function get preferredSize() : String
        {
            return this._preferredSize;
        }// end function

        public function selectProductType(param1:IProductType) : void
        {
            this._selectedProductType = param1;
            dispatchEvent(new Event(PRODUCTTYPE_SELECTION_CHANGED));
            return;
        }// end function

        public function getPreferredAppearance(param1:IProductType) : IProductTypeAppearance
        {
            var _loc_2:IProductTypeAppearance;
            for each (_loc_2 in param1.appearances)
            {
                
                if (this._preferredColors.indexOf(_loc_2) > -1)
                {
                    return _loc_2;
                }
            }
            return param1.defaultAppearance;
        }// end function

        public function get productTypes() : Array
        {
            if (this.currentPage > 0)
            {
            }
            if (!this.currentPage)
            {
                return new Array();
            }
            return this._pages[this._currentPage - 1];
        }// end function

        public function get topCategories() : Array
        {
            return [this.ALL_DEPARTMENTS].concat(this._topCategories);
        }// end function

        public function get subCategories() : Array
        {
            var _loc_2:String;
            if (!this.selectedTopCategory)
            {
                return [];
            }
            var _loc_1:Array;
            for each (_loc_2 in this.selectedTopCategory.categories)
            {
                
                _loc_1.push(this._subCategories.get(_loc_2));
            }
            return _loc_1;
        }// end function

        public function get selectedTopCategory()
        {
            return this.findDepartment(this._selectedTopCategory);
        }// end function

        public function selectTopCategory(param1:String) : Boolean
        {
            if (this._selectedTopCategory == param1)
            {
                return true;
            }
            if (param1 != this.ALL_DEPARTMENTS.id)
            {
            }
            if (param1 == null)
            {
                this._selectedTopCategory = null;
            }
            else
            {
                if (!this.findDepartment(param1))
                {
                    return false;
                }
                this._selectedTopCategory = param1;
            }
            dispatchEvent(new Event(TOP_CATEGORY_CHANGED));
            this.selectSubCategory(this.ALL_CATEGORIES.id);
            return true;
        }// end function

        public function get selectedSubCategory() : IProductTypeCategory
        {
            return IProductTypeCategory(this._subCategories.get(this._selectedSubCategory));
        }// end function

        public function selectSubCategory(param1:String) : void
        {
            if (this._selectedSubCategory == param1)
            {
                return;
            }
            param1 = param1 == this.ALL_CATEGORIES.id ? (null) : (param1);
            if (param1)
            {
                if (this.selectedTopCategory)
                {
                }
            }
            if (this.selectedTopCategory.categories.indexOf(param1) == -1)
            {
                log.warn("Tried to select product type category #{0} which does not belong" + " to currently selected department {1}", param1, this.selectedTopCategory.name);
                return;
            }
            this._selectedSubCategory = param1;
            this.refreshPages();
            dispatchEvent(new Event(SUB_CATEGORY_CHANGED));
            return;
        }// end function

        public function get pageCount() : int
        {
            return this._pages.length;
        }// end function

        public function get currentPage() : int
        {
            return this._currentPage;
        }// end function

        public function set currentPage(param1:int) : void
        {
            if (param1 == this._currentPage)
            {
                return;
            }
            param1 = param1 > this.pageCount ? (this.pageCount) : (param1);
            param1 = param1 < 1 ? (1) : (param1);
            this._currentPage = param1;
            dispatchEvent(new Event(PAGE_CHANGED));
            return;
        }// end function

        public function get hasNextPage() : Boolean
        {
            return this._currentPage < this.pageCount;
        }// end function

        public function get hasPreviousPage() : Boolean
        {
            return this._currentPage > 1;
        }// end function

        public function get sortColors() : Array
        {
            return SORT_COLORS;
        }// end function

        public function get sortSizes() : Array
        {
            return this._sizeNames;
        }// end function

        public function filterByAppearance(param1:uint) : void
        {
            var colorFilter:Function;
            var productType:IProductType;
            var color:* = param1;
            this._preferredColors = [];
            if (color != WHITE)
            {
                colorFilter = function (param1:IProductTypeAppearance, param2, param3) : Boolean
            {
                if (color != BLACK)
                {
                }
                return ColorUtil.isEqualShade(Color.fromHex(ColorUtil.getIntegerColor(param1.colors[0])), Color.fromHex(color), color == NEARLY_WHITE ? (5) : (ColorUtil.DEFAULT_TOLERANCE));
            }// end function
            ;
                var _loc_3:int;
                var _loc_4:* = this._sortedProductTypes;
                while (_loc_4 in _loc_3)
                {
                    
                    productType = _loc_4[_loc_3];
                    this._preferredColors = this._preferredColors.concat(productType.appearances.filter(colorFilter));
                }
            }
            this.refreshPages();
            return;
        }// end function

        public function sortByPrice(param1:uint) : void
        {
            this._priceSortDirection = param1;
            this.refreshPages();
            return;
        }// end function

        public function sortBySize(param1:String) : void
        {
            if (this._preferredSize == param1)
            {
                return;
            }
            this._preferredSize = param1;
            this.refreshPages();
            return;
        }// end function

        public function get categoriesLoaded() : Boolean
        {
            return this._categoriesLoaded;
        }// end function

        public function get productTypesLoaded() : Boolean
        {
            return this._productTypesLoaded;
        }// end function

        public function findDepartment(param1:String) : IProductTypeDepartment
        {
            var _loc_2:IProductTypeDepartment;
            for each (_loc_2 in this._topCategories)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        private function refreshPages() : void
        {
            var _loc_4:uint;
            var _loc_1:Array;
            if (this.selectedSubCategory)
            {
                _loc_1 = this.getProductTypesInCategory(this.selectedSubCategory);
            }
            else
            {
                if (!this.selectedSubCategory)
                {
                }
                if (this._selectedTopCategory)
                {
                    _loc_1 = this.getProductTypesInDepartment(this._selectedTopCategory);
                }
                else
                {
                    _loc_1 = this._sortedProductTypes;
                }
            }
            if (this._preferredColors.length > 0)
            {
                _loc_1 = ProductTypeSorting.filterByAppearance(_loc_1, this._preferredColors);
            }
            if (this._preferredSize)
            {
            }
            if (this._preferredSize != "-")
            {
                _loc_1 = ProductTypeSorting.filterBySize(_loc_1, this._preferredSize);
            }
            if (this._priceSortDirection != ProductTypeSorting.SORT_NATURAL)
            {
                _loc_1 = ProductTypeSorting.sortByPrice(_loc_1, this._priceSortDirection);
            }
            this._pages = [];
            var _loc_2:* = Math.ceil(_loc_1.length / ITEMS_PER_PAGE);
            var _loc_3:uint;
            while (_loc_3++ <= _loc_2 - 1)
            {
                
                _loc_4 = _loc_3 * ITEMS_PER_PAGE;
                this._pages[_loc_3] = _loc_1.slice(_loc_4, _loc_4 + ITEMS_PER_PAGE);
            }
            if (this._currentPage == 1)
            {
                this._currentPage = 0;
            }
            this.currentPage = 1;
            return;
        }// end function

        private function initSizes() : void
        {
            var productType:IProductType;
            var size:IProductTypeSize;
            var index:int;
            var sizes:Array;
            var i:uint;
            while (i < SIZE_SORT_ORDER.length)
            {
                
                sizes.push(null);
                i = i++;
            }
            var _loc_2:int;
            var _loc_3:* = this._sortedProductTypes;
            while (_loc_3 in _loc_2)
            {
                
                productType = _loc_3[_loc_2];
                var _loc_4:int;
                var _loc_5:* = productType.sizes;
                while (_loc_5 in _loc_4)
                {
                    
                    size = _loc_5[_loc_4];
                    index = SIZE_SORT_ORDER.indexOf(size.id);
                    if (index != -1)
                    {
                        sizes[index] = size.net.sprd.entities:IProductTypeSize::name;
                    }
                }
            }
            this._sizeNames = sizes.filter(function (param1, param2:int, param3:Array) : Boolean
            {
                return param1 != null;
            }// end function
            );
            this._sizeNames.splice(0, 0, "-");
            dispatchEvent(new Event(SIZES_CHANGED));
            return;
        }// end function

        private function getProductTypesInCategory(param1:IProductTypeCategory) : Array
        {
            var category:* = param1;
            if (!category)
            {
                return [];
            }
            return IProductTypeCategory(category).productTypes.map(function (param1:String, param2, param3) : IProductType
            {
                return IProductType(API.em.get(param1, APIRegistry.PRODUCT_TYPE));
            }// end function
            ).filter(function (param1:IProductType, param2, param3) : Boolean
            {
                if (param1)
                {
                }
                return param1.isValid();
            }// end function
            );
        }// end function

        private function getProductTypesInDepartment(param1:String) : Array
        {
            var _loc_4:String;
            var _loc_2:* = this.findDepartment(param1);
            var _loc_3:Array;
            if (!_loc_2)
            {
                return _loc_3;
            }
            for each (_loc_4 in _loc_2.categories)
            {
                
                _loc_3 = _loc_3.concat(this.getProductTypesInCategory(IProductTypeCategory(API.em.get(_loc_4, APIRegistry.PRODUCT_TYPE_CATEGORY))));
            }
            return ArrayUtil.removeDuplicates(_loc_3);
        }// end function

        private function loadEntities() : void
        {
            this._productTypesLoaded = false;
            this._categoriesLoaded = false;
            var _loc_1:* = new FetchPlan(false);
            _loc_1.partial = false;
            API.em.find(Query.findAll(APIRegistry.PRODUCT_TYPE, 0, Query.MAXIMUM_LIMIT), this.onProductTypesComplete, this.onLoadingFault, _loc_1);
            API.em.find(Query.findAll(APIRegistry.PRODUCT_TYPE_DEPARTMENT), this.onDepartmentsComplete, this.onLoadingFault, _loc_1);
            return;
        }// end function

        private function onProductTypesComplete(param1:Event) : void
        {
            var _loc_3:IProductType;
            var _loc_2:* = IQueryResult(param1.target);
            for each (_loc_3 in _loc_2.items)
            {
                
                if (_loc_3.isValid())
                {
                    this._sortedProductTypes.push(_loc_3);
                    continue;
                }
                log.error("Invalid product type " + _loc_3.id);
            }
            this.initSizes();
            this._productTypesLoaded = true;
            if (this._categoriesLoaded)
            {
                this.refreshPages();
                dispatchEvent(new Event(Event.COMPLETE));
            }
            return;
        }// end function

        private function onDepartmentsComplete(param1:Event) : void
        {
            var _loc_3:IProductTypeDepartment;
            var _loc_4:String;
            var _loc_2:* = IQueryResult(param1.target);
            this._topCategories = _loc_2.items;
            for each (_loc_3 in _loc_2.items)
            {
                
                for each (_loc_4 in _loc_3.categories)
                {
                    
                    this._subCategories.put(_loc_4, API.em.get(_loc_4, APIRegistry.PRODUCT_TYPE_CATEGORY));
                }
            }
            this._categoriesLoaded = true;
            dispatchEvent(new Event(CATEGORIES_CHANGED));
            if (this._productTypesLoaded)
            {
                this.refreshPages();
                dispatchEvent(new Event(Event.COMPLETE));
            }
            return;
        }// end function

        private function onLoadingFault(param1:IOErrorEvent) : void
        {
            return;
        }// end function

    }
}
