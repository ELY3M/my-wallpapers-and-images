package net.sprd.components.basket
{
    import flash.events.*;
    import flash.text.engine.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.events.*;
    import mx.formatters.*;
    import mx.validators.*;
    import net.sprd.api.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.components.common.*;
    import net.sprd.entities.*;
    import net.sprd.events.*;
    import net.sprd.models.basket.*;
    import net.sprd.models.common.*;
    import net.sprd.models.product.*;
    import net.sprd.services.externalapi.*;
    import net.sprd.services.statistics.*;
    import net.sprd.skins.d2c.buttons.*;

    public class BasketClass extends Canvas
    {
        public var addToBasketButton:ProgressButton;
        public var updateProductButton:ProgressButton;
        public var vatNoticeLabel:LinkButton;
        public var shippingNoticeLabel:LinkButton;
        public var bus:IEventDispatcher;
        public var _product:IProductModel;
        private var _priceChanged:Boolean;
        public var _basket:IBasketModel;
        private var _price:TextLine;
        private var _mode:String;
        private var _componentComplete:Boolean;
        public var statistics:IStatistics;
        public var externalAPI:IExternalAPI;
        public var confomatError:ConfomatErrorDialog;
        private static const log:ILogger = LogContext.getLogger(this);

        public function BasketClass()
        {
            return;
        }// end function

        public function init() : void
        {
            this._priceChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function set basket(param1:IBasketModel) : void
        {
            this._basket = param1;
            return;
        }// end function

        public function set mode(param1:String) : void
        {
            this._mode = param1;
            if (this._mode == ConfomatModes.ADMIN)
            {
                this.addToBasketButton.endEffectsStarted();
                this.addToBasketButton.visible = false;
                this.updateProductButton.endEffectsStarted();
                this.updateProductButton.visible = true;
            }
            else if (ConfomatConfiguration.updatingBasket)
            {
                this.addToBasketButton.label = resourceManager.getString("confomat7", "basket_section.btn_update_product");
            }
            return;
        }// end function

        private function updatePrice() : void
        {
            if (!this._product.price)
            {
                return;
            }
            if (this._price)
            {
                rawChildren.removeChild(this._price);
            }
            this._price = this.createFormattedPriceText().createTextLine(null, 600);
            this._price.x = this.vatNoticeLabel.getBounds(this).right - this._price.textWidth;
            this._price.y = 25;
            rawChildren.addChild(this._price);
            invalidateDisplayList();
            return;
        }// end function

        private function createFormattedPriceText() : TextBlock
        {
            var _loc_1:* = CurrencyFormatterFactory.createCurrencyFormatter(this._product.price.currency);
            var _loc_2:* = this.determinePriceParts(_loc_1);
            var _loc_3:* = new FontDescription("TheSerifCCF", "normal", "normal", FontLookup.EMBEDDED_CFF);
            var _loc_4:uint;
            if (styleManager.getStyleDeclarations(".priceLabel"))
            {
                _loc_4 = styleManager.getStyleDeclaration(".priceLabel").getStyle("color");
            }
            var _loc_5:* = new Vector.<ContentElement>;
            _loc_5.push(new TextElement(_loc_2[0], new ElementFormat(_loc_3, 40, _loc_4)));
            if (_loc_1.precision > 0)
            {
                _loc_5.push(new TextElement(_loc_1.decimalSeparatorTo, new ElementFormat(_loc_3, 23, _loc_4)));
                _loc_5.push(new TextElement(_loc_2[1], new ElementFormat(_loc_3, 24, _loc_4, 1, "auto", "roman", "useDominantBaseline", -9)));
            }
            if (_loc_1.alignSymbol == CurrencyValidatorAlignSymbol.RIGHT)
            {
                _loc_5.push(new TextElement(" " + _loc_1.currencySymbol, new ElementFormat(_loc_3, 33, _loc_4)));
            }
            else
            {
                _loc_5.unshift(new TextElement(_loc_1.currencySymbol + " ", new ElementFormat(_loc_3, 33, _loc_4)));
            }
            return new TextBlock(new GroupElement(_loc_5));
        }// end function

        private function determinePriceParts(param1:CurrencyFormatter) : Array
        {
            var _loc_2:* = param1.currencySymbol;
            param1.currencySymbol = "";
            var _loc_3:* = param1.format(this._product.price.amount).split(param1.decimalSeparatorTo);
            param1.currencySymbol = _loc_2;
            return _loc_3;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            this.shippingNoticeLabel.endEffectsStarted();
            this.shippingNoticeLabel.visible = this._price;
            this.vatNoticeLabel.endEffectsStarted();
            if (this._price)
            {
            }
            this.vatNoticeLabel.visible = ConfomatConfiguration.platform == ConfomatConfiguration.PLATFORM_EU;
            if (ConfomatConfiguration.shopID == "622775")
            {
            }
            if (ConfomatConfiguration.platform == ConfomatConfiguration.PLATFORM_EU)
            {
                this.shippingNoticeLabel.visible = false;
                this.vatNoticeLabel.visible = false;
                if (this._price)
                {
                    this._price.visible = false;
                }
            }
            if (stage)
            {
            }
            if (!visible)
            {
            }
            if (this._price)
            {
                endEffectsStarted();
                visible = true;
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this._priceChanged)
            {
                this._priceChanged = false;
                this.updatePrice();
            }
            return;
        }// end function

        protected function onUpdateProductClick(param1:MouseEvent) : void
        {
            var event:* = param1;
            dispatchEvent(event);
            this.addToBasketButton.isInProgress = true;
            with ({})
            {
                {}.productSavedHandler = function (param1:Event) : void
            {
                addToBasketButton.isInProgress = false;
                Alert.show("Product Updated");
                return;
            }// end function
            ;
            }
            with ({})
            {
                {}.productSavedErrorHandler = function (param1:Event) : void
            {
                addToBasketButton.isInProgress = false;
                Alert.show("Product Update Error");
                return;
            }// end function
            ;
            }
            this._product.saveIfModified(function (param1:Event) : void
            {
                addToBasketButton.isInProgress = false;
                Alert.show("Product Updated");
                return;
            }// end function
            , function (param1:Event) : void
            {
                addToBasketButton.isInProgress = false;
                Alert.show("Product Update Error");
                return;
            }// end function
            );
            return;
        }// end function

        protected function onAddToBasketClick(param1:MouseEvent) : void
        {
            var event:* = param1;
            dispatchEvent(event);
            this.addToBasketButton.isInProgress = true;
            with ({})
            {
                {}.item_completeHandler = function (param1:BasketEvent) : void
            {
                addToBasketButton.isInProgress = false;
                if (ConfomatConfiguration.updatingBasket)
                {
                    ConfomatConfiguration.updatingBasket = false;
                    showUpdatedBasketDialog();
                    updateButtonLabel();
                }
                else
                {
                    showCheckoutDialog();
                }
                return;
            }// end function
            ;
            }
            with ({})
            {
                {}.item_faultHandler = function (param1:BasketEvent) : void
            {
                addToBasketButton.isInProgress = false;
                if (param1.code == TrackingErrorCodes.NO_SIZE_SELECTED)
                {
                    bus.dispatchEvent(new ApplicationEvent(ApplicationEvent.NO_SIZE_SELECTED));
                }
                else
                {
                    showErrorDialog(param1.code, param1.message, param1.item);
                }
                return;
            }// end function
            ;
            }
            this._basket.addOrUpdateItem(this._product, ConfomatConfiguration.updatingBasket, function (param1:BasketEvent) : void
            {
                addToBasketButton.isInProgress = false;
                if (ConfomatConfiguration.updatingBasket)
                {
                    ConfomatConfiguration.updatingBasket = false;
                    showUpdatedBasketDialog();
                    updateButtonLabel();
                }
                else
                {
                    showCheckoutDialog();
                }
                return;
            }// end function
            , function (param1:BasketEvent) : void
            {
                addToBasketButton.isInProgress = false;
                if (param1.code == TrackingErrorCodes.NO_SIZE_SELECTED)
                {
                    bus.dispatchEvent(new ApplicationEvent(ApplicationEvent.NO_SIZE_SELECTED));
                }
                else
                {
                    showErrorDialog(param1.code, param1.message, param1.item);
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function updateButtonLabel() : void
        {
            if (ConfomatConfiguration.updatingBasket)
            {
                this.addToBasketButton.label = resourceManager.getString("confomat7", "basket_section.btn_update_product");
            }
            else
            {
                this.addToBasketButton.label = resourceManager.getString("confomat7", "basket_section.btn_add_to_basket");
            }
            return;
        }// end function

        private function showCheckoutDialog() : void
        {
            var onAlertConfirm:* = function (param1:CloseEvent) : void
            {
                if (param1.detail == Alert.YES)
                {
                    externalAPI.checkout();
                    statistics.track(T.getGotoCheckoutEvent());
                }
                else
                {
                    statistics.track(T.getDesignAnotherProductEvent());
                }
                return;
            }// end function
            ;
            var yesLabel:* = Alert.yesLabel;
            var noLabel:* = Alert.noLabel;
            var buttonWidth:* = Alert.buttonWidth;
            Alert.yesLabel = resourceManager.getString("confomat7", "messages_system.btn_article_added_confirm_got_to_checkout");
            Alert.noLabel = resourceManager.getString("confomat7", "messages_system.btn_article_added_confirm_create_a_new_one");
            Alert.buttonWidth = 170;
            Alert.show(resourceManager.getString("confomat7", "messages_system.article_added_confirm"), resourceManager.getString("confomat7", "messages_system.success_headline"), Alert.YES | Alert.NO, null, onAlertConfirm);
            Alert.yesLabel = yesLabel;
            Alert.noLabel = noLabel;
            Alert.buttonWidth = buttonWidth;
            return;
        }// end function

        private function showUpdatedBasketDialog() : void
        {
            var onAlertConfirm:* = function (param1:CloseEvent) : void
            {
                if (param1.detail == Alert.YES)
                {
                    statistics.track(T.getGotoCheckoutEvent());
                    externalAPI.checkout();
                }
                else
                {
                    statistics.track(T.getDesignAnotherProductEvent());
                }
                return;
            }// end function
            ;
            var yesLabel:* = Alert.yesLabel;
            var noLabel:* = Alert.noLabel;
            var buttonWidth:* = Alert.buttonWidth;
            Alert.yesLabel = resourceManager.getString("confomat7", "messages_system.btn_basket_updated_confirm_go_to_checkout");
            Alert.noLabel = resourceManager.getString("confomat7", "messages_system.btn_basket_updated_create_a_new_one");
            Alert.buttonWidth = 170;
            Alert.show(resourceManager.getString("confomat7", "messages_system.basket_updated_confirm"), resourceManager.getString("confomat7", "messages_system.basket_updated_confirm_headline"), Alert.YES | Alert.NO, null, onAlertConfirm);
            Alert.yesLabel = yesLabel;
            Alert.noLabel = noLabel;
            Alert.buttonWidth = buttonWidth;
            return;
        }// end function

        private function getSKUDescription(param1:IBasketItem) : String
        {
            if (!param1)
            {
                return "";
            }
            var _loc_2:* = IProduct(API.em.get(param1.elementID, APIRegistry.PRODUCT));
            return "t:" + (_loc_2 ? (_loc_2.productType) : ("?")) + ",a:" + param1.appearance + ",s:" + param1.size;
        }// end function

        private function showErrorDialog(param1:String, param2:String, param3:IBasketItem) : void
        {
            var _loc_4:Array;
            var _loc_5:String;
            if (param1 == "400")
            {
            }
            if (param2.indexOf("Remove the following terms from your text") != -1)
            {
                _loc_4 = param2.match(/Remove the following terms from your text: \[(.*?)\]/);
                _loc_5 = _loc_4[1] ? (_loc_4[1]) : ("");
                this.confomatError.error(resourceManager.getString("confomat7", "messages_system.TEXT_CONTENT_ERROR_ARBITRARY").replace("[TEXT]", _loc_5), "API Error, Copyright error", "API Error, Copyright error: \'" + _loc_5 + "\'.");
                return;
            }
            switch(param1)
            {
                case TrackingErrorCodes.PRODUCT_CREATION:
                {
                    this.confomatError.error(resourceManager.getString("confomat7", "messages_system.error_creating_product"), "Confomat Error, Code: " + param1, param2);
                    return;
                }
                case TrackingErrorCodes.HARD_BOUNDARY:
                {
                    this.confomatError.error(resourceManager.getString("confomat7", "messages_system.configuration_conflict_hard_boundaries"), "Confomat Error, Code: " + param1, param2);
                    return;
                }
                case TrackingErrorCodes.CONFIGURATION_OVERLAP:
                {
                    this.confomatError.error(resourceManager.getString("confomat7", "messages_system.configuration_conflict_overlap"), "Confomat Error, Code: " + param1, param2);
                    return;
                }
                case TrackingErrorCodes.MAX_BOUND:
                {
                    this.confomatError.error(resourceManager.getString("confomat7", "messages_system.configuration_conflict_printsize"), "Confomat Error, Code: " + param1, param2);
                    return;
                }
                case TrackingErrorCodes.MIN_BOUND:
                {
                    this.confomatError.error(resourceManager.getString("confomat7", "sizinginfo.design_too_small_for_printtype"), "Confomat Error, Code: " + param1, param2);
                    return;
                }
                case TrackingErrorCodes.MISSING_PARAMETERS:
                {
                    this.confomatError.error(resourceManager.getString("confomat7", "messages_system.error_creating_product"), "Basket Error, Code: " + param1, param2);
                    return;
                }
                case TrackingErrorCodes.NO_SIZE_SELECTED:
                {
                    this.confomatError.error(resourceManager.getString("confomat7", "basket._e1"), "Basket Error, Code: " + param1, param2);
                    return;
                }
                case TrackingErrorCodes.OUT_OF_STOCK:
                {
                    this.confomatError.error(resourceManager.getString("confomat7", "messages_system.product_out_of_stock"), "Basket Error, Code: " + param1, this.getSKUDescription(param3) + "," + param2);
                    return;
                }
                case TrackingErrorCodes.NO_COLOR_SELECTED:
                {
                    this.confomatError.error(resourceManager.getString("confomat7", "basket._e2"), "Basket Error, Code: " + param1, param2);
                    return;
                }
                case TrackingErrorCodes.QUANTITY_EXCEEDS_ARBITRARY_LIMIT:
                {
                    this.confomatError.error(resourceManager.getString("confomat7", "basket._e4"), "Basket Error, Code: " + param1, this.getSKUDescription(param3) + "," + param2);
                    return;
                }
                case TrackingErrorCodes.PRODUCTCOLOR_NOT_ALLOWED_WITH_PRINTTYPE:
                {
                    this.confomatError.error(resourceManager.getString("confomat7", "basket._e5"), "Basket Error, Code: " + param1, this.getSKUDescription(param3) + "," + param2);
                    return;
                }
                case TrackingErrorCodes.PRODUCT_STOCKOUT:
                {
                    this.confomatError.error(resourceManager.getString("confomat7", "basket._e6"), "Basket Error, Code: " + param1, this.getSKUDescription(param3) + "," + param2);
                    return;
                }
                case TrackingErrorCodes.PRODUCTTYPE_PRINTTYPE_NOT_SUPPORTED:
                {
                    this.confomatError.error(resourceManager.getString("confomat7", "messages_system.producttype_conflict_printtypes"), "Basket Error, Code: " + param1, param2);
                    return;
                }
                case TrackingErrorCodes.PRODUCT_CONFIGURATION_INVALID:
                case TrackingErrorCodes.UNKNOWN_ERROR:
                {
                    this.confomatError.error(resourceManager.getString("confomat7", "messages_system.error_creating_product"), "Basket Error, Code: " + param1, param2);
                    return;
                }
                case TrackingErrorCodes.HTTP_STATUS_400:
                case TrackingErrorCodes.HTTP_STATUS_401:
                case TrackingErrorCodes.HTTP_STATUS_403:
                case TrackingErrorCodes.HTTP_STATUS_404:
                case TrackingErrorCodes.HTTP_STATUS_500:
                {
                    this.confomatError.error(resourceManager.getString("confomat7", "messages_system.error_creating_product"), "API Error, Msg: " + param1, param2);
                    return;
                }
                default:
                {
                    this.confomatError.error(resourceManager.getString("confomat7", "messages_system.error_creating_product"), "API Error, Msg: " + param1, param2);
                    return;
                    break;
                }
            }
        }// end function

        public function bus_priceChangedHandler(param1:Event) : void
        {
            this._priceChanged = true;
            invalidateProperties();
            if (!this._componentComplete)
            {
                this._componentComplete = true;
                dispatchEvent(new ApplicationEvent(ApplicationEvent.COMPONENT_COMPLETE, true));
            }
            return;
        }// end function

        public function bus_countryChangedHandler(param1:ApplicationEvent) : void
        {
            this._priceChanged = true;
            invalidateProperties();
            this.updateButtonLabel();
            return;
        }// end function

    }
}
