package net.sprd.services.image.model
{
    import flash.display.*;
    import flash.events.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;

    public class ConfigurationImage extends CachedImage
    {
        private var _layers:Array;
        private var _colors:Array;
        private var _image:Sprite;
        private var _imageId:String;
        private var _layerDefinitions:Array;
        private static const log:ILogger = LogContext.getLogger(this);

        public function ConfigurationImage(param1:String)
        {
            this._layers = [];
            this._colors = [];
            this._layerDefinitions = [];
            this._imageId = param1;
            return;
        }// end function

        public function get colors() : Array
        {
            return this._colors;
        }// end function

        public function get layers() : Array
        {
            return this._layers;
        }// end function

        public function get imageId() : String
        {
            return this._imageId;
        }// end function

        public function duplicate(param1:ConfigurationImage = null) : ConfigurationImage
        {
            var _loc_3:*;
            var _loc_4:Rectangle;
            var _loc_5:Sprite;
            var _loc_6:Bitmap;
            var _loc_2:* = param1 ? (param1) : (new ConfigurationImage(this._imageId));
            _loc_2.isLoaded = isLoaded;
            _loc_2._colors = this._colors.slice();
            _loc_2._layerDefinitions = this._layerDefinitions.concat();
            _loc_2._image = new Sprite();
            _loc_2.addChild(_loc_2._image);
            for each (_loc_3 in _loc_2._layerDefinitions)
            {
                
                if (_loc_3 is Class)
                {
                    _loc_5 = Sprite(new _loc_3);
                    _loc_2._layers.push(_loc_5);
                    _loc_2._image.addChild(_loc_5);
                    continue;
                }
                _loc_6 = new Bitmap(Bitmap(_loc_3).bitmapData);
                _loc_6.smoothing = true;
                _loc_2._layers.push(_loc_6);
                _loc_2._image.addChild(_loc_6);
            }
            _loc_4 = _loc_2.getBounds(_loc_2);
            _loc_2.setActualSize(_loc_4.width, _loc_4.height);
            return _loc_2;
        }// end function

        public function get isVectorImage() : Boolean
        {
            if (this._layerDefinitions.length > 0)
            {
            }
            return this._colors.length > 0;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            if (!this._image)
            {
                return;
            }
            this._image.width = width;
            this._image.height = height;
            return;
        }// end function

        override function contentLoaderInfo_completeEventHandler(param1:Event) : void
        {
            var _loc_2:*;
            var _loc_3:Sprite;
            if (!content.hasOwnProperty("layers"))
            {
                log.error("Configuration image could not be created due to missing" + " layer definitions");
                dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR, false, false, "Configuration image could not be created due to missing layer definitions"));
                return;
            }
            if (this._image)
            {
                removeChild(this._image);
            }
            this._image = Sprite(content);
            this._layerDefinitions = this._image["layers"];
            this._colors = this._image["colors"];
            for each (_loc_2 in this._layerDefinitions)
            {
                
                if (_loc_2 is Class)
                {
                    _loc_3 = Sprite(new _loc_2);
                    this._layers.push(_loc_3);
                    continue;
                }
                Bitmap(_loc_2).smoothing = true;
                this._layers.push(_loc_2);
            }
            addChild(this._image);
            super.contentLoaderInfo_completeEventHandler(param1);
            return;
        }// end function

    }
}
