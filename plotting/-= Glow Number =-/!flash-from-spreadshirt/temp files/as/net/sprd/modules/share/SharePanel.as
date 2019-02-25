package net.sprd.modules.share
{
    import com.adrianparr.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;
    import flash.ui.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import mx.graphics.*;
    import mx.styles.*;
    import net.sprd.api.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.components.common.*;
    import net.sprd.components.common.paging.*;
    import net.sprd.components.common.palette.*;
    import net.sprd.components.common.statusbutton.*;
    import net.sprd.entities.*;
    import net.sprd.events.*;
    import net.sprd.models.basket.*;
    import net.sprd.models.product.*;
    import net.sprd.modules.share.Opossum.*;
    import net.sprd.modules.share.entities.*;
    import net.sprd.services.image.*;
    import net.sprd.services.statistics.*;
    import net.sprd.skins.modules.share.*;

    public class SharePanel extends Canvas implements IBindingClient
    {
        public var _SharePanel_Canvas14:Canvas;
        public var _SharePanel_Canvas15:Canvas;
        public var _SharePanel_Canvas16:Canvas;
        public var _SharePanel_Canvas19:Canvas;
        public var _SharePanel_Canvas2:Canvas;
        public var _SharePanel_Canvas20:Canvas;
        public var _SharePanel_Canvas21:Canvas;
        public var _SharePanel_Canvas3:Canvas;
        public var _SharePanel_Canvas4:Canvas;
        public var _SharePanel_Canvas7:Canvas;
        public var _SharePanel_Label1:Label;
        public var _SharePanel_Label2:Label;
        public var _SharePanel_Label3:Label;
        public var _SharePanel_Paging1:Paging;
        public var _SharePanel_SetPropertyAction1:SetPropertyAction;
        public var _SharePanel_Status1:Status;
        public var _SharePanel_Status3:Status;
        public var _SharePanel_Status4:Status;
        public var _SharePanel_Text1:Text;
        private var _96620249embed:VBox;
        private var _738080254embedImage:Canvas;
        private var _731960661embedPanel:Canvas;
        private var _1703815225embed_loader:LoadingIndicator;
        private var _1896942753embed_message:AutosizeTextArea;
        private var _717583581embed_save:VBox;
        private var _497130182facebook:VBox;
        private var _1469380692facebook_loader:LoadingIndicator;
        private var _1982850162facebook_message:AutosizeTextArea;
        private var _1282133823fadeIn:Fade;
        private var _1091436750fadeOut:Fade;
        private var _835984199hideLogin:Resize;
        private var _1773855993hideView:Resize;
        private var _1347010958inProgress:Status;
        private var _1345512082listOver:Canvas;
        private var _103149417login:Canvas;
        private var _829165563loginButton:Button;
        private var _1773631110loginColor:Canvas;
        private var _1719706073loginFail:Sequence;
        private var _1001129699loginSuccessful:Sequence;
        private var _3343799mail:VBox;
        private var _328815132mailImage:Canvas;
        private var _1592351757mailRecipientCount:TextArea;
        private var _980363904mail_error:AutosizeTextArea;
        private var _308692404mail_form:VBox;
        private var _155251269noProducts:Canvas;
        private var _2030076414noProductsMessage:Text;
        private var _798910853palette:Palette;
        private var _1216985755password:AdvancedTextInput;
        private var _1491869139productList:ProductTileList;
        private var _1447119655resizeProductList:Resize;
        private var _3522941save:VBox;
        private var _636957973save_loader:LoadingIndicator;
        private var _1110860987save_message:AutosizeTextArea;
        private var _945647759sendMessageButton:StatusButton;
        private var _74922237shareTabBar:ShareTabBar;
        private var _1796608561shareViews:ViewStack;
        private var _1921025428showLogin:Resize;
        private var _708497575tileImageHolder:Container;
        private var _2106131294tileOver:Canvas;
        private var _916346253twitter:VBox;
        private var _1451791521twitter_loader:LoadingIndicator;
        private var _1437585861twitter_message:AutosizeTextArea;
        private var _476674006txtEmbedCode:AdvancedTextArea;
        private var _878930374txtFrom:ValidationTextInput;
        private var _544786569txtMessage:AdvancedTextArea;
        private var _436788140txtPlainLink:AdvancedTextInput;
        private var _110817547txtTo:ValidationTextInput;
        private var _265713450username:AdvancedTextInput;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;
        private var progressIndicator:Class;
        public var productModel:IProductModel;
        public var confomatError:ConfomatErrorDialog;
        public var statistics:IStatistics;
        public var bus:IEventDispatcher;
        private var _1582043139shareTabs:Array;
        private var _3599307user:User;
        private var shareModul:ShareModul;
        private var _659939556_selectionModel:ProductSelectorModel;
        private var _currentProduct:IProduct;
        private var loadingProduct:Boolean;
        private var _loginWasVisible:Object;
        private const POPUP_URL:String = "";
        private var resize:Resize;
        private var embed_tab:ShareTab;
        private var mail_tab:ShareTab;
        private var _1565776463mailSendInProgress:Boolean;
        private var _doNotClose:Boolean;
        private var _lastTab:ShareTab;
        private var _confomat:ConfomatClass;
        var _SharePanel_StylesInit_done:Boolean = false;
        private var _embed_mxml__twitter_889825545:Class;
        private var _embed_mxml__facebook_155826300:Class;
        private var _embed_mxml__exclamationIcon_1529669431:Class;
        private var _embed_mxml__checkmarkIcon_1959331471:Class;
        private var _embed_mxml__save_37913085:Class;
        private var _embed_mxml__loader_1278526270:Class;
        private var _embed_mxml__embed_23856223:Class;
        private var _embed_mxml__email_23856930:Class;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static const log:ILogger = LogContext.getLogger(this);
        static const FACEBOOK_SHARE_URL:String = "http://www.facebook.com/sharer/sharer.php?u={URL}";
        static const TWITTER_SHARE_URL:String = "http://twitter.com/home?status={URL}";
        static const EMBED_CODE:String = "<div class=\"shared_product\" style=\"text-align:center;\"><a href=\"[PRODUCT_URL]\"><img src=\"[PRODUCT_IMAGE_URL]\" alt=\"[EMBED_TITLE]\"/><br /><span>[EMBED_TITLE]</span></a></div>";
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function SharePanel()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, events:{preinitialize:"___SharePanel_Canvas1_preinitialize", creationComplete:"___SharePanel_Canvas1_creationComplete"}, propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Palette, id:"palette", propertiesFactory:function () : Object
                {
                    return {width:270, gap:0, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", x:10, children:[_SharePanel_Canvas2_i(), _SharePanel_ShareTabBar1_i(), _SharePanel_ViewStack1_i(), _SharePanel_Spacer1_c(), _SharePanel_Label3_i(), _SharePanel_Canvas14_i(), _SharePanel_ProductTileList1_i(), _SharePanel_Paging1_i(), _SharePanel_Spacer2_c(), _SharePanel_Canvas17_i()]};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"noProducts", propertiesFactory:function () : Object
                {
                    return {left:10, right:10, childDescriptors:[new UIComponentDescriptor({type:Text, id:"noProductsMessage", stylesFactory:function () : void
                    {
                        this.textAlign = "center";
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {styleName:"notice", verticalCenter:0, horizontalCenter:0};
                    }// end function
                    })]};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"listOver", propertiesFactory:function () : Object
                {
                    return {clipContent:false, childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"tileOver", events:{click:"__tileOver_click", rollOut:"__tileOver_rollOut"}, propertiesFactory:function () : Object
                    {
                        return {width:98, height:98, styleName:"tileOver", visible:false, childDescriptors:[new UIComponentDescriptor({type:Container, id:"tileImageHolder", propertiesFactory:function () : Object
                        {
                            return {width:75, height:75, horizontalCenter:1, verticalCenter:0, mouseEnabled:false};
                        }// end function
                        })]};
                    }// end function
                    })]};
                }// end function
                })]};
            }// end function
            });
            this.progressIndicator = SharePanel_progressIndicator;
            this._3599307user = new User();
            this.shareModul = new ShareModul();
            this._embed_mxml__twitter_889825545 = SharePanel__embed_mxml__twitter_889825545;
            this._embed_mxml__facebook_155826300 = SharePanel__embed_mxml__facebook_155826300;
            this._embed_mxml__exclamationIcon_1529669431 = SharePanel__embed_mxml__exclamationIcon_1529669431;
            this._embed_mxml__checkmarkIcon_1959331471 = SharePanel__embed_mxml__checkmarkIcon_1959331471;
            this._embed_mxml__save_37913085 = SharePanel__embed_mxml__save_37913085;
            this._embed_mxml__loader_1278526270 = SharePanel__embed_mxml__loader_1278526270;
            this._embed_mxml__embed_23856223 = SharePanel__embed_mxml__embed_23856223;
            this._embed_mxml__email_23856930 = SharePanel__embed_mxml__email_23856930;
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            var bindings:* = this._SharePanel_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_net_sprd_modules_share_SharePanelWatcherSetupUtil");
                var _loc_2:* = watcherSetupUtilClass;
                _loc_2.watcherSetupUtilClass["init"](null);
            }
            _watcherSetupUtil.setup(this, function (param1:String)
            {
                return target[param1];
            }// end function
            , function (param1:String)
            {
                return [param1];
            }// end function
            , bindings, watchers);
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.minWidth = 290;
            this.minHeight = 200;
            this._SharePanel_Fade1_i();
            this._SharePanel_Fade2_i();
            this._SharePanel_Resize3_i();
            this._SharePanel_Resize1_i();
            this._SharePanel_Sequence2_i();
            this._SharePanel_Sequence1_i();
            this._SharePanel_Resize4_i();
            this._SharePanel_Resize2_i();
            this.addEventListener("preinitialize", this.___SharePanel_Canvas1_preinitialize);
            this.addEventListener("creationComplete", this.___SharePanel_Canvas1_creationComplete);
            var i:uint;
            while (i < bindings.length)
            {
                
                Binding(bindings[i]).execute();
                i = i++;
            }
            return;
        }// end function

        override public function set moduleFactory(param1:IFlexModuleFactory) : void
        {
            super.moduleFactory = param1;
            if (this.__moduleFactoryInitialized)
            {
                return;
            }
            this.__moduleFactoryInitialized = true;
            .mx_internal::_SharePanel_StylesInit();
            return;
        }// end function

        override public function initialize() : void
        {
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            super.initialize();
            return;
        }// end function

        public function init() : void
        {
            this.shareModul.init();
            this._selectionModel = new ProductSelectorModel();
            with ({})
            {
                {}.productsChanged = function (param1:Event) : void
            {
                var _loc_2:* = _selectionModel.productTotalCount <= 3 ? (1) : (2);
                if (_loc_2 != productList.rowCount)
                {
                    productList.rowCount = _loc_2;
                }
                if (_loc_2 * 90 != productList.height)
                {
                    productList.height = _loc_2 * 90;
                }
                return;
            }// end function
            ;
            }
            this._selectionModel.addEventListener(ProductSelectorModel.PRODUCTS_CHANGED, function (param1:Event) : void
            {
                var _loc_2:* = _selectionModel.productTotalCount <= 3 ? (1) : (2);
                if (_loc_2 != productList.rowCount)
                {
                    productList.rowCount = _loc_2;
                }
                if (_loc_2 * 90 != productList.height)
                {
                    productList.height = _loc_2 * 90;
                }
                return;
            }// end function
            );
            return;
        }// end function

        public function set confomatClass(param1:ConfomatClass) : void
        {
            this._confomat = param1;
            return;
        }// end function

        private function creationCompleteHandler(param1:FlexEvent) : void
        {
            var event:* = param1;
            this.shareTabs = [new ShareTab(this.save, this.save_click, true), new ShareTab(this.mail, this.mail_click, true), new ShareTab(this.facebook, this.facebook_click, true), new ShareTab(this.twitter, this.twitter_click, true), new ShareTab(this.embed_save, this.embed_click)];
            resourceManager.addEventListener("change", function (param1:Event) : void
            {
                shareTabs = shareTabs.slice();
                return;
            }// end function
            );
            this.embed_tab = new ShareTab(this.embed, null);
            this.mail_tab = new ShareTab(this.mail_form, null);
            this.facebook.invalidateSize();
            if (!this.user.isAuthentificated)
            {
                this.user.isAuthentificated = ExternalAPI.isAuthenticated();
            }
            with ({})
            {
                {}.close = function (param1:MouseEvent) : void
            {
                visible = false;
                return;
            }// end function
            ;
            }
            this.palette.closeButton.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent) : void
            {
                visible = false;
                return;
            }// end function
            );
            with ({})
            {
                {}.palette_Resize = function (param1:ResizeEvent) : void
            {
                if (!parent)
                {
                    return;
                }
                if (login.contentToGlobal(new Point(0, login.height)).y > parent.height)
                {
                    if (login.visible)
                    {
                        login.visible = false;
                    }
                }
                else
                {
                    if (!login.visible)
                    {
                    }
                    if (_loginWasVisible)
                    {
                        login.visible = true;
                    }
                }
                return;
            }// end function
            ;
            }
            this.palette.addEventListener(ResizeEvent.RESIZE, function (param1:ResizeEvent) : void
            {
                if (!parent)
                {
                    return;
                }
                if (login.contentToGlobal(new Point(0, login.height)).y > parent.height)
                {
                    if (login.visible)
                    {
                        login.visible = false;
                    }
                }
                else
                {
                    if (!login.visible)
                    {
                    }
                    if (_loginWasVisible)
                    {
                        login.visible = true;
                    }
                }
                return;
            }// end function
            );
            API.em.load("confomat7", APIRegistry.SHOP_APPLICATION, function (param1:Event) : void
            {
                var e:* = param1;
                var shop:* = IShopApplication(e.target);
                if (!shop.showSaveAndShareEmail)
                {
                    with ({})
                    {
                        {}.callback = function (param1:ShareTab, param2:int, param3:Array) : Boolean
                {
                    return param1.panel != mail;
                }// end function
                ;
                    }
                    shareTabs = shareTabs.filter(function (param1:ShareTab, param2:int, param3:Array) : Boolean
                {
                    return param1.panel != mail;
                }// end function
                );
                    shareTabBar.setStyle("tabWidth", Math.ceil(shareTabBar.width / shareTabs.length));
                }
                return;
            }// end function
            );
            return;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            super.visible = param1;
            if (this.login)
            {
                if (param1)
                {
                }
                if (this.user)
                {
                }
                if (!this.user.isAuthentificated)
                {
                }
                if (ConfomatConfiguration.opossumBaseUrlSecure)
                {
                }
                if (ConfomatConfiguration.opossumBaseUrlSecure.substring(0, 8) == "https://")
                {
                    this.login.visible = true;
                    this._loginWasVisible = true;
                }
                else
                {
                    this.login.visible = false;
                    this._loginWasVisible = false;
                }
                this.login.dispatchEvent(new ResizeEvent(ResizeEvent.RESIZE));
            }
            if (param1)
            {
                if (this._doNotClose)
                {
                    this._doNotClose = false;
                }
                else
                {
                    this.tab_selected(null);
                }
            }
            else if (initialized)
            {
                this.tab_selected(null);
            }
            return;
        }// end function

        private function generateErrorMessage(param1:IOErrorEvent) : String
        {
            var _loc_2:String;
            var _loc_4:String;
            var _loc_5:Array;
            var _loc_6:String;
            _loc_2 = resourceManager.getString("confomat7", "save_share.save_not_successful");
            var _loc_3:* = param1.text.split("#", 2);
            if (_loc_3.length == 2)
            {
                _loc_2 = _loc_3[1];
                _loc_4 = _loc_3[0];
            }
            else
            {
                _loc_2 = "";
                _loc_4 = param1.text;
            }
            if (_loc_4 == "400")
            {
            }
            if (_loc_2.indexOf("Remove the following terms from your text") != -1)
            {
                _loc_5 = _loc_2.match(/Remove the following terms from your text: \[(.*?)\]/);
                _loc_6 = _loc_5[1] ? (_loc_5[1]) : ("");
                _loc_2 = resourceManager.getString("confomat7", "messages_system.TEXT_CONTENT_ERROR_ARBITRARY").replace("[TEXT]", _loc_6);
            }
            switch(_loc_4)
            {
                case TrackingErrorCodes.PRODUCT_CREATION:
                {
                    _loc_2 = resourceManager.getString("confomat7", "messages_system.error_creating_product");
                    break;
                }
                case TrackingErrorCodes.HARD_BOUNDARY:
                {
                    _loc_2 = resourceManager.getString("confomat7", "messages_system.configuration_conflict_hard_boundaries");
                    break;
                }
                case TrackingErrorCodes.CONFIGURATION_OVERLAP:
                {
                    _loc_2 = resourceManager.getString("confomat7", "messages_system.configuration_conflict_overlap");
                    break;
                }
                case TrackingErrorCodes.MAX_BOUND:
                {
                    _loc_2 = resourceManager.getString("confomat7", "messages_system.configuration_conflict_printsize");
                    break;
                }
                case TrackingErrorCodes.MIN_BOUND:
                {
                    _loc_2 = resourceManager.getString("confomat7", "sizinginfo.design_too_small_for_printtype");
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function mail_click() : Boolean
        {
            var i:uint;
            var tmr:Timer;
            this.statistics.track(T.getSaveAndShare_eMailEvent());
            this.sendMessageButton.selectStatusByName("default");
            var error:String;
            if (this.productModel is ProductModel)
            {
                error = ProductModel(this.productModel).hasError();
            }
            if (error)
            {
                this.confomatError.error(this.generateErrorMessage(new IOErrorEvent(IOErrorEvent.IO_ERROR, false, false, error)), null, null, function () : void
            {
                tab_selected(null);
                return;
            }// end function
            );
                return true;
            }
            this.mailRecipientCount.text = "";
            this.refreshMailRecieptionCount();
            while (this.mailImage.numChildren > 0)
            {
                
                this.mailImage.removeChildAt(0);
            }
            if (this._confomat)
            {
            }
            if (this._confomat.productViewer)
            {
                tmr = new Timer(500, 1);
                with ({})
                {
                    {}.timer = function (param1:TimerEvent) : void
            {
                var _loc_2:* = new Bitmap(ImageSnapshot.captureBitmapData(_confomat.productViewer), "auto", true);
                var _loc_3:* = new Sprite();
                _loc_3.addChild(_loc_2);
                var _loc_5:* = Math.min(75 / _loc_2.width, 75 / _loc_2.height);
                _loc_3.scaleY = Math.min(75 / _loc_2.width, 75 / _loc_2.height);
                _loc_3.scaleX = _loc_5;
                var _loc_4:* = new UIComponent();
                _loc_4.addChild(_loc_3);
                mailImage.addChild(_loc_4);
                return;
            }// end function
            ;
                }
                EventUtil.registerOnetimeListeners(tmr, [TimerEvent.TIMER_COMPLETE], [function (param1:TimerEvent) : void
            {
                var _loc_2:* = new Bitmap(ImageSnapshot.captureBitmapData(_confomat.productViewer), "auto", true);
                var _loc_3:* = new Sprite();
                _loc_3.addChild(_loc_2);
                var _loc_5:* = Math.min(75 / _loc_2.width, 75 / _loc_2.height);
                _loc_3.scaleY = Math.min(75 / _loc_2.width, 75 / _loc_2.height);
                _loc_3.scaleX = _loc_5;
                var _loc_4:* = new UIComponent();
                _loc_4.addChild(_loc_3);
                mailImage.addChild(_loc_4);
                return;
            }// end function
            ]);
                tmr.start();
            }
            this.tab_selected(this.mail_tab);
            i;
            while (i < this.shareTabs.length)
            {
                
                if (ShareTab(this.shareTabs[i]).panel == this.mail)
                {
                    this.shareTabBar.selectedIndex = i;
                    break;
                }
                i = i++;
            }
            return false;
        }// end function

        private function save_click() : Boolean
        {
            this.save_loader.visible = true;
            this.statistics.track(T.getSaveAndShare_SaveEvent());
            var saved:* = function () : void
            {
                save_loader.visible = false;
                tab_selected(null);
                return;
            }// end function
            ;
            if (this.productModel.modified)
            {
                this.save_message.text = resourceManager.getString("confomat7", "save_share.saving_in_progress");
                this.save_loader.visible = true;
                with ({})
                {
                    {}.complete = function (param1:Event) : void
            {
                saved();
                return;
            }// end function
            ;
                }
                with ({})
                {
                    {}.fault = function (param1:IOErrorEvent) : void
            {
                var e:* = param1;
                confomatError.error(generateErrorMessage(e), null, null, function () : void
                {
                    tab_selected(null);
                    return;
                }// end function
                );
                save_loader.visible = false;
                return;
            }// end function
            ;
                }
                this.productModel.saveIfModified(function (param1:Event) : void
            {
                saved();
                return;
            }// end function
            , function (param1:IOErrorEvent) : void
            {
                var e:* = param1;
                confomatError.error(generateErrorMessage(e), null, null, function () : void
                {
                    tab_selected(null);
                    return;
                }// end function
                );
                save_loader.visible = false;
                return;
            }// end function
            );
            }
            else
            {
                return false;
            }
            return true;
        }// end function

        private function facebook_click() : Boolean
        {
            this.statistics.track(T.getSaveAndShare_FacebookEvent());
            return this.share(FACEBOOK_SHARE_URL, resourceManager.getString("confomat7", "save_share.share_facebook"), 980, 480, this.facebook_message, this.facebook_loader);
        }// end function

        private function twitter_click() : Boolean
        {
            this.statistics.track(T.getSaveAndShare_TwitterEvent());
            return this.share(TWITTER_SHARE_URL, resourceManager.getString("confomat7", "save_share.share_twitter"), 640, 480, this.twitter_message, this.twitter_loader);
        }// end function

        private function embed_click() : Boolean
        {
            this.embed_loader.visible = true;
            this.statistics.track(T.getSaveAndShare_EmbedEvent());
            var saved:* = function () : void
            {
                var image:Image;
                embed_loader.visible = false;
                tab_selected(embed_tab);
                var i:uint;
                while (i < shareTabs.length)
                {
                    
                    if (ShareTab(shareTabs[i]).panel == embed)
                    {
                        shareTabBar.selectedIndex = i;
                        break;
                    }
                    i = i++;
                }
                var url:* = ExternalAPI.getProductURL(productModel.product.id, productModel.currentView.id);
                var loader:* = new LoadingIndicator();
                loader.x = embedImage.width / 2 - loader.width / 2;
                loader.y = embedImage.height / 2 - loader.height / 2;
                embedImage.addChild(loader);
                txtPlainLink.text = url;
                var code:* = EMBED_CODE;
                var title:* = resourceManager.getString("confomat7", "save_share.embed_producttype").replace("[PRODUCTTYPE_NAME]", productModel.productType.name);
                title = HtmlEntities.encode(title);
                code = code.replace("[PRODUCT_URL]", url);
                code = code.replace("[PRODUCT_IMAGE_URL]", ImageService.getInstance().productImageURL(productModel.product.id, productModel.currentView.id, 450, 450));
                code = code.replace(/\[EMBED_TITLE\]/g, title);
                txtEmbedCode.text = code;
                image = ImageService.getInstance().productImage(productModel.product.id, productModel.product.defaultView, 75, 75);
                image.smoothBitmapContent = true;
                with ({})
                {
                    {}.complete = function (param1:Event) : void
                {
                    while (embedImage.numChildren > 0)
                    {
                        
                        embedImage.removeChildAt(0);
                    }
                    embedImage.addChild(image);
                    return;
                }// end function
                ;
                }
                with ({})
                {
                    {}.error = function (param1) : void
                {
                    while (embedImage.numChildren > 0)
                    {
                        
                        embedImage.removeChildAt(0);
                    }
                    return;
                }// end function
                ;
                }
                EventUtil.registerOnetimeListeners(image, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [function (param1:Event) : void
                {
                    while (embedImage.numChildren > 0)
                    {
                        
                        embedImage.removeChildAt(0);
                    }
                    embedImage.addChild(image);
                    return;
                }// end function
                , function (param1) : void
                {
                    while (embedImage.numChildren > 0)
                    {
                        
                        embedImage.removeChildAt(0);
                    }
                    return;
                }// end function
                ]);
                image.load();
                return;
            }// end function
            ;
            while (this.embedImage.numChildren > 0)
            {
                
                this.embedImage.removeChildAt(0);
            }
            if (this.productModel.modified)
            {
                this.embed_message.text = resourceManager.getString("confomat7", "save_share.saving_in_progress");
                this.embed_loader.visible = true;
                with ({})
                {
                    {}.complete = function (param1:Event) : void
            {
                saved();
                return;
            }// end function
            ;
                }
                with ({})
                {
                    {}.fault = function (param1:IOErrorEvent) : void
            {
                var e:* = param1;
                embed_loader.visible = false;
                confomatError.error(generateErrorMessage(e), null, null, function () : void
                {
                    tab_selected(null);
                    return;
                }// end function
                );
                return;
            }// end function
            ;
                }
                this.productModel.saveIfModified(function (param1:Event) : void
            {
                saved();
                return;
            }// end function
            , function (param1:IOErrorEvent) : void
            {
                var e:* = param1;
                embed_loader.visible = false;
                confomatError.error(generateErrorMessage(e), null, null, function () : void
                {
                    tab_selected(null);
                    return;
                }// end function
                );
                return;
            }// end function
            );
                return true;
            }
            this.saved();
            return false;
        }// end function

        private function share(param1:String, param2:String, param3:Number = 640, param4:Number = 320, param5:TextArea = null, param6:UIComponent = null) : Boolean
        {
            var internalPopup:Boolean;
            var baseURL:* = param1;
            var title:* = param2;
            var width:* = param3;
            var height:* = param4;
            var statusControl:* = param5;
            var loader:* = param6;
            var wasModified:* = this.productModel.modified;
            if (statusControl)
            {
                statusControl.text = resourceManager.getString("confomat7", "save_share.saving_in_progress");
            }
            if (loader)
            {
                loader.visible = true;
            }
            if (!ExternalAPI.openPopup(this.POPUP_URL, "share", width, height))
            {
                internalPopup;
            }
            with ({})
            {
                {}.complete = function (param1:Event) : void
            {
                var _loc_2:* = ExternalAPI.getProductURL(productModel.product.id, productModel.currentView.id);
                if (_loc_2)
                {
                    _loc_2 = generateURL(baseURL, _loc_2);
                    if (true)
                    {
                    }
                    if (!relocatePopup(_loc_2))
                    {
                        openPopupInternal(_loc_2, title, width, height);
                    }
                    if (loader)
                    {
                        loader.visible = false;
                    }
                    tab_selected(null);
                }
                else
                {
                    if (!internalPopup)
                    {
                        ExternalAPI.closePopup();
                    }
                    if (statusControl)
                    {
                        statusControl.text = resourceManager.getString("confomat7", "save_share.url_not_successful");
                    }
                }
                return;
            }// end function
            ;
            }
            with ({})
            {
                {}.fault = function (param1:IOErrorEvent) : void
            {
                var e:* = param1;
                if (!internalPopup)
                {
                    ExternalAPI.closePopup();
                }
                if (loader)
                {
                    loader.visible = false;
                }
                confomatError.error(generateErrorMessage(e), null, null, function () : void
                {
                    tab_selected(null);
                    return;
                }// end function
                );
                return;
            }// end function
            ;
            }
            this.productModel.saveIfModified(function (param1:Event) : void
            {
                var _loc_2:* = ExternalAPI.getProductURL(productModel.product.id, productModel.currentView.id);
                if (_loc_2)
                {
                    _loc_2 = generateURL(baseURL, _loc_2);
                    if (true)
                    {
                    }
                    if (!relocatePopup(_loc_2))
                    {
                        openPopupInternal(_loc_2, title, width, height);
                    }
                    if (loader)
                    {
                        loader.visible = false;
                    }
                    tab_selected(null);
                }
                else
                {
                    if (!internalPopup)
                    {
                        ExternalAPI.closePopup();
                    }
                    if (statusControl)
                    {
                        statusControl.text = resourceManager.getString("confomat7", "save_share.url_not_successful");
                    }
                }
                return;
            }// end function
            , function (param1:IOErrorEvent) : void
            {
                var e:* = param1;
                if (!internalPopup)
                {
                    ExternalAPI.closePopup();
                }
                if (loader)
                {
                    loader.visible = false;
                }
                confomatError.error(generateErrorMessage(e), null, null, function () : void
                {
                    tab_selected(null);
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return wasModified;
        }// end function

        private function generateURL(param1:String, param2:String) : String
        {
            return param1.replace("{URL}", encodeURI(param2));
        }// end function

        private function openPopupInternal(param1:String, param2:String, param3:Number, param4:Number) : void
        {
            var _loc_5:* = "javascript:window.open(\'" + param1 + "\',\'share\',\'width=" + param3 + ",height=" + param4 + ",toolbar=no,scrollbars=yes\'); void(0);";
            navigateToURL(new URLRequest(_loc_5), "_self");
            return;
        }// end function

        private function relocatePopup(param1:String) : Boolean
        {
            return ExternalAPI.relocatePopup(param1);
        }// end function

        private function tab_selected(param1:ShareTab, param2:Boolean = false) : void
        {
            var openPanel:Boolean;
            var showPanel:Function;
            var tab:* = param1;
            var byClick:* = param2;
            this._lastTab = tab;
            if (tab)
            {
                openPanel;
                if (tab.click != null)
                {
                    openPanel = tab.click();
                }
                if (!openPanel)
                {
                    if (this._lastTab == tab)
                    {
                        this.tab_selected(null);
                    }
                    return;
                }
                showPanel = function () : void
            {
                if (resize)
                {
                    resize.stop();
                }
                shareViews.selectedChild = tab.panel;
                shareViews.visible = true;
                resize = new Resize(shareViews);
                resize.heightTo = tab.panel.measuredHeight;
                if (!isNaN(tab.panel.explicitHeight))
                {
                    resize.heightTo = tab.panel.explicitHeight;
                }
                resize.play();
                return;
            }// end function
            ;
                if (this.shareViews.height > 0)
                {
                }
                if (this.shareViews.visible)
                {
                    if (this.resize)
                    {
                        this.resize.stop();
                    }
                    this.resize = new Resize(this.shareViews);
                    this.resize.duration = 300;
                    this.resize.heightTo = 0;
                    with ({})
                    {
                        {}.end = function (param1:EffectEvent) : void
            {
                resize.removeEventListener(param1.type, _loc_2.callee);
                showPanel();
                return;
            }// end function
            ;
                    }
                    this.resize.addEventListener(EffectEvent.EFFECT_END, function (param1:EffectEvent) : void
            {
                resize.removeEventListener(param1.type, _loc_2.callee);
                showPanel();
                return;
            }// end function
            );
                    this.resize.play();
                }
                else
                {
                    this.showPanel();
                }
            }
            else
            {
                this.shareTabBar.selectedIndex = -1;
                if (this.resize)
                {
                    this.resize.stop();
                }
                this.resize = new Resize(this.shareViews);
                this.resize.duration = 300;
                this.resize.heightTo = 0;
                this.resize.play();
            }
            return;
        }// end function

        private function selectAndCopyToClipboard(param1:Event) : void
        {
            var t:TextArea;
            var tt:TextInput;
            var e:* = param1;
            if (e.currentTarget == this.txtPlainLink)
            {
                this.statistics.track(T.getSaveAndShare_EmbedURLEvent());
            }
            if (e.currentTarget == this.txtEmbedCode)
            {
                this.statistics.track(T.getSaveAndShare_EmbedHTMLEvent());
            }
            if (e)
            {
            }
            if (e.currentTarget is TextArea)
            {
                t = TextArea(e.currentTarget);
                try
                {
                    t.setSelection(0, t.text.length);
                    System.setClipboard(t.text);
                }
                catch (e:Error)
                {
                }
            }
            else
            {
                if (e)
                {
                }
                if (e.currentTarget is TextInput)
                {
                    tt = TextInput(e.currentTarget);
                    try
                    {
                        tt.setSelection(0, tt.text.length);
                        System.setClipboard(tt.text);
                    }
                    catch (e:Error)
                    {
                    }
                }
            }
            return;
        }// end function

        private function tabBar_itemClickHandler(param1:ItemClickEvent) : void
        {
            if (param1.item is ShareTab)
            {
                this.tab_selected(param1.item as ShareTab, true);
            }
            else
            {
                this.tab_selected(null, true);
            }
            return;
        }// end function

        private function sendMessageButton_clickHandler(param1:MouseEvent) : void
        {
            var mailTo:Array;
            var event:* = param1;
            this.txtFrom.validate();
            this.txtTo.validate();
            mailTo = this.extractMailAddresses(this.txtTo.text);
            if (this.txtFrom.isValid)
            {
            }
            if (this.txtTo.isValid)
            {
            }
            if (mailTo.length > 0)
            {
                this.mailSendInProgress = true;
                this.sendMessageButton.selectStatusByName("progress");
                this.statistics.track(T.getSaveAndShare_eMailTryEvent());
                with ({})
                {
                    {}.complete = function (param1:Event) : void
            {
                var msg:ShareProductMessage;
                var printAreas:Array;
                var toError:Array;
                var toSuccess:Array;
                var checkComplete:Function;
                var to:String;
                var e:* = param1;
                var URL:* = ExternalAPI.getProductURL(productModel.product.id, productModel.currentView.id);
                if (URL)
                {
                }
                if (URL != "false")
                {
                    msg = new ShareProductMessage();
                    msg.mailFrom = txtFrom.text;
                    msg.message = txtMessage.text;
                    msg.productId = productModel.product.id;
                    msg.productDeeplinkURL = URL;
                    printAreas;
                    productModel.product.configurations.forEach(function (param1:IConfiguration, param2:int, param3:Array) : void
                {
                    if (printAreas.indexOf(param1.printArea))
                    {
                        printAreas.push(param1.printArea);
                    }
                    return;
                }// end function
                );
                    productModel.views.forEach(function (param1:IProductTypeView, param2:int, param3:Array) : void
                {
                    var view:* = param1;
                    var index:* = param2;
                    var arr:* = param3;
                    if (view.net.sprd.entities:IProductTypeView::printAreas)
                    {
                        with ({})
                        {
                            {}.callback = function (param1:String, param2:int, param3:Array) : Boolean
                    {
                        if (printAreas.indexOf(param1) != -1)
                        {
                            if (msg.viewIds.indexOf(view.id))
                            {
                                msg.viewIds.push(view.id);
                            }
                            return true;
                        }
                        return false;
                    }// end function
                    ;
                        }
                        view.net.sprd.entities:IProductTypeView::printAreas.some(function (param1:String, param2:int, param3:Array) : Boolean
                    {
                        if (printAreas.indexOf(param1) != -1)
                        {
                            if (msg.viewIds.indexOf(view.id))
                            {
                                msg.viewIds.push(view.id);
                            }
                            return true;
                        }
                        return false;
                    }// end function
                    );
                    }
                    return;
                }// end function
                );
                    if (msg.viewIds.length == 0)
                    {
                        msg.viewIds.push(productModel.currentView.id);
                    }
                    msg.shopId = ConfomatConfiguration.shopID;
                    msg.locale = ConfomatConfiguration.combinedLangLocale;
                    if (user.username)
                    {
                    }
                    if (user.username != "")
                    {
                        msg.nameFrom = user.username;
                    }
                    if (user.firstName)
                    {
                    }
                    if (user.firstName != "")
                    {
                        msg.nameFrom = user.firstName;
                    }
                    if (user.id)
                    {
                        msg.userId = user.id;
                    }
                    toError;
                    toSuccess;
                    checkComplete = function ()
                {
                    if (toError.length + toSuccess.length == mailTo.length)
                    {
                        mailSendInProgress = false;
                        if (toError.length == 0)
                        {
                            txtTo.text = "";
                            txtTo.setFocus();
                            statistics.track(T.getSaveAndShare_eMailSuccessEvent());
                            mailRecipientCount.text = "";
                            sendMessageButton.selectStatusByName("success");
                        }
                        else
                        {
                            txtTo.text = toError.join(";");
                            statistics.track(T.getSaveAndShare_eMailFailedEvent("API"));
                            sendMessageButton.selectStatusByName("default");
                            mailRecipientCount.text = "";
                            confomatError.error(resourceManager.getString("confomat7", "save_share.mail_was_not_sent"), null, null, null);
                        }
                    }
                    return;
                }// end function
                ;
                    var _loc_3:int;
                    var _loc_4:* = mailTo;
                    while (_loc_4 in _loc_3)
                    {
                        
                        to = _loc_4[_loc_3];
                        msg.mailTo = to;
                        with ({})
                        {
                            {}.complete = function (param1:Event) : void
                {
                    toSuccess.push(to);
                    checkComplete();
                    return;
                }// end function
                ;
                        }
                        with ({})
                        {
                            {}.fault = function (param1:IOErrorEvent) : void
                {
                    log.warn("Mail delivery to \'" + to + "\' failed.");
                    toError.push(to);
                    checkComplete();
                    return;
                }// end function
                ;
                        }
                        msg.sendMessage(function (param1:Event) : void
                {
                    toSuccess.push(to);
                    checkComplete();
                    return;
                }// end function
                , function (param1:IOErrorEvent) : void
                {
                    log.warn("Mail delivery to \'" + to + "\' failed.");
                    toError.push(to);
                    checkComplete();
                    return;
                }// end function
                );
                    }
                }
                else
                {
                    mailSendInProgress = false;
                    sendMessageButton.selectStatusByName("default");
                    statistics.track(T.getSaveAndShare_eMailFailedEvent("URL"));
                    log.warn("URL creation failed");
                    confomatError.error(resourceManager.getString("confomat7", "save_share.url_not_successful"), null, null, function () : void
                {
                    tab_selected(null);
                    return;
                }// end function
                , resourceManager.getString("confomat7", "save_share.mail_was_not_sent"));
                }
                return;
            }// end function
            ;
                }
                with ({})
                {
                    {}.fault = function (param1:IOErrorEvent) : void
            {
                var e:* = param1;
                mailSendInProgress = false;
                sendMessageButton.selectStatusByName("default");
                statistics.track(T.getSaveAndShare_eMailFailedEvent("Save"));
                log.warn("Mail fault:" + e.toString());
                confomatError.error(generateErrorMessage(e), null, null, function () : void
                {
                    tab_selected(null);
                    return;
                }// end function
                , resourceManager.getString("confomat7", "save_share.mail_was_not_sent"));
                return;
            }// end function
            ;
                }
                this.productModel.saveIfModified(function (param1:Event) : void
            {
                var msg:ShareProductMessage;
                var printAreas:Array;
                var toError:Array;
                var toSuccess:Array;
                var checkComplete:Function;
                var to:String;
                var e:* = param1;
                var URL:* = ExternalAPI.getProductURL(productModel.product.id, productModel.currentView.id);
                if (URL)
                {
                }
                if (URL != "false")
                {
                    msg = new ShareProductMessage();
                    msg.mailFrom = txtFrom.text;
                    msg.message = txtMessage.text;
                    msg.productId = productModel.product.id;
                    msg.productDeeplinkURL = URL;
                    printAreas;
                    productModel.product.configurations.forEach(function (param1:IConfiguration, param2:int, param3:Array) : void
                {
                    if (printAreas.indexOf(param1.printArea))
                    {
                        printAreas.push(param1.printArea);
                    }
                    return;
                }// end function
                );
                    productModel.views.forEach(function (param1:IProductTypeView, param2:int, param3:Array) : void
                {
                    var view:* = param1;
                    var index:* = param2;
                    var arr:* = param3;
                    if (view.net.sprd.entities:IProductTypeView::printAreas)
                    {
                        with ({})
                        {
                            {}.callback = function (param1:String, param2:int, param3:Array) : Boolean
                    {
                        if (printAreas.indexOf(param1) != -1)
                        {
                            if (msg.viewIds.indexOf(view.id))
                            {
                                msg.viewIds.push(view.id);
                            }
                            return true;
                        }
                        return false;
                    }// end function
                    ;
                        }
                        view.net.sprd.entities:IProductTypeView::printAreas.some(function (param1:String, param2:int, param3:Array) : Boolean
                    {
                        if (printAreas.indexOf(param1) != -1)
                        {
                            if (msg.viewIds.indexOf(view.id))
                            {
                                msg.viewIds.push(view.id);
                            }
                            return true;
                        }
                        return false;
                    }// end function
                    );
                    }
                    return;
                }// end function
                );
                    if (msg.viewIds.length == 0)
                    {
                        msg.viewIds.push(productModel.currentView.id);
                    }
                    msg.shopId = ConfomatConfiguration.shopID;
                    msg.locale = ConfomatConfiguration.combinedLangLocale;
                    if (user.username)
                    {
                    }
                    if (user.username != "")
                    {
                        msg.nameFrom = user.username;
                    }
                    if (user.firstName)
                    {
                    }
                    if (user.firstName != "")
                    {
                        msg.nameFrom = user.firstName;
                    }
                    if (user.id)
                    {
                        msg.userId = user.id;
                    }
                    toError;
                    toSuccess;
                    checkComplete = function ()
                {
                    if (toError.length + toSuccess.length == mailTo.length)
                    {
                        mailSendInProgress = false;
                        if (toError.length == 0)
                        {
                            txtTo.text = "";
                            txtTo.setFocus();
                            statistics.track(T.getSaveAndShare_eMailSuccessEvent());
                            mailRecipientCount.text = "";
                            sendMessageButton.selectStatusByName("success");
                        }
                        else
                        {
                            txtTo.text = toError.join(";");
                            statistics.track(T.getSaveAndShare_eMailFailedEvent("API"));
                            sendMessageButton.selectStatusByName("default");
                            mailRecipientCount.text = "";
                            confomatError.error(resourceManager.getString("confomat7", "save_share.mail_was_not_sent"), null, null, null);
                        }
                    }
                    return;
                }// end function
                ;
                    var _loc_3:int;
                    var _loc_4:* = mailTo;
                    while (_loc_4 in _loc_3)
                    {
                        
                        to = _loc_4[_loc_3];
                        msg.mailTo = to;
                        with ({})
                        {
                            {}.complete = function (param1:Event) : void
                {
                    toSuccess.push(to);
                    checkComplete();
                    return;
                }// end function
                ;
                        }
                        with ({})
                        {
                            {}.fault = function (param1:IOErrorEvent) : void
                {
                    log.warn("Mail delivery to \'" + to + "\' failed.");
                    toError.push(to);
                    checkComplete();
                    return;
                }// end function
                ;
                        }
                        msg.sendMessage(function (param1:Event) : void
                {
                    toSuccess.push(to);
                    checkComplete();
                    return;
                }// end function
                , function (param1:IOErrorEvent) : void
                {
                    log.warn("Mail delivery to \'" + to + "\' failed.");
                    toError.push(to);
                    checkComplete();
                    return;
                }// end function
                );
                    }
                }
                else
                {
                    mailSendInProgress = false;
                    sendMessageButton.selectStatusByName("default");
                    statistics.track(T.getSaveAndShare_eMailFailedEvent("URL"));
                    log.warn("URL creation failed");
                    confomatError.error(resourceManager.getString("confomat7", "save_share.url_not_successful"), null, null, function () : void
                {
                    tab_selected(null);
                    return;
                }// end function
                , resourceManager.getString("confomat7", "save_share.mail_was_not_sent"));
                }
                return;
            }// end function
            , function (param1:IOErrorEvent) : void
            {
                var e:* = param1;
                mailSendInProgress = false;
                sendMessageButton.selectStatusByName("default");
                statistics.track(T.getSaveAndShare_eMailFailedEvent("Save"));
                log.warn("Mail fault:" + e.toString());
                confomatError.error(generateErrorMessage(e), null, null, function () : void
                {
                    tab_selected(null);
                    return;
                }// end function
                , resourceManager.getString("confomat7", "save_share.mail_was_not_sent"));
                return;
            }// end function
            );
            }
            return;
        }// end function

        public function get selectionModel() : ProductSelectorModel
        {
            return this._selectionModel;
        }// end function

        private function loginButton_clickHandler(param1:MouseEvent) : void
        {
            var event:* = param1;
            this.statistics.track(T.getSaveAndShare_LoginTryEvent());
            with ({})
            {
                {}.success = function (param1:LoginEvent) : void
            {
                _loginWasVisible = false;
                user = param1.user;
                loginSuccessful.play();
                ExternalAPI.userLoggedIn();
                if (txtFrom.text == "")
                {
                    txtFrom.text = user.email ? (user.email) : ("");
                }
                _selectionModel.reload();
                statistics.track(T.getSaveAndShare_LoginSuccessEvent());
                return;
            }// end function
            ;
            }
            with ({})
            {
                {}.fault = function (param1:LoginEvent) : void
            {
                loginFail.play();
                statistics.track(T.getSaveAndShare_LoginFailedEvent());
                return;
            }// end function
            ;
            }
            Login.login(this.username.text, this.password.text, function (param1:LoginEvent) : void
            {
                _loginWasVisible = false;
                user = param1.user;
                loginSuccessful.play();
                ExternalAPI.userLoggedIn();
                if (txtFrom.text == "")
                {
                    txtFrom.text = user.email ? (user.email) : ("");
                }
                _selectionModel.reload();
                statistics.track(T.getSaveAndShare_LoginSuccessEvent());
                return;
            }// end function
            , function (param1:LoginEvent) : void
            {
                loginFail.play();
                statistics.track(T.getSaveAndShare_LoginFailedEvent());
                return;
            }// end function
            );
            return;
        }// end function

        private function username_keyUpHandler(param1:KeyboardEvent) : void
        {
            if (param1.keyCode == Keyboard.ENTER)
            {
                this.password.setFocus();
            }
            return;
        }// end function

        private function password_keyUpHandler(param1:KeyboardEvent) : void
        {
            if (param1.keyCode == Keyboard.ENTER)
            {
            }
            if (this.loginButton.enabled)
            {
                this.loginButton.setFocus();
                this.loginButton_clickHandler(null);
            }
            return;
        }// end function

        private function onItemRollOver(param1:ListEvent) : void
        {
            if (!param1.itemRenderer.data is IProduct)
            {
                return;
            }
            this._currentProduct = IProduct(param1.itemRenderer.data);
            this.loadImages(this._currentProduct);
            this.tileOver.x = param1.itemRenderer.x + (param1.itemRenderer.width - this.tileOver.width) / 2 - 2;
            this.tileOver.y = param1.itemRenderer.y + (param1.itemRenderer.height - this.tileOver.height) / 2 - 1;
            if (!this.tileOver.visible)
            {
                this.fadeIn.play([this.tileOver]);
            }
            return;
        }// end function

        private function itemRollOut(param1:MouseEvent) : void
        {
            var _loc_2:* = globalToContent(new Point(param1.stageX, param1.stageY));
            var _loc_3:* = this.productList.getBounds(this);
            _loc_3.right = _loc_3.right - 20;
            if (!_loc_3.containsPoint(_loc_2))
            {
                this.fadeOut.play([this.tileOver]);
            }
            return;
        }// end function

        private function loadImages(param1:Object) : void
        {
            var productImage:ProductImage;
            var spinner:Sprite;
            var container:UIComponent;
            var value:* = param1;
            var product:* = value as IProduct;
            if (!product)
            {
                return;
            }
            while (this.tileImageHolder.numChildren > 0)
            {
                
                this.tileImageHolder.removeChildAt(0);
            }
            productImage = ImageService.getInstance().productImage(product.id, product.defaultView, 75, 75);
            productImage.smoothBitmapContent = true;
            if (!productImage.isLoaded)
            {
                spinner = new this.progressIndicator() as Sprite;
                spinner.mouseEnabled = false;
                spinner.mouseChildren = false;
                spinner.name = "spinner";
                container = new UIComponent();
                container.addChild(spinner);
                container.x = this.tileImageHolder.width / 2;
                container.y = this.tileImageHolder.height / 2;
                this.tileImageHolder.addChild(container);
            }
            with ({})
            {
                {}.complete = function (param1:Event) : void
            {
                while (tileImageHolder.numChildren > 0)
                {
                    
                    tileImageHolder.removeChildAt(0);
                }
                productImage.width = 75;
                productImage.height = 75;
                tileImageHolder.addChild(productImage);
                tileImageHolder.endEffectsStarted();
                tileImageHolder.visible = true;
                return;
            }// end function
            ;
            }
            with ({})
            {
                {}.fault = function (param1:Event) : void
            {
                while (tileImageHolder.numChildren > 0)
                {
                    
                    tileImageHolder.removeChildAt(0);
                }
                return;
            }// end function
            ;
            }
            EventUtil.registerOnetimeListeners(productImage, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [function (param1:Event) : void
            {
                while (tileImageHolder.numChildren > 0)
                {
                    
                    tileImageHolder.removeChildAt(0);
                }
                productImage.width = 75;
                productImage.height = 75;
                tileImageHolder.addChild(productImage);
                tileImageHolder.endEffectsStarted();
                tileImageHolder.visible = true;
                return;
            }// end function
            , function (param1:Event) : void
            {
                while (tileImageHolder.numChildren > 0)
                {
                    
                    tileImageHolder.removeChildAt(0);
                }
                return;
            }// end function
            ]);
            productImage.load();
            return;
        }// end function

        private function productList_itemClickHandler(param1:ListEvent) : void
        {
            var _loc_2:* = ProductRenderer(param1.itemRenderer).data;
            if (_loc_2 is IProduct)
            {
                this.loadProduct(IProduct(_loc_2));
            }
            return;
        }// end function

        private function itemClick(param1:MouseEvent) : void
        {
            if (this._currentProduct)
            {
                this.loadProduct(this._currentProduct);
            }
            return;
        }// end function

        private function loadProduct(param1:IProduct) : void
        {
            var product:* = param1;
            if (this.loadingProduct)
            {
                return;
            }
            this.tab_selected(null);
            this.loadingProduct = true;
            product = product.clone();
            with ({})
            {
                {}.complete = function (param1:Event = null) : void
            {
                loadingProduct = false;
                productModel.selectConfiguration(null, true);
                return;
            }// end function
            ;
            }
            with ({})
            {
                {}.fault = function (param1:Event = null) : void
            {
                var e:* = param1;
                with ({})
                {
                    {}.onAlertCloseError = function () : void
                {
                    return;
                }// end function
                ;
                }
                confomatError.error(resourceManager.getString("confomat7", "save_share.load_not_successful"), "Loading fault: " + e, "Loading fault: " + e, function () : void
                {
                    return;
                }// end function
                );
                log.warn("Could not load product");
                loadingProduct = false;
                productModel.selectConfiguration(null, true);
                return;
            }// end function
            ;
            }
            this.productModel.loadProduct(product, function (param1:Event = null) : void
            {
                loadingProduct = false;
                productModel.selectConfiguration(null, true);
                return;
            }// end function
            , function (param1:Event = null) : void
            {
                var e:* = param1;
                with ({})
                {
                    {}.onAlertCloseError = function () : void
                {
                    return;
                }// end function
                ;
                }
                confomatError.error(resourceManager.getString("confomat7", "save_share.load_not_successful"), "Loading fault: " + e, "Loading fault: " + e, function () : void
                {
                    return;
                }// end function
                );
                log.warn("Could not load product");
                loadingProduct = false;
                productModel.selectConfiguration(null, true);
                return;
            }// end function
            );
            return;
        }// end function

        private function mail_focus(param1:Event) : void
        {
            if (this.mailSendInProgress)
            {
                return;
            }
            this.sendMessageButton.selectStatusByName("default");
            return;
        }// end function

        private function validateEmail(param1:ValidationTextInput, param2:String) : Boolean
        {
            return MailValidator.isValid(param2);
        }// end function

        private function validateMultiEmail(param1:ValidationTextInput, param2:String) : Boolean
        {
            var sender:* = param1;
            var value:* = param2;
            var mails:* = this.extractMailAddresses(value);
            with ({})
            {
                {}.testMail = function (param1:String, param2:int, param3:Array) : Boolean
            {
                return MailValidator.isValid(param1);
            }// end function
            ;
            }
            var validMails:* = mails.filter(function (param1:String, param2:int, param3:Array) : Boolean
            {
                return MailValidator.isValid(param1);
            }// end function
            );
            if (mails.length >= 1)
            {
            }
            return mails.length == validMails.length;
        }// end function

        private function txtTo_changeHandler(param1:Event) : void
        {
            this.refreshMailRecieptionCount();
            return;
        }// end function

        private function refreshMailRecieptionCount() : void
        {
            with ({})
            {
                {}.testMail = function (param1:String, param2:int, param3:Array) : Boolean
            {
                return MailValidator.isValid(param1);
            }// end function
            ;
            }
            var validMails:* = this.extractMailAddresses(this.txtTo.text).filter(function (param1:String, param2:int, param3:Array) : Boolean
            {
                return MailValidator.isValid(param1);
            }// end function
            );
            this.mailRecipientCount.setStyle("color", "#4A3C31");
            if (validMails.length == 0)
            {
                this.mailRecipientCount.text = "";
            }
            else
            {
                this.mailRecipientCount.text = resourceManager.getString("confomat7", "save_share.mail_recipient_count").replace("[x]", validMails.length);
            }
            return;
        }// end function

        private function extractMailAddresses(param1:String) : Array
        {
            var value:* = param1;
            var mails:* = value.split(/[ ,;]+/);
            with ({})
            {
                {}.excludeSpacer = function (param1:String, param2:int, param3:Array) : Boolean
            {
                return param1 != "";
            }// end function
            ;
            }
            mails = mails.filter(function (param1:String, param2:int, param3:Array) : Boolean
            {
                return param1 != "";
            }// end function
            );
            return mails;
        }// end function

        public function bus_productSaveStarted(param1:ProductEvent) : void
        {
            this._selectionModel.currentPage = 1;
            this._selectionModel.insertEmptyProduct();
            return;
        }// end function

        public function bus_productSaved(param1:ProductEvent) : void
        {
            this._selectionModel.removeEmptyProduct(false);
            this._selectionModel.insertProduct(param1.product);
            return;
        }// end function

        public function bus_productSaveFault(param1:ProductEvent) : void
        {
            this._selectionModel.removeEmptyProduct(true);
            return;
        }// end function

        public function bus_configurationSelectionChanged(param1:ConfigurationEvent) : void
        {
            if (this.loadingProduct)
            {
                return;
            }
            if (this.visible)
            {
            }
            if (param1.configuration != null)
            {
                this.visible = false;
            }
            return;
        }// end function

        public function bus_productTypeChanged(param1:ProductTypeEvent) : void
        {
            this.tab_selected(null);
            return;
        }// end function

        public function bus_productTypeAppearanceChanged(param1:ProductTypeEvent) : void
        {
            this.tab_selected(null);
            return;
        }// end function

        public function bus_productViewChanged(param1:ProductTypeEvent) : void
        {
            this.tab_selected(null);
            return;
        }// end function

        private function loginCloseButton_clickHandler(param1:MouseEvent) : void
        {
            this.login.visible = false;
            this._loginWasVisible = false;
            return;
        }// end function

        private function resizeTab() : void
        {
            var _loc_1:Number;
            if (this.shareTabBar)
            {
            }
            if (this.shareTabBar.selectedIndex != -1)
            {
            }
            if (this.shareViews.selectedChild)
            {
                _loc_1 = this.shareViews.selectedChild.measuredHeight;
                this.shareViews.height = _loc_1;
            }
            return;
        }// end function

        public function openPanel(param1:String) : void
        {
            var _loc_3:ShareTab;
            var _loc_2:uint;
            for each (_loc_3 in this.shareTabs)
            {
                
                if (_loc_3)
                {
                }
                if (_loc_3.panel)
                {
                }
                if (_loc_3.panel.id == param1)
                {
                    if (this.shareViews.selectedChild == _loc_3.panel)
                    {
                    }
                    if (_loc_3.openMultiple)
                    {
                        this.shareTabBar.selectedIndex = _loc_2;
                        this.tab_selected(_loc_3, true);
                        this._doNotClose = true;
                    }
                    return;
                }
            }
            return;
        }// end function

        private function _SharePanel_Fade1_i() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaFrom = 0;
            _loc_1.alphaTo = 1;
            _loc_1.duration = 300;
            _loc_1.addEventListener("effectStart", this.__fadeIn_effectStart);
            this.fadeIn = _loc_1;
            BindingManager.executeBindings(this, "fadeIn", this.fadeIn);
            return _loc_1;
        }// end function

        public function __fadeIn_effectStart(param1:EffectEvent) : void
        {
            DisplayObject(param1.effectInstance.mx.effects:IEffectInstance::target).visible = true;
            return;
        }// end function

        private function _SharePanel_Fade2_i() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaFrom = 1;
            _loc_1.alphaTo = 0;
            _loc_1.duration = 300;
            _loc_1.addEventListener("effectEnd", this.__fadeOut_effectEnd);
            this.fadeOut = _loc_1;
            BindingManager.executeBindings(this, "fadeOut", this.fadeOut);
            return _loc_1;
        }// end function

        public function __fadeOut_effectEnd(param1:EffectEvent) : void
        {
            DisplayObject(param1.effectInstance.mx.effects:IEffectInstance::target).visible = false;
            return;
        }// end function

        private function _SharePanel_Resize3_i() : Resize
        {
            var _loc_1:* = new Resize();
            _loc_1.heightTo = 0;
            _loc_1.duration = 300;
            this.hideLogin = _loc_1;
            BindingManager.executeBindings(this, "hideLogin", this.hideLogin);
            return _loc_1;
        }// end function

        private function _SharePanel_Resize1_i() : Resize
        {
            var _loc_1:* = new Resize();
            _loc_1.heightTo = 0;
            _loc_1.duration = 300;
            this.hideView = _loc_1;
            BindingManager.executeBindings(this, "hideView", this.hideView);
            return _loc_1;
        }// end function

        private function _SharePanel_Sequence2_i() : Sequence
        {
            var _loc_1:* = new Sequence();
            _loc_1.repeatCount = 1;
            _loc_1.children = [this._SharePanel_SetStyleAction2_c(), this._SharePanel_Fade4_c(), this._SharePanel_Fade5_c()];
            this.loginFail = _loc_1;
            BindingManager.executeBindings(this, "loginFail", this.loginFail);
            return _loc_1;
        }// end function

        private function _SharePanel_SetStyleAction2_c() : SetStyleAction
        {
            var _loc_1:* = new SetStyleAction();
            _loc_1.name = "backgroundColor";
            _loc_1.value = 16545077;
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _SharePanel_Fade4_c() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaTo = 0.5;
            _loc_1.duration = 700;
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _SharePanel_Fade5_c() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaTo = 0;
            _loc_1.duration = 700;
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _SharePanel_Sequence1_i() : Sequence
        {
            var _loc_1:* = new Sequence();
            _loc_1.repeatCount = 1;
            _loc_1.children = [this._SharePanel_SetStyleAction1_c(), this._SharePanel_Fade3_c(), this._SharePanel_SetPropertyAction1_i()];
            this.loginSuccessful = _loc_1;
            BindingManager.executeBindings(this, "loginSuccessful", this.loginSuccessful);
            return _loc_1;
        }// end function

        private function _SharePanel_SetStyleAction1_c() : SetStyleAction
        {
            var _loc_1:* = new SetStyleAction();
            _loc_1.name = "backgroundColor";
            _loc_1.value = 5219840;
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _SharePanel_Fade3_c() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaTo = 0.5;
            _loc_1.duration = 1000;
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _SharePanel_SetPropertyAction1_i() : SetPropertyAction
        {
            var _loc_1:* = new SetPropertyAction();
            _loc_1.name = "visible";
            _loc_1.value = false;
            this._SharePanel_SetPropertyAction1 = _loc_1;
            BindingManager.executeBindings(this, "_SharePanel_SetPropertyAction1", this._SharePanel_SetPropertyAction1);
            return _loc_1;
        }// end function

        private function _SharePanel_Resize4_i() : Resize
        {
            var _loc_1:* = new Resize();
            _loc_1.duration = 300;
            this.resizeProductList = _loc_1;
            BindingManager.executeBindings(this, "resizeProductList", this.resizeProductList);
            return _loc_1;
        }// end function

        private function _SharePanel_Resize2_i() : Resize
        {
            var _loc_1:* = new Resize();
            _loc_1.duration = 300;
            _loc_1.heightTo = 82;
            this.showLogin = _loc_1;
            BindingManager.executeBindings(this, "showLogin", this.showLogin);
            return _loc_1;
        }// end function

        public function ___SharePanel_Canvas1_preinitialize(param1:FlexEvent) : void
        {
            this.init();
            return;
        }// end function

        public function ___SharePanel_Canvas1_creationComplete(param1:FlexEvent) : void
        {
            this.creationCompleteHandler(param1);
            return;
        }// end function

        private function _SharePanel_Canvas2_i() : Canvas
        {
            var temp:* = new Canvas();
            temp.height = 2;
            temp.x = 1;
            temp.id = "_SharePanel_Canvas2";
            if (!temp.document)
            {
                temp.document = this;
            }
            mx_internal::_documentDescriptor = new UIComponentDescriptor({type:Canvas, id:"_SharePanel_Canvas2", propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"_SharePanel_Canvas3", stylesFactory:function () : void
                {
                    this.backgroundColor = 15395303;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {height:1, x:1, y:0};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"_SharePanel_Canvas4", stylesFactory:function () : void
                {
                    this.backgroundColor = 16777215;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {height:1, x:1, y:1};
                }// end function
                })]};
            }// end function
            });
            mx_internal::_documentDescriptor.document = this;
            this._SharePanel_Canvas2 = temp;
            BindingManager.executeBindings(this, "_SharePanel_Canvas2", this._SharePanel_Canvas2);
            return temp;
        }// end function

        private function _SharePanel_ShareTabBar1_i() : ShareTabBar
        {
            var _loc_1:* = new ShareTabBar();
            _loc_1.selectedIndex = -1;
            _loc_1.left = 1;
            _loc_1.right = 1;
            _loc_1.styleName = "SaveAndShareTabBar";
            _loc_1.setStyle("tabWidth", 55);
            _loc_1.setStyle("tabHeight", 60);
            _loc_1.addEventListener("itemClick", this.__shareTabBar_itemClick);
            _loc_1.id = "shareTabBar";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this.shareTabBar = _loc_1;
            BindingManager.executeBindings(this, "shareTabBar", this.shareTabBar);
            return _loc_1;
        }// end function

        public function __shareTabBar_itemClick(param1:ItemClickEvent) : void
        {
            this.tabBar_itemClickHandler(param1);
            return;
        }// end function

        private function _SharePanel_ViewStack1_i() : ViewStack
        {
            var temp:* = new ViewStack();
            temp.creationPolicy = "all";
            temp.resizeToContent = true;
            temp.left = 1;
            temp.right = 1;
            temp.height = 0;
            temp.verticalScrollPolicy = "off";
            temp.horizontalScrollPolicy = "off";
            temp.id = "shareViews";
            if (!temp.document)
            {
                temp.document = this;
            }
            mx_internal::_documentDescriptor = new UIComponentDescriptor({type:ViewStack, id:"shareViews", propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:VBox, id:"save", propertiesFactory:function () : Object
                {
                    return {styleName:"SaveAndShareTabContent", icon:_embed_mxml__save_37913085, percentWidth:100, visible:false, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", childDescriptors:[new UIComponentDescriptor({type:Canvas, events:{resize:"___SharePanel_Canvas5_resize"}, propertiesFactory:function () : Object
                    {
                        return {percentWidth:100, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", childDescriptors:[new UIComponentDescriptor({type:LoadingIndicator, id:"save_loader", propertiesFactory:function () : Object
                        {
                            return {x:4, y:4};
                        }// end function
                        }), new UIComponentDescriptor({type:AutosizeTextArea, id:"save_message", stylesFactory:function () : void
                        {
                            this.borderThickness = 0;
                            this.backgroundAlpha = 0;
                            return;
                        }// end function
                        , propertiesFactory:function () : Object
                        {
                            return {left:30, y:6, right:4, minHeight:25, wordWrap:true, editable:false, verticalScrollPolicy:"off", horizontalScrollPolicy:"off"};
                        }// end function
                        })]};
                    }// end function
                    })]};
                }// end function
                }), new UIComponentDescriptor({type:VBox, id:"mail", propertiesFactory:function () : Object
                {
                    return {styleName:"SaveAndShareTabContent", icon:_embed_mxml__email_23856930, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", childDescriptors:[new UIComponentDescriptor({type:Canvas, events:{resize:"___SharePanel_Canvas6_resize"}, propertiesFactory:function () : Object
                    {
                        return {percentWidth:100, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", childDescriptors:[new UIComponentDescriptor({type:AutosizeTextArea, id:"mail_error", stylesFactory:function () : void
                        {
                            this.borderThickness = 0;
                            this.backgroundAlpha = 0;
                            return;
                        }// end function
                        , propertiesFactory:function () : Object
                        {
                            return {left:4, y:6, right:4, minHeight:25, text:" ", wordWrap:true, editable:false, verticalScrollPolicy:"off", horizontalScrollPolicy:"off"};
                        }// end function
                        })]};
                    }// end function
                    })]};
                }// end function
                }), new UIComponentDescriptor({type:VBox, id:"mail_form", propertiesFactory:function () : Object
                {
                    return {styleName:"SaveAndShareTabContent", icon:_embed_mxml__email_23856930, percentWidth:100, visible:false, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"_SharePanel_Canvas7", propertiesFactory:function () : Object
                    {
                        return {percentWidth:100, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", childDescriptors:[new UIComponentDescriptor({type:ValidationTextInput, id:"txtFrom", events:{focusOut:"__txtFrom_focusOut", focusIn:"__txtFrom_focusIn"}, propertiesFactory:function () : Object
                        {
                            return {hasReset:true, y:3, left:4, right:4, validationCallback:validateEmail};
                        }// end function
                        }), new UIComponentDescriptor({type:ValidationTextInput, id:"txtTo", events:{change:"__txtTo_change", focusOut:"__txtTo_focusOut", focusIn:"__txtTo_focusIn"}, propertiesFactory:function () : Object
                        {
                            return {hasReset:true, y:29, left:4, right:4, validationCallback:validateMultiEmail};
                        }// end function
                        }), new UIComponentDescriptor({type:Canvas, id:"mailImage", stylesFactory:function () : void
                        {
                            this.borderThickness = 1;
                            this.borderStyle = "solid";
                            return;
                        }// end function
                        , propertiesFactory:function () : Object
                        {
                            return {left:4, y:55, width:80, height:80, verticalScrollPolicy:"off", horizontalScrollPolicy:"off"};
                        }// end function
                        }), new UIComponentDescriptor({type:AdvancedTextArea, id:"txtMessage", events:{focusIn:"__txtMessage_focusIn"}, propertiesFactory:function () : Object
                        {
                            return {left:88, right:4, y:55, height:80};
                        }// end function
                        }), new UIComponentDescriptor({type:TextArea, id:"mailRecipientCount", stylesFactory:function () : void
                        {
                            this.backgroundAlpha = 0;
                            this.borderStyle = "none";
                            return;
                        }// end function
                        , propertiesFactory:function () : Object
                        {
                            return {left:4, y:135, minHeight:30, focusEnabled:false, editable:false, horizontalScrollPolicy:"off", verticalScrollPolicy:"off", text:""};
                        }// end function
                        }), new UIComponentDescriptor({type:StatusButton, id:"sendMessageButton", events:{click:"__sendMessageButton_click"}, propertiesFactory:function () : Object
                        {
                            return {right:5, y:138, height:24, stati:[_SharePanel_Status1_i(), _SharePanel_Status2_i(), _SharePanel_Status3_i(), _SharePanel_Status4_i()]};
                        }// end function
                        })]};
                    }// end function
                    })]};
                }// end function
                }), new UIComponentDescriptor({type:VBox, id:"facebook", propertiesFactory:function () : Object
                {
                    return {styleName:"SaveAndShareTabContent", label:"Facebook", icon:_embed_mxml__facebook_155826300, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", childDescriptors:[new UIComponentDescriptor({type:Canvas, events:{resize:"___SharePanel_Canvas9_resize"}, propertiesFactory:function () : Object
                    {
                        return {percentWidth:100, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", childDescriptors:[new UIComponentDescriptor({type:LoadingIndicator, id:"facebook_loader", propertiesFactory:function () : Object
                        {
                            return {x:4, y:4};
                        }// end function
                        }), new UIComponentDescriptor({type:AutosizeTextArea, id:"facebook_message", stylesFactory:function () : void
                        {
                            this.borderThickness = 0;
                            this.backgroundAlpha = 0;
                            return;
                        }// end function
                        , propertiesFactory:function () : Object
                        {
                            return {left:30, y:6, right:4, minHeight:25, wordWrap:true, editable:false, verticalScrollPolicy:"off", horizontalScrollPolicy:"off"};
                        }// end function
                        })]};
                    }// end function
                    })]};
                }// end function
                }), new UIComponentDescriptor({type:VBox, id:"twitter", propertiesFactory:function () : Object
                {
                    return {label:"Twitter", styleName:"SaveAndShareTabContent", icon:_embed_mxml__twitter_889825545, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", childDescriptors:[new UIComponentDescriptor({type:Canvas, events:{resize:"___SharePanel_Canvas10_resize"}, propertiesFactory:function () : Object
                    {
                        return {percentWidth:100, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", childDescriptors:[new UIComponentDescriptor({type:LoadingIndicator, id:"twitter_loader", propertiesFactory:function () : Object
                        {
                            return {x:4, y:4};
                        }// end function
                        }), new UIComponentDescriptor({type:AutosizeTextArea, id:"twitter_message", stylesFactory:function () : void
                        {
                            this.borderThickness = 0;
                            this.backgroundAlpha = 0;
                            return;
                        }// end function
                        , propertiesFactory:function () : Object
                        {
                            return {left:30, y:6, right:4, minHeight:25, wordWrap:true, editable:false, verticalScrollPolicy:"off", horizontalScrollPolicy:"off"};
                        }// end function
                        })]};
                    }// end function
                    })]};
                }// end function
                }), new UIComponentDescriptor({type:VBox, id:"embed_save", propertiesFactory:function () : Object
                {
                    return {styleName:"SaveAndShareTabContent", icon:_embed_mxml__embed_23856223, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", childDescriptors:[new UIComponentDescriptor({type:Canvas, events:{resize:"___SharePanel_Canvas11_resize"}, propertiesFactory:function () : Object
                    {
                        return {percentWidth:100, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", childDescriptors:[new UIComponentDescriptor({type:LoadingIndicator, id:"embed_loader", propertiesFactory:function () : Object
                        {
                            return {x:4, y:4};
                        }// end function
                        }), new UIComponentDescriptor({type:AutosizeTextArea, id:"embed_message", stylesFactory:function () : void
                        {
                            this.borderThickness = 0;
                            this.backgroundAlpha = 0;
                            return;
                        }// end function
                        , propertiesFactory:function () : Object
                        {
                            return {left:30, y:6, right:4, minHeight:25, wordWrap:true, editable:false, verticalScrollPolicy:"off", horizontalScrollPolicy:"off"};
                        }// end function
                        })]};
                    }// end function
                    })]};
                }// end function
                }), new UIComponentDescriptor({type:VBox, id:"embed", propertiesFactory:function () : Object
                {
                    return {styleName:"SaveAndShareTabContent", icon:_embed_mxml__embed_23856223, percentWidth:100, visible:false, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", explicitHeight:150, childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"embedPanel", propertiesFactory:function () : Object
                    {
                        return {percentWidth:100, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", childDescriptors:[new UIComponentDescriptor({type:Label, id:"_SharePanel_Label1", propertiesFactory:function () : Object
                        {
                            return {left:4, y:4};
                        }// end function
                        }), new UIComponentDescriptor({type:AdvancedTextInput, id:"txtPlainLink", events:{focusIn:"__txtPlainLink_focusIn"}, propertiesFactory:function () : Object
                        {
                            return {y:20, left:4, right:4, editable:false};
                        }// end function
                        }), new UIComponentDescriptor({type:Label, id:"_SharePanel_Label2", propertiesFactory:function () : Object
                        {
                            return {left:4, y:45};
                        }// end function
                        }), new UIComponentDescriptor({type:Canvas, id:"embedImage", stylesFactory:function () : void
                        {
                            this.borderThickness = 1;
                            this.borderStyle = "solid";
                            return;
                        }// end function
                        , propertiesFactory:function () : Object
                        {
                            return {left:4, y:63, width:80, height:80, verticalScrollPolicy:"off", horizontalScrollPolicy:"off"};
                        }// end function
                        }), new UIComponentDescriptor({type:AdvancedTextArea, id:"txtEmbedCode", events:{focusIn:"__txtEmbedCode_focusIn"}, propertiesFactory:function () : Object
                        {
                            return {left:88, right:4, y:63, height:80, editable:false, verticalScrollPolicy:"off", horizontalScrollPolicy:"off"};
                        }// end function
                        })]};
                    }// end function
                    })]};
                }// end function
                })]};
            }// end function
            });
            mx_internal::_documentDescriptor.document = this;
            this.shareViews = temp;
            BindingManager.executeBindings(this, "shareViews", this.shareViews);
            return temp;
        }// end function

        public function ___SharePanel_Canvas5_resize(param1:ResizeEvent) : void
        {
            this.resizeTab();
            return;
        }// end function

        public function ___SharePanel_Canvas6_resize(param1:ResizeEvent) : void
        {
            this.resizeTab();
            return;
        }// end function

        public function __txtFrom_focusOut(param1:FocusEvent) : void
        {
            this.txtFrom.validate();
            return;
        }// end function

        public function __txtFrom_focusIn(param1:FocusEvent) : void
        {
            this.mail_focus(param1);
            return;
        }// end function

        public function __txtTo_change(param1:Event) : void
        {
            this.txtTo_changeHandler(param1);
            return;
        }// end function

        public function __txtTo_focusOut(param1:FocusEvent) : void
        {
            this.txtTo.validate();
            return;
        }// end function

        public function __txtTo_focusIn(param1:FocusEvent) : void
        {
            this.mail_focus(param1);
            return;
        }// end function

        public function __txtMessage_focusIn(param1:FocusEvent) : void
        {
            this.mail_focus(param1);
            return;
        }// end function

        private function _SharePanel_Status1_i() : Status
        {
            var _loc_1:* = new Status();
            _loc_1.name = "default";
            this._SharePanel_Status1 = _loc_1;
            BindingManager.executeBindings(this, "_SharePanel_Status1", this._SharePanel_Status1);
            return _loc_1;
        }// end function

        private function _SharePanel_Status2_i() : Status
        {
            var _loc_1:* = new Status();
            _loc_1.name = "progress";
            _loc_1.iconClass = this._embed_mxml__loader_1278526270;
            this.inProgress = _loc_1;
            BindingManager.executeBindings(this, "inProgress", this.inProgress);
            return _loc_1;
        }// end function

        private function _SharePanel_Status3_i() : Status
        {
            var _loc_1:* = new Status();
            _loc_1.name = "success";
            _loc_1.iconClass = this._embed_mxml__checkmarkIcon_1959331471;
            _loc_1.styleName = "success";
            this._SharePanel_Status3 = _loc_1;
            BindingManager.executeBindings(this, "_SharePanel_Status3", this._SharePanel_Status3);
            return _loc_1;
        }// end function

        private function _SharePanel_Status4_i() : Status
        {
            var _loc_1:* = new Status();
            _loc_1.name = "error";
            _loc_1.iconClass = this._embed_mxml__exclamationIcon_1529669431;
            _loc_1.styleName = "error";
            this._SharePanel_Status4 = _loc_1;
            BindingManager.executeBindings(this, "_SharePanel_Status4", this._SharePanel_Status4);
            return _loc_1;
        }// end function

        public function __sendMessageButton_click(param1:MouseEvent) : void
        {
            this.sendMessageButton_clickHandler(param1);
            return;
        }// end function

        public function ___SharePanel_Canvas9_resize(param1:ResizeEvent) : void
        {
            this.resizeTab();
            return;
        }// end function

        public function ___SharePanel_Canvas10_resize(param1:ResizeEvent) : void
        {
            this.resizeTab();
            return;
        }// end function

        public function ___SharePanel_Canvas11_resize(param1:ResizeEvent) : void
        {
            this.resizeTab();
            return;
        }// end function

        public function __txtPlainLink_focusIn(param1:FocusEvent) : void
        {
            this.selectAndCopyToClipboard(param1);
            return;
        }// end function

        public function __txtEmbedCode_focusIn(param1:FocusEvent) : void
        {
            this.selectAndCopyToClipboard(param1);
            return;
        }// end function

        private function _SharePanel_Spacer1_c() : Spacer
        {
            var _loc_1:* = new Spacer();
            _loc_1.height = 3;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _SharePanel_Label3_i() : Label
        {
            var _loc_1:* = new Label();
            _loc_1.styleName = "labelStyle";
            _loc_1.left = 10;
            _loc_1.right = 10;
            _loc_1.id = "_SharePanel_Label3";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this._SharePanel_Label3 = _loc_1;
            BindingManager.executeBindings(this, "_SharePanel_Label3", this._SharePanel_Label3);
            return _loc_1;
        }// end function

        private function _SharePanel_Canvas14_i() : Canvas
        {
            var temp:* = new Canvas();
            temp.height = 2;
            temp.x = 1;
            temp.id = "_SharePanel_Canvas14";
            if (!temp.document)
            {
                temp.document = this;
            }
            mx_internal::_documentDescriptor = new UIComponentDescriptor({type:Canvas, id:"_SharePanel_Canvas14", propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"_SharePanel_Canvas15", stylesFactory:function () : void
                {
                    this.backgroundColor = 15395303;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {height:1, x:1, y:0};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"_SharePanel_Canvas16", stylesFactory:function () : void
                {
                    this.backgroundColor = 16777215;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {height:1, x:1, y:1};
                }// end function
                })]};
            }// end function
            });
            mx_internal::_documentDescriptor.document = this;
            this._SharePanel_Canvas14 = temp;
            BindingManager.executeBindings(this, "_SharePanel_Canvas14", this._SharePanel_Canvas14);
            return temp;
        }// end function

        private function _SharePanel_ProductTileList1_i() : ProductTileList
        {
            var _loc_1:* = new ProductTileList();
            _loc_1.styleName = "SaveAndShare_productList";
            _loc_1.left = 1;
            _loc_1.right = 0;
            _loc_1.height = 90;
            _loc_1.columnCount = 1;
            _loc_1.rowCount = 3;
            _loc_1.rowHeight = 89;
            _loc_1.columnWidth = 89;
            _loc_1.horizontalScrollPolicy = "off";
            _loc_1.verticalScrollPolicy = "off";
            _loc_1.itemRenderer = this._SharePanel_ClassFactory1_c();
            _loc_1.addEventListener("itemClick", this.__productList_itemClick);
            _loc_1.addEventListener("itemRollOver", this.__productList_itemRollOver);
            _loc_1.id = "productList";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this.productList = _loc_1;
            BindingManager.executeBindings(this, "productList", this.productList);
            return _loc_1;
        }// end function

        private function _SharePanel_ClassFactory1_c() : ClassFactory
        {
            var _loc_1:* = new ClassFactory();
            _loc_1.generator = ProductRenderer;
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        public function __productList_itemClick(param1:ListEvent) : void
        {
            this.productList_itemClickHandler(param1);
            return;
        }// end function

        public function __productList_itemRollOver(param1:ListEvent) : void
        {
            this.onItemRollOver(param1);
            return;
        }// end function

        private function _SharePanel_Paging1_i() : Paging
        {
            var _loc_1:* = new Paging();
            _loc_1.width = 270;
            _loc_1.height = 30;
            _loc_1.id = "_SharePanel_Paging1";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this._SharePanel_Paging1 = _loc_1;
            BindingManager.executeBindings(this, "_SharePanel_Paging1", this._SharePanel_Paging1);
            return _loc_1;
        }// end function

        private function _SharePanel_Spacer2_c() : Spacer
        {
            var _loc_1:* = new Spacer();
            _loc_1.height = 6;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _SharePanel_Canvas17_i() : Canvas
        {
            var temp:* = new Canvas();
            temp.left = 1;
            temp.right = 1;
            temp.height = 82;
            temp.visible = false;
            temp.verticalScrollPolicy = "off";
            temp.horizontalScrollPolicy = "off";
            temp.id = "login";
            if (!temp.document)
            {
                temp.document = this;
            }
            mx_internal::_documentDescriptor = new UIComponentDescriptor({type:Canvas, id:"login", effects:["hideEffect", "showEffect"], propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"loginColor", stylesFactory:function () : void
                {
                    this.backgroundColor = 65280;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {alpha:0, height:70, y:2, percentWidth:100};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"_SharePanel_Canvas19", propertiesFactory:function () : Object
                {
                    return {height:2, x:1, childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"_SharePanel_Canvas20", stylesFactory:function () : void
                    {
                        this.backgroundColor = 15395303;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {height:1, x:1, y:0};
                    }// end function
                    }), new UIComponentDescriptor({type:Canvas, id:"_SharePanel_Canvas21", stylesFactory:function () : void
                    {
                        this.backgroundColor = 16777215;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {height:1, x:1, y:1};
                    }// end function
                    })]};
                }// end function
                }), new UIComponentDescriptor({type:Button, events:{click:"___SharePanel_Button1_click"}, propertiesFactory:function () : Object
                {
                    return {styleName:"closeButton", label:"x", right:5, y:5, width:15, height:15};
                }// end function
                }), new UIComponentDescriptor({type:Text, id:"_SharePanel_Text1", propertiesFactory:function () : Object
                {
                    return {styleName:"notice", left:4, y:3, right:23, minHeight:40};
                }// end function
                }), new UIComponentDescriptor({type:AdvancedTextInput, id:"username", events:{keyUp:"__username_keyUp"}, propertiesFactory:function () : Object
                {
                    return {hasReset:true, x:4, height:20, y:35};
                }// end function
                }), new UIComponentDescriptor({type:AdvancedTextInput, id:"password", events:{keyUp:"__password_keyUp"}, propertiesFactory:function () : Object
                {
                    return {x:4, height:20, y:58, displayAsPassword:true, hasReset:true};
                }// end function
                }), new UIComponentDescriptor({type:Button, id:"loginButton", events:{click:"__loginButton_click"}, propertiesFactory:function () : Object
                {
                    return {y:53, right:4};
                }// end function
                })]};
            }// end function
            });
            mx_internal::_documentDescriptor.document = this;
            this.login = temp;
            BindingManager.executeBindings(this, "login", this.login);
            return temp;
        }// end function

        public function ___SharePanel_Button1_click(param1:MouseEvent) : void
        {
            this.loginCloseButton_clickHandler(param1);
            return;
        }// end function

        public function __username_keyUp(param1:KeyboardEvent) : void
        {
            this.username_keyUpHandler(param1);
            return;
        }// end function

        public function __password_keyUp(param1:KeyboardEvent) : void
        {
            this.password_keyUpHandler(param1);
            return;
        }// end function

        public function __loginButton_click(param1:MouseEvent) : void
        {
            this.loginButton_clickHandler(param1);
            return;
        }// end function

        public function __tileOver_click(param1:MouseEvent) : void
        {
            this.itemClick(param1);
            return;
        }// end function

        public function __tileOver_rollOut(param1:MouseEvent) : void
        {
            this.itemRollOut(param1);
            return;
        }// end function

        private function _SharePanel_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, null, null, "loginSuccessful.target", "loginColor");
            result[1] = new Binding(this, null, null, "_SharePanel_SetPropertyAction1.target", "login");
            result[2] = new Binding(this, null, null, "loginFail.target", "loginColor");
            result[3] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.save_share");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "palette.caption");
            result[4] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_SharePanel_Canvas2.width");
            result[5] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_SharePanel_Canvas3.width");
            result[6] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_SharePanel_Canvas4.width");
            result[7] = new Binding(this, function () : Object
            {
                return shareTabs;
            }// end function
            , null, "shareTabBar.dataProvider");
            result[8] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.save");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "save.label");
            result[9] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.saving_in_progress");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "save_message.text");
            result[10] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.email");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "mail.label");
            result[11] = new Binding(this, function () : Number
            {
                return shareViews.width;
            }// end function
            , null, "mail.width");
            result[12] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.email");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "mail_form.label");
            result[13] = new Binding(this, function () : Number
            {
                return 142 + sendMessageButton.height;
            }// end function
            , null, "_SharePanel_Canvas7.height");
            result[14] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.mail_from");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "txtFrom.defaultText");
            result[15] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.mail_to");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "txtTo.defaultText");
            result[16] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.mail_message");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "txtMessage.defaultText");
            result[17] = new Binding(this, function () : Number
            {
                return mail_form.width - sendMessageButton.width - 10;
            }// end function
            , null, "mailRecipientCount.width");
            result[18] = new Binding(this, function () : Boolean
            {
                if (txtFrom.isValid)
                {
                }
                if (txtTo.isValid)
                {
                }
                return !mailSendInProgress;
            }// end function
            , null, "sendMessageButton.enabled");
            result[19] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.mail_send_mail");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "_SharePanel_Status1.text");
            result[20] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.mail_sending");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "inProgress.text");
            result[21] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.mail_was_sent");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "_SharePanel_Status3.text");
            result[22] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.mail_was_not_sent");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "_SharePanel_Status4.text");
            result[23] = new Binding(this, function () : Number
            {
                return shareViews.width;
            }// end function
            , null, "facebook.width");
            result[24] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.saving_in_progress");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "facebook_message.text");
            result[25] = new Binding(this, function () : Number
            {
                return shareViews.width;
            }// end function
            , null, "twitter.width");
            result[26] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.saving_in_progress");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "twitter_message.text");
            result[27] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.embed");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "embed_save.label");
            result[28] = new Binding(this, function () : Number
            {
                return shareViews.width;
            }// end function
            , null, "embed_save.width");
            result[29] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.saving_in_progress");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "embed_message.text");
            result[30] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.embed");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "embed.label");
            result[31] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.embed_plain");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "_SharePanel_Label1.text");
            result[32] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.embed_html");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "_SharePanel_Label2.text");
            result[33] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.saved_products");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "_SharePanel_Label3.text");
            result[34] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_SharePanel_Canvas14.width");
            result[35] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_SharePanel_Canvas15.width");
            result[36] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_SharePanel_Canvas16.width");
            result[37] = new Binding(this, null, function (param1) : void
            {
                productList.setStyle("resizeEffect", param1);
                return;
            }// end function
            , "productList.resizeEffect", "resizeProductList");
            result[38] = new Binding(this, function () : Object
            {
                return _selectionModel.products;
            }// end function
            , null, "productList.dataProvider");
            result[39] = new Binding(this, function () : IPageable
            {
                return _selectionModel;
            }// end function
            , null, "_SharePanel_Paging1.dataProvider");
            result[40] = new Binding(this, null, function (param1) : void
            {
                login.setStyle("hideEffect", param1);
                return;
            }// end function
            , "login.hideEffect", "hideLogin");
            result[41] = new Binding(this, null, function (param1) : void
            {
                login.setStyle("showEffect", param1);
                return;
            }// end function
            , "login.showEffect", "showLogin");
            result[42] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_SharePanel_Canvas19.width");
            result[43] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_SharePanel_Canvas20.width");
            result[44] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_SharePanel_Canvas21.width");
            result[45] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.no_auth_login_notice");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "_SharePanel_Text1.text");
            result[46] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.username");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "username.defaultText");
            result[47] = new Binding(this, function () : Number
            {
                return login.width - 16 - loginButton.width;
            }// end function
            , null, "username.width");
            result[48] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.password");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "password.defaultText");
            result[49] = new Binding(this, function () : Number
            {
                return login.width - 16 - loginButton.width;
            }// end function
            , null, "password.width");
            result[50] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "save_share.login");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "loginButton.label");
            result[51] = new Binding(this, function () : Boolean
            {
                if (username.text.length > 0)
                {
                }
                return password.text.length > 0;
            }// end function
            , null, "loginButton.enabled");
            result[52] = new Binding(this, function () : Number
            {
                return productList.y;
            }// end function
            , null, "noProducts.y");
            result[53] = new Binding(this, function () : Number
            {
                return productList.height;
            }// end function
            , null, "noProducts.height");
            result[54] = new Binding(this, function () : Boolean
            {
                return _selectionModel.productTotalCount == 0;
            }// end function
            , null, "noProducts.visible");
            result[55] = new Binding(this, function () : String
            {
                var _loc_1:* = user.isAuthentificated ? (resourceManager.getString("confomat7", "save_share.auth_no_saved_products")) : (resourceManager.getString("confomat7", "save_share.no_auth_no_saved_products"));
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "noProductsMessage.text");
            result[56] = new Binding(this, function () : Number
            {
                return noProducts.width - 20;
            }// end function
            , null, "noProductsMessage.width");
            result[57] = new Binding(this, function () : Number
            {
                return productList.x + palette.x;
            }// end function
            , null, "listOver.x");
            result[58] = new Binding(this, function () : Number
            {
                return productList.y + palette.y;
            }// end function
            , null, "listOver.y");
            result[59] = new Binding(this, function () : Number
            {
                return productList.width;
            }// end function
            , null, "listOver.width");
            result[60] = new Binding(this, function () : Number
            {
                return productList.height;
            }// end function
            , null, "listOver.height");
            return result;
        }// end function

        function _SharePanel_StylesInit() : void
        {
            var style:CSSStyleDeclaration;
            var effects:Array;
            if (mx_internal::_SharePanel_StylesInit_done)
            {
                return;
            }
            mx_internal::_SharePanel_StylesInit_done = true;
            style = styleManager.getStyleDeclaration(".SaveAndShareTabBar");
            if (!style)
            {
                style = new CSSStyleDeclaration(null, styleManager);
                StyleManager.setStyleDeclaration(".SaveAndShareTabBar", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.selectedTabTextStyleName = "SaveAndShareTabSelected";
                this.tabStyleName = "SaveAndShareTab";
                return;
            }// end function
            ;
            }
            style = styleManager.getStyleDeclaration(".SaveAndShareTab");
            if (!style)
            {
                style = new CSSStyleDeclaration(null, styleManager);
                StyleManager.setStyleDeclaration(".SaveAndShareTab", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.fontWeight = "normal";
                this.color = 6576206;
                this.cornerRadius = 15;
                this.textAlign = "center";
                this.fontFamily = "Trebuchet";
                this.fontSize = 10;
                this.textIndent = 4;
                this.disabledColor = 13027014;
                this.paddingLeft = 0;
                this.skin = TabSkin;
                this.paddingRight = 0;
                return;
            }// end function
            ;
            }
            style = styleManager.getStyleDeclaration(".SaveAndShareTabSelected");
            if (!style)
            {
                style = new CSSStyleDeclaration(null, styleManager);
                StyleManager.setStyleDeclaration(".SaveAndShareTabSelected", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.color = 6576206;
                return;
            }// end function
            ;
            }
            style = styleManager.getStyleDeclaration(".SaveAndShareTabContent");
            if (!style)
            {
                style = new CSSStyleDeclaration(null, styleManager);
                StyleManager.setStyleDeclaration(".SaveAndShareTabContent", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderSkin = TabContentSkin;
                this.fillRatios = [0, 255];
                this.fillColors = [15132390, 14277081];
                this.fillAlphas = [1, 1];
                return;
            }// end function
            ;
            }
            style = styleManager.getStyleDeclaration(".TabBarButton");
            if (!style)
            {
                style = new CSSStyleDeclaration(null, styleManager);
                StyleManager.setStyleDeclaration(".TabBarButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.labelPlacement = bottom;
                return;
            }// end function
            ;
            }
            style = styleManager.getStyleDeclaration(".SaveAndShare_productList");
            if (!style)
            {
                style = new CSSStyleDeclaration(null, styleManager);
                StyleManager.setStyleDeclaration(".SaveAndShare_productList", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.borderStyle = "none";
                this.paddingTop = 0;
                this.backgroundColor = 16185078;
                this.rollOverColor = 3423296;
                this.selectionColor = 5930640;
                this.paddingBottom = 0;
                return;
            }// end function
            ;
            }
            style = styleManager.getStyleDeclaration(".mailFailed");
            if (!style)
            {
                style = new CSSStyleDeclaration(null, styleManager);
                StyleManager.setStyleDeclaration(".mailFailed", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.fillColors = [16711680, 15921906];
                return;
            }// end function
            ;
            }
            return;
        }// end function

        public function get embed() : VBox
        {
            return this._96620249embed;
        }// end function

        public function set embed(param1:VBox) : void
        {
            var _loc_2:* = this._96620249embed;
            if (_loc_2 !== param1)
            {
                this._96620249embed = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "embed", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get embedImage() : Canvas
        {
            return this._738080254embedImage;
        }// end function

        public function set embedImage(param1:Canvas) : void
        {
            var _loc_2:* = this._738080254embedImage;
            if (_loc_2 !== param1)
            {
                this._738080254embedImage = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "embedImage", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get embedPanel() : Canvas
        {
            return this._731960661embedPanel;
        }// end function

        public function set embedPanel(param1:Canvas) : void
        {
            var _loc_2:* = this._731960661embedPanel;
            if (_loc_2 !== param1)
            {
                this._731960661embedPanel = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "embedPanel", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get embed_loader() : LoadingIndicator
        {
            return this._1703815225embed_loader;
        }// end function

        public function set embed_loader(param1:LoadingIndicator) : void
        {
            var _loc_2:* = this._1703815225embed_loader;
            if (_loc_2 !== param1)
            {
                this._1703815225embed_loader = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "embed_loader", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get embed_message() : AutosizeTextArea
        {
            return this._1896942753embed_message;
        }// end function

        public function set embed_message(param1:AutosizeTextArea) : void
        {
            var _loc_2:* = this._1896942753embed_message;
            if (_loc_2 !== param1)
            {
                this._1896942753embed_message = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "embed_message", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get embed_save() : VBox
        {
            return this._717583581embed_save;
        }// end function

        public function set embed_save(param1:VBox) : void
        {
            var _loc_2:* = this._717583581embed_save;
            if (_loc_2 !== param1)
            {
                this._717583581embed_save = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "embed_save", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get facebook() : VBox
        {
            return this._497130182facebook;
        }// end function

        public function set facebook(param1:VBox) : void
        {
            var _loc_2:* = this._497130182facebook;
            if (_loc_2 !== param1)
            {
                this._497130182facebook = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "facebook", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get facebook_loader() : LoadingIndicator
        {
            return this._1469380692facebook_loader;
        }// end function

        public function set facebook_loader(param1:LoadingIndicator) : void
        {
            var _loc_2:* = this._1469380692facebook_loader;
            if (_loc_2 !== param1)
            {
                this._1469380692facebook_loader = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "facebook_loader", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get facebook_message() : AutosizeTextArea
        {
            return this._1982850162facebook_message;
        }// end function

        public function set facebook_message(param1:AutosizeTextArea) : void
        {
            var _loc_2:* = this._1982850162facebook_message;
            if (_loc_2 !== param1)
            {
                this._1982850162facebook_message = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "facebook_message", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get fadeIn() : Fade
        {
            return this._1282133823fadeIn;
        }// end function

        public function set fadeIn(param1:Fade) : void
        {
            var _loc_2:* = this._1282133823fadeIn;
            if (_loc_2 !== param1)
            {
                this._1282133823fadeIn = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fadeIn", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get fadeOut() : Fade
        {
            return this._1091436750fadeOut;
        }// end function

        public function set fadeOut(param1:Fade) : void
        {
            var _loc_2:* = this._1091436750fadeOut;
            if (_loc_2 !== param1)
            {
                this._1091436750fadeOut = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fadeOut", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get hideLogin() : Resize
        {
            return this._835984199hideLogin;
        }// end function

        public function set hideLogin(param1:Resize) : void
        {
            var _loc_2:* = this._835984199hideLogin;
            if (_loc_2 !== param1)
            {
                this._835984199hideLogin = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hideLogin", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get hideView() : Resize
        {
            return this._1773855993hideView;
        }// end function

        public function set hideView(param1:Resize) : void
        {
            var _loc_2:* = this._1773855993hideView;
            if (_loc_2 !== param1)
            {
                this._1773855993hideView = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hideView", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get inProgress() : Status
        {
            return this._1347010958inProgress;
        }// end function

        public function set inProgress(param1:Status) : void
        {
            var _loc_2:* = this._1347010958inProgress;
            if (_loc_2 !== param1)
            {
                this._1347010958inProgress = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inProgress", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get listOver() : Canvas
        {
            return this._1345512082listOver;
        }// end function

        public function set listOver(param1:Canvas) : void
        {
            var _loc_2:* = this._1345512082listOver;
            if (_loc_2 !== param1)
            {
                this._1345512082listOver = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "listOver", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get login() : Canvas
        {
            return this._103149417login;
        }// end function

        public function set login(param1:Canvas) : void
        {
            var _loc_2:* = this._103149417login;
            if (_loc_2 !== param1)
            {
                this._103149417login = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "login", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get loginButton() : Button
        {
            return this._829165563loginButton;
        }// end function

        public function set loginButton(param1:Button) : void
        {
            var _loc_2:* = this._829165563loginButton;
            if (_loc_2 !== param1)
            {
                this._829165563loginButton = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loginButton", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get loginColor() : Canvas
        {
            return this._1773631110loginColor;
        }// end function

        public function set loginColor(param1:Canvas) : void
        {
            var _loc_2:* = this._1773631110loginColor;
            if (_loc_2 !== param1)
            {
                this._1773631110loginColor = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loginColor", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get loginFail() : Sequence
        {
            return this._1719706073loginFail;
        }// end function

        public function set loginFail(param1:Sequence) : void
        {
            var _loc_2:* = this._1719706073loginFail;
            if (_loc_2 !== param1)
            {
                this._1719706073loginFail = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loginFail", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get loginSuccessful() : Sequence
        {
            return this._1001129699loginSuccessful;
        }// end function

        public function set loginSuccessful(param1:Sequence) : void
        {
            var _loc_2:* = this._1001129699loginSuccessful;
            if (_loc_2 !== param1)
            {
                this._1001129699loginSuccessful = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loginSuccessful", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get mail() : VBox
        {
            return this._3343799mail;
        }// end function

        public function set mail(param1:VBox) : void
        {
            var _loc_2:* = this._3343799mail;
            if (_loc_2 !== param1)
            {
                this._3343799mail = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mail", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get mailImage() : Canvas
        {
            return this._328815132mailImage;
        }// end function

        public function set mailImage(param1:Canvas) : void
        {
            var _loc_2:* = this._328815132mailImage;
            if (_loc_2 !== param1)
            {
                this._328815132mailImage = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mailImage", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get mailRecipientCount() : TextArea
        {
            return this._1592351757mailRecipientCount;
        }// end function

        public function set mailRecipientCount(param1:TextArea) : void
        {
            var _loc_2:* = this._1592351757mailRecipientCount;
            if (_loc_2 !== param1)
            {
                this._1592351757mailRecipientCount = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mailRecipientCount", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get mail_error() : AutosizeTextArea
        {
            return this._980363904mail_error;
        }// end function

        public function set mail_error(param1:AutosizeTextArea) : void
        {
            var _loc_2:* = this._980363904mail_error;
            if (_loc_2 !== param1)
            {
                this._980363904mail_error = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mail_error", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get mail_form() : VBox
        {
            return this._308692404mail_form;
        }// end function

        public function set mail_form(param1:VBox) : void
        {
            var _loc_2:* = this._308692404mail_form;
            if (_loc_2 !== param1)
            {
                this._308692404mail_form = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mail_form", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get noProducts() : Canvas
        {
            return this._155251269noProducts;
        }// end function

        public function set noProducts(param1:Canvas) : void
        {
            var _loc_2:* = this._155251269noProducts;
            if (_loc_2 !== param1)
            {
                this._155251269noProducts = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "noProducts", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get noProductsMessage() : Text
        {
            return this._2030076414noProductsMessage;
        }// end function

        public function set noProductsMessage(param1:Text) : void
        {
            var _loc_2:* = this._2030076414noProductsMessage;
            if (_loc_2 !== param1)
            {
                this._2030076414noProductsMessage = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "noProductsMessage", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get palette() : Palette
        {
            return this._798910853palette;
        }// end function

        public function set palette(param1:Palette) : void
        {
            var _loc_2:* = this._798910853palette;
            if (_loc_2 !== param1)
            {
                this._798910853palette = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "palette", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get password() : AdvancedTextInput
        {
            return this._1216985755password;
        }// end function

        public function set password(param1:AdvancedTextInput) : void
        {
            var _loc_2:* = this._1216985755password;
            if (_loc_2 !== param1)
            {
                this._1216985755password = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "password", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get productList() : ProductTileList
        {
            return this._1491869139productList;
        }// end function

        public function set productList(param1:ProductTileList) : void
        {
            var _loc_2:* = this._1491869139productList;
            if (_loc_2 !== param1)
            {
                this._1491869139productList = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "productList", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get resizeProductList() : Resize
        {
            return this._1447119655resizeProductList;
        }// end function

        public function set resizeProductList(param1:Resize) : void
        {
            var _loc_2:* = this._1447119655resizeProductList;
            if (_loc_2 !== param1)
            {
                this._1447119655resizeProductList = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resizeProductList", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get save() : VBox
        {
            return this._3522941save;
        }// end function

        public function set save(param1:VBox) : void
        {
            var _loc_2:* = this._3522941save;
            if (_loc_2 !== param1)
            {
                this._3522941save = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "save", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get save_loader() : LoadingIndicator
        {
            return this._636957973save_loader;
        }// end function

        public function set save_loader(param1:LoadingIndicator) : void
        {
            var _loc_2:* = this._636957973save_loader;
            if (_loc_2 !== param1)
            {
                this._636957973save_loader = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "save_loader", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get save_message() : AutosizeTextArea
        {
            return this._1110860987save_message;
        }// end function

        public function set save_message(param1:AutosizeTextArea) : void
        {
            var _loc_2:* = this._1110860987save_message;
            if (_loc_2 !== param1)
            {
                this._1110860987save_message = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "save_message", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get sendMessageButton() : StatusButton
        {
            return this._945647759sendMessageButton;
        }// end function

        public function set sendMessageButton(param1:StatusButton) : void
        {
            var _loc_2:* = this._945647759sendMessageButton;
            if (_loc_2 !== param1)
            {
                this._945647759sendMessageButton = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sendMessageButton", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get shareTabBar() : ShareTabBar
        {
            return this._74922237shareTabBar;
        }// end function

        public function set shareTabBar(param1:ShareTabBar) : void
        {
            var _loc_2:* = this._74922237shareTabBar;
            if (_loc_2 !== param1)
            {
                this._74922237shareTabBar = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "shareTabBar", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get shareViews() : ViewStack
        {
            return this._1796608561shareViews;
        }// end function

        public function set shareViews(param1:ViewStack) : void
        {
            var _loc_2:* = this._1796608561shareViews;
            if (_loc_2 !== param1)
            {
                this._1796608561shareViews = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "shareViews", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get showLogin() : Resize
        {
            return this._1921025428showLogin;
        }// end function

        public function set showLogin(param1:Resize) : void
        {
            var _loc_2:* = this._1921025428showLogin;
            if (_loc_2 !== param1)
            {
                this._1921025428showLogin = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showLogin", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get tileImageHolder() : Container
        {
            return this._708497575tileImageHolder;
        }// end function

        public function set tileImageHolder(param1:Container) : void
        {
            var _loc_2:* = this._708497575tileImageHolder;
            if (_loc_2 !== param1)
            {
                this._708497575tileImageHolder = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tileImageHolder", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get tileOver() : Canvas
        {
            return this._2106131294tileOver;
        }// end function

        public function set tileOver(param1:Canvas) : void
        {
            var _loc_2:* = this._2106131294tileOver;
            if (_loc_2 !== param1)
            {
                this._2106131294tileOver = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tileOver", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get twitter() : VBox
        {
            return this._916346253twitter;
        }// end function

        public function set twitter(param1:VBox) : void
        {
            var _loc_2:* = this._916346253twitter;
            if (_loc_2 !== param1)
            {
                this._916346253twitter = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "twitter", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get twitter_loader() : LoadingIndicator
        {
            return this._1451791521twitter_loader;
        }// end function

        public function set twitter_loader(param1:LoadingIndicator) : void
        {
            var _loc_2:* = this._1451791521twitter_loader;
            if (_loc_2 !== param1)
            {
                this._1451791521twitter_loader = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "twitter_loader", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get twitter_message() : AutosizeTextArea
        {
            return this._1437585861twitter_message;
        }// end function

        public function set twitter_message(param1:AutosizeTextArea) : void
        {
            var _loc_2:* = this._1437585861twitter_message;
            if (_loc_2 !== param1)
            {
                this._1437585861twitter_message = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "twitter_message", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get txtEmbedCode() : AdvancedTextArea
        {
            return this._476674006txtEmbedCode;
        }// end function

        public function set txtEmbedCode(param1:AdvancedTextArea) : void
        {
            var _loc_2:* = this._476674006txtEmbedCode;
            if (_loc_2 !== param1)
            {
                this._476674006txtEmbedCode = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "txtEmbedCode", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get txtFrom() : ValidationTextInput
        {
            return this._878930374txtFrom;
        }// end function

        public function set txtFrom(param1:ValidationTextInput) : void
        {
            var _loc_2:* = this._878930374txtFrom;
            if (_loc_2 !== param1)
            {
                this._878930374txtFrom = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "txtFrom", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get txtMessage() : AdvancedTextArea
        {
            return this._544786569txtMessage;
        }// end function

        public function set txtMessage(param1:AdvancedTextArea) : void
        {
            var _loc_2:* = this._544786569txtMessage;
            if (_loc_2 !== param1)
            {
                this._544786569txtMessage = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "txtMessage", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get txtPlainLink() : AdvancedTextInput
        {
            return this._436788140txtPlainLink;
        }// end function

        public function set txtPlainLink(param1:AdvancedTextInput) : void
        {
            var _loc_2:* = this._436788140txtPlainLink;
            if (_loc_2 !== param1)
            {
                this._436788140txtPlainLink = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "txtPlainLink", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get txtTo() : ValidationTextInput
        {
            return this._110817547txtTo;
        }// end function

        public function set txtTo(param1:ValidationTextInput) : void
        {
            var _loc_2:* = this._110817547txtTo;
            if (_loc_2 !== param1)
            {
                this._110817547txtTo = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "txtTo", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get username() : AdvancedTextInput
        {
            return this._265713450username;
        }// end function

        public function set username(param1:AdvancedTextInput) : void
        {
            var _loc_2:* = this._265713450username;
            if (_loc_2 !== param1)
            {
                this._265713450username = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "username", _loc_2, param1));
                }
            }
            return;
        }// end function

        private function get shareTabs() : Array
        {
            return this._1582043139shareTabs;
        }// end function

        private function set shareTabs(param1:Array) : void
        {
            var _loc_2:* = this._1582043139shareTabs;
            if (_loc_2 !== param1)
            {
                this._1582043139shareTabs = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "shareTabs", _loc_2, param1));
                }
            }
            return;
        }// end function

        private function get user() : User
        {
            return this._3599307user;
        }// end function

        private function set user(param1:User) : void
        {
            var _loc_2:* = this._3599307user;
            if (_loc_2 !== param1)
            {
                this._3599307user = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "user", _loc_2, param1));
                }
            }
            return;
        }// end function

        private function get _selectionModel() : ProductSelectorModel
        {
            return this._659939556_selectionModel;
        }// end function

        private function set _selectionModel(param1:ProductSelectorModel) : void
        {
            var _loc_2:* = this._659939556_selectionModel;
            if (_loc_2 !== param1)
            {
                this._659939556_selectionModel = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_selectionModel", _loc_2, param1));
                }
            }
            return;
        }// end function

        private function get mailSendInProgress() : Boolean
        {
            return this._1565776463mailSendInProgress;
        }// end function

        private function set mailSendInProgress(param1:Boolean) : void
        {
            var _loc_2:* = this._1565776463mailSendInProgress;
            if (_loc_2 !== param1)
            {
                this._1565776463mailSendInProgress = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mailSendInProgress", _loc_2, param1));
                }
            }
            return;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
        {
            _watcherSetupUtil = param1;
            return;
        }// end function

    }
}
