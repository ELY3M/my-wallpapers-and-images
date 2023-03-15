package net.sprd.text
{
    import FontManager.as$88.*;
    import flash.events.*;
    import flash.utils.*;
    import net.sprd.api.*;
    import net.sprd.api.plan.*;
    import net.sprd.api.resource.*;
    import net.sprd.common.actions.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.entities.*;

    public class FontManager extends EventDispatcher implements IEventDispatcher
    {
        private var fontFamiliesLoadingState:int = 0;
        private var fontInfosById:Dictionary;
        private var fontInfosByEmbeddedFontName:Dictionary;
        private var fontFamilies:IQueryResult;
        private static const log:ILogger = LogContext.getLogger(this);
        private static const _instance:FontManager = new FontManager;

        public function FontManager()
        {
            this.fontInfosById = new Dictionary();
            this.fontInfosByEmbeddedFontName = new Dictionary();
            if (_instance)
            {
                throw new Error("Singleton and can only be accessed through " + "FontManager.getInstance()");
            }
            return;
        }// end function

        public function loadFontFamilies(param1:Function, param2:Function) : void
        {
            var fontFamiliesCompleteHandler:* = param1;
            var fontFamiliesFaultHandler:* = param2;
            if (this.fontFamiliesLoadingState != ResourceLoadingState.LOADED)
            {
                this.fontFamiliesLoadingState = ResourceLoadingState.LOADING;
            }
            this.fontFamilies = API.em.find(Query.findAll(APIRegistry.FONT_FAMILY), function (param1:Event) : void
            {
                if (fontFamiliesLoadingState != ResourceLoadingState.LOADED)
                {
                    indexFontFamilies(IQueryResult(param1.target).items);
                }
                fontFamiliesLoadingState = ResourceLoadingState.LOADED;
                if (fontFamiliesCompleteHandler)
                {
                    fontFamiliesCompleteHandler(param1);
                }
                return;
            }// end function
            , function (param1:Event) : void
            {
                fontFamiliesLoadingState = ResourceLoadingState.ERROR;
                if (fontFamiliesCompleteHandler)
                {
                    fontFamiliesFaultHandler(param1);
                }
                return;
            }// end function
            , FetchPlan.lazyPlan(false));
            return;
        }// end function

        public function loadFontAsset(param1:IFontFamily, param2:Boolean, param3:Boolean, param4:Function, param5:Function = null) : void
        {
            var family:* = param1;
            var bold:* = param2;
            var italic:* = param3;
            var completeHandler:* = param4;
            var faultHandler:* = param5;
            var loader:* = function (param1:Event) : void
            {
                var _loc_2:* = fontInfosById[family.id];
                var _loc_3:* = _loc_2.getFontStyleLoader(bold, italic);
                doLoadFontAsset(_loc_3, completeHandler, faultHandler);
                return;
            }// end function
            ;
            switch(this.fontFamiliesLoadingState)
            {
                case ResourceLoadingState.LOADED:
                {
                    this.loader(null);
                    break;
                }
                case ResourceLoadingState.CREATED:
                {
                    this.loadFontFamilies(loader, null);
                    break;
                }
                case ResourceLoadingState.LOADING:
                {
                    this.fontFamilies.addEventListener(Event.COMPLETE, loader);
                    break;
                }
                case ResourceLoadingState.ERROR:
                {
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function loadFontAssetById(param1:String, param2:Function, param3:Function) : void
        {
            var fontStyleID:* = param1;
            var completeHandler:* = param2;
            var faultHandler:* = param3;
            var loadAssetInternal:* = function (param1:Event) : void
            {
                var _loc_2:* = IFontStyle(API.em.get(fontStyleID, APIRegistry.FONT_STYLE));
                var _loc_3:* = fontInfosById[_loc_2.fontFamily].getStyle(fontStyleID);
                doLoadFontAsset(_loc_3, completeHandler, faultHandler);
                return;
            }// end function
            ;
            log.info("Loading font asset. fontStyleId: " + fontStyleID + ", fontFamiliesLoadingState: " + this.fontFamiliesLoadingState);
            switch(this.fontFamiliesLoadingState)
            {
                case ResourceLoadingState.LOADED:
                {
                    this.loadAssetInternal(null);
                    break;
                }
                case ResourceLoadingState.CREATED:
                {
                    this.loadFontFamilies(loadAssetInternal, null);
                    break;
                }
                case ResourceLoadingState.LOADING:
                {
                    this.fontFamilies.addEventListener(Event.COMPLETE, loadAssetInternal);
                    break;
                }
                case ResourceLoadingState.ERROR:
                {
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function isEmbeddedFontLoaded(param1:IFontFamily, param2:Boolean, param3:Boolean) : Boolean
        {
            if (this.fontFamiliesLoadingState != ResourceLoadingState.LOADED)
            {
                return false;
            }
            var _loc_4:* = this.fontInfosById[param1.id];
            if (!_loc_4)
            {
                return false;
            }
            var _loc_5:* = _loc_4.getFontStyleLoader(param2, param3);
            return _loc_5 ? (_loc_5.state == ResourceLoadingState.LOADED) : (false);
        }// end function

        public function getFontFamilyFromEmbbededName(param1:String) : IFontFamily
        {
            var _loc_2:* = this.fontInfosByEmbeddedFontName[param1];
            return _loc_2 ? (_loc_2.FontManager.as$88::family) : (null);
        }// end function

        public function getFontStyle(param1:String, param2:Boolean, param3:Boolean) : IFontStyle
        {
            var _loc_4:* = this.fontInfosById[param1];
            if (!_loc_4)
            {
                return null;
            }
            var _loc_5:* = _loc_4.getFontStyleLoader(param2, param3);
            return _loc_5 ? (_loc_5.style) : (null);
        }// end function

        public function hasFontStyle(param1:IFontFamily, param2:Boolean, param3:Boolean) : Boolean
        {
            var _loc_4:* = this.fontInfosById[param1.id];
            if (!_loc_4)
            {
                return false;
            }
            return _loc_4.hasFontStyle(param2, param3);
        }// end function

        public function getDefaultStyle(param1:IFontFamily) : IFontStyle
        {
            if (!param1)
            {
                return null;
            }
            var _loc_2:* = this.fontInfosById[param1.id];
            if (_loc_2.hasFontStyle(false, false))
            {
                return this.getFontStyle(param1.id, false, false);
            }
            return _loc_2.getStyle(param1.styles[0]).style;
        }// end function

        private function doLoadFontAsset(param1:FontStyleLoader, param2:Function, param3:Function) : void
        {
            if (param1 == null)
            {
                return;
            }
            EventUtil.registerOnetimeListeners(param1, [ActionEvent.COMPLETE, ActionEvent.ERROR], [param2, param3]);
            if (param1.state == ResourceLoadingState.LOADED)
            {
                param1.dispatchEvent(new ActionEvent(param1, ActionEvent.COMPLETE));
            }
            else
            {
                param1.execute();
            }
            return;
        }// end function

        private function indexFontFamilies(param1:Array) : void
        {
            var _loc_2:IFontFamily;
            var _loc_3:FontFamilyInfo;
            var _loc_4:String;
            var _loc_5:IFontStyle;
            for each (_loc_2 in param1)
            {
                
                _loc_3 = new FontFamilyInfo(_loc_2);
                this.fontInfosById[_loc_2.id] = _loc_3;
                this.fontInfosByEmbeddedFontName[_loc_2.getEmbeddedFontName()] = _loc_3;
                for each (_loc_4 in _loc_2.styles)
                {
                    
                    _loc_5 = IFontStyle(API.em.get(_loc_4, APIRegistry.FONT_STYLE));
                    _loc_3.addStyle(_loc_5);
                }
            }
            return;
        }// end function

        public function loadAllAssets() : void
        {
            if (this.fontFamiliesLoadingState == ResourceLoadingState.LOADED)
            {
                this._loadAllAssets();
            }
            else
            {
                this.loadFontFamilies(this._loadAllAssets, function (param1:Event) : void
            {
                log.warn("This should not have been seen.");
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function _loadAllAssets(param1 = null) : void
        {
            var styleQueue:Array;
            var f:IFontFamily;
            var loadAsset:Function;
            var s:String;
            var e:* = param1;
            styleQueue;
            var _loc_3:int;
            var _loc_4:* = this.fontFamilies.items;
            while (_loc_4 in _loc_3)
            {
                
                f = _loc_4[_loc_3];
                var _loc_5:int;
                var _loc_6:* = f.styles;
                while (_loc_6 in _loc_5)
                {
                    
                    s = _loc_6[_loc_5];
                    if (!f.deprecated)
                    {
                        styleQueue.push(s);
                    }
                }
            }
            loadAsset = function (param1:Event) : void
            {
                var _loc_2:* = styleQueue.shift();
                if (_loc_2)
                {
                    loadFontAssetById(_loc_2, loadAsset, loadAsset);
                }
                return;
            }// end function
            ;
            this.loadAsset(null);
            return;
        }// end function

        public static function getInstance() : FontManager
        {
            return _instance;
        }// end function

    }
}
