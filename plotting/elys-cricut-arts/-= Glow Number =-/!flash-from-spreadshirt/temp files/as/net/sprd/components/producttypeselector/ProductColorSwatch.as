package net.sprd.components.producttypeselector
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import mx.core.*;
    import net.sprd.common.colors.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.entities.*;
    import net.sprd.services.image.model.*;

    public class ProductColorSwatch extends UIComponent
    {
        private var _color:IProductTypeAppearance;
        private var _colorChanged:Boolean;
        private var _colorSwatch:Sprite;
        private var _externalColor:CachedImage;
        private var _shader:Sprite;
        private static const log:ILogger = LogContext.getLogger(this);

        public function ProductColorSwatch()
        {
            return;
        }// end function

        public function get color() : IProductTypeAppearance
        {
            return this._color;
        }// end function

        public function set color(param1:IProductTypeAppearance) : void
        {
            if (this._color == param1)
            {
                return;
            }
            this._color = param1;
            this._colorChanged = true;
            invalidateProperties();
            return;
        }// end function

        private function renderColor() : void
        {
            var _loc_2:Matrix;
            if (this._color)
            {
            }
            if (this._color.colors.length == 0)
            {
                return;
            }
            this._colorSwatch.graphics.clear();
            graphics.clear();
            graphics.beginFill(0, 0.1);
            graphics.drawRoundRect(0, 0, width, height, 5, 5);
            graphics.beginFill(16777215, 1);
            graphics.drawRoundRect(1, 1, width - 2, height - 2, 5, 5);
            if (this.isMonochromatic)
            {
                this._colorSwatch.graphics.beginFill(ColorUtil.getIntegerColor(this.color.colors[0]));
            }
            else
            {
                _loc_2 = new Matrix();
                _loc_2.scale(width / this._externalColor.content.width, height / this._externalColor.content.height);
                this._colorSwatch.graphics.beginBitmapFill(Bitmap(this._externalColor.content).bitmapData, _loc_2, true);
            }
            this._colorSwatch.graphics.drawRoundRect(3, 3, width - 6, height - 6, 3, 3);
            this._colorSwatch.graphics.endFill();
            var _loc_1:* = new GlowFilter(16777215, 0.3, 3, 3, 2, 3, true);
            this._colorSwatch.filters = [_loc_1];
            return;
        }// end function

        private function get isMonochromatic() : Boolean
        {
            return this._color.colors.length == 1;
        }// end function

        private function loadColor() : void
        {
            this._externalColor.source = this._color.previewURI;
            with ({})
            {
                {}.complete = function (param1) : void
            {
                renderColor();
                return;
            }// end function
            ;
            }
            with ({})
            {
                {}.error = function (param1) : void
            {
                log.warn("Could no load color: " + color.id);
                return;
            }// end function
            ;
            }
            EventUtil.registerOnetimeListeners(this._externalColor, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [function (param1) : void
            {
                renderColor();
                return;
            }// end function
            , function (param1) : void
            {
                log.warn("Could no load color: " + color.id);
                return;
            }// end function
            ]);
            this._externalColor.load();
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this._externalColor = new CachedImage();
            this._externalColor.autoLoad = false;
            this._colorSwatch = new Sprite();
            this._shader = new Sprite();
            addChild(this._colorSwatch);
            addChild(this._shader);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this._colorChanged)
            {
                this._colorChanged = false;
                if (this.isMonochromatic)
                {
                    this.renderColor();
                }
                else
                {
                    this.loadColor();
                }
            }
            return;
        }// end function

    }
}
