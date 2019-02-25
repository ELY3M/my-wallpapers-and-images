package net.sprd.skins.d2c
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.controls.*;
    import mx.skins.*;
    import mx.utils.*;
    import net.sprd.common.graphics.*;

    public class TabSkin extends Border
    {
        private static var tabnavs:Object = {};

        public function TabSkin()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_4:Array;
            var _loc_11:DropShadowFilter;
            var _loc_12:Array;
            var _loc_13:uint;
            var _loc_14:String;
            super.updateDisplayList(param1, param2);
            if (parent)
            {
            }
            if (!parent.parent)
            {
                return;
            }
            var _loc_3:* = getStyle("cornerRadius");
            _loc_4 = getStyle("fillColors");
            var _loc_5:* = getStyle("fillAlphas");
            var _loc_6:* = getStyle("borderColor");
            var _loc_7:* = TabBar(parent.parent).getChildIndex(parent);
            var _loc_8:* = _loc_7 == 0 ? (0) : (_loc_3);
            var _loc_9:* = _loc_7 == 0 ? (_loc_3) : (0);
            var _loc_10:* = new Matrix();
            graphics.clear();
            switch(name)
            {
                case "upSkin":
                case "overSkin":
                {
                    graphics.beginFill(0, 0.5);
                    graphics.drawRoundRectComplex(-1, -1, param1 + 2, param2 + 1, _loc_8, _loc_9, 0, 0);
                    graphics.endFill();
                    _loc_10.createGradientBox(param1, param2, UnitUtil.deg2rad(270));
                    graphics.beginGradientFill(GradientType.LINEAR, _loc_4, _loc_5, [0, 127], _loc_10);
                    graphics.drawRoundRectComplex(0, 0, param1, param2, _loc_8, _loc_9, 0, 0);
                    _loc_11 = new DropShadowFilter(1, 90, 16777215, 0.9, 3, 3, 1, 3, true);
                    filters = [_loc_11];
                    graphics.lineStyle(1, 0, 0.2);
                    graphics.moveTo(-1, param2);
                    graphics.lineTo(param1 - 1, param2);
                    break;
                }
                case "downSkin":
                case "selectedUpSkin":
                case "selectedDownSkin":
                case "selectedOverSkin":
                {
                    graphics.beginFill(0, 0.5);
                    graphics.drawRoundRectComplex(-1, -1, param1 + 2, param2 + 1, _loc_8, _loc_9, 0, 0);
                    graphics.endFill();
                    _loc_10.createGradientBox(param1, param2, UnitUtil.deg2rad(90));
                    graphics.beginGradientFill(GradientType.LINEAR, _loc_4, _loc_5, [0, 255], _loc_10);
                    graphics.drawRoundRectComplex(0, 0, param1, param2, _loc_8, _loc_9, 0, 0);
                    _loc_11 = new DropShadowFilter(1, 90, 16777215, 0.9, 3, 3, 1, 3, true);
                    filters = [_loc_11];
                    graphics.lineStyle(1, 0, 0.01);
                    graphics.moveTo(-1, param2);
                    graphics.lineTo(param1 - 1, param2);
                    break;
                }
                case "disabledSkin":
                case "selectedDisabledSkin":
                {
                    _loc_12 = _loc_4.concat();
                    _loc_13 = 0;
                    for each (_loc_14 in _loc_12)
                    {
                        
                        _loc_12[_loc_13] = ColorUtil.adjustBrightness(_loc_12[_loc_13++], 10);
                    }
                    graphics.beginFill(0, 0.3);
                    graphics.drawRoundRectComplex(-1, -1, param1 + 2, param2 + 1, _loc_8, _loc_9, 0, 0);
                    graphics.endFill();
                    _loc_10.createGradientBox(param1, param2, UnitUtil.deg2rad(90));
                    graphics.beginGradientFill(GradientType.LINEAR, _loc_12, _loc_5, [0, 255], _loc_10);
                    graphics.drawRoundRectComplex(0, 0, param1, param2, _loc_8, _loc_9, 0, 0);
                    _loc_11 = new DropShadowFilter(1, 90, 16777215, 0.9, 3, 3, 1, 3, true);
                    filters = [_loc_11];
                    graphics.lineStyle(1, 0, 0.2);
                    graphics.moveTo(-1, param2);
                    graphics.lineTo(param1 - 1, param2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private static function isTabNavigator(param1:Object) : Boolean
        {
            var s:String;
            var x:XML;
            var parent:* = param1;
            s = getQualifiedClassName(parent);
            if (tabnavs[s] == 1)
            {
                return true;
            }
            if (tabnavs[s] == 0)
            {
                return false;
            }
            if (s == "mx.containers::TabNavigator")
            {
                return true;
            }
            x = describeType(parent);
            var _loc_4:int;
            var _loc_5:* = x.extendsClass;
            var _loc_3:* = new XMLList("");
            for each (_loc_6 in _loc_5)
            {
                
                var _loc_7:* = _loc_6;
                with (_loc_6)
                {
                    if (@type == "mx.containers::TabNavigator")
                    {
                        _loc_3[_loc_4] = _loc_6;
                    }
                }
            }
            var xmllist:* = _loc_3;
            if (xmllist.length() == 0)
            {
                tabnavs[s] = 0;
                return false;
            }
            tabnavs[s] = 1;
            return true;
        }// end function

    }
}
