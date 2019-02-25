package net.sprd.components.producttypeappeaeranceselector
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.system.*;
    import mx.controls.*;
    import net.sprd.common.colors.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.entities.*;
    import net.sprd.services.image.model.*;

    public class Swatch extends Button
    {
        private var _swatch:Sprite;
        private var appearanceChanged:Boolean;
        private var _appearance:IProductTypeAppearance;
        private var appearanceImage:CachedImage;
        private static const log:ILogger = LogContext.getLogger(this);

        public function Swatch()
        {
            buttonMode = true;
            mouseChildren = false;
            return;
        }// end function

        public function set appearance(param1:IProductTypeAppearance) : void
        {
            if (this._appearance == param1)
            {
                return;
            }
            this._appearance = param1;
            this.appearanceChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get appearance() : IProductTypeAppearance
        {
            return this._appearance;
        }// end function

        override protected function commitProperties() : void
        {
            if (this.appearanceChanged)
            {
                this.appearanceChanged = false;
                if (this.isMonochromatic)
                {
                    this.drawSwatch();
                }
                else
                {
                    this.loadAppearance();
                }
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            mouseChildren = false;
            this._swatch = new Sprite();
            addChild(this._swatch);
            this.appearanceImage = new CachedImage();
            this.appearanceImage.autoLoad = false;
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            measuredHeight = 20;
            measuredWidth = 20;
            return;
        }// end function

        private function getHexColor(param1:String) : uint
        {
            return ColorUtil.getIntegerColor(param1);
        }// end function

        private function get isMonochromatic() : Boolean
        {
            var _loc_2:String;
            if (!this._appearance)
            {
                return true;
            }
            var _loc_1:* = this._appearance.colors[0];
            if (this._appearance.colors.length > 1)
            {
                for each (_loc_2 in this._appearance.colors)
                {
                    
                    if (_loc_2 != _loc_1)
                    {
                        return false;
                    }
                    _loc_1 = _loc_2;
                }
            }
            return true;
        }// end function

        private function loadAppearance() : void
        {
            var context:* = new LoaderContext();
            context.checkPolicyFile = true;
            this.appearanceImage.source = this._appearance.previewURI;
            this.appearanceImage.loaderContext = context;
            with ({})
            {
                {}.complete = function (param1) : void
            {
                drawSwatch();
                return;
            }// end function
            ;
            }
            with ({})
            {
                {}.error = function (param1) : void
            {
                log.warn("Error loading swatch for color: " + _appearance.id);
                return;
            }// end function
            ;
            }
            EventUtil.registerOnetimeListeners(this.appearanceImage, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [function (param1) : void
            {
                drawSwatch();
                return;
            }// end function
            , function (param1) : void
            {
                log.warn("Error loading swatch for color: " + _appearance.id);
                return;
            }// end function
            ]);
            this.appearanceImage.load();
            return;
        }// end function

        private function drawSwatch() : void
        {
            var data:BitmapData;
            var scalingMatrix:Matrix;
            this._swatch.graphics.clear();
            if (!this._appearance)
            {
                return;
            }
            if (this.isMonochromatic)
            {
                this._swatch.graphics.beginFill(this.getHexColor(this._appearance.colors[0]), 1);
            }
            else
            {
                data = new BitmapData(this.appearanceImage.contentWidth, this.appearanceImage.contentHeight);
                try
                {
                    data.draw(this.appearanceImage);
                }
                catch (error:Error)
                {
                    log.info("could not draw product type appearance swatch. " + error);
                }
                scalingMatrix = new Matrix();
                scalingMatrix.scale(width / this.appearanceImage.contentWidth, height / this.appearanceImage.contentHeight);
                this._swatch.graphics.beginBitmapFill(data, scalingMatrix, false);
            }
            this._swatch.graphics.drawRect(width / 6, height / 6, width - width / 3, height - height / 3);
            this._swatch.graphics.endFill();
            return;
        }// end function

    }
}
