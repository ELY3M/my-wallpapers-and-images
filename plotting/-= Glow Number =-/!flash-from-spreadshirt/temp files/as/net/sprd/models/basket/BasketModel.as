package net.sprd.models.basket
{
    import flash.events.*;
    import flash.utils.*;
    import net.sprd.api.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.entities.impl.*;
    import net.sprd.events.*;
    import net.sprd.models.product.*;
    import net.sprd.services.externalapi.*;
    import net.sprd.services.statistics.*;

    public class BasketModel extends EventDispatcher implements IBasketModel
    {
        public var bus:IEventDispatcher;
        public var statistics:IStatistics;
        public var externalAPI:IExternalAPI;
        private var basketImpl:IBasketStore;
        private static const log:ILogger = LogContext.getLogger(this);

        public function BasketModel()
        {
            return;
        }// end function

        public function postConstruct() : void
        {
            this.basketImpl = new InternalOpossumBasketStore(ConfomatConfiguration.opossumBaseURL);
            return;
        }// end function

        public function addOrUpdateItem(param1:IProductModel, param2:Boolean, param3:Function = null, param4:Function = null) : void
        {
            var startTime:Number;
            var item_CompleteHandler:Function;
            var item_errorHandler:Function;
            var item:IBasketItem;
            var product:* = param1;
            var update:* = param2;
            var completeHandler:* = param3;
            var faultHandler:* = param4;
            startTime = getTimer();
            item_CompleteHandler = function (param1:BasketEvent) : void
            {
                statistics.track(T.getAdded2BasketEvent((getTimer() - startTime) / 1000));
                bus.dispatchEvent(param1);
                if (completeHandler)
                {
                    completeHandler(param1);
                }
                return;
            }// end function
            ;
            item_errorHandler = function (param1:BasketEvent) : void
            {
                bus.dispatchEvent(param1);
                if (faultHandler)
                {
                    faultHandler(param1);
                }
                return;
            }// end function
            ;
            item = new BasketItem();
            if (ConfomatConfiguration.updatingBasket)
            {
                item.id = ConfomatConfiguration.basketItemId;
            }
            item.elementID = product.currentProductID;
            item.shop = API.em.shopID;
            item.quantity = 1;
            item.elementType = APIRegistry.PRODUCT;
            item.editBasketItemBaseUrl = ConfomatConfiguration.editBasketItemBaseUrl;
            item.appearance = product.currentAppearance.id;
            if (!product.isOnStock(product.currentAppearance))
            {
                EventUtil.registerOnetimeListeners(item, [BasketEvent.ITEM_ERROR], [item_errorHandler]);
                item.dispatchEvent(new BasketEvent(item, BasketEvent.ITEM_ERROR, TrackingErrorCodes.OUT_OF_STOCK));
                return;
            }
            if (product.currentSize)
            {
                item.size = product.currentSize.id;
                this.statistics.track(T.getAdd2BasketEvent());
            }
            else
            {
                EventUtil.registerOnetimeListeners(item, [BasketEvent.ITEM_ERROR], [item_errorHandler]);
                item.dispatchEvent(new BasketEvent(item, BasketEvent.ITEM_ERROR, TrackingErrorCodes.NO_SIZE_SELECTED));
                return;
            }
            item.oldProductId = product.currentProductID;
            with ({})
            {
                {}.saveComplete = function (param1:Event) : void
            {
                statistics.track(T.getProductCreatedEvent((getTimer() - startTime) / 1000));
                item.elementID = product.currentProductID;
                basketImpl.saveItem(item, update, item_CompleteHandler, item_errorHandler);
                return;
            }// end function
            ;
            }
            with ({})
            {
                {}.saveError = function (param1:IOErrorEvent) : void
            {
                var _loc_3:String;
                var _loc_4:String;
                var _loc_2:* = param1.text.split("#", 2);
                if (_loc_2.length == 2)
                {
                    _loc_3 = _loc_2[1];
                    _loc_4 = _loc_2[0];
                }
                else
                {
                    _loc_3 = "";
                    _loc_4 = param1.text;
                }
                log.warn("Couldn\'t save product.");
                EventUtil.registerOnetimeListeners(item, [BasketEvent.ITEM_ERROR], [item_errorHandler]);
                item.dispatchEvent(new BasketEvent(item, BasketEvent.ITEM_ERROR, _loc_4, _loc_3));
                return;
            }// end function
            ;
            }
            product.saveIfModified(function (param1:Event) : void
            {
                statistics.track(T.getProductCreatedEvent((getTimer() - startTime) / 1000));
                item.elementID = product.currentProductID;
                basketImpl.saveItem(item, update, item_CompleteHandler, item_errorHandler);
                return;
            }// end function
            , function (param1:IOErrorEvent) : void
            {
                var _loc_3:String;
                var _loc_4:String;
                var _loc_2:* = param1.text.split("#", 2);
                if (_loc_2.length == 2)
                {
                    _loc_3 = _loc_2[1];
                    _loc_4 = _loc_2[0];
                }
                else
                {
                    _loc_3 = "";
                    _loc_4 = param1.text;
                }
                log.warn("Couldn\'t save product.");
                EventUtil.registerOnetimeListeners(item, [BasketEvent.ITEM_ERROR], [item_errorHandler]);
                item.dispatchEvent(new BasketEvent(item, BasketEvent.ITEM_ERROR, _loc_4, _loc_3));
                return;
            }// end function
            );
            return;
        }// end function

        public function loadItem(param1:String, param2:Function = null, param3:Function = null) : void
        {
            this.basketImpl.loadItem(param1, param2, param3);
            return;
        }// end function

    }
}
