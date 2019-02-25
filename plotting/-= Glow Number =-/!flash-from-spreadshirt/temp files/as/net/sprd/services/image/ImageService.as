package net.sprd.services.image
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.system.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.modules.share.*;
    import net.sprd.services.image.model.*;

    public class ImageService extends Object implements IImageService
    {
        private const MEDIATYPE_SWF:String = "swf";
        private const MEDIATYPE_PNG:String = "png";
        private const MAX_SIZE:uint = 600;
        private var _imageCache:Object;
        private var _duplicatedImages:Object;
        private var _endpointURI:String;
        private var _version:String;
        private static const log:ILogger = LogContext.getLogger(this);
        private static var _instance:ImageService = new ImageService;

        public function ImageService()
        {
            this._imageCache = {};
            this._duplicatedImages = {};
            if (_instance)
            {
                throw new Error("Singleton and can only be accessed through ImageService.getInstance()");
            }
            this._endpointURI = "http://image.spreadshirt.net/image-server";
            this._version = "1";
            return;
        }// end function

        public function get endPoint() : String
        {
            return this._endpointURI;
        }// end function

        public function set endPoint(param1:String) : void
        {
            this._endpointURI = param1;
            return;
        }// end function

        public function get version() : String
        {
            return this._version;
        }// end function

        public function set version(param1:String) : void
        {
            this._version = param1;
            return;
        }// end function

        public function productTypeImage(param1:String, param2:String, param3:String, param4:Number, param5:Number, param6:String) : ProductTypeImage
        {
            var _loc_7:ProductTypeImage;
            var _loc_11:BitmapData;
            var _loc_12:DisplayObject;
            var _loc_13:Matrix;
            var _loc_14:Number;
            var _loc_15:Bitmap;
            var _loc_16:LoaderContext;
            if (param1 == null)
            {
                log.warn("product type id is null");
                return null;
            }
            var _loc_8:* = param4;
            var _loc_9:* = param5;
            param4 = this.narrowDimension(param4);
            param5 = this.narrowDimension(param5);
            var _loc_10:* = "prodType_" + param1 + "_" + param2 + "_" + param3 + "_" + param4 + "_" + param5 + "_" + param6;
            if (this._imageCache[_loc_10])
            {
            }
            if (CachedImage(this._imageCache[_loc_10]).isLoaded)
            {
                _loc_11 = new BitmapData(_loc_8, _loc_9, true, null);
                _loc_12 = CachedImage(this._imageCache[_loc_10]).content;
                _loc_13 = new Matrix();
                _loc_14 = _loc_8 / _loc_12.getBounds(_loc_12).width;
                _loc_13.scale(_loc_14, _loc_14);
                _loc_11.draw(_loc_12, _loc_13, null, null, null, true);
                _loc_15 = new Bitmap(_loc_11);
                _loc_7 = new ProductTypeImage(param1, param2, param3);
                _loc_7.autoLoad = false;
                _loc_7.width = _loc_8;
                _loc_7.height = _loc_9;
                _loc_7.isLoaded = CachedImage(this._imageCache[_loc_10]).isLoaded;
                _loc_7.addChild(_loc_15);
            }
            else
            {
                _loc_7 = new ProductTypeImage(param1, param2, param3);
                _loc_7.autoLoad = false;
                _loc_7.width = _loc_8;
                _loc_7.height = _loc_9;
                _loc_7.source = this.createURI("productTypes/" + param1 + "/views/" + param2 + "/appearances/" + param3, param4, param5, param6);
                this._imageCache[_loc_10] = _loc_7;
                _loc_16 = new LoaderContext();
                _loc_16.checkPolicyFile = true;
                _loc_7.loaderContext = _loc_16;
            }
            return _loc_7;
        }// end function

        public function designImage(param1:String, param2:Number, param3:Number) : ConfigurationImage
        {
            var img:ConfigurationImage;
            var tmpImage:ConfigurationImage;
            var imgID:String;
            var imageId:* = param1;
            var width:* = param2;
            var height:* = param3;
            var mediaType:* = this.MEDIATYPE_SWF;
            width = width > this.MAX_SIZE ? (this.MAX_SIZE) : (width);
            height = height > this.MAX_SIZE ? (this.MAX_SIZE) : (height);
            img = this.findDesign(imageId);
            if (img)
            {
                tmpImage = img.duplicate();
                this._duplicatedImages["design_" + imageId] = true;
                tmpImage.autoLoad = false;
                if (!img.isLoaded)
                {
                    img.addEventListener(Event.COMPLETE, function () : void
            {
                img.duplicate(tmpImage);
                img.setActualSize(width, height);
                tmpImage.dispatchEvent(new Event(Event.COMPLETE));
                return;
            }// end function
            );
                    ;
                }
                return tmpImage;
            }
            else
            {
                imgID = "design_" + imageId;
                img = new ConfigurationImage(imageId);
                img.autoLoad = false;
                img.source = this.createURI("designs/" + imageId, -1, -1, null, mediaType);
                this._imageCache[imgID] = img;
            }
            return img;
        }// end function

        public function evictDesignImage(param1:String) : void
        {
            log.debug("Evicting design image: " + param1);
            var _loc_2:* = this.findDesign(param1);
            if (!_loc_2)
            {
                return;
            }
            delete this._imageCache["design_" + param1];
            _loc_2.cancel();
            return;
        }// end function

        public function evictProductImage(param1:String, param2:String, param3:Number, param4:Number) : void
        {
            log.debug("Evicting product image. id:" + param1 + " view: " + param2 + "width: " + param3 + " height: " + param4);
            var _loc_5:* = "prod_" + param1 + "_" + param2 + "_" + param3 + "_" + param4;
            var _loc_6:* = this._imageCache[_loc_5];
            if (!_loc_6)
            {
                return;
            }
            delete this._imageCache[_loc_5];
            _loc_6.cancel();
            return;
        }// end function

        private function createURI(param1:String, param2:Number = 0, param3:Number = 0, param4:String = null, param5:String = "") : String
        {
            var _loc_6:* = new Array();
            if (param2 > 0)
            {
                _loc_6.push("width=" + this.narrowDimension(param2));
            }
            if (param3 > 0)
            {
                _loc_6.push("height=" + this.narrowDimension(param3));
            }
            if (param4 != null)
            {
                _loc_6.push("renderer:backgroundColor=" + param4);
            }
            var _loc_7:* = this._endpointURI + "/v" + this._version + "/" + param1;
            _loc_7 = _loc_7 + (_loc_6.length > 0 ? ("," + _loc_6.join(",")) : (""));
            _loc_7 = _loc_7 + ("." + (param5 == "" ? (this.MEDIATYPE_PNG) : (param5)));
            return _loc_7;
        }// end function

        private function narrowDimension(param1:Number) : uint
        {
            if (param1 % 50 > 0)
            {
                param1 = Math.ceil(param1 / 50) * 50;
            }
            return param1;
        }// end function

        private function findDesign(param1:String) : ConfigurationImage
        {
            return this._imageCache["design_" + param1];
        }// end function

        public function productImage(param1:String, param2:String, param3:Number, param4:Number) : ProductImage
        {
            var _loc_5:ProductImage;
            var _loc_9:BitmapData;
            var _loc_10:DisplayObject;
            var _loc_11:Matrix;
            var _loc_12:Number;
            var _loc_13:Bitmap;
            var _loc_14:LoaderContext;
            if (param1 == null)
            {
                log.warn("product id is null");
                return null;
            }
            var _loc_6:* = param3;
            var _loc_7:* = param4;
            param3 = this.narrowDimension(param3);
            param4 = this.narrowDimension(param4);
            var _loc_8:* = "prod_" + param1 + "_" + param2 + "_" + param3 + "_" + param4;
            if (this._imageCache[_loc_8])
            {
            }
            if (CachedImage(this._imageCache[_loc_8]).isLoaded)
            {
                _loc_9 = new BitmapData(_loc_6, _loc_7, true, null);
                _loc_10 = CachedImage(this._imageCache[_loc_8]).content;
                _loc_11 = new Matrix();
                _loc_12 = _loc_6 / _loc_10.getBounds(_loc_10).width;
                _loc_11.scale(_loc_12, _loc_12);
                _loc_9.draw(_loc_10, _loc_11, null, null, null, true);
                _loc_13 = new Bitmap(_loc_9);
                _loc_5 = new ProductImage(param1, param2);
                _loc_5.autoLoad = false;
                _loc_5.width = _loc_6;
                _loc_5.height = _loc_7;
                _loc_5.isLoaded = CachedImage(this._imageCache[_loc_8]).isLoaded;
                _loc_5.addChild(_loc_13);
            }
            else
            {
                _loc_5 = new ProductImage(param1, param2);
                _loc_5.autoLoad = false;
                _loc_5.width = _loc_6;
                _loc_5.height = _loc_7;
                _loc_5.source = this.createURI("products/" + param1 + "/views/" + param2, param3, param4, null);
                this._imageCache[_loc_8] = _loc_5;
                _loc_14 = new LoaderContext();
                _loc_14.checkPolicyFile = true;
                _loc_5.loaderContext = _loc_14;
            }
            return _loc_5;
        }// end function

        public function productImageURL(param1:String, param2:String, param3:Number, param4:Number) : String
        {
            return this.createURI("products/" + param1 + "/views/" + param2, param3, param4, null);
        }// end function

        public static function getInstance() : ImageService
        {
            return _instance;
        }// end function

    }
}
