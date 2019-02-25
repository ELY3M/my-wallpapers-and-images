package net.sprd.modules.share
{
    import flash.events.*;
    import flash.system.*;
    import net.sprd.common.collections.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.entities.*;
    import net.sprd.services.image.*;

    public class ProductSelectorModel extends EventDispatcher implements IPageable
    {
        var productList:ArrayList;
        private var productPages:Pages;
        private var _currentPage:uint = 1;
        private var _pageCount:uint;
        private var _productTotalCount:uint = 0;
        private var _loading:Boolean;
        private var _reload:Boolean;
        private static const log:ILogger = LogContext.getLogger(this);
        public static const PRODUCTS_CHANGED:String = "pageChanged";
        public static const LOADINGSTATE_CHANGED:String = "loadingStateChanged";
        public static const BATCH_SIZE:uint = 60;
        public static const ITEMS_PER_PAGE:uint = 6;
        public static const UNLOAD_PAGE_DISTANCE:uint = 3;

        public function ProductSelectorModel()
        {
            this.productList = new ArrayList();
            super(this);
            this.productPages = new Pages(this.productList, ITEMS_PER_PAGE);
            return;
        }// end function

        public function get products() : Array
        {
            if (!this.productPages)
            {
                return [];
            }
            var _loc_1:* = CollectionUtil.asArray(this.productPages.get(this._currentPage - 1));
            return _loc_1;
        }// end function

        public function get isLoading() : Boolean
        {
            return this._loading;
        }// end function

        private function set _isLoading(param1:Boolean) : void
        {
            if (param1 != this._loading)
            {
                this._loading = param1;
                dispatchEvent(new Event(LOADINGSTATE_CHANGED));
            }
            return;
        }// end function

        public function load() : void
        {
            this.loadNextProducts();
            return;
        }// end function

        public function reload() : void
        {
            this._reload = true;
            dispatchEvent(new Event(PRODUCTS_CHANGED));
            this.loadNextProducts();
            return;
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
            var _loc_2:* = this.productPages.size;
            param1 = param1 > _loc_2 ? (_loc_2) : (param1);
            param1 = param1 < 1 ? (1) : (param1);
            this._currentPage = param1;
            if (this.productPages.size < this._pageCount)
            {
            }
            if (param1 >= _loc_2 - 5)
            {
                this.loadNextProducts();
            }
            dispatchEvent(new Event("pageChanged"));
            var _loc_3:* = param1 - 1 - UNLOAD_PAGE_DISTANCE;
            if (_loc_3 >= 0)
            {
                this.evictPage(_loc_3);
            }
            this.evictPage(param1 - 1 + UNLOAD_PAGE_DISTANCE);
            return;
        }// end function

        private function loadNextProducts() : void
        {
            var action:* = new LoadProductsAction(this._reload ? (0) : (this.productList.size), this._reload);
            this._isLoading = true;
            EventUtil.registerOnetimeListeners(action, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [function (param1:Event) : void
            {
                var _loc_3:*;
                if (_reload)
                {
                    _reload = false;
                    _productTotalCount = 0;
                    _currentPage = 1;
                    productList.clear();
                }
                var _loc_2:* = LoadProductsAction(param1.currentTarget).result;
                for each (_loc_3 in _loc_2.items)
                {
                    
                    productList.add(_loc_3.clone());
                }
                productTotalCount = _loc_2.totalCount;
                _isLoading = false;
                dispatchEvent(new Event("pageChanged"));
                return;
            }// end function
            , function (param1) : void
            {
                _isLoading = false;
                dispatchEvent(new Event("pageChanged"));
                return;
            }// end function
            ]);
            action.execute();
            return;
        }// end function

        private function evictPage(param1:int) : void
        {
            var _loc_3:IProduct;
            var _loc_2:* = CollectionUtil.asArray(this.productPages.get(param1));
            for each (_loc_3 in _loc_2)
            {
                
                ImageService.getInstance().evictProductImage(_loc_3.id, _loc_3.defaultView, 75, 75);
            }
            System.gc();
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

        public function get pageCount() : int
        {
            if (!this.productPages)
            {
                return 0;
            }
            return this.productPages.size;
        }// end function

        public function set productTotalCount(param1:uint) : void
        {
            this._productTotalCount = param1;
            return;
        }// end function

        public function get productTotalCount() : uint
        {
            return this._productTotalCount;
        }// end function

        function insertProduct(param1:IProduct) : void
        {
            this.productList.addItemAt(param1.clone(), 0);
            var _loc_2:String;
            _loc_2._productTotalCount = this._productTotalCount++;
            dispatchEvent(new Event("pageChanged"));
            return;
        }// end function

        public function insertEmptyProduct(param1:Boolean = true) : void
        {
            this.productList.addItemAt(null, 0);
            var _loc_2:String;
            _loc_2._productTotalCount = this._productTotalCount++;
            if (param1)
            {
                dispatchEvent(new Event("pageChanged"));
            }
            return;
        }// end function

        public function removeEmptyProduct(param1:Boolean = true) : void
        {
            var _loc_2:Boolean;
            do
            {
                
                this.productList.removeItemAt(0);
                var _loc_3:String;
                _loc_3._productTotalCount = this._productTotalCount--;
                _loc_2 = true;
                if (this.productList.size > 0)
                {
                }
            }while (this.productList.get(0) == null)
            if (_loc_2)
            {
            }
            if (param1)
            {
                dispatchEvent(new Event("pageChanged"));
            }
            return;
        }// end function

    }
}
