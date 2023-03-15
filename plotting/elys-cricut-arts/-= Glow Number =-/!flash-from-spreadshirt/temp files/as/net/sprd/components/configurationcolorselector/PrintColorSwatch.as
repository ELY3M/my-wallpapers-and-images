package net.sprd.components.configurationcolorselector
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.net.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;
    import net.sprd.common.colors.*;
    import net.sprd.entities.*;
    import net.sprd.models.product.rules.*;
    import net.sprd.services.image.*;

    public class PrintColorSwatch extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer
    {
        private var _printColor:IPrintColor;
        private var _printColorChanged:Boolean;
        private var _colorSwatch:Sprite;
        private var _listData:ListData;
        private var _loadedSwatch:Loader;

        public function PrintColorSwatch() : void
        {
            useHandCursor = true;
            mouseChildren = false;
            buttonMode = true;
            return;
        }// end function

        public function get data() : Object
        {
            return this._printColor;
        }// end function

        public function set data(param1:Object) : void
        {
            this._printColor = IPrintColor(param1);
            this._printColorChanged = true;
            invalidateProperties();
            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
            return;
        }// end function

        public function get listData() : BaseListData
        {
            return this._listData;
        }// end function

        public function set listData(param1:BaseListData) : void
        {
            this._listData = ListData(param1);
            invalidateProperties();
            return;
        }// end function

        private function updateColor() : void
        {
            var _loc_4:IImageService;
            var _loc_5:BitmapData;
            if (PrintTypeRules.isSpecialColor(this._printColor))
            {
                PrintTypeRules.isSpecialColor(this._printColor);
            }
            if (!this._loadedSwatch)
            {
                _loc_4 = ImageService.getInstance();
                this._loadedSwatch = new Loader();
                this._loadedSwatch.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onColorComplete);
                this._loadedSwatch.load(new URLRequest(_loc_4.endPoint + "/v" + _loc_4.version + "/printColors/" + this._printColor.id));
                return;
            }
            var _loc_1:* = this._colorSwatch.graphics;
            _loc_1.clear();
            if (PrintTypeRules.isSpecialColor(this._printColor))
            {
                PrintTypeRules.isSpecialColor(this._printColor);
            }
            if (this._loadedSwatch)
            {
            }
            if (this._loadedSwatch.content)
            {
                _loc_5 = new BitmapData(this._loadedSwatch.content.width, this._loadedSwatch.content.height);
                _loc_5.draw(this._loadedSwatch);
                _loc_1.beginBitmapFill(_loc_5);
            }
            else
            {
                _loc_1.beginFill(ColorUtil.getIntegerColor(this._printColor.hexCode));
            }
            _loc_1.drawRoundRect(0, 0, 14, 14, 5, 5);
            _loc_1.endFill();
            var _loc_2:* = new GlowFilter(8550511, 0.3, 2, 2, 3, 3);
            var _loc_3:* = new DropShadowFilter(5, 90, 16777215, 0.4, 4, 4, 1, 3, true);
            filters = [_loc_3, _loc_2];
            return;
        }// end function

        private function updateToolTip() : void
        {
            var _loc_1:* = ListBase(this._listData.owner);
            if (_loc_1.showDataTips)
            {
                if (_loc_1.dataTipFunction != null)
                {
                    toolTip = _loc_1.itemToDataTip(this._printColor);
                }
                else
                {
                    toolTip = null;
                }
            }
            else
            {
                toolTip = null;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this._colorSwatch = new Sprite();
            this._colorSwatch.x = 2;
            addChild(this._colorSwatch);
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this._printColorChanged)
            {
                this._printColorChanged = false;
                this.updateColor();
                this.updateToolTip();
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:int;
            measuredMinHeight = 16;
            measuredHeight = _loc_1;
            var _loc_1:int;
            measuredMinWidth = 16;
            measuredWidth = _loc_1;
            return;
        }// end function

        private function onColorComplete(param1:Event) : void
        {
            LoaderInfo(param1.target).removeEventListener(Event.COMPLETE, this.onColorComplete);
            this.updateColor();
            return;
        }// end function

    }
}
