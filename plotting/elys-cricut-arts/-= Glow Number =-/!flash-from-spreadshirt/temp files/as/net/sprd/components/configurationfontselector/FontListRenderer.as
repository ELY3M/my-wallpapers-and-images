package net.sprd.components.configurationfontselector
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.engine.*;
    import mx.controls.listClasses.*;
    import net.sprd.entities.*;
    import net.sprd.text.*;

    public class FontListRenderer extends ListItemRenderer
    {
        private var _textContainer:Sprite;
        private var _textElement:TextElement;

        public function FontListRenderer()
        {
            return;
        }// end function

        override public function set data(param1:Object) : void
        {
            super.data = param1;
            var _loc_2:* = IFontFamily(param1);
            FontManager.getInstance().loadFontAsset(_loc_2, false, false, this.onComplete, this.onFault);
            return;
        }// end function

        private function onFault(param1:Event)
        {
            this._textContainer.visible = false;
            label.visible = true;
            invalidateDisplayList();
            return;
        }// end function

        private function onComplete(param1:Event) : void
        {
            var _loc_2:* = new FontDescription(IFontFamily(data).getEmbeddedFontName(), FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF);
            var _loc_3:* = new ElementFormat();
            _loc_3.fontDescription = _loc_2;
            _loc_3.fontSize = 16;
            while (this._textContainer.numChildren > 0)
            {
                
                this._textContainer.removeChildAt(0);
            }
            var _loc_4:* = new TextBlock();
            this._textElement = new TextElement(IFontFamily(data).name, _loc_3);
            _loc_4.content = this._textElement;
            this._textContainer.addChild(_loc_4.createTextLine());
            this._textContainer.visible = true;
            label.visible = false;
            invalidateDisplayList();
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this._textContainer = new Sprite();
            var _loc_1:* = new Sprite();
            _loc_1.graphics.beginFill(16711680);
            _loc_1.graphics.drawRect(0, 0, 120, 50);
            addChild(_loc_1);
            this._textContainer.mask = _loc_1;
            addChild(this._textContainer);
            this._textContainer.visible = false;
            this._textContainer.mouseChildren = false;
            this._textContainer.mouseEnabled = false;
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:Rectangle;
            var _loc_4:uint;
            var _loc_5:ListBase;
            var _loc_6:ElementFormat;
            super.updateDisplayList(param1, param2);
            if (data)
            {
            }
            if (parent)
            {
            }
            if (this._textContainer.visible)
            {
                _loc_3 = this._textContainer.getBounds(this._textContainer);
                this._textContainer.y = (param2 - _loc_3.height) / 2 - _loc_3.y;
                _loc_5 = ListBase(listData.owner);
                if (!enabled)
                {
                    _loc_4 = getStyle("disabledColor");
                }
                else if (_loc_5.isItemHighlighted(listData.uid))
                {
                    _loc_4 = getStyle("textRollOverColor");
                }
                else if (_loc_5.isItemSelected(listData.uid))
                {
                    _loc_4 = getStyle("textSelectedColor");
                }
                else
                {
                    _loc_4 = getStyle("color");
                }
                _loc_6 = this._textElement.elementFormat.clone();
                _loc_6.color = _loc_4;
                this._textElement.elementFormat = _loc_6;
                this._textContainer.removeChildAt(0);
                this._textContainer.addChild(this._textElement.textBlock.createTextLine());
            }
            return;
        }// end function

    }
}
