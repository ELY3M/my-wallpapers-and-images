package net.sprd.components.producttypeselector
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import net.sprd.common.utils.*;
    import net.sprd.components.common.categoryselector.*;
    import net.sprd.components.common.gallerytilelist.*;
    import net.sprd.components.common.paging.*;
    import net.sprd.components.common.palette.*;
    import net.sprd.components.producttypeselector.sorting.*;
    import net.sprd.entities.*;
    import net.sprd.events.*;
    import net.sprd.models.common.*;
    import net.sprd.models.product.*;
    import net.sprd.models.product.rules.*;
    import net.sprd.services.image.*;
    import net.sprd.services.image.model.*;

    public class ProductTypeSelector extends Canvas implements IBindingClient
    {
        public var _ProductTypeSelector_Canvas10:Canvas;
        public var _ProductTypeSelector_Canvas2:Canvas;
        public var _ProductTypeSelector_Canvas3:Canvas;
        public var _ProductTypeSelector_Canvas4:Canvas;
        public var _ProductTypeSelector_Canvas5:Canvas;
        public var _ProductTypeSelector_Canvas6:Canvas;
        public var _ProductTypeSelector_Canvas7:Canvas;
        public var _ProductTypeSelector_Canvas8:Canvas;
        public var _ProductTypeSelector_Canvas9:Canvas;
        public var _ProductTypeSelector_CategorySelector1:CategorySelector;
        public var _ProductTypeSelector_Paging1:Paging;
        private var _93997959brand:Label;
        private var _1367706280canvas:Canvas;
        private var _1354842768colors:Tile;
        private var _1724546052description:Text;
        private var _1282133823fadeIn:Fade;
        private var _1091436750fadeOut:Fade;
        private var _1945385533infoBox:VBox;
        private var _1302741632infoButton:Button;
        private var _411753817infoImageHolder:Container;
        private var _798910853palette:Palette;
        private var _106934601price:Label;
        private var _1491817446productName:Label;
        private var _529770233productTypeList:GalleryTileList;
        private var _27458944sizeContainer:Canvas;
        private var _109453458sizes:HBox;
        private var _514065054sizesMask:HBox;
        private var _3536286sort:ProductTypeSort;
        private var _708497575tileImageHolder:Container;
        private var _2106131294tileOver:Canvas;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;
        private var _659939556_selectionModel:ProductTypeSelectorModel;
        public var productModel:IProductModel;
        public var bus:IEventDispatcher;
        private var progressIndicator:Class;
        private var _currentProductType:IProductType;
        private var _overImage:ProductTypeImage;
        private var infoImage:ProductTypeImage;
        private var _lastProductTypeID:String;
        private var productTypeIdLabel:Label;
        private var cache:Object;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function ProductTypeSelector()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, events:{preinitialize:"___ProductTypeSelector_Canvas1_preinitialize", creationComplete:"___ProductTypeSelector_Canvas1_creationComplete"}, propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Palette, id:"palette", events:{mouseOut:"__palette_mouseOut"}, propertiesFactory:function () : Object
                {
                    return {width:270, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", left:10, children:[_ProductTypeSelector_Canvas2_i(), _ProductTypeSelector_CategorySelector1_i(), _ProductTypeSelector_Canvas5_i(), _ProductTypeSelector_ProductTypeSort1_i(), _ProductTypeSelector_Canvas8_i(), _ProductTypeSelector_GalleryTileList1_i(), _ProductTypeSelector_Paging1_i()]};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"tileOver", events:{click:"__tileOver_click", rollOut:"__tileOver_rollOut"}, propertiesFactory:function () : Object
                {
                    return {width:98, height:98, styleName:"tileOver", visible:false, childDescriptors:[new UIComponentDescriptor({type:Container, id:"tileImageHolder", propertiesFactory:function () : Object
                    {
                        return {width:75, height:75, horizontalCenter:1, verticalCenter:0, mouseEnabled:false};
                    }// end function
                    }), new UIComponentDescriptor({type:Button, id:"infoButton", events:{rollOver:"__infoButton_rollOver", rollOut:"__infoButton_rollOut"}, propertiesFactory:function () : Object
                    {
                        return {width:16, height:16, bottom:5, right:6, styleName:"infoButton"};
                    }// end function
                    })]};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"canvas", propertiesFactory:function () : Object
                {
                    return {width:380, height:178, styleName:"description", includeInLayout:false, y:0, x:10, visible:false, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", childDescriptors:[new UIComponentDescriptor({type:Container, id:"infoImageHolder", propertiesFactory:function () : Object
                    {
                        return {x:6, y:10, width:130, height:130};
                    }// end function
                    }), new UIComponentDescriptor({type:Tile, id:"colors", stylesFactory:function () : void
                    {
                        this.horizontalGap = 0;
                        this.verticalGap = 0;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {width:100, bottom:32, left:6};
                    }// end function
                    }), new UIComponentDescriptor({type:VBox, id:"infoBox", stylesFactory:function () : void
                    {
                        this.paddingTop = 12;
                        this.verticalGap = 0;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {x:140, percentHeight:100, percentWidth:100, childDescriptors:[new UIComponentDescriptor({type:Label, id:"productName", propertiesFactory:function () : Object
                        {
                            return {styleName:"descriptionHead", width:230, height:18};
                        }// end function
                        }), new UIComponentDescriptor({type:Label, id:"brand", propertiesFactory:function () : Object
                        {
                            return {styleName:"descriptionSubHead", width:230};
                        }// end function
                        }), new UIComponentDescriptor({type:Text, id:"description", propertiesFactory:function () : Object
                        {
                            return {width:200, height:60, styleName:"descriptionText"};
                        }// end function
                        }), new UIComponentDescriptor({type:Canvas, id:"sizeContainer", propertiesFactory:function () : Object
                        {
                            return {percentWidth:100, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", childDescriptors:[new UIComponentDescriptor({type:HBox, id:"sizes", stylesFactory:function () : void
                            {
                                this.horizontalGap = 0;
                                return;
                            }// end function
                            , propertiesFactory:function () : Object
                            {
                                return {styleName:"descriptionSizeBg", top:4, left:4, verticalScrollPolicy:"off", horizontalScrollPolicy:"off"};
                            }// end function
                            }), new UIComponentDescriptor({type:HBox, id:"sizesMask", stylesFactory:function () : void
                            {
                                this.horizontalGap = 0;
                                return;
                            }// end function
                            , propertiesFactory:function () : Object
                            {
                                return {top:4, left:4};
                            }// end function
                            }), new UIComponentDescriptor({type:Label, id:"price", propertiesFactory:function () : Object
                            {
                                return {styleName:"prizeFormat", right:10, top:-6};
                            }// end function
                            })]};
                        }// end function
                        })]};
                    }// end function
                    })]};
                }// end function
                })]};
            }// end function
            });
            this.progressIndicator = ProductTypeSelector_progressIndicator;
            this.cache = {};
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            var bindings:* = this._ProductTypeSelector_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_net_sprd_components_producttypeselector_ProductTypeSelectorWatcherSetupUtil");
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
            this._ProductTypeSelector_Fade1_i();
            this._ProductTypeSelector_Fade2_i();
            this.addEventListener("preinitialize", this.___ProductTypeSelector_Canvas1_preinitialize);
            this.addEventListener("creationComplete", this.___ProductTypeSelector_Canvas1_creationComplete);
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

        private function init() : void
        {
            this._selectionModel = new ProductTypeSelectorModel();
            this._selectionModel.addEventListener(ProductTypeSelectorModel.PRODUCTTYPE_SELECTION_CHANGED, this.onProductTypeChanged);
            return;
        }// end function

        public function get selectionModel() : ProductTypeSelectorModel
        {
            return this._selectionModel;
        }// end function

        private function loadImages(param1:IProductType) : void
        {
            var infoID:*;
            var spinner:Sprite;
            var container:UIComponent;
            var value:* = param1;
            if (!value)
            {
                return;
            }
            while (this.tileImageHolder.numChildren > 0)
            {
                
                this.tileImageHolder.removeChildAt(0);
            }
            while (this.infoImageHolder.numChildren > 0)
            {
                
                this.infoImageHolder.removeChildAt(0);
            }
            var appearanceID:* = this._selectionModel.getPreferredAppearance(value).id;
            infoID = value.id + "_" + appearanceID + "_130";
            if (!this.cache[infoID])
            {
                this.infoImage = ImageService.getInstance().productTypeImage(value.id, value.defaultView.id, appearanceID, 130, 130, null);
                this.infoImage.smoothBitmapContent = true;
                this.cache[infoID] = this.infoImage;
                with ({})
                {
                    {}.infoImage_faultHandler = function (param1:IOErrorEvent) : void
            {
                while (infoImageHolder.numChildren > 0)
                {
                    
                    infoImageHolder.removeChildAt(0);
                }
                return;
            }// end function
            ;
                }
                EventUtil.registerOnetimeListeners(this.infoImage, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [this.infoImage_completeHandler, function (param1:IOErrorEvent) : void
            {
                while (infoImageHolder.numChildren > 0)
                {
                    
                    infoImageHolder.removeChildAt(0);
                }
                return;
            }// end function
            ]);
                this.infoImage.load();
            }
            else
            {
                this.infoImage = ProductTypeImage(this.cache[infoID]);
            }
            infoID = value.id + "_" + appearanceID + "_75";
            if (!this.cache[infoID])
            {
                this._overImage = ImageService.getInstance().productTypeImage(value.id, value.defaultView.id, appearanceID, 75, 75, null);
                this._overImage.smoothBitmapContent = true;
                this.cache[infoID] = this._overImage;
                with ({})
                {
                    {}.infoImage_faultHandler = function (param1:IOErrorEvent) : void
            {
                while (tileImageHolder.numChildren > 0)
                {
                    
                    tileImageHolder.removeChildAt(0);
                }
                return;
            }// end function
            ;
                }
                EventUtil.registerOnetimeListeners(this._overImage, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [this.overImage_completeHandler, function (param1:IOErrorEvent) : void
            {
                while (tileImageHolder.numChildren > 0)
                {
                    
                    tileImageHolder.removeChildAt(0);
                }
                return;
            }// end function
            ]);
                this._overImage.load();
            }
            else
            {
                this._overImage = ProductTypeImage(this.cache[infoID]);
            }
            if (!this.infoImage.isLoaded)
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
            }
            else
            {
                this.infoImage_completeHandler(null);
            }
            if (!this._overImage.isLoaded)
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
            else
            {
                this.overImage_completeHandler(null);
            }
            return;
        }// end function

        private function createDescription() : void
        {
            var _loc_2:IProductTypeSize;
            var _loc_3:IProductTypeAppearance;
            var _loc_4:Canvas;
            var _loc_5:Label;
            var _loc_6:Canvas;
            var _loc_7:ProductColorSwatch;
            if (this._currentProductType.id == this._lastProductTypeID)
            {
                return;
            }
            this.description.htmlText = "";
            this.sizes.removeAllChildren();
            this.sizesMask.removeAllChildren();
            this.colors.removeAllChildren();
            var _loc_1:Number;
            for each (_loc_2 in this._currentProductType.sizes)
            {
                
                _loc_4 = new Canvas();
                _loc_5 = new Label();
                _loc_6 = new Canvas();
                _loc_6.width = 25;
                _loc_6.height = 14;
                _loc_6.styleName = "sizeMask";
                _loc_4.width = 25;
                _loc_4.height = 14;
                _loc_5.text = _loc_2.name;
                _loc_5.styleName = "descriptionSize";
                if (_loc_5.text.length > 3)
                {
                    _loc_4.width = 25 + (_loc_5.text.length - 3) * 8;
                    _loc_6.width = 25 + (_loc_5.text.length - 3) * 8;
                }
                if (_loc_1 + _loc_4.width >= 150)
                {
                    break;
                }
                _loc_4.addChild(_loc_5);
                this.sizes.addChild(_loc_4);
                this.sizesMask.addChild(_loc_6);
                _loc_1 = _loc_1 + _loc_4.width;
            }
            for each (_loc_3 in this._currentProductType.appearances)
            {
                
                _loc_7 = new ProductColorSwatch();
                _loc_7.color = _loc_3;
                _loc_7.width = 15;
                _loc_7.height = 15;
                this.colors.addChild(_loc_7);
            }
            this.productName.text = this._currentProductType.name;
            this.brand.text = this._currentProductType.brand;
            this.description.htmlText = this._currentProductType.description.slice(0, 140) + "...";
            this.price.text = CurrencyFormatterFactory.createCurrencyFormatter(this._currentProductType.price.currency).format(this._currentProductType.price.amount);
            this._lastProductTypeID = this._currentProductType.id;
            return;
        }// end function

        private function doProductTypeChange(param1:IProductType) : void
        {
            if (!param1)
            {
                return;
            }
            this.productTypeList.selectedItem = param1;
            IProductType(this.productTypeList.selectedItem).defaultAppearance = this._selectionModel.getPreferredAppearance(IProductType(this.productTypeList.selectedItem));
            this._selectionModel.selectProductType(IProductType(this.productTypeList.selectedItem));
            return;
        }// end function

        private function onDescriptionOver(param1:Event) : void
        {
            this.createDescription();
            this.canvas.x = Math.round(this.tileOver.x + this.infoButton.x - 80);
            this.canvas.y = Math.round(this.tileOver.y + this.infoButton.y - this.canvas.height);
            this.canvas.endEffectsStarted();
            this.canvas.visible = true;
            this.fadeIn.play([this.canvas]);
            return;
        }// end function

        private function onHideDescriptionOut(param1:Event) : void
        {
            this.fadeOut.play([this.canvas]);
            return;
        }// end function

        private function onProductTypeChanged(param1:Event) : void
        {
            var size:IProductTypeSize;
            var appearance:IProductTypeAppearance;
            var event:* = param1;
            var sizeId:String;
            var appearanceId:String;
            if (this._selectionModel.preferredSize)
            {
                size = ProductTypeRules.findMatchingSize(this._selectionModel.preferredSize, this._selectionModel.selectedProductType.sizes);
                if (size)
                {
                    sizeId = size.id;
                }
            }
            if (this._selectionModel.preferredColors)
            {
            }
            if (this._selectionModel.preferredColors.length > 0)
            {
                appearance = ProductTypeRules.findMatchingAppearance(this._selectionModel.preferredColors[0], this._selectionModel.selectedProductType.appearances);
                if (appearance)
                {
                    appearanceId = appearance.id;
                }
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
            this.productModel.changeProductType(this._selectionModel.selectedProductType.id, appearanceId, null, sizeId, function () : void
            {
                bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(productModel));
                return;
            }// end function
            );
            return;
        }// end function

        private function onClose(param1:MouseEvent) : void
        {
            endEffectsStarted();
            visible = false;
            return;
        }// end function

        private function onItemRollOver(param1:ListEvent) : void
        {
            this._currentProductType = IProductType(param1.itemRenderer.data);
            this.loadImages(this._currentProductType);
            this.tileOver.x = param1.itemRenderer.x + 10 - (this.tileOver.width - param1.itemRenderer.width) * 0.5;
            this.tileOver.y = param1.itemRenderer.y + this.productTypeList.y - (this.tileOver.height - param1.itemRenderer.height) * 0.5;
            if (!this.tileOver.visible)
            {
                this.fadeIn.play([this.tileOver]);
            }
            return;
        }// end function

        private function itemRollOut(param1:MouseEvent) : void
        {
            var _loc_2:* = globalToContent(new Point(param1.stageX, param1.stageY));
            var _loc_3:* = this.productTypeList.getBounds(this);
            _loc_3.right = _loc_3.right - 20;
            if (!_loc_3.containsPoint(_loc_2))
            {
                this.fadeOut.play([this.tileOver]);
            }
            return;
        }// end function

        private function itemClick(param1:Event) : void
        {
            var _loc_2:* = this.productModel.canChangeProductType(this._currentProductType);
            if (_loc_2.hasConstraints)
            {
                Alert.show(_loc_2.toString(), resourceManager.getString("confomat7", "universal.notice"), Alert.OK | Alert.CANCEL, null, this.onAlertClose);
            }
            else
            {
                this.doProductTypeChange(this._currentProductType);
            }
            return;
        }// end function

        override protected function childrenCreated() : void
        {
            super.childrenCreated();
            this.palette.closeButton.addEventListener(MouseEvent.CLICK, this.onClose);
            this._selectionModel.addEventListener("pageChanged", this.onPageChanged);
            return;
        }// end function

        private function onAlertClose(param1:CloseEvent) : void
        {
            if (param1.detail == Alert.OK)
            {
                this.doProductTypeChange(this._currentProductType);
            }
            return;
        }// end function

        private function overImage_completeHandler(param1:Event) : void
        {
            if (this._currentProductType)
            {
            }
            if (this._overImage)
            {
            }
            if (this._currentProductType.id != this._overImage.productTypeId)
            {
                return;
            }
            while (this.tileImageHolder.numChildren > 0)
            {
                
                this.tileImageHolder.removeChildAt(0);
            }
            this.tileImageHolder.addChild(this._overImage);
            this.tileImageHolder.endEffectsStarted();
            this.tileImageHolder.visible = true;
            return;
        }// end function

        private function infoImage_completeHandler(param1:Event) : void
        {
            if (this._currentProductType)
            {
            }
            if (this.infoImage)
            {
            }
            if (this._currentProductType.id != this.infoImage.productTypeId)
            {
                return;
            }
            while (this.infoImageHolder.numChildren > 0)
            {
                
                this.infoImageHolder.removeChildAt(0);
            }
            this.infoImage.width = 130;
            this.infoImage.height = 130;
            this.infoImageHolder.addChild(this.infoImage);
            this.infoImageHolder.endEffectsStarted();
            this.infoImageHolder.visible = true;
            return;
        }// end function

        protected function onMouseOut(param1:MouseEvent) : void
        {
            var _loc_2:* = new Point(param1.stageX, param1.stageY);
            if (getObjectsUnderPoint(_loc_2).indexOf(this.palette) == -1)
            {
                this.fadeOut.play([this.tileOver]);
            }
            return;
        }// end function

        private function onPageChanged(param1:Event) : void
        {
            this.fadeOut.play([this.tileOver]);
            return;
        }// end function

        private function creationCompleteHandler(param1:FlexEvent) : void
        {
            if (ConfomatConfiguration.shopID == "622775")
            {
            }
            if (ConfomatConfiguration.platform == ConfomatConfiguration.PLATFORM_EU)
            {
                this.price.visible = false;
            }
            return;
        }// end function

        private function _ProductTypeSelector_Fade1_i() : Fade
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

        private function _ProductTypeSelector_Fade2_i() : Fade
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

        public function ___ProductTypeSelector_Canvas1_preinitialize(param1:FlexEvent) : void
        {
            this.init();
            return;
        }// end function

        public function ___ProductTypeSelector_Canvas1_creationComplete(param1:FlexEvent) : void
        {
            this.creationCompleteHandler(param1);
            return;
        }// end function

        private function _ProductTypeSelector_Canvas2_i() : Canvas
        {
            var temp:* = new Canvas();
            temp.height = 2;
            temp.x = 1;
            temp.id = "_ProductTypeSelector_Canvas2";
            if (!temp.document)
            {
                temp.document = this;
            }
            mx_internal::_documentDescriptor = new UIComponentDescriptor({type:Canvas, id:"_ProductTypeSelector_Canvas2", propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"_ProductTypeSelector_Canvas3", stylesFactory:function () : void
                {
                    this.backgroundColor = 15395303;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {height:1, x:1, y:0};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"_ProductTypeSelector_Canvas4", stylesFactory:function () : void
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
            this._ProductTypeSelector_Canvas2 = temp;
            BindingManager.executeBindings(this, "_ProductTypeSelector_Canvas2", this._ProductTypeSelector_Canvas2);
            return temp;
        }// end function

        private function _ProductTypeSelector_CategorySelector1_i() : CategorySelector
        {
            var _loc_1:* = new CategorySelector();
            _loc_1.width = 269;
            _loc_1.height = 25;
            _loc_1.x = 1;
            _loc_1.id = "_ProductTypeSelector_CategorySelector1";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this._ProductTypeSelector_CategorySelector1 = _loc_1;
            BindingManager.executeBindings(this, "_ProductTypeSelector_CategorySelector1", this._ProductTypeSelector_CategorySelector1);
            return _loc_1;
        }// end function

        private function _ProductTypeSelector_Canvas5_i() : Canvas
        {
            var temp:* = new Canvas();
            temp.height = 2;
            temp.x = 1;
            temp.id = "_ProductTypeSelector_Canvas5";
            if (!temp.document)
            {
                temp.document = this;
            }
            mx_internal::_documentDescriptor = new UIComponentDescriptor({type:Canvas, id:"_ProductTypeSelector_Canvas5", propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"_ProductTypeSelector_Canvas6", stylesFactory:function () : void
                {
                    this.backgroundColor = 15395303;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {height:1, x:1, y:0};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"_ProductTypeSelector_Canvas7", stylesFactory:function () : void
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
            this._ProductTypeSelector_Canvas5 = temp;
            BindingManager.executeBindings(this, "_ProductTypeSelector_Canvas5", this._ProductTypeSelector_Canvas5);
            return temp;
        }// end function

        private function _ProductTypeSelector_ProductTypeSort1_i() : ProductTypeSort
        {
            var _loc_1:* = new ProductTypeSort();
            _loc_1.x = 1;
            _loc_1.id = "sort";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this.sort = _loc_1;
            BindingManager.executeBindings(this, "sort", this.sort);
            return _loc_1;
        }// end function

        private function _ProductTypeSelector_Canvas8_i() : Canvas
        {
            var temp:* = new Canvas();
            temp.height = 2;
            temp.x = 1;
            temp.id = "_ProductTypeSelector_Canvas8";
            if (!temp.document)
            {
                temp.document = this;
            }
            mx_internal::_documentDescriptor = new UIComponentDescriptor({type:Canvas, id:"_ProductTypeSelector_Canvas8", propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"_ProductTypeSelector_Canvas9", stylesFactory:function () : void
                {
                    this.backgroundColor = 15395303;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {height:1, x:1, y:0};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"_ProductTypeSelector_Canvas10", stylesFactory:function () : void
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
            this._ProductTypeSelector_Canvas8 = temp;
            BindingManager.executeBindings(this, "_ProductTypeSelector_Canvas8", this._ProductTypeSelector_Canvas8);
            return temp;
        }// end function

        private function _ProductTypeSelector_GalleryTileList1_i() : GalleryTileList
        {
            var _loc_1:* = new GalleryTileList();
            _loc_1.name = "productList";
            _loc_1.height = 270;
            _loc_1.x = 1;
            _loc_1.itemRenderer = this._ProductTypeSelector_ClassFactory1_c();
            _loc_1.columnCount = 3;
            _loc_1.rowCount = 3;
            _loc_1.columnWidth = 90;
            _loc_1.rowHeight = 90;
            _loc_1.horizontalScrollPolicy = "off";
            _loc_1.addEventListener("itemRollOver", this.__productTypeList_itemRollOver);
            _loc_1.addEventListener("itemClick", this.__productTypeList_itemClick);
            _loc_1.id = "productTypeList";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this.productTypeList = _loc_1;
            BindingManager.executeBindings(this, "productTypeList", this.productTypeList);
            return _loc_1;
        }// end function

        private function _ProductTypeSelector_ClassFactory1_c() : ClassFactory
        {
            var _loc_1:* = new ClassFactory();
            _loc_1.generator = ProductTypeRenderer;
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        public function __productTypeList_itemRollOver(param1:ListEvent) : void
        {
            this.onItemRollOver(param1);
            return;
        }// end function

        public function __productTypeList_itemClick(param1:ListEvent) : void
        {
            this.itemClick(param1);
            return;
        }// end function

        private function _ProductTypeSelector_Paging1_i() : Paging
        {
            var _loc_1:* = new Paging();
            _loc_1.width = 270;
            _loc_1.height = 30;
            _loc_1.id = "_ProductTypeSelector_Paging1";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this._ProductTypeSelector_Paging1 = _loc_1;
            BindingManager.executeBindings(this, "_ProductTypeSelector_Paging1", this._ProductTypeSelector_Paging1);
            return _loc_1;
        }// end function

        public function __palette_mouseOut(param1:MouseEvent) : void
        {
            this.onMouseOut(param1);
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

        public function __infoButton_rollOver(param1:MouseEvent) : void
        {
            this.onDescriptionOver(param1);
            return;
        }// end function

        public function __infoButton_rollOut(param1:MouseEvent) : void
        {
            this.onHideDescriptionOut(param1);
            return;
        }// end function

        private function _ProductTypeSelector_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "product_gallery.label_section_header");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "palette.caption");
            result[1] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_ProductTypeSelector_Canvas2.width");
            result[2] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_ProductTypeSelector_Canvas3.width");
            result[3] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_ProductTypeSelector_Canvas4.width");
            result[4] = new Binding(this, function () : ICategoryProvider
            {
                return _selectionModel;
            }// end function
            , null, "_ProductTypeSelector_CategorySelector1.dataProvider");
            result[5] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_ProductTypeSelector_Canvas5.width");
            result[6] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_ProductTypeSelector_Canvas6.width");
            result[7] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_ProductTypeSelector_Canvas7.width");
            result[8] = new Binding(this, function () : ProductTypeSelectorModel
            {
                return _selectionModel;
            }// end function
            , null, "sort.dataProvider");
            result[9] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_ProductTypeSelector_Canvas8.width");
            result[10] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_ProductTypeSelector_Canvas9.width");
            result[11] = new Binding(this, function () : Number
            {
                return palette.width - 1;
            }// end function
            , null, "_ProductTypeSelector_Canvas10.width");
            result[12] = new Binding(this, function () : Number
            {
                return width - 1;
            }// end function
            , null, "productTypeList.width");
            result[13] = new Binding(this, function () : Object
            {
                return _selectionModel.productTypes;
            }// end function
            , null, "productTypeList.dataProvider");
            result[14] = new Binding(this, function () : IPageable
            {
                return _selectionModel;
            }// end function
            , null, "_ProductTypeSelector_Paging1.dataProvider");
            result[15] = new Binding(this, null, null, "sizes.mask", "sizesMask");
            result[16] = new Binding(this, function () : Array
            {
                var _loc_1:*;
                if (_loc_1 != null)
                {
                }
                if (!(_loc_1 is Array))
                {
                }
                return _loc_1 is Proxy ? (_loc_1) : ([_loc_1]);
            }// end function
            , null, "sizes.filters");
            return result;
        }// end function

        public function get brand() : Label
        {
            return this._93997959brand;
        }// end function

        public function set brand(param1:Label) : void
        {
            var _loc_2:* = this._93997959brand;
            if (_loc_2 !== param1)
            {
                this._93997959brand = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "brand", _loc_2, param1));
                }
            }
            return;
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

        public function get colors() : Tile
        {
            return this._1354842768colors;
        }// end function

        public function set colors(param1:Tile) : void
        {
            var _loc_2:* = this._1354842768colors;
            if (_loc_2 !== param1)
            {
                this._1354842768colors = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colors", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get description() : Text
        {
            return this._1724546052description;
        }// end function

        public function set description(param1:Text) : void
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

        public function get infoImageHolder() : Container
        {
            return this._411753817infoImageHolder;
        }// end function

        public function set infoImageHolder(param1:Container) : void
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

        public function get price() : Label
        {
            return this._106934601price;
        }// end function

        public function set price(param1:Label) : void
        {
            var _loc_2:* = this._106934601price;
            if (_loc_2 !== param1)
            {
                this._106934601price = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "price", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get productName() : Label
        {
            return this._1491817446productName;
        }// end function

        public function set productName(param1:Label) : void
        {
            var _loc_2:* = this._1491817446productName;
            if (_loc_2 !== param1)
            {
                this._1491817446productName = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "productName", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get productTypeList() : GalleryTileList
        {
            return this._529770233productTypeList;
        }// end function

        public function set productTypeList(param1:GalleryTileList) : void
        {
            var _loc_2:* = this._529770233productTypeList;
            if (_loc_2 !== param1)
            {
                this._529770233productTypeList = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "productTypeList", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get sizeContainer() : Canvas
        {
            return this._27458944sizeContainer;
        }// end function

        public function set sizeContainer(param1:Canvas) : void
        {
            var _loc_2:* = this._27458944sizeContainer;
            if (_loc_2 !== param1)
            {
                this._27458944sizeContainer = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sizeContainer", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get sizes() : HBox
        {
            return this._109453458sizes;
        }// end function

        public function set sizes(param1:HBox) : void
        {
            var _loc_2:* = this._109453458sizes;
            if (_loc_2 !== param1)
            {
                this._109453458sizes = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sizes", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get sizesMask() : HBox
        {
            return this._514065054sizesMask;
        }// end function

        public function set sizesMask(param1:HBox) : void
        {
            var _loc_2:* = this._514065054sizesMask;
            if (_loc_2 !== param1)
            {
                this._514065054sizesMask = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sizesMask", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get sort() : ProductTypeSort
        {
            return this._3536286sort;
        }// end function

        public function set sort(param1:ProductTypeSort) : void
        {
            var _loc_2:* = this._3536286sort;
            if (_loc_2 !== param1)
            {
                this._3536286sort = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sort", _loc_2, param1));
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

        private function get _selectionModel() : ProductTypeSelectorModel
        {
            return this._659939556_selectionModel;
        }// end function

        private function set _selectionModel(param1:ProductTypeSelectorModel) : void
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

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
        {
            _watcherSetupUtil = param1;
            return;
        }// end function

    }
}
