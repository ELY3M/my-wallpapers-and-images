package net.sprd.components.designupload
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.containers.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.services.image.*;
    import net.sprd.services.image.model.*;

    public class OverTile extends Canvas
    {
        private var designInfo:DesignInfo;
        private var designChanged:Boolean;
        private var configurationImage:ConfigurationImage;
        private var tile:Sprite;
        private static const log:ILogger = LogContext.getLogger(this);

        public function OverTile()
        {
            return;
        }// end function

        public function get dataProvider() : DesignInfo
        {
            return this.designInfo;
        }// end function

        public function set dataProvider(param1:DesignInfo) : void
        {
            if (this.designInfo == param1)
            {
                return;
            }
            this.designInfo = param1;
            this.designChanged = true;
            invalidateProperties();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.designChanged)
            {
                this.designChanged = false;
                this.loadDesign();
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.tile = new Sprite();
            rawChildren.addChild(this.tile);
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            this.tile.x = 4;
            this.tile.y = 4;
            return;
        }// end function

        private function loadDesign() : void
        {
            this.configurationImage = ImageService.getInstance().designImage(this.designInfo.design.imageId, 100, 100);
            var completeHandler:* = function (param1:Event) : void
            {
                renderImage();
                return;
            }// end function
            ;
            var faultHandler:* = function (param1:IOErrorEvent) : void
            {
                log.warn("Loading fault: " + designInfo.design.imageId);
                return;
            }// end function
            ;
            EventUtil.registerOnetimeListeners(this.configurationImage, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [completeHandler, faultHandler]);
            this.configurationImage.load();
            return;
        }// end function

        private function renderImage() : void
        {
            if (this.configurationImage.layers.length == 0)
            {
                return;
            }
            var _loc_1:* = this.configurationImage["layers"][0].bitmapData;
            var _loc_2:* = Math.min(85 / _loc_1.width, 85 / _loc_1.height);
            var _loc_3:* = new Matrix();
            _loc_3.scale(_loc_2, _loc_2);
            var _loc_4:* = Math.round((85 - _loc_1.width * _loc_2) / 2) + 3;
            var _loc_5:* = Math.round((85 - _loc_1.height * _loc_2) / 2) + 3;
            _loc_3.translate(_loc_4, _loc_5);
            this.tile.graphics.clear();
            this.tile.graphics.beginBitmapFill(_loc_1, _loc_3, false, true);
            this.tile.graphics.drawRoundRect(_loc_4, _loc_5, _loc_1.width * _loc_2, _loc_1.height * _loc_2, 10, 10);
            return;
        }// end function

    }
}
