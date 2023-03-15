package net.sprd.components.designselector
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import mx.managers.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.components.common.*;
    import net.sprd.components.common.categoryselector.*;
    import net.sprd.components.common.paging.*;
    import net.sprd.components.common.palette.*;
    import net.sprd.entities.*;
    import net.sprd.events.*;
    import net.sprd.models.common.*;
    import net.sprd.models.product.*;
    import net.sprd.services.externalapi.*;
    import net.sprd.services.image.*;
    import net.sprd.services.image.model.*;
    import net.sprd.skins.d2c.buttons.*;

    public class DesignSelector extends Canvas implements IBindingClient
    {
        public var _DesignSelector_Canvas10:Canvas;
        public var _DesignSelector_Canvas11:Canvas;
        public var _DesignSelector_Canvas12:Canvas;
        public var _DesignSelector_Canvas13:Canvas;
        public var _DesignSelector_Canvas2:Canvas;
        public var _DesignSelector_Canvas3:Canvas;
        public var _DesignSelector_Canvas4:Canvas;
        public var _DesignSelector_Canvas5:Canvas;
        public var _DesignSelector_Canvas6:Canvas;
        public var _DesignSelector_Canvas7:Canvas;
        public var _DesignSelector_Canvas8:Canvas;
        public var _DesignSelector_Canvas9:Canvas;
        public var _DesignSelector_HBox1:HBox;
        public var _DesignSelector_Paging1:Paging;
        private var _1367706280canvas:Canvas;
        private var _1296516636categories:CategorySelector;
        private var _1724546052description:TextArea;
        private var _29698180designList:DesignTileList;
        private var _29646487designName:Label;
        private var _916691413designPrice:Label;
        private var _2047223786designerName:Label;
        private var _1773741241fadeInInfoCanvas:Fade;
        private var _2026090255fadeInTile:Fade;
        private var _1842474888fadeOutInfoCanvas:Fade;
        private var _356328192fadeOutTile:Fade;
        private var _1004035066hideWarning:Resize;
        private var _1945385533infoBox:VBox;
        private var _1302741632infoButton:Button;
        private var _411753817infoImageHolder:UIComponent;
        private var _787717913overImage:Container;
        private var _798910853palette:Palette;
        private var _906336856search:AdvancedTextInput;
        private var _365389062searchButton:ProgressButton;
        private var _1512605151showWarning:Resize;
        private var _2106131294tileOver:Canvas;
        private var _1124446108warning:Text;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;
        private var designIdLabel:Label;
        private var _1541599668_designModel:DesignSelectorModel;
        public var bus:IEventDispatcher;
        public var externalAPI:IExternalAPI;
        public var productModel:IProductModel;
        private var descriptionImage:CachedImage;
        private var _errorTip:ToolTip;
        private var _337373347showDesignSearch:Boolean = true;
        private var _942447407allowDesignsOnPrintArea:Boolean = true;
        private var allowDesignsOnPrintAreaInitialized:Boolean;
        private var progressIndicator:Class;
        private var cache:Object;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static const log:ILogger = LogContext.getLogger(this);
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function DesignSelector()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, events:{creationComplete:"___DesignSelector_Canvas1_creationComplete"}, propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Palette, id:"palette", events:{mouseOut:"__palette_mouseOut"}, propertiesFactory:function () : Object
                {
                    return {width:270, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", left:10, children:[_DesignSelector_Canvas2_i(), _DesignSelector_HBox1_i(), _DesignSelector_Canvas5_i(), _DesignSelector_CategorySelector1_i(), _DesignSelector_Canvas8_i(), _DesignSelector_Text1_i(), _DesignSelector_Canvas11_i(), _DesignSelector_DesignTileList1_i(), _DesignSelector_Paging1_i()]};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"tileOver", events:{click:"__tileOver_click", rollOut:"__tileOver_rollOut"}, propertiesFactory:function () : Object
                {
                    return {width:98, height:98, styleName:"tileOver", visible:false, childDescriptors:[new UIComponentDescriptor({type:Container, id:"overImage", propertiesFactory:function () : Object
                    {
                        return {width:75, height:75, x:11.5, y:11.5, mouseEnabled:false, horizontalScrollPolicy:"off", verticalScrollPolicy:"off"};
                    }// end function
                    }), new UIComponentDescriptor({type:Button, id:"infoButton", events:{rollOver:"__infoButton_rollOver", rollOut:"__infoButton_rollOut"}, propertiesFactory:function () : Object
                    {
                        return {width:16, height:16, bottom:5, right:6, styleName:"infoButton"};
                    }// end function
                    })]};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"canvas", propertiesFactory:function () : Object
                {
                    return {width:380, height:178, styleName:"description", includeInLayout:false, y:0, x:200, visible:false, mouseChildren:false, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", childDescriptors:[new UIComponentDescriptor({type:UIComponent, id:"infoImageHolder", propertiesFactory:function () : Object
                    {
                        return {x:6, y:10, width:120, height:120};
                    }// end function
                    }), new UIComponentDescriptor({type:VBox, id:"infoBox", stylesFactory:function () : void
                    {
                        this.paddingTop = 12;
                        this.verticalGap = 0;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {x:110, percentHeight:100, percentWidth:100, childDescriptors:[new UIComponentDescriptor({type:Label, id:"designName", propertiesFactory:function () : Object
                        {
                            return {styleName:"descriptionHead", width:250, height:18, truncateToFit:true};
                        }// end function
                        }), new UIComponentDescriptor({type:Label, id:"designerName", propertiesFactory:function () : Object
                        {
                            return {styleName:"descriptionSubHead", width:250, truncateToFit:true};
                        }// end function
                        }), new UIComponentDescriptor({type:TextArea, id:"description", propertiesFactory:function () : Object
                        {
                            return {width:250, styleName:"descriptionText", verticalScrollPolicy:"off", horizontalScrollPolicy:"off"};
                        }// end function
                        }), new UIComponentDescriptor({type:Label, id:"designPrice", stylesFactory:function () : void
                        {
                            this.fontSize = 16;
                            return;
                        }// end function
                        , propertiesFactory:function () : Object
                        {
                            return {styleName:"prizeFormat"};
                        }// end function
                        })]};
                    }// end function
                    })]};
                }// end function
                })]};
            }// end function
            });
            this._1541599668_designModel = new DesignSelectorModel();
            this.progressIndicator = DesignSelector_progressIndicator;
            this.cache = {};
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            var bindings:* = this._DesignSelector_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_net_sprd_components_designselector_DesignSelectorWatcherSetupUtil");
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
            this._DesignSelector_Fade3_i();
            this._DesignSelector_Fade1_i();
            this._DesignSelector_Fade4_i();
            this._DesignSelector_Fade2_i();
            this._DesignSelector_Resize2_i();
            this._DesignSelector_Resize1_i();
            this.addEventListener("creationComplete", this.___DesignSelector_Canvas1_creationComplete);
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
            return;
        }// end function

        override public function initialize() : void
        {
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            super.initialize();
            return;
        }// end function

        public function postConstruct() : void
        {
            this._designModel.product = this.productModel;
            return;
        }// end function

        public function get designModel() : DesignSelectorModel
        {
            return this._designModel;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.designIdLabel = new Label();
            this.infoBox.addChild(this.designIdLabel);
            if (ConfomatConfiguration.shopID == "622775")
            {
            }
            if (ConfomatConfiguration.platform == ConfomatConfiguration.PLATFORM_EU)
            {
                this.designPrice.visible = false;
            }
            return;
        }// end function

        private function init() : void
        {
            this.palette.closeButton.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent) : void
            {
                endEffectsStarted();
                visible = false;
                return;
            }// end function
            );
            this._designModel.addEventListener("searchFault", this.onSearchEmpty);
            this._designModel.addEventListener("searchBackendDesignFault", this.onBackendDesignSearchFailure);
            this._designModel.addEventListener("searchComplete", this.onSearchComplete);
            this._designModel.addEventListener("pageChanged", this.updateAvailability);
            this._designModel.addEventListener("currentDesignChanged", this.updateDescription);
            return;
        }// end function

        private function loadImage(param1:IDesign) : void
        {
            var spinner:Sprite;
            var container:UIComponent;
            var value:* = param1;
            while (this.overImage.numChildren > 0)
            {
                
                this.overImage.removeChildAt(0);
            }
            while (this.infoImageHolder.numChildren > 0)
            {
                
                this.infoImageHolder.removeChildAt(0);
            }
            var infoID:* = value.id + "_" + "100";
            if (!this.cache[infoID])
            {
                this.descriptionImage = ImageService.getInstance().designImage(value.imageId, 100, 100);
                this.cache[infoID] = this.descriptionImage;
                with ({})
                {
                    {}.infoImage_faultHandler = function (param1:IOErrorEvent) : void
            {
                while (infoImageHolder.numChildren > 0)
                {
                    
                    infoImageHolder.removeChildAt(0);
                }
                while (overImage.numChildren > 0)
                {
                    
                    overImage.removeChildAt(0);
                }
                return;
            }// end function
            ;
                }
                EventUtil.registerOnetimeListeners(this.descriptionImage, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [this.descriptionImage_completeHandler, function (param1:IOErrorEvent) : void
            {
                while (infoImageHolder.numChildren > 0)
                {
                    
                    infoImageHolder.removeChildAt(0);
                }
                while (overImage.numChildren > 0)
                {
                    
                    overImage.removeChildAt(0);
                }
                return;
            }// end function
            ]);
                this.descriptionImage.load();
            }
            else
            {
                this.descriptionImage = this.cache[infoID];
            }
            if (!this.descriptionImage.isLoaded)
            {
                spinner = new this.progressIndicator() as Sprite;
                spinner.mouseEnabled = false;
                spinner.mouseChildren = false;
                spinner.name = "spinner";
                container = new UIComponent();
                container.addChild(spinner);
                container.x = this.infoImageHolder.width / 2;
                container.y = this.infoImageHolder.height / 2;
                this.infoImageHolder.addChild(container);
                spinner = new this.progressIndicator() as Sprite;
                spinner.mouseEnabled = false;
                spinner.mouseChildren = false;
                spinner.name = "spinner";
                container = new UIComponent();
                container.addChild(spinner);
                container.x = this.overImage.width / 2;
                container.y = this.overImage.height / 2;
                this.overImage.addChild(container);
                this.overImage.visible = true;
            }
            else
            {
                this.descriptionImage_completeHandler(null);
            }
            return;
        }// end function

        private function updateDescription(param1:Event) : void
        {
            this.description.text = "";
            if (!this._designModel.currentDesign)
            {
                return;
            }
            if (this._designModel.currentDesigner)
            {
            }
            if (this._designModel.currentDesigner.state == EntityState.LOADED)
            {
            }
            if (this._designModel.currentDesigner.name)
            {
                this.designerName.text = resourceManager.getString("confomat7", "design_gallery.designed_by") + " " + this._designModel.currentDesigner.name;
            }
            else
            {
                this.designerName.text = "";
            }
            var _loc_2:* = this._designModel.currentDesign;
            this.designName.text = StringUtil.ucwords(_loc_2.name);
            this.description.text = _loc_2.description;
            this.designIdLabel.text = _loc_2.id;
            var _loc_3:* = CurrencyFormatterFactory.createCurrencyFormatter(this._designModel.currentDesign.price.currency).format(this._designModel.priceTotal.amount);
            this.designPrice.text = resourceManager.getString("confomat7", "design_gallery.price_from") + " " + _loc_3;
            return;
        }// end function

        private function infoButton_onRollOver(param1:Event) : void
        {
            if (this.tileOver.visible)
            {
            }
            if (!this.fadeInTile.isPlaying)
            {
                this.canvas.x = this.tileOver.x + this.infoButton.x - 80;
                this.canvas.y = this.tileOver.y + this.infoButton.y - this.canvas.height;
                if (!this.canvas.visible)
                {
                    this.canvas.endEffectsStarted();
                    this.canvas.visible = true;
                    this.fadeInInfoCanvas.play([this.canvas]);
                }
            }
            return;
        }// end function

        private function infoButton_onRollOut(param1:Event) : void
        {
            if (this.canvas.visible)
            {
                this.canvas.endEffectsStarted();
                this.fadeOutInfoCanvas.play([this.canvas]);
            }
            return;
        }// end function

        private function onItemRollOver(param1:ListEvent) : void
        {
            var _loc_3:Point;
            this._designModel.currentDesign = IDesign(param1.itemRenderer.data);
            this.updateDescription(null);
            this.overImage.endEffectsStarted();
            this.overImage.visible = false;
            var _loc_2:* = this.designList.designConstraints[this._designModel.currentDesign.id];
            if (_loc_2)
            {
            }
            if (!_loc_2.isUsable)
            {
                if (this.tileOver.visible)
                {
                    this.tileOver.endEffectsStarted();
                    this.fadeOutTile.play([this.tileOver]);
                }
                this.resetTips();
                _loc_3 = DesignRenderer(param1.itemRenderer).getBounds(this).bottomRight;
                _loc_3.x = _loc_3.x - param1.itemRenderer.width / 2;
                _loc_3 = localToGlobal(_loc_3);
                this._errorTip = ToolTipManager.createToolTip(_loc_2.toString(), _loc_3.x, _loc_3.y, "errorTipBelow") as ToolTip;
                return;
            }
            this.loadImage(this._designModel.currentDesign);
            this.tileOver.x = param1.itemRenderer.x + 11 - (this.tileOver.width - param1.itemRenderer.width) * 0.5;
            this.tileOver.y = param1.itemRenderer.y + this.designList.y - (this.tileOver.height - param1.itemRenderer.height) * 0.5;
            this.tileOver.endEffectsStarted();
            if (!this.tileOver.visible)
            {
                this.fadeInTile.play([this.tileOver]);
            }
            return;
        }// end function

        private function onItemRollOut(param1:ListEvent) : void
        {
            this.resetTips();
            return;
        }// end function

        private function tileOver_rollOutHandler(param1:MouseEvent) : void
        {
            var _loc_2:* = this.designList.getBounds(this);
            _loc_2.right = _loc_2.right - 20;
            var _loc_3:* = globalToContent(new Point(param1.stageX, param1.stageY));
            if (!_loc_2.containsPoint(_loc_3))
            {
                this.tileOver.endEffectsStarted();
                this.fadeOutTile.play([this.tileOver]);
                this.resetTips();
            }
            return;
        }// end function

        private function designList_itemClickHandler(param1:ListEvent) : void
        {
            this.pickDesign(IDesign(DesignRenderer(param1.itemRenderer).data));
            return;
        }// end function

        private function tileOver_clickHandler(param1:Event) : void
        {
            this.pickDesign(this._designModel.currentDesign);
            return;
        }// end function

        private function pickDesign(param1:IDesign) : void
        {
            var design:* = param1;
            this.canvas.endEffectsStarted();
            this.canvas.visible = false;
            this._designModel.currentDesign = design;
            this.designList.selectedItem = design;
            if (!this.designList.designConstraints[design.id].isUsable)
            {
                return;
            }
            with ({})
            {
                {}.complete = function () : void
            {
                bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(productModel));
                return;
            }// end function
            ;
            }
            this.productModel.addDesignConfiguration(design, null, null, null, true, true, function () : void
            {
                bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(productModel));
                return;
            }// end function
            );
            this.externalAPI.onDesignChanged(design);
            return;
        }// end function

        public function doSearch(param1:Event) : void
        {
            if (this.searchButton.isInProgress)
            {
                return;
            }
            if (ConfomatConfiguration.mode == ConfomatModes.ADMIN)
            {
                if (this.search.text != this.search.defaultText)
                {
                }
                if (this.search.text == "")
                {
                    return;
                }
            }
            this.searchButton.isInProgress = true;
            if (this.search.text == this.search.defaultText)
            {
                this._designModel.searchTerm = "";
            }
            else
            {
                this._designModel.searchTerm = this.search.text;
            }
            return;
        }// end function

        private function descriptionImage_completeHandler(param1:Event) : void
        {
            while (this.overImage.numChildren > 0)
            {
                
                this.overImage.removeChildAt(0);
            }
            var _loc_2:* = this.descriptionImage.getBounds(null);
            var _loc_3:* = new Rectangle(0, 0, this.overImage.width, this.overImage.height);
            BoundsUtil.trimBoundsProportionally(_loc_2, _loc_3);
            this.descriptionImage.width = _loc_2.width;
            this.descriptionImage.height = _loc_2.height;
            this.descriptionImage.x = (this.overImage.width - this.descriptionImage.width) / 2;
            this.descriptionImage.y = (this.overImage.height - this.descriptionImage.height) / 2;
            this.overImage.addChild(this.descriptionImage);
            this.overImage.endEffectsStarted();
            this.overImage.visible = true;
            var _loc_4:* = ConfigurationImage(this.descriptionImage).duplicate();
            _loc_2 = _loc_4.getBounds(_loc_4);
            _loc_3 = new Rectangle(0, 0, 100, 100);
            BoundsUtil.trimBoundsProportionally(_loc_2, _loc_3);
            while (this.infoImageHolder.numChildren > 0)
            {
                
                this.infoImageHolder.removeChildAt(0);
            }
            _loc_4.width = _loc_2.width;
            _loc_4.height = _loc_2.height;
            this.infoImageHolder.addChild(_loc_4);
            return;
        }// end function

        private function onSearchEmpty(param1:Event) : void
        {
            this.searchButton.isInProgress = false;
            this.resetTips();
            var _loc_2:* = this.search.getBounds(systemManager.stage);
            var _loc_3:* = resourceManager.getString("confomat7", "messages_system.no_search_result");
            this._errorTip = ToolTipManager.createToolTip(_loc_3, _loc_2.left, _loc_2.bottom, "errorTipBelow") as ToolTip;
            this._errorTip.minWidth = this.search.width;
            var _loc_4:* = new Timer(FXDefaults.ERROR_TIP_DISPLAY_DURATION, 1);
            _loc_4.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            _loc_4.start();
            return;
        }// end function

        private function onBackendDesignSearchFailure(param1:Event) : void
        {
            Alert.show("Can not find a design with specified id ", "Design not found", Alert.OK, null, null);
            return;
        }// end function

        private function onSearchComplete(param1:Event) : void
        {
            this.searchButton.isInProgress = false;
            return;
        }// end function

        private function resetTips() : void
        {
            if (this._errorTip)
            {
                ToolTipManager.destroyToolTip(this._errorTip);
                this._errorTip = null;
            }
            return;
        }// end function

        private function onTimerComplete(param1:TimerEvent) : void
        {
            Timer(param1.target).removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            this.search.text = "";
            stage.focus = null;
            this.resetTips();
            return;
        }// end function

        protected function onMouseOut(param1:MouseEvent) : void
        {
            var _loc_2:* = new Point(param1.stageX, param1.stageY);
            if (getObjectsUnderPoint(_loc_2).indexOf(this.palette) == -1)
            {
                this.tileOver.endEffectsStarted();
                this.fadeOutTile.play([this.tileOver]);
                this.resetTips();
            }
            return;
        }// end function

        public function updateAvailability(param1:Event) : void
        {
            var _loc_3:IDesign;
            var _loc_2:* = new Dictionary();
            if (!this._designModel)
            {
                return;
            }
            for each (_loc_3 in this._designModel.designs)
            {
                
                if (!_loc_3)
                {
                    continue;
                }
                _loc_2[_loc_3.id] = this.productModel.canAddDesign(_loc_3);
            }
            this.designList.designConstraints = _loc_2;
            this.tileOver.endEffectsStarted();
            this.tileOver.visible = false;
            invalidateDisplayList();
            return;
        }// end function

        public function bus_productTypeOrViewChanged(param1:Event)
        {
            if (this.productModel)
            {
            }
            if (this.productModel.currentPrintArea)
            {
            }
            var _loc_2:* = this.productModel.currentPrintArea.allowsDesign;
            if (this.allowDesignsOnPrintAreaInitialized)
            {
            }
            if (_loc_2 != this.allowDesignsOnPrintArea)
            {
                this.warning.endEffectsStarted();
                this.allowDesignsOnPrintAreaInitialized = true;
                this.allowDesignsOnPrintArea = _loc_2;
                if (!this.allowDesignsOnPrintArea)
                {
                    this.showWarning.heightTo = this.warning.measuredHeight;
                    this.showWarning.play();
                }
                else
                {
                    this.hideWarning.heightFrom = this.warning.measuredHeight;
                    this.hideWarning.play();
                }
            }
            return;
        }// end function

        protected function onSearchReset(param1:Event) : void
        {
            this.doSearch(param1);
            return;
        }// end function

        private function _DesignSelector_Fade3_i() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaFrom = 0;
            _loc_1.alphaTo = 1;
            _loc_1.duration = 300;
            _loc_1.addEventListener("effectStart", this.__fadeInInfoCanvas_effectStart);
            this.fadeInInfoCanvas = _loc_1;
            BindingManager.executeBindings(this, "fadeInInfoCanvas", this.fadeInInfoCanvas);
            return _loc_1;
        }// end function

        public function __fadeInInfoCanvas_effectStart(param1:EffectEvent) : void
        {
            DisplayObject(param1.effectInstance.mx.effects:IEffectInstance::target).visible = true;
            return;
        }// end function

        private function _DesignSelector_Fade1_i() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaFrom = 0;
            _loc_1.alphaTo = 1;
            _loc_1.duration = 300;
            _loc_1.addEventListener("effectStart", this.__fadeInTile_effectStart);
            this.fadeInTile = _loc_1;
            BindingManager.executeBindings(this, "fadeInTile", this.fadeInTile);
            return _loc_1;
        }// end function

        public function __fadeInTile_effectStart(param1:EffectEvent) : void
        {
            DisplayObject(param1.effectInstance.mx.effects:IEffectInstance::target).visible = true;
            return;
        }// end function

        private function _DesignSelector_Fade4_i() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaFrom = 1;
            _loc_1.alphaTo = 0;
            _loc_1.duration = 300;
            _loc_1.addEventListener("effectEnd", this.__fadeOutInfoCanvas_effectEnd);
            this.fadeOutInfoCanvas = _loc_1;
            BindingManager.executeBindings(this, "fadeOutInfoCanvas", this.fadeOutInfoCanvas);
            return _loc_1;
        }// end function

        public function __fadeOutInfoCanvas_effectEnd(param1:EffectEvent) : void
        {
            DisplayObject(param1.effectInstance.mx.effects:IEffectInstance::target).visible = false;
            return;
        }// end function

        private function _DesignSelector_Fade2_i() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaFrom = 1;
            _loc_1.alphaTo = 0;
            _loc_1.duration = 300;
            _loc_1.addEventListener("effectEnd", this.__fadeOutTile_effectEnd);
            this.fadeOutTile = _loc_1;
            BindingManager.executeBindings(this, "fadeOutTile", this.fadeOutTile);
            return _loc_1;
        }// end function

        public function __fadeOutTile_effectEnd(param1:EffectEvent) : void
        {
            DisplayObject(param1.effectInstance.mx.effects:IEffectInstance::target).visible = false;
            return;
        }// end function

        private function _DesignSelector_Resize2_i() : Resize
        {
            var _loc_1:* = new Resize();
            _loc_1.heightTo = 0;
            _loc_1.duration = 300;
            _loc_1.addEventListener("effectEnd", this.__hideWarning_effectEnd);
            this.hideWarning = _loc_1;
            BindingManager.executeBindings(this, "hideWarning", this.hideWarning);
            return _loc_1;
        }// end function

        public function __hideWarning_effectEnd(param1:EffectEvent) : void
        {
            DisplayObject(param1.effectInstance.mx.effects:IEffectInstance::target).visible = false;
            return;
        }// end function

        private function _DesignSelector_Resize1_i() : Resize
        {
            var _loc_1:* = new Resize();
            _loc_1.heightFrom = 0;
            _loc_1.duration = 300;
            _loc_1.addEventListener("effectStart", this.__showWarning_effectStart);
            this.showWarning = _loc_1;
            BindingManager.executeBindings(this, "showWarning", this.showWarning);
            return _loc_1;
        }// end function

        public function __showWarning_effectStart(param1:EffectEvent) : void
        {
            DisplayObject(param1.effectInstance.mx.effects:IEffectInstance::target).visible = true;
            return;
        }// end function

        public function ___DesignSelector_Canvas1_creationComplete(param1:FlexEvent) : void
        {
            this.init();
            return;
        }// end function

        private function _DesignSelector_Canvas2_i() : Canvas
        {
            var temp:* = new Canvas();
            temp.height = 2;
            temp.x = 1;
            temp.id = "_DesignSelector_Canvas2";
            if (!temp.document)
            {
                temp.document = this;
            }
            mx_internal::_documentDescriptor = new UIComponentDescriptor({type:Canvas, id:"_DesignSelector_Canvas2", propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"_DesignSelector_Canvas3", stylesFactory:function () : void
                {
                    this.backgroundColor = 15395303;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {height:1, x:1, y:0};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"_DesignSelector_Canvas4", stylesFactory:function () : void
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
            this._DesignSelector_Canvas2 = temp;
            BindingManager.executeBindings(this, "_DesignSelector_Canvas2", this._DesignSelector_Canvas2);
            return temp;
        }// end function

        private function _DesignSelector_HBox1_i() : HBox
        {
            var temp:* = new HBox();
            temp.width = 270;
            temp.setStyle("horizontalGap", 2);
            temp.setStyle("paddingLeft", 5);
            temp.id = "_DesignSelector_HBox1";
            if (!temp.document)
            {
                temp.document = this;
            }
            mx_internal::_documentDescriptor = new UIComponentDescriptor({type:HBox, id:"_DesignSelector_HBox1", stylesFactory:function () : void
            {
                this.horizontalGap = 2;
                this.paddingLeft = 5;
                return;
            }// end function
            , propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:AdvancedTextInput, id:"search", events:{enter:"__search_enter", onReset:"__search_onReset"}, propertiesFactory:function () : Object
                {
                    return {width:170, height:20, hasReset:true};
                }// end function
                }), new UIComponentDescriptor({type:ProgressButton, id:"searchButton", events:{click:"__searchButton_click"}, stylesFactory:function () : void
                {
                    this.fontSize = 12;
                    this.textAlign = "center";
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {width:88, height:20};
                }// end function
                })]};
            }// end function
            });
            mx_internal::_documentDescriptor.document = this;
            this._DesignSelector_HBox1 = temp;
            BindingManager.executeBindings(this, "_DesignSelector_HBox1", this._DesignSelector_HBox1);
            return temp;
        }// end function

        public function __search_enter(param1:FlexEvent) : void
        {
            this.doSearch(param1);
            return;
        }// end function

        public function __search_onReset(param1:Event) : void
        {
            this.onSearchReset(param1);
            return;
        }// end function

        public function __searchButton_click(param1:MouseEvent) : void
        {
            this.doSearch(param1);
            return;
        }// end function

        private function _DesignSelector_Canvas5_i() : Canvas
        {
            var temp:* = new Canvas();
            temp.x = 1;
            temp.id = "_DesignSelector_Canvas5";
            if (!temp.document)
            {
                temp.document = this;
            }
            mx_internal::_documentDescriptor = new UIComponentDescriptor({type:Canvas, id:"_DesignSelector_Canvas5", propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"_DesignSelector_Canvas6", stylesFactory:function () : void
                {
                    this.backgroundColor = 15395303;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {height:1, x:1, y:0};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"_DesignSelector_Canvas7", stylesFactory:function () : void
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
            this._DesignSelector_Canvas5 = temp;
            BindingManager.executeBindings(this, "_DesignSelector_Canvas5", this._DesignSelector_Canvas5);
            return temp;
        }// end function

        private function _DesignSelector_CategorySelector1_i() : CategorySelector
        {
            var _loc_1:* = new CategorySelector();
            _loc_1.width = 269;
            _loc_1.height = 25;
            _loc_1.x = 1;
            _loc_1.id = "categories";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this.categories = _loc_1;
            BindingManager.executeBindings(this, "categories", this.categories);
            return _loc_1;
        }// end function

        private function _DesignSelector_Canvas8_i() : Canvas
        {
            var temp:* = new Canvas();
            temp.height = 2;
            temp.x = 1;
            temp.id = "_DesignSelector_Canvas8";
            if (!temp.document)
            {
                temp.document = this;
            }
            mx_internal::_documentDescriptor = new UIComponentDescriptor({type:Canvas, id:"_DesignSelector_Canvas8", propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"_DesignSelector_Canvas9", stylesFactory:function () : void
                {
                    this.backgroundColor = 15395303;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {height:1, x:1, y:0};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"_DesignSelector_Canvas10", stylesFactory:function () : void
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
            this._DesignSelector_Canvas8 = temp;
            BindingManager.executeBindings(this, "_DesignSelector_Canvas8", this._DesignSelector_Canvas8);
            return temp;
        }// end function

        private function _DesignSelector_Text1_i() : Text
        {
            var _loc_1:* = new Text();
            _loc_1.selectable = false;
            _loc_1.visible = false;
            _loc_1.explicitWidth = 270;
            _loc_1.setStyle("fontWeight", "bold");
            _loc_1.setStyle("paddingLeft", 5);
            _loc_1.id = "warning";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this.warning = _loc_1;
            BindingManager.executeBindings(this, "warning", this.warning);
            return _loc_1;
        }// end function

        private function _DesignSelector_Canvas11_i() : Canvas
        {
            var temp:* = new Canvas();
            temp.height = 2;
            temp.x = 1;
            temp.id = "_DesignSelector_Canvas11";
            if (!temp.document)
            {
                temp.document = this;
            }
            mx_internal::_documentDescriptor = new UIComponentDescriptor({type:Canvas, id:"_DesignSelector_Canvas11", propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"_DesignSelector_Canvas12", stylesFactory:function () : void
                {
                    this.backgroundColor = 15395303;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {height:1, x:1, y:0};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"_DesignSelector_Canvas13", stylesFactory:function () : void
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
            this._DesignSelector_Canvas11 = temp;
            BindingManager.executeBindings(this, "_DesignSelector_Canvas11", this._DesignSelector_Canvas11);
            return temp;
        }// end function

        private function _DesignSelector_DesignTileList1_i() : DesignTileList
        {
            var _loc_1:* = new DesignTileList();
            _loc_1.name = "designListHolder";
            _loc_1.width = 270;
            _loc_1.height = 270;
            _loc_1.x = 1;
            _loc_1.itemRenderer = this._DesignSelector_ClassFactory1_c();
            _loc_1.columnCount = 3;
            _loc_1.rowCount = 3;
            _loc_1.columnWidth = 90;
            _loc_1.rowHeight = 90;
            _loc_1.horizontalScrollPolicy = "off";
            _loc_1.verticalScrollPolicy = "off";
            _loc_1.setStyle("paddingTop", 0);
            _loc_1.setStyle("paddingBottom", 0);
            _loc_1.addEventListener("itemRollOver", this.__designList_itemRollOver);
            _loc_1.addEventListener("itemRollOut", this.__designList_itemRollOut);
            _loc_1.addEventListener("itemClick", this.__designList_itemClick);
            _loc_1.id = "designList";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this.designList = _loc_1;
            BindingManager.executeBindings(this, "designList", this.designList);
            return _loc_1;
        }// end function

        private function _DesignSelector_ClassFactory1_c() : ClassFactory
        {
            var _loc_1:* = new ClassFactory();
            _loc_1.generator = DesignRenderer;
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        public function __designList_itemRollOver(param1:ListEvent) : void
        {
            this.onItemRollOver(param1);
            return;
        }// end function

        public function __designList_itemRollOut(param1:ListEvent) : void
        {
            this.onItemRollOut(param1);
            return;
        }// end function

        public function __designList_itemClick(param1:ListEvent) : void
        {
            this.designList_itemClickHandler(param1);
            return;
        }// end function

        private function _DesignSelector_Paging1_i() : Paging
        {
            var _loc_1:* = new Paging();
            _loc_1.width = 270;
            _loc_1.height = 30;
            _loc_1.id = "_DesignSelector_Paging1";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this._DesignSelector_Paging1 = _loc_1;
            BindingManager.executeBindings(this, "_DesignSelector_Paging1", this._DesignSelector_Paging1);
            return _loc_1;
        }// end function

        public function __palette_mouseOut(param1:MouseEvent) : void
        {
            this.onMouseOut(param1);
            return;
        }// end function

        public function __tileOver_click(param1:MouseEvent) : void
        {
            this.tileOver_clickHandler(param1);
            return;
        }// end function

        public function __tileOver_rollOut(param1:MouseEvent) : void
        {
            this.tileOver_rollOutHandler(param1);
            return;
        }// end function

        public function __infoButton_rollOver(param1:MouseEvent) : void
        {
            this.infoButton_onRollOver(param1);
            return;
        }// end function

        public function __infoButton_rollOut(param1:MouseEvent) : void
        {
            this.infoButton_onRollOut(param1);
            return;
        }// end function

        private function _DesignSelector_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, function () : Number
            {
                return warning.measuredHeight;
            }// end function
            , null, "showWarning.heightTo");
            result[1] = new Binding(this, null, null, "showWarning.target", "warning");
            result[2] = new Binding(this, function () : Number
            {
                return warning.measuredHeight;
            }// end function
            , null, "hideWarning.heightFrom");
            result[3] = new Binding(this, null, null, "hideWarning.target", "warning");
            result[4] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "design_gallery.label_section_header");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "palette.caption");
            result[5] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_DesignSelector_Canvas2.width");
            result[6] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_DesignSelector_Canvas3.width");
            result[7] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_DesignSelector_Canvas4.width");
            result[8] = new Binding(this, function () : Number
            {
                return showDesignSearch ? (25) : (0);
            }// end function
            , null, "_DesignSelector_HBox1.height");
            result[9] = new Binding(this, null, null, "_DesignSelector_HBox1.visible", "showDesignSearch");
            result[10] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "universal.label_searchbox");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "search.defaultText");
            result[11] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "universal.btn_search");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "searchButton.label");
            result[12] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "universal.btn_search");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "searchButton.progressLabel");
            result[13] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_DesignSelector_Canvas5.width");
            result[14] = new Binding(this, function () : Number
            {
                return showDesignSearch ? (2) : (0);
            }// end function
            , null, "_DesignSelector_Canvas5.height");
            result[15] = new Binding(this, null, null, "_DesignSelector_Canvas5.visible", "showDesignSearch");
            result[16] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_DesignSelector_Canvas6.width");
            result[17] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_DesignSelector_Canvas7.width");
            result[18] = new Binding(this, function () : ICategoryProvider
            {
                return _designModel;
            }// end function
            , null, "categories.dataProvider");
            result[19] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_DesignSelector_Canvas8.width");
            result[20] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_DesignSelector_Canvas9.width");
            result[21] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_DesignSelector_Canvas10.width");
            result[22] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "messages_system.printarea_disallow_designs");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "warning.text");
            result[23] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_DesignSelector_Canvas11.width");
            result[24] = new Binding(this, function () : Boolean
            {
                return !allowDesignsOnPrintArea;
            }// end function
            , null, "_DesignSelector_Canvas11.visible");
            result[25] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_DesignSelector_Canvas12.width");
            result[26] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_DesignSelector_Canvas13.width");
            result[27] = new Binding(this, function () : Object
            {
                return _designModel.designs;
            }// end function
            , null, "designList.dataProvider");
            result[28] = new Binding(this, function () : IPageable
            {
                return _designModel;
            }// end function
            , null, "_DesignSelector_Paging1.dataProvider");
            return result;
        }// end function

        public function get canvas() : Canvas
        {
            return this._1367706280canvas;
        }// end function

        public function set canvas(param1:Canvas) : void
        {
            var _loc_2:* = this._1367706280canvas;
            if (_loc_2 !== param1)
            {
                this._1367706280canvas = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canvas", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get categories() : CategorySelector
        {
            return this._1296516636categories;
        }// end function

        public function set categories(param1:CategorySelector) : void
        {
            var _loc_2:* = this._1296516636categories;
            if (_loc_2 !== param1)
            {
                this._1296516636categories = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "categories", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get description() : TextArea
        {
            return this._1724546052description;
        }// end function

        public function set description(param1:TextArea) : void
        {
            var _loc_2:* = this._1724546052description;
            if (_loc_2 !== param1)
            {
                this._1724546052description = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "description", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get designList() : DesignTileList
        {
            return this._29698180designList;
        }// end function

        public function set designList(param1:DesignTileList) : void
        {
            var _loc_2:* = this._29698180designList;
            if (_loc_2 !== param1)
            {
                this._29698180designList = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "designList", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get designName() : Label
        {
            return this._29646487designName;
        }// end function

        public function set designName(param1:Label) : void
        {
            var _loc_2:* = this._29646487designName;
            if (_loc_2 !== param1)
            {
                this._29646487designName = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "designName", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get designPrice() : Label
        {
            return this._916691413designPrice;
        }// end function

        public function set designPrice(param1:Label) : void
        {
            var _loc_2:* = this._916691413designPrice;
            if (_loc_2 !== param1)
            {
                this._916691413designPrice = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "designPrice", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get designerName() : Label
        {
            return this._2047223786designerName;
        }// end function

        public function set designerName(param1:Label) : void
        {
            var _loc_2:* = this._2047223786designerName;
            if (_loc_2 !== param1)
            {
                this._2047223786designerName = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "designerName", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get fadeInInfoCanvas() : Fade
        {
            return this._1773741241fadeInInfoCanvas;
        }// end function

        public function set fadeInInfoCanvas(param1:Fade) : void
        {
            var _loc_2:* = this._1773741241fadeInInfoCanvas;
            if (_loc_2 !== param1)
            {
                this._1773741241fadeInInfoCanvas = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fadeInInfoCanvas", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get fadeInTile() : Fade
        {
            return this._2026090255fadeInTile;
        }// end function

        public function set fadeInTile(param1:Fade) : void
        {
            var _loc_2:* = this._2026090255fadeInTile;
            if (_loc_2 !== param1)
            {
                this._2026090255fadeInTile = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fadeInTile", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get fadeOutInfoCanvas() : Fade
        {
            return this._1842474888fadeOutInfoCanvas;
        }// end function

        public function set fadeOutInfoCanvas(param1:Fade) : void
        {
            var _loc_2:* = this._1842474888fadeOutInfoCanvas;
            if (_loc_2 !== param1)
            {
                this._1842474888fadeOutInfoCanvas = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fadeOutInfoCanvas", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get fadeOutTile() : Fade
        {
            return this._356328192fadeOutTile;
        }// end function

        public function set fadeOutTile(param1:Fade) : void
        {
            var _loc_2:* = this._356328192fadeOutTile;
            if (_loc_2 !== param1)
            {
                this._356328192fadeOutTile = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fadeOutTile", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get hideWarning() : Resize
        {
            return this._1004035066hideWarning;
        }// end function

        public function set hideWarning(param1:Resize) : void
        {
            var _loc_2:* = this._1004035066hideWarning;
            if (_loc_2 !== param1)
            {
                this._1004035066hideWarning = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hideWarning", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get infoBox() : VBox
        {
            return this._1945385533infoBox;
        }// end function

        public function set infoBox(param1:VBox) : void
        {
            var _loc_2:* = this._1945385533infoBox;
            if (_loc_2 !== param1)
            {
                this._1945385533infoBox = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "infoBox", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get infoButton() : Button
        {
            return this._1302741632infoButton;
        }// end function

        public function set infoButton(param1:Button) : void
        {
            var _loc_2:* = this._1302741632infoButton;
            if (_loc_2 !== param1)
            {
                this._1302741632infoButton = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "infoButton", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get infoImageHolder() : UIComponent
        {
            return this._411753817infoImageHolder;
        }// end function

        public function set infoImageHolder(param1:UIComponent) : void
        {
            var _loc_2:* = this._411753817infoImageHolder;
            if (_loc_2 !== param1)
            {
                this._411753817infoImageHolder = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "infoImageHolder", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get overImage() : Container
        {
            return this._787717913overImage;
        }// end function

        public function set overImage(param1:Container) : void
        {
            var _loc_2:* = this._787717913overImage;
            if (_loc_2 !== param1)
            {
                this._787717913overImage = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "overImage", _loc_2, param1));
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

        public function get search() : AdvancedTextInput
        {
            return this._906336856search;
        }// end function

        public function set search(param1:AdvancedTextInput) : void
        {
            var _loc_2:* = this._906336856search;
            if (_loc_2 !== param1)
            {
                this._906336856search = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "search", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get searchButton() : ProgressButton
        {
            return this._365389062searchButton;
        }// end function

        public function set searchButton(param1:ProgressButton) : void
        {
            var _loc_2:* = this._365389062searchButton;
            if (_loc_2 !== param1)
            {
                this._365389062searchButton = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "searchButton", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get showWarning() : Resize
        {
            return this._1512605151showWarning;
        }// end function

        public function set showWarning(param1:Resize) : void
        {
            var _loc_2:* = this._1512605151showWarning;
            if (_loc_2 !== param1)
            {
                this._1512605151showWarning = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showWarning", _loc_2, param1));
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

        public function get warning() : Text
        {
            return this._1124446108warning;
        }// end function

        public function set warning(param1:Text) : void
        {
            var _loc_2:* = this._1124446108warning;
            if (_loc_2 !== param1)
            {
                this._1124446108warning = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "warning", _loc_2, param1));
                }
            }
            return;
        }// end function

        private function get _designModel() : DesignSelectorModel
        {
            return this._1541599668_designModel;
        }// end function

        private function set _designModel(param1:DesignSelectorModel) : void
        {
            var _loc_2:* = this._1541599668_designModel;
            if (_loc_2 !== param1)
            {
                this._1541599668_designModel = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_designModel", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get showDesignSearch() : Boolean
        {
            return this._337373347showDesignSearch;
        }// end function

        public function set showDesignSearch(param1:Boolean) : void
        {
            var _loc_2:* = this._337373347showDesignSearch;
            if (_loc_2 !== param1)
            {
                this._337373347showDesignSearch = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showDesignSearch", _loc_2, param1));
                }
            }
            return;
        }// end function

        private function get allowDesignsOnPrintArea() : Boolean
        {
            return this._942447407allowDesignsOnPrintArea;
        }// end function

        private function set allowDesignsOnPrintArea(param1:Boolean) : void
        {
            var _loc_2:* = this._942447407allowDesignsOnPrintArea;
            if (_loc_2 !== param1)
            {
                this._942447407allowDesignsOnPrintArea = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allowDesignsOnPrintArea", _loc_2, param1));
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
