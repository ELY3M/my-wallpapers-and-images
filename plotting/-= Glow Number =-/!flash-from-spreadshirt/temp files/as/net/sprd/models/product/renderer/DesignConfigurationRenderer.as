package net.sprd.models.product.renderer
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import net.sprd.api.*;
    import net.sprd.common.colors.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.entities.*;
    import net.sprd.models.product.*;
    import net.sprd.services.image.*;
    import net.sprd.services.image.model.*;

    public class DesignConfigurationRenderer extends EventDispatcher implements IConfigurationRenderer
    {
        private var result:Sprite;
        private var _layers:Array;
        private var _fillPatterns:Array;
        private var _fillPatternLoadCount:uint = 0;
        private var _specialLayers:Array;
        private var configurationModel:IConfigurationModel;
        private var _loading:Boolean;
        private static const log:ILogger = LogContext.getLogger(this);

        public function DesignConfigurationRenderer(param1:IConfigurationModel)
        {
            this._layers = [];
            this._fillPatterns = [];
            this._specialLayers = [];
            this.configurationModel = param1;
            return;
        }// end function

        public function render() : Sprite
        {
            var _loc_3:uint;
            var _loc_4:ColorTransform;
            var _loc_1:* = this.configurationModel.rgbColors;
            var _loc_2:uint;
            while (_loc_2++ < this._layers.length)
            {
                
                if (_loc_1[_loc_2] == null)
                {
                    continue;
                }
                _loc_3 = ColorUtil.getIntegerColor(_loc_1[_loc_2]);
                _loc_4 = new ColorTransform();
                _loc_4.color = _loc_3;
                DisplayObject(this._layers[_loc_2]).transform.colorTransform = _loc_4;
            }
            return this.result;
        }// end function

        public function layers() : Array
        {
            return this._layers;
        }// end function

        private function onPatternComplete(param1:Event) : void
        {
            LoaderInfo(param1.target).removeEventListener(Event.COMPLETE, this.onPatternComplete);
            var _loc_2:String;
            _loc_2._fillPatternLoadCount = ++this._fillPatternLoadCount;
            if (this._fillPatterns.length == ++this._fillPatternLoadCount)
            {
                this.render();
            }
            return;
        }// end function

        public function loadAssets() : void
        {
            var designID:String;
            if (this._loading)
            {
                return;
            }
            this._loading = true;
            designID = this.configurationModel.designId;
            with ({})
            {
                {}.complete = function (param1:Event) : void
            {
                var _loc_2:* = IDesign(param1.target);
                if (!_loc_2)
                {
                    log.warn("Design " + designID + " not found.");
                    dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
                    return;
                }
                var _loc_3:* = ImageService.getInstance().designImage(_loc_2.imageId, configurationModel.width, configurationModel.height);
                EventUtil.registerOnetimeListeners(_loc_3, [Event.COMPLETE, IOErrorEvent.IO_ERROR, SecurityErrorEvent.SECURITY_ERROR], [image_completeHandler, image_faultHandler, image_faultHandler]);
                _loc_3.load();
                return;
            }// end function
            ;
            }
            with ({})
            {
                {}.fault = function (param1:Event) : void
            {
                log.warn("Design " + designID + " not found.");
                dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
                return;
            }// end function
            ;
            }
            IDesign(API.em.load(designID, APIRegistry.DESIGN, function (param1:Event) : void
            {
                var _loc_2:* = IDesign(param1.target);
                if (!_loc_2)
                {
                    log.warn("Design " + designID + " not found.");
                    dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
                    return;
                }
                var _loc_3:* = ImageService.getInstance().designImage(_loc_2.imageId, configurationModel.width, configurationModel.height);
                EventUtil.registerOnetimeListeners(_loc_3, [Event.COMPLETE, IOErrorEvent.IO_ERROR, SecurityErrorEvent.SECURITY_ERROR], [image_completeHandler, image_faultHandler, image_faultHandler]);
                _loc_3.load();
                return;
            }// end function
            , function (param1:Event) : void
            {
                log.warn("Design " + designID + " not found.");
                dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
                return;
            }// end function
            ));
            return;
        }// end function

        private function image_faultHandler(param1:Event) : void
        {
            var _loc_2:* = ConfigurationImage(param1.target);
            var _loc_3:* = "Couldn\'t load image \'" + _loc_2.imageId + "\'. ";
            log.warn(_loc_3 + param1.toString());
            this._loading = false;
            dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR, false, false, _loc_3));
            return;
        }// end function

        private function image_completeHandler(param1:Event) : void
        {
            var layer:DisplayObject;
            var bounds:Rectangle;
            var event:* = param1;
            var image:* = ConfigurationImage(event.target);
            this._layers = [];
            var rawObject:* = new Sprite();
            var _loc_3:int;
            var _loc_4:* = image.layers;
            while (_loc_4 in _loc_3)
            {
                
                layer = _loc_4[_loc_3];
                this._layers.push(layer);
                rawObject.addChild(layer);
            }
            this.result = new Sprite();
            this.result.name = "designRenderer";
            rawObject.width = this.configurationModel.unscaledWidth;
            rawObject.height = this.configurationModel.unscaledHeight;
            bounds = rawObject.getBounds(rawObject);
            var _loc_3:int;
            var _loc_4:* = this._layers;
            while (_loc_4 in _loc_3)
            {
                
                layer = _loc_4[_loc_3];
                layer.x = layer.x - bounds.x;
                layer.y = layer.y - bounds.y;
            }
            this.result.addChild(rawObject);
            var _loc_3:* = this.result.graphics;
            with (this.result.graphics)
            {
                clear();
                beginFill(0, 0);
                drawRect(0, 0, result.width, result.height);
            }
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

    }
}
