package 
{
    import SprdPreloader.*;
    import flash.events.*;
    import flash.external.*;
    import flash.utils.*;
    import mx.events.*;
    import mx.preloaders.*;
    import net.sprd.api.*;
    import net.sprd.entities.*;
    import net.sprd.entities.impl.*;

    public class SprdPreloader extends DownloadProgressBar
    {
        private var _mov:customPreloader;
        private var _lang:String;
        private var _initCount:uint;
        private var _startTime:uint;
        private var _displayShown:Boolean;
        private var _percentTotal:uint;
        private var _UIComplete:Boolean;
        private var _shopComplete:Boolean;
        private var _dataLoadingFailed:Boolean;
        private static var DOWNLOAD_SWF_SHARE:uint = 70;
        private static var DOWNLOAD_RSL_SHARE:uint = 20;
        private static var INIT_UI_SHARE:uint = 10;
        private static var jsInjected:Boolean;

        public function SprdPreloader()
        {
            initProgressTotal = 10;
            return;
        }// end function

        override public function initialize() : void
        {
            this._startTime = getTimer();
            this.preloadData();
            return;
        }// end function

        override protected function progressHandler(param1:ProgressEvent) : void
        {
            if (param1.type == RSLEvent.RSL_PROGRESS)
            {
                return;
            }
            var _loc_2:* = getTimer() - this._startTime;
            if (true)
            {
            }
            if (this.showDisplayForDownloading(_loc_2, param1))
            {
                if (!this._displayShown)
                {
                    this.showDisplay();
                }
                this._percentTotal = Math.ceil(param1.bytesLoaded / param1.bytesTotal * DOWNLOAD_SWF_SHARE);
                this.updateDisplay();
            }
            return;
        }// end function

        override protected function completeHandler(param1:Event) : void
        {
            this._percentTotal = DOWNLOAD_SWF_SHARE;
            this.updateDisplay();
            return;
        }// end function

        override protected function rslProgressHandler(param1:RSLEvent) : void
        {
            if (!this._displayShown)
            {
                this.showDisplay();
            }
            var _loc_2:* = DOWNLOAD_RSL_SHARE / param1.rslTotal;
            var _loc_3:* = DOWNLOAD_SWF_SHARE + _loc_2 * param1.rslIndex;
            this._percentTotal = Math.ceil(_loc_3 + param1.bytesLoaded / param1.bytesTotal * _loc_2);
            this.updateDisplay();
            return;
        }// end function

        override protected function rslCompleteHandler(param1:RSLEvent) : void
        {
            this._percentTotal = DOWNLOAD_SWF_SHARE + Math.ceil(param1.rslIndex / param1.rslTotal * DOWNLOAD_RSL_SHARE);
            this.updateDisplay();
            return;
        }// end function

        override protected function initProgressHandler(param1:Event) : void
        {
            var _loc_3:uint;
            if (this._dataLoadingFailed)
            {
                param1.stopImmediatePropagation();
            }
            var _loc_2:* = getTimer() - this._startTime;
            var _loc_4:String;
            _loc_4._initCount = this._initCount++;
            if (!this._displayShown)
            {
            }
            if (showDisplayForInit(_loc_2, this._initCount))
            {
                this.showDisplay();
            }
            if (this._displayShown)
            {
                _loc_3 = DOWNLOAD_RSL_SHARE + DOWNLOAD_SWF_SHARE;
                this._percentTotal = _loc_3 + Math.ceil(this._initCount / initProgressTotal * INIT_UI_SHARE);
                this.updateDisplay();
            }
            return;
        }// end function

        override protected function initCompleteHandler(param1:Event) : void
        {
            if (this._dataLoadingFailed)
            {
                param1.stopImmediatePropagation();
            }
            this._percentTotal = DOWNLOAD_RSL_SHARE + DOWNLOAD_SWF_SHARE + INIT_UI_SHARE;
            this.updateDisplay();
            this._UIComplete = true;
            this.testPreloadComplete();
            return;
        }// end function

        override protected function showDisplayForDownloading(param1:int, param2:ProgressEvent) : Boolean
        {
            return true;
        }// end function

        private function showDisplay() : void
        {
            if (this._mov)
            {
                return;
            }
            this._mov = new customPreloader();
            addChild(this._mov);
            if (loaderInfo.parameters.locale)
            {
                this._lang = loaderInfo.parameters.locale.split("_")[0].toString().toLowerCase();
            }
            else
            {
                this._lang = "en";
            }
            x = Math.round((stage.stageWidth - this._mov.width) / 2 + this._mov.width / 2);
            y = Math.round((stage.stageHeight - this._mov.height) / 2 + this._mov.height / 2);
            this._displayShown = true;
            return;
        }// end function

        private function updateDisplay() : void
        {
            if (parseInt(this._mov.percentField.text) <= this._percentTotal)
            {
            }
            if (this._dataLoadingFailed)
            {
                return;
            }
            this._mov.percentField.text = this._percentTotal > 99 ? ("99%") : (this._percentTotal + "%");
            var _loc_1:* = Math.ceil(this._percentTotal / 100 * 20);
            this._mov.setFrame(_loc_1, this._lang);
            this._mov.gotoAndStop(_loc_1);
            return;
        }// end function

        private function preloadData() : void
        {
            injectJs();
            ConfomatConfiguration.initialize(stage);
            API.em.load(ConfomatConfiguration.shopID, APIRegistry.SHOP, function (param1:Event) : void
            {
                var e:* = param1;
                var shop:* = IShop(e.target);
                ConfomatConfiguration.shop = shop;
                with ({})
                {
                    {}.complete = function (param1:Event) : void
                {
                    ConfomatConfiguration.country = ICountry(param1.target);
                    loadComplete();
                    return;
                }// end function
                ;
                }
                API.em.load(shop.country, APIRegistry.COUNTRY, function (param1:Event) : void
                {
                    ConfomatConfiguration.country = ICountry(param1.target);
                    loadComplete();
                    return;
                }// end function
                , onShopFault);
                loadComplete();
                return;
            }// end function
            , this.onShopFault);
            API.em.load("confomat7", APIRegistry.SHOP_APPLICATION, function (param1:Event) : void
            {
                ConfomatConfiguration.shopApplication = IShopApplication(param1.target);
                loadComplete();
                return;
            }// end function
            , function (param1:Event) : void
            {
                ConfomatConfiguration.shopApplication = new ShopApplication();
                loadComplete();
                return;
            }// end function
            );
            var query:* = Query.findAll(APIRegistry.PRINT_TYPE, 0, 1000);
            var fetchPlan:* = APIRegistry.getFetchPlan(APIRegistry.PRINT_TYPE);
            fetchPlan.partial = false;
            API.em.find(query, null, null, fetchPlan);
            return;
        }// end function

        private function testPreloadComplete() : void
        {
            if (this._shopComplete)
            {
            }
            if (this._UIComplete)
            {
                dispatchEvent(new Event(Event.COMPLETE));
            }
            return;
        }// end function

        private function loadComplete() : void
        {
            var _loc_1:IShopApplication;
            var _loc_2:*;
            if (ConfomatConfiguration.shop)
            {
            }
            if (ConfomatConfiguration.country)
            {
            }
            if (ConfomatConfiguration.shopApplication)
            {
                _loc_1 = ConfomatConfiguration.shopApplication;
                _loc_2 = root.loaderInfo.parameters;
                if (_loc_2.showDesignGallery)
                {
                    _loc_1.showDesignGallery = _loc_2.showDesignGallery.toString().toLowerCase() == "true";
                }
                if (_loc_2.showMarketPlaceDesigns)
                {
                    _loc_1.showMarketPlaceDesigns = _loc_2.showMarketPlaceDesigns.toString().toLowerCase() == "true";
                }
                if (_loc_2.showProductTypeGallery)
                {
                    _loc_1.showProductTypeGallery = _loc_2.showProductTypeGallery.toString().toLowerCase() == "true";
                }
                if (_loc_2.showAddText)
                {
                    _loc_1.showAddText = _loc_2.showAddText.toString().toLowerCase() == "true";
                }
                if (_loc_2.uploadMode)
                {
                }
                if (UploadModeType.valueExists(_loc_2.uploadMode))
                {
                    _loc_1.uploadMode = _loc_2.uploadMode;
                }
                if (_loc_2.showDesignSearch)
                {
                    _loc_1.showDesignSearch = _loc_2.showDesignSearch.toString().toLowerCase() == "true";
                }
                if (_loc_2.showSaveAndShare)
                {
                    _loc_1.showSaveAndShare = _loc_2.showSaveAndShare.toString().toLowerCase() == "true";
                }
                if (_loc_2.mode == "partner")
                {
                    _loc_1.showDesignSearch = false;
                }
                this._shopComplete = true;
                this.testPreloadComplete();
            }
            return;
        }// end function

        private function onShopFault(param1:Event) : void
        {
            this._dataLoadingFailed = true;
            this._mov.headline.text = "Could not load shop.";
            this._mov.percentField.text = "";
            this._mov.gotoAndStop(20);
            return;
        }// end function

        public static function injectJs() : void
        {
            var id:String;
            var jsCode:XML;
            if (!jsInjected)
            {
            }
            if (ExternalInterface.available)
            {
                jsInjected = true;
                id = "sprd_" + Math.floor(Math.random() * 1000000);
                ExternalInterface.addCallback(id, function ()
            {
                return;
            }// end function
            );
                jsCode = <script><![CDATA[
				function(){

					if(typeof sprd == "undefined" || !sprd)sprd = {};
					var userAgent = navigator.userAgent.toLowerCase();

					sprd.platform = {
						win:/win/.test(userAgent),
						mac:/mac/.test(userAgent)
					};

					sprd.browser = {
						version: (userAgent.match(/.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/) || [])[1],
						safari: /webkit/.test(userAgent),
						opera: /opera/.test(userAgent),
						msie: /msie/.test(userAgent) && !/opera/.test(userAgent),
						mozilla: /mozilla/.test(userAgent) && !/(compatible|webkit)/.test(userAgent),
						chrome: /chrome/.test(userAgent)
					};

			        // current browser width
					sprd.getBrowserWidth = function(){
						return sprd.browser.msie ? document.documentElement.clientWidth : window.innerWidth;
					}

                    // current browser height
					sprd.getBrowserHeight = function(){
						return sprd.browser.msie ? document.documentElement.clientHeight : window.innerHeight;
					}
				} 
			]]></script>;
                ExternalInterface.call(jsCode);
            }
            return;
        }// end function

    }
}
