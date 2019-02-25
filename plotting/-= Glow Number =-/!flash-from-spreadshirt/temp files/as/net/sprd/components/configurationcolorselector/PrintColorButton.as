package net.sprd.components.configurationcolorselector
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.net.*;
    import net.sprd.common.colors.*;
    import net.sprd.components.common.*;
    import net.sprd.entities.*;
    import net.sprd.models.product.rules.*;

    public class PrintColorButton extends ArrowButton
    {
        private var _color:uint;
        private var _colorChanged:Boolean;
        private var _colorSquare:Sprite;
        private var _printType:IPrintType;
        private var _printTypeChanged:Boolean;

        public function PrintColorButton()
        {
            return;
        }// end function

        public function get color() : uint
        {
            return this._color;
        }// end function

        public function set color(param1:uint) : void
        {
            if (this.color == param1)
            {
                return;
            }
            this._color = param1;
            this._colorChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get printType() : IPrintType
        {
            return this._printType;
        }// end function

        public function set printType(param1:IPrintType) : void
        {
            if (this.printType == param1)
            {
                return;
            }
            this._printType = param1;
            this._printTypeChanged = true;
            invalidateProperties();
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this._colorSquare = new Sprite();
            addChild(this._colorSquare);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            var _loc_1:Boolean;
            if (this._colorChanged)
            {
                this._colorChanged = false;
                _loc_1 = true;
            }
            if (this._printTypeChanged)
            {
                this._printTypeChanged = false;
                _loc_1 = true;
            }
            if (_loc_1)
            {
                _loc_1 = false;
                this.redrawColorSquare();
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            this._colorSquare.x = 10;
            this._colorSquare.y = (param2 - this._colorSquare.height) / 2;
            setChildIndex(this._colorSquare, numChildren - 1);
            this._colorSquare.visible = param2 > 1;
            return;
        }// end function

        override public function drawFocus(param1:Boolean) : void
        {
            super.drawFocus(param1);
            filters = [];
            return;
        }// end function

        private function redrawColorSquare() : void
        {
            var _loc_3:IPrintColor;
            var _loc_4:Loader;
            if (this.printType)
            {
            }
            if (this.printType.colorSpace == ColorSpace.PRINTCOLORS)
            {
                _loc_3 = PrintTypeRules.getPrintColorForRGBColor(this.printType, Color.fromHex(this.color));
                if (PrintTypeRules.isSpecialColor(_loc_3))
                {
                    _loc_4 = new Loader();
                    _loc_4.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onPrintColorComplete);
                    _loc_4.load(new URLRequest(_loc_3.iconURI));
                }
            }
            this._colorSquare.graphics.clear();
            this._colorSquare.graphics.beginFill(this.color);
            this._colorSquare.graphics.drawRoundRect(0, 0, 15, 15, 5, 5);
            var _loc_1:* = new GlowFilter(8550511, 0.25, 2, 2, 3, BitmapFilterQuality.HIGH);
            var _loc_2:* = new DropShadowFilter(5, 90, 16777215, 0.5, 4, 4, 1, BitmapFilterQuality.HIGH, true);
            this._colorSquare.filters = [_loc_2, _loc_1];
            return;
        }// end function

        private function onPrintColorComplete(param1:Event) : void
        {
            LoaderInfo(param1.target).removeEventListener(Event.COMPLETE, this.onPrintColorComplete);
            var _loc_2:* = LoaderInfo(param1.target).content;
            var _loc_3:* = new BitmapData(_loc_2.width, _loc_2.height);
            _loc_3.draw(_loc_2);
            this._colorSquare.graphics.clear();
            this._colorSquare.graphics.beginBitmapFill(_loc_3);
            this._colorSquare.graphics.drawRoundRect(0, 0, 15, 15, 5, 5);
            return;
        }// end function

    }
}
