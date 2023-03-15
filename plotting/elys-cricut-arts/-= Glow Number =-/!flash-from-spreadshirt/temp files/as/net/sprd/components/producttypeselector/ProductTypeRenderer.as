package net.sprd.components.producttypeselector
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;
    import net.sprd.api.resource.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.entities.*;
    import net.sprd.models.common.*;
    import net.sprd.services.image.*;
    import net.sprd.services.image.model.*;

    public class ProductTypeRenderer extends Canvas implements IDropInListItemRenderer
    {
        private var _1391345023loadingImage:Image;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;
        private var productType:IProductType;
        private var productTypeImage:ProductTypeImage;
        private var _listData:BaseListData;
        private var _loadingState:int;
        private var _cachedIndicator:UIComponent;
        private var progressIndicator:Class;
        private static const log:ILogger = LogContext.getLogger(this);

        public function ProductTypeRenderer()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {width:89, height:89, childDescriptors:[new UIComponentDescriptor({type:Image, id:"loadingImage", propertiesFactory:function () : Object
                {
                    return {width:75, height:75, horizontalCenter:0, verticalCenter:0, mouseEnabled:false, mouseChildren:false};
                }// end function
                })]};
            }// end function
            });
            this.progressIndicator = ProductTypeRenderer_progressIndicator;
            mx_internal::_document = this;
            this.width = 89;
            this.height = 89;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.useHandCursor = true;
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

        public function get listData() : BaseListData
        {
            return this._listData;
        }// end function

        public function set listData(param1:BaseListData) : void
        {
            this._listData = param1;
            return;
        }// end function

        override public function set data(param1:Object) : void
        {
            super.data = param1;
            this.removeImage();
            this.removeLoader();
            this.productType = IProductType(param1);
            id = "productType" + this.productType.id;
            this.loadImage();
            return;
        }// end function

        private function removeImage() : void
        {
            if (getChildByName("productType"))
            {
                removeChild(getChildByName("productType"));
            }
            return;
        }// end function

        private function removeLoader() : void
        {
            if (this._cachedIndicator)
            {
            }
            if (this._cachedIndicator.parent)
            {
                this._cachedIndicator.parent.removeChild(this._cachedIndicator);
                this._cachedIndicator = null;
            }
            return;
        }// end function

        override public function get data() : Object
        {
            return this.productType;
        }// end function

        private function loadImage() : void
        {
            var preferredAppearance:IProductTypeAppearance;
            var spinner:Sprite;
            if (!this._cachedIndicator)
            {
                spinner = new this.progressIndicator() as Sprite;
                spinner.mouseEnabled = false;
                spinner.mouseChildren = false;
                spinner.name = "spinner";
                this._cachedIndicator = new UIComponent();
                this._cachedIndicator.addChild(spinner);
                this._cachedIndicator.verticalCenter = 0;
                this._cachedIndicator.horizontalCenter = 0;
                addChild(this._cachedIndicator);
            }
            if (this.productTypeImage)
            {
                this.productTypeImage.endEffectsStarted();
                this.productTypeImage.visible = false;
            }
            if (parentDocument)
            {
                preferredAppearance = ProductTypeSelectorModel(parentDocument.selectionModel).getPreferredAppearance(this.productType);
            }
            var appearance:* = preferredAppearance ? (preferredAppearance) : (this.productType.defaultAppearance);
            this.productTypeImage = ImageService.getInstance().productTypeImage(this.productType.id, this.productType.defaultView.id, appearance.id, 75, 75, null);
            with ({})
            {
                {}.complete = function (param1:Event) : void
            {
                var _loc_2:* = ProductTypeImage(param1.target);
                if (_loc_2.productTypeId == productTypeImage.productTypeId)
                {
                }
                if (_loc_2.viewId == productTypeImage.viewId)
                {
                }
                if (_loc_2.appearanceId != productTypeImage.appearanceId)
                {
                    return;
                }
                _loadingState = ResourceLoadingState.LOADED;
                removeLoader();
                showImage();
                return;
            }// end function
            ;
            }
            with ({})
            {
                {}.error = function (param1) : void
            {
                removeLoader();
                _loadingState = ResourceLoadingState.ERROR;
                return;
            }// end function
            ;
            }
            EventUtil.registerOnetimeListeners(this.productTypeImage, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [function (param1:Event) : void
            {
                var _loc_2:* = ProductTypeImage(param1.target);
                if (_loc_2.productTypeId == productTypeImage.productTypeId)
                {
                }
                if (_loc_2.viewId == productTypeImage.viewId)
                {
                }
                if (_loc_2.appearanceId != productTypeImage.appearanceId)
                {
                    return;
                }
                _loadingState = ResourceLoadingState.LOADED;
                removeLoader();
                showImage();
                return;
            }// end function
            , function (param1) : void
            {
                removeLoader();
                _loadingState = ResourceLoadingState.ERROR;
                return;
            }// end function
            ]);
            this._loadingState = ResourceLoadingState.LOADING;
            this.productTypeImage.load();
            return;
        }// end function

        private function showImage() : void
        {
            this.removeImage();
            this.productTypeImage.x = this.loadingImage.x;
            this.productTypeImage.y = this.loadingImage.y;
            this.productTypeImage.mouseEnabled = false;
            this.productTypeImage.mouseChildren = false;
            this.productTypeImage.smoothBitmapContent = true;
            this.productTypeImage.name = "productType";
            addChild(this.productTypeImage);
            var _loc_1:* = this.productTypeImage.getBounds(this.productTypeImage);
            var _loc_2:* = new Rectangle(0, 0, 75, 75);
            BoundsUtil.trimBoundsProportionally(_loc_1, _loc_2);
            this.productTypeImage.width = _loc_1.width;
            this.productTypeImage.height = _loc_1.height;
            this.loadingImage.endEffectsStarted();
            this.loadingImage.visible = false;
            this.productTypeImage.endEffectsStarted();
            this.productTypeImage.visible = true;
            return;
        }// end function

        public function get loadingImage() : Image
        {
            return this._1391345023loadingImage;
        }// end function

        public function set loadingImage(param1:Image) : void
        {
            var _loc_2:* = this._1391345023loadingImage;
            if (_loc_2 !== param1)
            {
                this._1391345023loadingImage = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loadingImage", _loc_2, param1));
                }
            }
            return;
        }// end function

    }
}
