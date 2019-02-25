package net.sprd.components.designselector
{
    import DesignSelectorModel.as$533.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;
    import net.sprd.api.*;
    import net.sprd.common.collections.*;
    import net.sprd.common.colors.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.entities.*;
    import net.sprd.models.product.*;
    import net.sprd.models.product.rules.*;
    import net.sprd.services.image.*;
    import net.sprd.valueObjects.*;

    public class DesignSelectorModel extends EventDispatcher implements ICategoryProvider, IPageable
    {
        private var _searchTerm:String = null;
        private var _oldSearchTerm:String;
        private var _currentDesign:IDesign;
        private var _currentDesigner:IUser;
        private var selectedTopCategoryNode:ITreeNode;
        private var selectedSubCategoryNode:ITreeNode;
        private var sortField:String = "weight";
        private var sortOrder:String = "desc";
        private var _product:IProductModel;
        private var designPages:Pages;
        private var designList:INavigable;
        private var backendDesignSearchList:ArrayList;
        private var currentDesignsPage:uint = 1;
        public var categoryTrees:Dictionary;
        private var _categoriesLoaded:Boolean = false;
        private var _pageCount:uint;
        private static const log:ILogger = LogContext.getLogger(this);
        public static const ITEMS_PER_PAGE:uint = 9;
        public static const DESIGN_BATCH_SIZE:uint = 54;
        public static const UNLOAD_PAGE_DISTANCE:Object = 3;

        public function DesignSelectorModel()
        {
            this.designList = new ArrayList();
            this.categoryTrees = new Dictionary();
            super(this);
            this.designPages = new Pages(this.designList, ITEMS_PER_PAGE);
            return;
        }// end function

        public function get designs() : Array
        {
            return CollectionUtil.asArray(this.designPages.get(this.currentDesignsPage - 1));
        }// end function

        public function get currentDesign() : IDesign
        {
            return this._currentDesign;
        }// end function

        public function set currentDesign(param1:IDesign) : void
        {
            var value:* = param1;
            if (this._currentDesign == value)
            {
                dispatchEvent(new Event("currentDesignChanged"));
                return;
            }
            this._currentDesign = value;
            this._currentDesigner = IUser(API.em.get(value.user, APIRegistry.USER));
            if (!this._currentDesigner)
            {
                this._currentDesigner = IUser(API.em.load(value.user, APIRegistry.USER, function ()
            {
                dispatchEvent(new Event("currentDesignChanged"));
                return;
            }// end function
            ));
            }
            dispatchEvent(new Event("currentDesignChanged"));
            return;
        }// end function

        public function get topCategories() : Array
        {
            return this.currentTree ? (CollectionUtil.asArray(ITreeNode(this.currentTree).nodeItems)) : ([]);
        }// end function

        public function get subCategories() : Array
        {
            return this.selectedTopCategoryNode ? (CollectionUtil.asArray(this.selectedTopCategoryNode.nodeItems)) : ([]);
        }// end function

        public function get selectedTopCategory()
        {
            return this.selectedTopCategoryNode ? (IDesignCategory(this.selectedTopCategoryNode.item)) : (null);
        }// end function

        public function selectTopCategory(param1:String) : Boolean
        {
            var id:* = param1;
            var newSelectedTopCategoryNode:* = ITreeNode(CollectionUtil.find(this.currentTree.nodeChildren, function (param1) : Boolean
            {
                return param1.item.id == id;
            }// end function
            ));
            if (this.selectedTopCategoryNode == newSelectedTopCategoryNode)
            {
                return true;
            }
            this.selectedTopCategoryNode = newSelectedTopCategoryNode;
            var category:* = this.selectedTopCategory;
            if (category)
            {
            }
            if (category.bestsellers)
            {
                this.selectSubCategory(category.bestsellers);
            }
            else
            {
                if (category)
                {
                }
                if (this.getSubCategoryIDs(category, this._searchTerm)[0])
                {
                    this.selectSubCategory(this.getSubCategoryIDs(category, this._searchTerm)[0]);
                }
                else
                {
                    this.selectSubCategory(null);
                }
            }
            return true;
        }// end function

        public function selectSubCategory(param1:String) : void
        {
            var categoryID:String;
            var newSelectedSubCategoryNode:ITreeNode;
            var id:* = param1;
            if (id == null)
            {
                this.selectedSubCategoryNode = null;
                categoryID = this.selectedTopCategory.id;
            }
            else
            {
                newSelectedSubCategoryNode = ITreeNode(CollectionUtil.find(this.selectedTopCategoryNode.nodeChildren, function (param1) : Boolean
            {
                return param1.item.id == id;
            }// end function
            ));
                categoryID = newSelectedSubCategoryNode.item.id;
                if (this.selectedSubCategoryNode == newSelectedSubCategoryNode)
                {
                    return;
                }
                this.selectedSubCategoryNode = newSelectedSubCategoryNode;
            }
            var action:* = new LoadDesignsAction(this, 0, categoryID, this._searchTerm, this.sortField, this.sortOrder);
            EventUtil.registerOnetimeListeners(action, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [this.designsLoaded, this.designsFault]);
            action.execute();
            dispatchEvent(new Event("categoryChanged"));
            return;
        }// end function

        public function get selectedSubCategory() : IDesignCategory
        {
            return IDesignCategory(this.selectedSubCategoryNode.item);
        }// end function

        public function get selectedCategoryNode() : ITreeNode
        {
            if (this.selectedSubCategoryNode != null)
            {
                return this.selectedSubCategoryNode;
            }
            if (this.selectedTopCategoryNode != null)
            {
                return this.selectedTopCategoryNode;
            }
            return null;
        }// end function

        public function get selectedCategoryID() : String
        {
            var _loc_1:* = this.selectedCategoryNode;
            return _loc_1 ? (_loc_1.item.id) : (null);
        }// end function

        public function getSubCategoryIDs(param1:IDesignCategory, param2:String) : Array
        {
            var category:* = param1;
            var searchTerm:* = param2;
            if (searchTerm != null)
            {
            }
            if (searchTerm == Query.EMPTY_QUERY)
            {
                return category.subCategories;
            }
            return category.subCategories.filter(function (param1:String, param2:int, param3:Array) : Boolean
            {
                var _loc_4:* = IDesignCategory(API.em.get(param1, APIRegistry.DESIGN_CATEGORY));
                var _loc_5:* = _loc_4.getEntryCount(searchTerm);
                if (_loc_5 != undefined)
                {
                }
                if (_loc_5 > 0)
                {
                    return true;
                }
                if (!_loc_4.bestsellers)
                {
                    return false;
                }
                var _loc_6:* = IDesignCategory(API.em.get(_loc_4.bestsellers, APIRegistry.DESIGN_CATEGORY));
                _loc_5 = _loc_6.getEntryCount(searchTerm);
                if (_loc_5 != undefined)
                {
                }
                return _loc_5 > 0;
            }// end function
            );
        }// end function

        public function get currentPage() : int
        {
            return this.currentDesignsPage;
        }// end function

        public function set currentPage(param1:int) : void
        {
            var action:IAsyncAction;
            var pageNumber:* = param1;
            if (pageNumber == this.currentDesignsPage)
            {
                return;
            }
            var numPages:* = this.designPages.size;
            pageNumber = pageNumber > numPages ? (numPages) : (pageNumber);
            pageNumber = pageNumber < 1 ? (1) : (pageNumber);
            this.currentDesignsPage = pageNumber;
            if (this.designPages.size < this._pageCount)
            {
            }
            if (pageNumber >= numPages - 5)
            {
                action = new LoadDesignsAction(this, this.designList.size, this.selectedCategoryID, this._searchTerm, this.sortField, this.sortOrder);
                EventUtil.registerOnetimeListeners(action, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [function (param1) : void
            {
                dispatchEvent(new Event("pageChanged"));
                return;
            }// end function
            , function (param1) : void
            {
                dispatchEvent(new Event("pageChanged"));
                return;
            }// end function
            ]);
                action.execute();
            }
            dispatchEvent(new Event("pageChanged"));
            var evictBeforePage:* = pageNumber - 1 - UNLOAD_PAGE_DISTANCE;
            if (evictBeforePage >= 0)
            {
                this.evictPage(evictBeforePage);
            }
            this.evictPage(pageNumber - 1 + UNLOAD_PAGE_DISTANCE);
            return;
        }// end function

        private function evictPage(param1:int) : void
        {
            var _loc_3:IDesign;
            var _loc_2:* = CollectionUtil.asArray(this.designPages.get(param1));
            for each (_loc_3 in _loc_2)
            {
                
                ImageService.getInstance().evictDesignImage(_loc_3.imageId);
            }
            System.gc();
            return;
        }// end function

        public function get pageCount() : int
        {
            return this._pageCount;
        }// end function

        public function get hasNextPage() : Boolean
        {
            return this.currentDesignsPage < this.pageCount;
        }// end function

        public function get hasPreviousPage() : Boolean
        {
            return this.currentDesignsPage > 1;
        }// end function

        public function set searchTerm(param1:String) : void
        {
            var action:IAsyncAction;
            var searchTerm:* = param1;
            if (searchTerm != null)
            {
            }
            if (searchTerm.replace(/ /g, "") == "")
            {
                searchTerm = Query.EMPTY_QUERY;
            }
            if (searchTerm == this._searchTerm)
            {
                dispatchEvent(new Event("searchComplete"));
                return;
            }
            this._oldSearchTerm = this._searchTerm;
            this._searchTerm = searchTerm;
            this.selectedTopCategoryNode = null;
            this.selectedSubCategoryNode = null;
            if (ConfomatConfiguration.mode == ConfomatModes.ADMIN)
            {
                with ({})
                {
                    {}.ioErrorHandler = function (param1:Event) : void
            {
                log.warn("bonfomat design search failed, designid = " + searchTerm);
                dispatchEvent(new Event("searchFault"));
                dispatchEvent(new Event("searchBackendDesignFault"));
                return;
            }// end function
            ;
                }
                API.em.load(searchTerm, APIRegistry.DESIGN, function (param1:Event) : void
            {
                if (backendDesignSearchList == null)
                {
                    backendDesignSearchList = new ArrayList([param1.target]);
                }
                else
                {
                    backendDesignSearchList.add(param1.target);
                }
                designList = backendDesignSearchList;
                designPages = new Pages(designList, ITEMS_PER_PAGE);
                if (backendDesignSearchList.size < 1)
                {
                    currentDesignsPage = 1;
                }
                else
                {
                    currentDesignsPage = (backendDesignSearchList.size - 1) / ITEMS_PER_PAGE + 1;
                }
                dispatchEvent(new Event("pageChanged"));
                dispatchEvent(new Event("searchComplete"));
                return;
            }// end function
            , function (param1:Event) : void
            {
                log.warn("bonfomat design search failed, designid = " + searchTerm);
                dispatchEvent(new Event("searchFault"));
                dispatchEvent(new Event("searchBackendDesignFault"));
                return;
            }// end function
            );
            }
            else if (!this.currentTree)
            {
                action = new LoadDesignCategoriesAction(this, this._searchTerm, this.sortField, this.sortOrder);
                EventUtil.registerOnetimeListeners(action, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [this.designCategoriesLoadedForSearchTermSetting, this.designCategoriesFaultForSearchTermSetting]);
                action.execute();
            }
            else
            {
                this.designCategoriesLoadedForSearchTermSetting(null);
            }
            return;
        }// end function

        public function sort(param1:String, param2:String) : void
        {
            var _loc_3:IAsyncAction;
            if (param1 == this.sortField)
            {
            }
            if (param2 == this.sortOrder)
            {
                return;
            }
            this.sortOrder = param2;
            this.sortField = param1;
            if (!this.currentTree)
            {
                _loc_3 = new LoadDesignCategoriesAction(this, this._searchTerm, param1, param2);
                EventUtil.registerOnetimeListeners(_loc_3, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [this.designCategoriesLoadedForSort, this.designCategoriesFaultForSort]);
                _loc_3.execute();
            }
            else
            {
                this.designCategoriesLoadedForSort(null);
            }
            return;
        }// end function

        public function get categoriesLoaded() : Boolean
        {
            return this._categoriesLoaded;
        }// end function

        public function get currentTree() : IMutableTreeNode
        {
            return this.categoryTrees[treeKey(this._searchTerm, this.sortField, this.sortOrder)];
        }// end function

        public function get currentDesigner() : IUser
        {
            return this._currentDesigner;
        }// end function

        public function get priceTotal() : Money
        {
            var _loc_3:IPrintType;
            var _loc_4:Number;
            var _loc_5:Array;
            var _loc_6:String;
            var _loc_7:IPrintColor;
            var _loc_1:* = int.MAX_VALUE;
            var _loc_2:* = this._product.getPossiblePrintTypesForDesign(this._currentDesign);
            for each (_loc_3 in _loc_2)
            {
                
                _loc_4 = 0;
                if (_loc_3.colorSpace == ColorSpace.PRINTCOLORS)
                {
                    _loc_5 = ArrayUtil.removeDuplicates(this.currentDesign.colors);
                    for each (_loc_6 in _loc_5)
                    {
                        
                        _loc_7 = PrintTypeRules.getPrintColorForRGBColor(_loc_3, Color.fromHex(ColorUtil.getIntegerColor(_loc_6)));
                        if (_loc_7)
                        {
                            _loc_4 = _loc_4 + _loc_7.price.amount;
                        }
                    }
                }
                _loc_4 = _loc_4 + _loc_3.price.amount;
                _loc_4 = _loc_4 + this._currentDesign.price.amount;
                _loc_1 = Math.min(_loc_1, _loc_4);
            }
            return new Money(_loc_1, ConfomatConfiguration.shop.currency);
        }// end function

        public function set product(param1:IProductModel) : void
        {
            this._product = param1;
            return;
        }// end function

        private function resetDesignPages() : void
        {
            this.refreshCategories();
            this.designList = this.selectedCategoryNode.leafChildren;
            this.designPages = new Pages(this.designList, ITEMS_PER_PAGE);
            var _loc_1:* = IDesignCategory(this.selectedCategoryNode.item).getEntryCount(this._searchTerm);
            this._pageCount = Math.floor(_loc_1 / ITEMS_PER_PAGE);
            if (_loc_1 % ITEMS_PER_PAGE > 0)
            {
                var _loc_2:String;
                _loc_2._pageCount = this._pageCount++;
            }
            this.currentDesignsPage = 1;
            dispatchEvent(new Event("pageChanged"));
            return;
        }// end function

        private function refreshCategories() : void
        {
            var _loc_1:String;
            if (!this.selectedTopCategoryNode)
            {
                return;
            }
            if (this.selectedSubCategoryNode)
            {
                _loc_1 = this.selectedSubCategory.net.sprd.entities:IBaseEntity::id;
                this.selectTopCategory(this.selectedTopCategory.id);
                this.selectSubCategory(_loc_1);
            }
            else
            {
                this.selectTopCategory(this.selectedTopCategory.id);
            }
            return;
        }// end function

        private function designsLoaded(param1:Event) : void
        {
            var _loc_2:* = LoadDesignsAction(param1.target);
            if (_loc_2.searchTerm == this._searchTerm)
            {
            }
            if (_loc_2.sortField == this.sortField)
            {
            }
            if (_loc_2.sortOrder == this.sortOrder)
            {
            }
            if (_loc_2.categoryID == this.selectedCategoryID)
            {
                this.resetDesignPages();
            }
            dispatchEvent(new Event("searchComplete"));
            return;
        }// end function

        private function designsFault(param1:Event) : void
        {
            var _loc_2:* = LoadDesignsAction(param1.target);
            if (_loc_2.searchTerm == this._searchTerm)
            {
            }
            if (_loc_2.sortField == this.sortField)
            {
            }
            if (_loc_2.sortOrder == this.sortOrder)
            {
            }
            if (_loc_2.categoryID == this.selectedCategoryID)
            {
                if (this.selectedCategoryNode)
                {
                }
                if (this.selectedCategoryNode.leafChildren.size > 0)
                {
                    this.resetDesignPages();
                }
                else
                {
                    if (this.selectedSubCategory)
                    {
                        this.selectSubCategory(null);
                        return;
                    }
                    if (this.selectedTopCategory)
                    {
                        this.selectTopCategory(this.currentTree.nodeItems.next().id);
                    }
                }
            }
            return;
        }// end function

        private function designCategoriesLoadedForSearchTermSetting(param1:Event) : void
        {
            var _loc_2:* = IIterator(this.currentTree.nodeItems);
            var _loc_3:* = _loc_2.hasNext() ? (IDesignCategory(_loc_2.next())) : (null);
            var _loc_4:* = _loc_3 ? (_loc_3.getEntryCount(this._searchTerm)) : (0);
            if (this._searchTerm != Query.EMPTY_QUERY)
            {
            }
            if (_loc_4 == 0)
            {
                this.searchTerm = this._oldSearchTerm;
                dispatchEvent(new Event("searchFault"));
            }
            else
            {
                this._categoriesLoaded = true;
                if (_loc_3)
                {
                    this.selectTopCategory(_loc_3.net.sprd.entities:IBaseEntity::id);
                }
                dispatchEvent(new Event("categoriesChanged"));
            }
            return;
        }// end function

        private function designCategoriesFaultForSearchTermSetting(param1:IOErrorEvent) : void
        {
            dispatchEvent(new Event("searchFault"));
            return;
        }// end function

        private function designCategoriesLoadedForSort(param1:Event) : void
        {
            var _loc_2:* = new LoadDesignsAction(this, 0, this.selectedCategoryID, this._searchTerm, this.sortField, this.sortOrder);
            EventUtil.registerOnetimeListeners(_loc_2, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [this.designsLoaded, this.designsFault]);
            _loc_2.execute();
            return;
        }// end function

        private function designCategoriesFaultForSort(param1:IOErrorEvent) : void
        {
            return;
        }// end function

    }
}
