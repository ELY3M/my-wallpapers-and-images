package net.sprd.components.productviewer
{
    import flash.events.*;
    import flash.utils.*;
    import mx.controls.*;
    import mx.core.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.events.*;
    import net.sprd.models.common.*;
    import net.sprd.models.product.*;
    import net.sprd.services.image.*;
    import net.sprd.services.image.model.*;

    public class ProductTypeViewer extends UIComponent
    {
        public var _model:IProductModel;
        private var viewImages:Dictionary;
        private var _prodTypeChanged:Boolean;
        private var _viewChanged:Boolean;
        private var _appearanceChanged:Boolean;
        private var _currentImage:Image;
        private var _currentAppearance:String;
        private var _currentView:String;
        private var _currentProductType:String;
        private var _autoPrefetchViews:Boolean = true;
        private var _autoPrefetchViewsChanged:Boolean = true;
        private var _componentComplete:Boolean = false;
        public const MIN_SIZE:uint = 25;
        public const MAX_SIZE:uint = 1200;
        private static const log:ILogger = LogContext.getLogger(this);

        public function ProductTypeViewer()
        {
            this.viewImages = new Dictionary();
            return;
        }// end function

        public function init()
        {
            if (this._model.state == ModelState.INITIALIZED)
            {
                this._prodTypeChanged = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get autoPrefetchViews() : Boolean
        {
            return this._autoPrefetchViews;
        }// end function

        public function set autoPrefetchViews(param1:Boolean) : void
        {
            if (this._autoPrefetchViews == param1)
            {
                return;
            }
            this._autoPrefetchViews = param1;
            this._autoPrefetchViewsChanged = true;
            invalidateProperties();
            return;
        }// end function

        private function loadProductTypeImages() : void
        {
            var _loc_1:IProductTypeView;
            if (this._model.views.length == 0)
            {
                log.warn("Tried to update images of product type but no views are defined");
                return;
            }
            this.viewImages = new Dictionary();
            for each (_loc_1 in this._model.views)
            {
                
                this.viewImages[_loc_1.id] = ImageService.getInstance().productTypeImage(this._currentProductType, _loc_1.id, this._currentAppearance, width, height, null);
            }
            this.showView(this.viewImages[this._model.currentView.id]);
            if (this.autoPrefetchViews)
            {
                this.prefetchViews();
            }
            return;
        }// end function

        private function showView(param1:CachedImage) : void
        {
            var img:* = param1;
            if (!img.isLoaded)
            {
                EventUtil.registerOnetimeListeners(img, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [function (param1:Event) : void
            {
                replaceCurrentImage(CachedImage(param1.target));
                return;
            }// end function
            , function (param1:IOErrorEvent) : void
            {
                log.warn("image not loaded: " + CachedImage(param1.target).source);
                return;
            }// end function
            ]);
                img.load();
            }
            else
            {
                this.replaceCurrentImage(img);
            }
            return;
        }// end function

        private function replaceCurrentImage(param1:CachedImage) : void
        {
            removeChild(this._currentImage);
            param1.smoothBitmapContent = true;
            this._currentImage = param1;
            addChild(param1);
            if (!this._componentComplete)
            {
                this._componentComplete = true;
                dispatchEvent(new ApplicationEvent(ApplicationEvent.COMPONENT_COMPLETE));
            }
            return;
        }// end function

        private function prefetchViews() : void
        {
            var _loc_1:CachedImage;
            for each (_loc_1 in this.viewImages)
            {
                
                if (_loc_1 != this._currentImage)
                {
                }
                if (!_loc_1.isLoaded)
                {
                    _loc_1.load();
                }
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            this._currentImage = new CachedImage();
            this._currentImage.endEffectsStarted();
            this._currentImage.visible = false;
            addChild(this._currentImage);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:Boolean;
            super.commitProperties();
            if (this._prodTypeChanged)
            {
                this._prodTypeChanged = false;
                _loc_1 = true;
            }
            if (this._appearanceChanged)
            {
                this._appearanceChanged = false;
                _loc_1 = true;
            }
            if (_loc_1)
            {
                this.loadProductTypeImages();
            }
            if (this._viewChanged)
            {
                this._viewChanged = false;
                this.showView(this.viewImages[this._model.currentView.id]);
            }
            if (this._autoPrefetchViewsChanged)
            {
                this._autoPrefetchViewsChanged = false;
                if (this.autoPrefetchViews)
                {
                    this.prefetchViews();
                }
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = Math.min(parent.width, parent.height);
            var _loc_2:* = _loc_1;
            if (_loc_1 < this.MIN_SIZE)
            {
                _loc_2 = this.MIN_SIZE;
            }
            if (_loc_1 > this.MAX_SIZE)
            {
                _loc_2 = this.MAX_SIZE;
            }
            var _loc_3:* = _loc_2;
            measuredMinHeight = _loc_2;
            measuredHeight = _loc_3;
            var _loc_3:* = _loc_2;
            measuredMinWidth = _loc_2;
            measuredWidth = _loc_3;
            return;
        }// end function

        public function bus_productTypeChangedHandler(param1:Event) : void
        {
            this._currentProductType = this._model.productTypeID;
            this._prodTypeChanged = true;
            this._currentView = this._model.currentView.id;
            this._viewChanged = true;
            this._currentAppearance = this._model.currentAppearance.id;
            this._appearanceChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function bus_viewChangedHandler(param1:ProductTypeEvent) : void
        {
            if (this._currentView == this._model.currentView.id)
            {
                return;
            }
            this._currentView = this._model.currentView.id;
            this._viewChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function bus_appearanceChangedHandler(param1:ProductTypeEvent) : void
        {
            if (!this._model.currentAppearance)
            {
                log.warn("current appearance of model is null");
                return;
            }
            if (this._currentAppearance == this._model.currentAppearance.id)
            {
                return;
            }
            this._currentAppearance = this._model.currentAppearance.id;
            this._appearanceChanged = true;
            invalidateProperties();
            return;
        }// end function

    }
}
