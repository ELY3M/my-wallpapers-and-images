package net.sprd.modules.share
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
    import net.sprd.common.utils.*;
    import net.sprd.entities.*;
    import net.sprd.models.common.*;
    import net.sprd.services.image.*;

    public class ProductRenderer extends Canvas implements IDropInListItemRenderer
    {
        private var _1391345023loadingImage:Image;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;
        private var _listData:BaseListData;
        private var image:ProductImage;
        private var _loadingState:int;
        private var _cachedIndicator:UIComponent;
        private var progressIndicator:Class;

        public function ProductRenderer()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Image, id:"loadingImage", propertiesFactory:function () : Object
                {
                    return {width:75, height:75, horizontalCenter:0, verticalCenter:0, mouseEnabled:false, mouseChildren:false};
                }// end function
                })]};
            }// end function
            });
            this.progressIndicator = ProductRenderer_progressIndicator;
            mx_internal::_document = this;
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
            if (param1)
            {
            }
            if (param1 is IProduct)
            {
                id = "product" + this.product.id;
            }
            this.loadImage();
            return;
        }// end function

        private function isProduct() : Boolean
        {
            return data is IProduct;
        }// end function

        private function get product() : IProduct
        {
            return data as IProduct;
        }// end function

        private function loadImage() : void
        {
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
            if (this.isProduct())
            {
                this.image = ImageService.getInstance().productImage(this.product.id, this.product.defaultView, 75, 75);
                this.image.smoothBitmapContent = true;
                with ({})
                {
                    {}.complete = function (param1:Event) : void
            {
                var _loc_2:* = ProductImage(param1.target);
                if (_loc_2.productId == image.productId)
                {
                }
                if (_loc_2.viewId != image.viewId)
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
                EventUtil.registerOnetimeListeners(this.image, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [function (param1:Event) : void
            {
                var _loc_2:* = ProductImage(param1.target);
                if (_loc_2.productId == image.productId)
                {
                }
                if (_loc_2.viewId != image.viewId)
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
                this.image.load();
            }
            return;
        }// end function

        private function showImage() : void
        {
            this.removeImage();
            this.image.x = this.loadingImage.x;
            this.image.y = this.loadingImage.y;
            this.image.mouseEnabled = false;
            this.image.mouseChildren = false;
            this.image.smoothBitmapContent = true;
            this.image.name = "product";
            addChild(this.image);
            var _loc_1:* = this.image.getBounds(this.image);
            var _loc_2:* = new Rectangle(0, 0, 75, 75);
            BoundsUtil.trimBoundsProportionally(_loc_1, _loc_2);
            this.image.width = _loc_1.width;
            this.image.height = _loc_1.height;
            this.loadingImage.endEffectsStarted();
            this.loadingImage.visible = false;
            this.image.endEffectsStarted();
            this.image.visible = true;
            return;
        }// end function

        private function removeImage() : void
        {
            if (getChildByName("product"))
            {
                removeChild(getChildByName("product"));
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
