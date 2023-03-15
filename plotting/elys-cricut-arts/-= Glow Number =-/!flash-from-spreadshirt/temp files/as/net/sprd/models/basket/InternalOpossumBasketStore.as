package net.sprd.models.basket
{
    import flash.events.*;
    import flash.net.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.entities.*;
    import net.sprd.entities.impl.*;
    import net.sprd.events.*;

    public class InternalOpossumBasketStore extends Object implements IBasketStore
    {
        private var basketUrl:String;
        private static const log:ILogger = LogContext.getLogger(this);
        private static const ADD_TO_BASKET_PATH:String = "/Basket/addtobasket/nogui/1";
        private static const UPDATE_BASKET_PATH:String = "/Basket/updateBasketItem";
        private static const LOAD_BASKET_ITEM_PATH:String = "/Basket/getBasketItem/basketItemId";

        public function InternalOpossumBasketStore(param1:String)
        {
            this.basketUrl = param1;
            return;
        }// end function

        public function saveItem(param1:IBasketItem, param2:Boolean, param3:Function, param4:Function) : void
        {
            var httpStatus:String;
            var loader:URLLoader;
            var request:URLRequest;
            var item:* = param1;
            var update:* = param2;
            var completeHandler:* = param3;
            var faultHandler:* = param4;
            EventUtil.registerOnetimeListeners(item, [update ? (BasketEvent.ITEM_UPDATED) : (BasketEvent.ITEM_CREATED), BasketEvent.ITEM_ERROR], [completeHandler, faultHandler]);
            httpStatus;
            loader = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.TEXT;
            var variables:* = new URLVariables();
            variables.shopId = item.shop;
            variables.appearanceId = item.appearance;
            variables.sizeId = item.size;
            variables.quantity = item.quantity;
            variables.editBasketItemBaseUrl = item.editBasketItemBaseUrl;
            if (update)
            {
                request = new URLRequest(this.basketUrl + UPDATE_BASKET_PATH);
                variables.basketItemId = item.id;
                variables.newProductId = item.elementID;
                variables.oldProductId = item.oldProductId;
            }
            else
            {
                request = new URLRequest(this.basketUrl + ADD_TO_BASKET_PATH);
                variables.originId = ConfomatConfiguration.originId;
                variables.originContext = "designer";
                variables.productId = item.elementID;
            }
            request.data = variables;
            request.method = URLRequestMethod.POST;
            var postCompleteHandler:* = function (param1:Event) : void
            {
                log.debug("Posted basket, data: " + loader.data);
                if (loader.data == "0")
                {
                    item.dispatchEvent(new BasketEvent(item, update ? (BasketEvent.ITEM_UPDATED) : (BasketEvent.ITEM_CREATED)));
                }
                else
                {
                    log.warn("Error creating basket item: " + param1 + ", data: " + loader.data);
                    item.dispatchEvent(new BasketEvent(item, BasketEvent.ITEM_ERROR, loader.data));
                }
                return;
            }// end function
            ;
            var ioErrorHandler:* = function (param1:Event) : void
            {
                log.warn("IO Error creating basket item: " + param1 + ", status: " + httpStatus + ", data: " + loader.data);
                item.dispatchEvent(new BasketEvent(item, BasketEvent.ITEM_ERROR, httpStatus, loader.data));
                return;
            }// end function
            ;
            var securityErrorHandler:* = function (param1:SecurityErrorEvent) : void
            {
                log.warn("Security Error creating basket item: " + param1 + ", status: " + httpStatus + ", data: " + loader.data);
                item.dispatchEvent(new BasketEvent(item, BasketEvent.ITEM_ERROR, httpStatus, loader.data));
                return;
            }// end function
            ;
            EventUtil.registerOnetimeListeners(loader, [Event.COMPLETE, IOErrorEvent.IO_ERROR, SecurityErrorEvent.SECURITY_ERROR], [postCompleteHandler, ioErrorHandler, securityErrorHandler]);
            EventUtil.registerOnetimeListeners(loader, [HTTPStatusEvent.HTTP_STATUS], [function (param1:HTTPStatusEvent)
            {
                httpStatus = param1.status.toString();
                return;
            }// end function
            ]);
            try
            {
                loader.load(request);
            }
            catch (error:Error)
            {
                log.warn("Unable to post to basket: " + error);
                loader.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
            }
            return;
        }// end function

        public function loadItem(param1:String, param2:Function, param3:Function) : void
        {
            var item:IBasketItem;
            var httpStatus:String;
            var loader:URLLoader;
            var id:* = param1;
            var completeHandler:* = param2;
            var errorHandler:* = param3;
            item = new BasketItem();
            EventUtil.registerOnetimeListeners(item, [BasketEvent.ITEM_LOADED, BasketEvent.ITEM_ERROR], [completeHandler, errorHandler]);
            httpStatus;
            loader = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.BINARY;
            var request:* = new URLRequest(this.basketUrl + LOAD_BASKET_ITEM_PATH + "/" + id);
            request.method = URLRequestMethod.GET;
            var loader_completeHandler:* = function (param1:Event) : void
            {
                var _loc_3:String;
                var _loc_4:Array;
                var _loc_2:*;
                for each (_loc_3 in String(loader.data).split("&"))
                {
                    
                    _loc_4 = _loc_3.split("=", 2);
                    _loc_2[_loc_4[0]] = _loc_4[1];
                }
                item.id = _loc_2.basketItemId;
                item.shop = _loc_2.shopId;
                item.size = _loc_2.sizeId;
                item.appearance = _loc_2.appearanceId;
                item.quantity = _loc_2.quantity;
                item.elementID = _loc_2.productId;
                item.dispatchEvent(new BasketEvent(item, BasketEvent.ITEM_LOADED));
                return;
            }// end function
            ;
            var ioErrorHandler:* = function (param1:IOErrorEvent)
            {
                var _loc_2:* = "IO error, status: " + httpStatus + ": " + param1.text;
                log.warn(_loc_2);
                item.dispatchEvent(new BasketEvent(item, BasketEvent.ITEM_ERROR, httpStatus, param1.text));
                return;
            }// end function
            ;
            var securityErrorHandler:* = function (param1:SecurityErrorEvent)
            {
                var _loc_2:* = "Security error, status: " + httpStatus + ": " + param1.text;
                item.dispatchEvent(new BasketEvent(item, BasketEvent.ITEM_ERROR, httpStatus, param1.text));
                return;
            }// end function
            ;
            var statusHandler:* = function (param1:HTTPStatusEvent)
            {
                httpStatus = param1.status.toString();
                return;
            }// end function
            ;
            EventUtil.registerOnetimeListeners(loader, [Event.COMPLETE, IOErrorEvent.IO_ERROR, SecurityErrorEvent.SECURITY_ERROR], [loader_completeHandler, ioErrorHandler, securityErrorHandler]);
            EventUtil.registerOnetimeListeners(loader, [HTTPStatusEvent.HTTP_STATUS], [statusHandler]);
            try
            {
                loader.load(request);
            }
            catch (error:Error)
            {
                log.warn("Unable to get basket: " + error);
                loader.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
            }
            return;
        }// end function

    }
}
