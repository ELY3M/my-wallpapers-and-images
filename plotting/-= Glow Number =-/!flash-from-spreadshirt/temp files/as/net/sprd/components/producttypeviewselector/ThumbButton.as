package net.sprd.components.producttypeviewselector
{
    import flash.events.*;
    import mx.controls.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.entities.*;
    import net.sprd.services.image.*;
    import net.sprd.services.image.model.*;

    public class ThumbButton extends Button
    {
        private var _thumbImage:CachedImage;
        private var _productTypeChanged:Boolean;
        private var _productColorChanged:Boolean;
        private var _view:IProductTypeView;
        private var _viewChanged:Boolean;
        private var _productTypeID:String;
        private var _productColorID:String;
        private static const log:ILogger = LogContext.getLogger(this);

        public function ThumbButton()
        {
            buttonMode = true;
            mouseChildren = false;
            return;
        }// end function

        public function set view(param1:IProductTypeView) : void
        {
            if (param1 == this._view)
            {
                return;
            }
            this._view = param1;
            this._viewChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get view() : IProductTypeView
        {
            return this._view;
        }// end function

        public function set productTypeID(param1:String) : void
        {
            if (this._productTypeID == param1)
            {
                return;
            }
            this._productTypeID = param1;
            this._productTypeChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get productTypeID() : String
        {
            return this._productTypeID;
        }// end function

        public function set productColorID(param1:String) : void
        {
            if (this._productColorID == param1)
            {
                return;
            }
            this._productColorID = param1;
            this._productColorChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get productColorID() : String
        {
            return this._productColorID;
        }// end function

        private function updateImage() : void
        {
            if (getExplicitOrMeasuredWidth() != 0)
            {
            }
            if (getExplicitOrMeasuredHeight() == 0)
            {
                callLater(this.updateImage);
                return;
            }
            var _loc_1:* = ImageService.getInstance();
            var _loc_2:* = _loc_1.productTypeImage(this._productTypeID, this._view.id, this._productColorID, 34, 34, null);
            if (!_loc_2.isLoaded)
            {
                EventUtil.registerOnetimeListeners(_loc_2, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [this.image_completeHandler, this.image_faultHandler]);
                _loc_2.load();
            }
            else
            {
                _loc_2.smoothBitmapContent = true;
                removeChild(this._thumbImage);
                this._thumbImage = _loc_2;
                addChild(_loc_2);
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            this._thumbImage.move(5, 5);
            setChildIndex(this._thumbImage, numChildren - 1);
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this._thumbImage = new CachedImage();
            addChild(this._thumbImage);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:Boolean;
            super.commitProperties();
            if (this._viewChanged)
            {
                this._viewChanged = false;
                _loc_1 = true;
            }
            if (this._productTypeChanged)
            {
                this._productTypeChanged = false;
                _loc_1 = true;
            }
            if (this._productColorChanged)
            {
                this._productColorChanged = false;
                _loc_1 = true;
            }
            if (_loc_1)
            {
                _loc_1 = false;
                callLater(this.updateImage);
            }
            return;
        }// end function

        override protected function measure() : void
        {
            measuredHeight = 40;
            measuredWidth = 40;
            return;
        }// end function

        private function image_completeHandler(param1:Event) : void
        {
            var _loc_2:* = CachedImage(param1.target);
            _loc_2.smoothBitmapContent = true;
            removeChild(this._thumbImage);
            this._thumbImage = _loc_2;
            addChild(this._thumbImage);
            invalidateDisplayList();
            return;
        }// end function

        private function image_faultHandler(param1:IOErrorEvent) : void
        {
            log.warn("Could not load thumb of product type view: " + this._productTypeID + ":" + this._view.id + ":" + this._productColorID);
            return;
        }// end function

    }
}
