package net.sprd.skins.d2c
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import mx.core.*;

    public class ToolTipSkin extends UIComponent implements IProgrammaticSkin
    {
        private var _borderMetrics:EdgeMetrics;

        public function ToolTipSkin()
        {
            return;
        }// end function

        public function get borderMetrics() : EdgeMetrics
        {
            if (this._borderMetrics)
            {
                return this._borderMetrics;
            }
            var _loc_1:* = getStyle("borderStyle");
            switch(_loc_1)
            {
                case "errorTipRight":
                {
                    this._borderMetrics = new EdgeMetrics(15, 1, 3, 3);
                    break;
                }
                case "errorTipAbove":
                {
                    this._borderMetrics = new EdgeMetrics(3, 1, 3, 15);
                    break;
                }
                case "errorTipBelow":
                {
                    this._borderMetrics = new EdgeMetrics(3, 13, 3, 3);
                    break;
                }
                default:
                {
                    this._borderMetrics = new EdgeMetrics(3, 1, 3, 3);
                    break;
                    break;
                }
            }
            return this._borderMetrics;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_9:Class;
            var _loc_10:IFlexDisplayObject;
            var _loc_11:IFlexDisplayObject;
            var _loc_12:ColorTransform;
            var _loc_13:GlowFilter;
            var _loc_14:GlowFilter;
            var _loc_15:DropShadowFilter;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("backgroundColor");
            var _loc_4:* = getStyle("borderColor");
            var _loc_5:* = getStyle("borderStyle");
            var _loc_6:* = getStyle("shadowColor");
            var _loc_7:Number;
            var _loc_8:* = graphics;
            _loc_8.clear();
            switch(_loc_5)
            {
                case "toolTip":
                {
                    _loc_9 = Class(getStyle("backgroundImage"));
                    _loc_10 = IFlexDisplayObject(getChildByName("ttbg"));
                    _loc_11 = IFlexDisplayObject(getChildByName("ttfx"));
                    if (!_loc_10)
                    {
                        _loc_10 = IFlexDisplayObject(new _loc_9);
                        _loc_10.name = "ttbg";
                        _loc_10.cacheAsBitmap = true;
                        _loc_11 = IFlexDisplayObject(new _loc_9);
                        _loc_11.name = "ttfx";
                        _loc_11.cacheAsBitmap = true;
                        _loc_12 = new ColorTransform();
                        _loc_12.color = _loc_3;
                        _loc_10.transform.colorTransform = _loc_12;
                        _loc_13 = new GlowFilter(_loc_4, 1, 6, 6, 2, BitmapFilterQuality.HIGH, true);
                        _loc_14 = new GlowFilter(_loc_4, 1, 1.5, 1.5, 5, BitmapFilterQuality.HIGH, false);
                        _loc_15 = new DropShadowFilter(1, 90, 8550511, 0.5, 2, 2, 1, BitmapFilterQuality.HIGH);
                        _loc_10.filters = [_loc_13];
                        _loc_11.filters = [_loc_14, _loc_15];
                        _loc_10.cacheAsBitmap = true;
                        _loc_11.cacheAsBitmap = true;
                        addChild(DisplayObject(_loc_11));
                        addChild(DisplayObject(_loc_10));
                    }
                    _loc_10.width = width;
                    _loc_10.height = Math.ceil(height + 5);
                    _loc_11.width = Math.ceil(width);
                    _loc_11.height = height + 5;
                    break;
                }
                case "errorTipRight":
                {
                    drawRoundRect(x + 11, y + 5, param1 - 11, param2 - 5, 5, _loc_6, _loc_7);
                    drawRoundRect(x + 13, y + 4, param1 - 13, param2 - 5, 4, _loc_6, _loc_7);
                    drawRoundRect(x + 11, y, param1 - 11, param2 - 2, 3, _loc_4, 1);
                    drawRoundRect(x + 13, y + 1, param1 - 13, param2 - 4, 2, _loc_4, 1);
                    _loc_8.beginFill(_loc_6, _loc_7);
                    _loc_8.moveTo(x + 11, y + 7);
                    _loc_8.lineTo(x, y + 14);
                    _loc_8.lineTo(x + 11, y + 20);
                    _loc_8.moveTo(x + 11, y + 8);
                    _loc_8.endFill();
                    _loc_8.beginFill(_loc_4);
                    _loc_8.moveTo(x + 11, y + 7);
                    _loc_8.lineTo(x, y + 13);
                    _loc_8.lineTo(x + 11, y + 19);
                    _loc_8.moveTo(x + 11, y + 7);
                    _loc_8.endFill();
                    break;
                }
                case "errorTipAbove":
                {
                    drawRoundRect(x, y + 5, param1, param2 - 16, 5, _loc_6, _loc_7);
                    drawRoundRect(x + 1, y + 4, param1 - 2, param2 - 16, 4, _loc_6, _loc_7);
                    drawRoundRect(x, y, param1, param2 - 13, 3, _loc_4, 1);
                    drawRoundRect(x + 1, y + 1, param1 - 2, param2 - 15, 2, _loc_4, 1);
                    _loc_8.beginFill(_loc_6, _loc_7);
                    _loc_8.moveTo(x + 9, y + param2 - 11);
                    _loc_8.lineTo(x + 15, y + param2);
                    _loc_8.lineTo(x + 21, y + param2 - 11);
                    _loc_8.moveTo(x + 10, y + param2 - 11);
                    _loc_8.endFill();
                    _loc_8.beginFill(_loc_4);
                    _loc_8.moveTo(x + 9, y + param2 - 13);
                    _loc_8.lineTo(x + 15, y + param2 - 2);
                    _loc_8.lineTo(x + 21, y + param2 - 13);
                    _loc_8.moveTo(x + 9, y + param2 - 13);
                    _loc_8.endFill();
                    break;
                }
                case "errorTipBelow":
                {
                    drawRoundRect(x, y + 16, param1, param2 - 16, 5, _loc_6, _loc_7);
                    drawRoundRect(x + 1, y + 15, param1 - 2, param2 - 16, 4, _loc_6, _loc_7);
                    drawRoundRect(x, y + 11, param1, param2 - 13, 3, _loc_4, 1);
                    drawRoundRect(x + 1, y + 13, param1 - 2, param2 - 15, 2, _loc_4, 1);
                    _loc_8.beginFill(_loc_4);
                    _loc_8.moveTo(x + 9, y + 11);
                    _loc_8.lineTo(x + 15, y);
                    _loc_8.lineTo(x + 21, y + 11);
                    _loc_8.moveTo(x + 10, y + 11);
                    _loc_8.endFill();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            if (param1 != "borderStyle")
            {
            }
            if (param1 == "styleName")
            {
                this._borderMetrics = null;
            }
            invalidateDisplayList();
            return;
        }// end function

    }
}
