package net.sprd.services.externalapi
{
    import com.laiyonghao.*;
    import flash.events.*;
    import flash.external.*;
    import flash.system.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.entities.*;
    import net.sprd.events.*;
    import net.sprd.models.basket.*;
    import net.sprd.models.product.*;
    import net.sprd.services.i18n.*;

    public class ExternalAPI extends EventDispatcher implements IExternalAPI
    {
        public var i18n:I18n;
        public var product:IProductModel;
        public var basket:IBasketModel;
        private var _applicationLoaded:Boolean = false;
        private static const log:ILogger = LogContext.getLogger(this);
        private static const ON_PRODUCT_CHANGE:String = "onProductChange";
        private static const ON_PRODUCT_UPDATED:String = "onProductUpdated";
        private static const DISPLAY_SHIPPING_DETAILS:String = "confomatContext.displayShippingDetails";
        private static const DISPLAY_TAX_DETAILS:String = "confomatContext.displayTaxDetails";
        private static const CHECKOUT:String = "confomatContext.checkout";
        private static const ADD_TO_BASKET:String = "addToBasket";
        private static const UPDATE_BASKET_ITEM:String = "updateBasketItem";
        private static const ON_APPLICATION_LOADED:String = "onApplicationLoaded";
        private static const ON_DESIGN_CHANGED:String = "onDesignChanged";
        private static const ON_BASKET_ITEM_CREATED:String = "onBasketItemCreated";
        private static const ON_BASKET_ITEM_UPDATED:String = "onBasketItemUpdated";
        private static const ON_PRODUCTTYPE_CHANGE:String = "onProductTypeChange";
        private static const SET_TOKEN:String = "confomatContext.setToken";
        private static const GET_TOKEN:String = "confomatContext.getToken";
        private static var token:String = null;

        public function ExternalAPI()
        {
            return;
        }// end function

        public function init() : void
        {
            ExternalInterface.addCallback("startAddToBasket", this.startAddToBasket);
            ExternalInterface.addCallback("setLocale", this.setLocale);
            ExternalInterface.addCallback("setProductId", this.setProductId);
            ExternalInterface.addCallback("setProductTypeId", this.setProductTypeId);
            ExternalInterface.addCallback("setAppearanceId", this.setAppearanceId);
            ExternalInterface.addCallback("setSizeId", this.setSizeId);
            ExternalInterface.addCallback("getProductId", this.getProductId);
            ExternalInterface.addCallback("getProductTypeId", this.getProductTypeId);
            ExternalInterface.addCallback("getAppearanceId", this.getAppearanceId);
            ExternalInterface.addCallback("getSizeId", this.getSizeId);
            ExternalInterface.addCallback("isLoaded", this.isLoaded);
            ExternalInterface.addCallback("gotoCheckout", this.checkout);
            Security.allowDomain("*");
            return;
        }// end function

        public function isAvailable() : Boolean
        {
            return ExternalInterface.available;
        }// end function

        private function startAddToBasket() : void
        {
            this.basket.addOrUpdateItem(this.product, false);
            return;
        }// end function

        private function setLocale(param1:String) : void
        {
            this.i18n.setLocale(param1);
            return;
        }// end function

        private function setProductId(param1:String) : void
        {
            this.product.initializeProduct(param1);
            return;
        }// end function

        private function setProductTypeId(param1:String) : void
        {
            this.product.changeProductType(param1);
            return;
        }// end function

        private function setAppearanceId(param1:String) : void
        {
            var _loc_2:* = this.product.productType.getAppearanceById(param1);
            if (_loc_2)
            {
                this.product.currentAppearance = _loc_2;
            }
            return;
        }// end function

        private function setSizeId(param1:String) : void
        {
            var _loc_2:* = this.product.productType.getSizeById(param1);
            if (_loc_2)
            {
                this.product.currentSize = _loc_2;
            }
            return;
        }// end function

        private function isLoaded() : Boolean
        {
            return this._applicationLoaded;
        }// end function

        private function getProductId() : String
        {
            return this.product.currentProductID;
        }// end function

        private function getProductTypeId() : String
        {
            return this.product.productType ? (this.product.productType.id) : (null);
        }// end function

        private function getAppearanceId() : String
        {
            return this.product.currentAppearance ? (this.product.currentAppearance.id) : (null);
        }// end function

        private function getSizeId() : String
        {
            return this.product.currentSize ? (this.product.currentSize.id) : (null);
        }// end function

        public function onApplicationLoaded(param1:Number) : void
        {
            var time:* = param1;
            try
            {
                ExternalInterface.call(ON_APPLICATION_LOADED, time);
            }
            catch (e:Error)
            {
                log.error(e.toString());
            }
            this._applicationLoaded = true;
            return;
        }// end function

        public function displayShippingDetails() : void
        {
            try
            {
                ExternalInterface.call(DISPLAY_SHIPPING_DETAILS);
            }
            catch (e:Error)
            {
                log.error(e.toString());
            }
            return;
        }// end function

        public function displayTaxDetails() : void
        {
            try
            {
                ExternalInterface.call(DISPLAY_TAX_DETAILS);
            }
            catch (e:Error)
            {
                log.error(e.toString());
            }
            return;
        }// end function

        public function checkout() : void
        {
            try
            {
                ExternalInterface.call(CHECKOUT);
            }
            catch (e:Error)
            {
                log.error(e.toString());
            }
            return;
        }// end function

        public function onProductUpdated(param1:String, param2:String, param3:String, param4:String) : void
        {
            var oldId:* = param1;
            var newId:* = param2;
            var appearanceId:* = param3;
            var sizeId:* = param4;
            try
            {
                ExternalInterface.call(ON_PRODUCT_UPDATED, newId, oldId, appearanceId, sizeId);
            }
            catch (e:Error)
            {
                log.error(e.toString());
            }
            return;
        }// end function

        public function onDesignChanged(param1:IDesign) : void
        {
            var value:* = param1;
            if (value)
            {
            }
            if (!this.isAvailable())
            {
                return;
            }
            try
            {
                ExternalInterface.call(ON_DESIGN_CHANGED, value.id);
            }
            catch (e:Error)
            {
                log.error(e.toString());
            }
            return;
        }// end function

        public function bus_basketUpdatedHandler(param1:BasketEvent) : void
        {
            var event:* = param1;
            var item:* = event.item;
            log.debug("BasketEvent.type = " + event.type);
            if (event.type == BasketEvent.ITEM_CREATED)
            {
                log.info("Send item created: " + item);
                ExternalInterface.call(ON_BASKET_ITEM_CREATED, item.id, item.shop, item.elementID, item.appearance, item.size, item.quantity);
            }
            else if (event.type == BasketEvent.ITEM_UPDATED)
            {
                log.info("Send item updated: " + item);
                try
                {
                    ExternalInterface.call(ON_BASKET_ITEM_UPDATED, item.id, item.shop, item.oldProductId, item.elementID, item.appearance, item.size, item.quantity);
                }
                catch (e:Error)
                {
                    log.error(e.toString());
                }
            }
            else
            {
                log.info("Basket item cannot be updated. Event type: " + event.type + " : " + event.message);
            }
            return;
        }// end function

        public function product_changeHandler(param1:ProductEvent) : void
        {
            var event:* = param1;
            try
            {
                ExternalInterface.call(ON_PRODUCT_CHANGE, event.product.id);
                ExternalInterface.call(ON_PRODUCTTYPE_CHANGE, event.product.net.sprd.entities:IProduct::productType);
            }
            catch (e:Error)
            {
                log.error(e.toString());
            }
            return;
        }// end function

        public function productType_changeHandler(param1:ProductTypeEvent) : void
        {
            var event:* = param1;
            try
            {
                ExternalInterface.call(ON_PRODUCTTYPE_CHANGE, event.productType.id);
            }
            catch (e:Error)
            {
                log.error(e.toString());
            }
            return;
        }// end function

        public static function getToken() : String
        {
            var newToken:Boolean;
            if (token)
            {
            }
            if (token is String)
            {
            }
            if (String(token).length != 36)
            {
                try
                {
                    token = ExternalInterface.call(GET_TOKEN);
                }
                catch (e:Error)
                {
                }
                if (token == undefined)
                {
                    token = null;
                }
                if (token)
                {
                }
                if (token is String)
                {
                }
                if (String(token).length != 36)
                {
                    token = new Uuid().toString();
                    newToken;
                }
                if (ExternalInterface.available)
                {
                    try
                    {
                        ExternalInterface.call(SET_TOKEN, token);
                    }
                    catch (e:Error)
                    {
                        log.warn(e.toString());
                    }
                }
            }
            return token;
        }// end function

    }
}
