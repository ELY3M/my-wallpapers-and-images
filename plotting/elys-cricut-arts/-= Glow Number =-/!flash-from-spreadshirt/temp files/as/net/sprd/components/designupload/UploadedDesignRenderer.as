package net.sprd.components.designupload
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.services.image.*;
    import net.sprd.services.image.model.*;

    public class UploadedDesignRenderer extends Container implements IDropInListItemRenderer
    {
        private var _listData:BaseListData;
        private var designInfo:DesignInfo;
        private var image:ConfigurationImage;
        private var progressBar:ProgressBar;
        private var previewImage:Sprite;
        private static const log:ILogger = LogContext.getLogger(this);

        public function UploadedDesignRenderer()
        {
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
            if (this.designInfo)
            {
            }
            if (param1.design.id == this.designInfo.design.id)
            {
                if (param1 != this.designInfo)
                {
                    this.designInfo = DesignInfo(param1);
                }
                return;
            }
            this.designInfo = DesignInfo(param1);
            id = "design" + this.designInfo.design.id;
            this.showPreview();
            if (this.designInfo.isUpLoading)
            {
                this.designInfo.addEventListener(DesignUploadEvent.UPLOAD_COMPLETE, this.fileReference_uploadCompleteHandler);
                this.progressBar.endEffectsStarted();
                this.progressBar.visible = true;
                this.progressBar.source = this.designInfo.fileReference;
                this.progressBar.label = "";
            }
            else
            {
                this.loadDesign();
            }
            super.data = param1;
            return;
        }// end function

        override public function get data() : Object
        {
            return this.designInfo;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.previewImage = new Sprite();
            rawChildren.addChild(this.previewImage);
            this.progressBar = new ProgressBar();
            this.progressBar.width = 60;
            this.progressBar.x = 10;
            this.progressBar.y = 40;
            this.progressBar.direction = ProgressBarDirection.RIGHT;
            this.progressBar.endEffectsStarted();
            this.progressBar.visible = false;
            addChild(this.progressBar);
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            if (true)
            {
            }
            if (this.designInfo.constraints)
            {
            }
            if (!this.designInfo.constraints.isUsable)
            {
                alpha = 0.3;
            }
            else
            {
                alpha = 1;
            }
            return;
        }// end function

        private function showPreview() : void
        {
            if (!this.designInfo.isUpLoading)
            {
                return;
            }
            var data:* = new ByteArray();
            this.designInfo.fileReference.data.readBytes(data, 0, this.designInfo.fileReference.data.bytesAvailable);
            var loadBytesComplete:* = function (param1:Event) : void
            {
                var _loc_2:* = LoaderInfo(param1.target);
                var _loc_3:* = Bitmap(_loc_2.content).bitmapData;
                var _loc_4:* = 1 / 3;
                var _loc_5:* = 1 / 3;
                var _loc_6:* = 1 / 3;
                _loc_3.applyFilter(_loc_3, _loc_3.rect, new Point(), new ColorMatrixFilter([_loc_4, _loc_5, _loc_6, 0, 0, _loc_4, _loc_5, _loc_6, 0, 0, _loc_4, _loc_5, _loc_6, 0, 0, 0, 0, 0, 1, 0]));
                var _loc_7:* = Math.min(85 / _loc_2.width, 85 / _loc_2.height);
                var _loc_8:* = new Matrix();
                _loc_8.scale(_loc_7, _loc_7);
                var _loc_9:* = Math.round((85 - _loc_3.width * _loc_7) / 2) + 3;
                var _loc_10:* = Math.round((85 - _loc_3.height * _loc_7) / 2) + 3;
                _loc_8.translate(_loc_9, _loc_10);
                previewImage.graphics.clear();
                previewImage.graphics.beginBitmapFill(_loc_3, _loc_8, false, true);
                previewImage.graphics.drawRoundRect(_loc_9, _loc_10, _loc_3.width * _loc_7, _loc_3.height * _loc_7, 10, 10);
                previewImage.alpha = 0.4;
                previewImage.visible = true;
                var _loc_11:* = previewImage.getBounds(null);
                progressBar.move(_loc_11.left + (_loc_11.width - progressBar.width) / 2, _loc_11.top + _loc_11.height / 2);
                return;
            }// end function
            ;
            var loader:* = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadBytesComplete);
            loader.loadBytes(data);
            return;
        }// end function

        private function showImage() : void
        {
            this.previewImage.visible = false;
            graphics.clear();
            if (this.image["layers"].length == 0)
            {
                return;
            }
            var _loc_1:* = this.image["layers"][0].bitmapData;
            var _loc_2:* = Math.min(85 / _loc_1.width, 85 / _loc_1.height);
            var _loc_3:* = new Matrix();
            _loc_3.scale(_loc_2, _loc_2);
            var _loc_4:* = Math.round((85 - _loc_1.width * _loc_2) / 2) + 3;
            var _loc_5:* = Math.round((85 - _loc_1.height * _loc_2) / 2) + 3;
            _loc_3.translate(_loc_4, _loc_5);
            graphics.beginBitmapFill(_loc_1, _loc_3, false, true);
            graphics.drawRoundRect(_loc_4, _loc_5, _loc_1.width * _loc_2, _loc_1.height * _loc_2, 10, 10);
            return;
        }// end function

        private function loadDesign() : void
        {
            if (this.designInfo)
            {
                if (this.image)
                {
                }
            }
            if (this.image.imageId == this.designInfo.design.imageId)
            {
                return;
            }
            graphics.clear();
            this.image = ImageService.getInstance().designImage(this.designInfo.design.imageId, 100, 100);
            EventUtil.registerOnetimeListeners(this.image, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [this.image_completeHandler, this.image_faultHandler]);
            this.image.load();
            return;
        }// end function

        private function image_completeHandler(param1:Event) : void
        {
            this.progressBar.endEffectsStarted();
            this.progressBar.visible = false;
            invalidateDisplayList();
            this.showImage();
            return;
        }// end function

        private function image_faultHandler(param1:IOErrorEvent) : void
        {
            log.warn("Error loading preview image: " + param1);
            this.progressBar.endEffectsStarted();
            this.progressBar.visible = false;
            return;
        }// end function

        private function fileReference_uploadCompleteHandler(param1:Event) : void
        {
            this.loadDesign();
            return;
        }// end function

    }
}
