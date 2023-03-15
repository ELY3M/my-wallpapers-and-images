package net.sprd.skins.modules.share
{
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.controls.tabBarClasses.*;
    import mx.skins.*;

    public class TabSkin extends Border
    {
        private static var tabnavs:Object = {};

        public function TabSkin()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_8:Tab;
            super.updateDisplayList(param1, param2);
            if (this.parent is Tab)
            {
                _loc_8 = Tab(this.parent);
                _loc_8.labelPlacement = "bottom";
            }
            var _loc_3:* = getStyle("cornerRadius");
            var _loc_4:* = getStyle("fillColors");
            var _loc_5:* = getStyle("fillAlphas");
            var _loc_6:* = getStyle("borderColor");
            var _loc_7:* = new Matrix();
            _loc_7.createGradientBox(param1, param2, SkinUtil.deg2rad(90));
            graphics.clear();
            graphics.beginFill(16777215, 0);
            graphics.drawRect(0, 0, param1, param2);
            graphics.endFill();
            switch(name)
            {
                case "overSkin":
                {
                    graphics.beginGradientFill(GradientType.LINEAR, [16250871, 15132390], [0, 0.5], [100, 255], _loc_7);
                    graphics.drawRect(0, 0, param1, param2);
                    graphics.endFill();
                    break;
                }
                case "downSkin":
                case "selectedUpSkin":
                case "selectedDownSkin":
                case "selectedOverSkin":
                {
                    graphics.beginGradientFill(GradientType.LINEAR, [16250871, 15132390], [0, 1], [0, 255], _loc_7);
                    graphics.drawRect(0, 0, param1, param2);
                    graphics.endFill();
                    break;
                }
                case "disabledSkin":
                case "selectedDisabledSkin":
                {
                }
                default:
                {
                    break;
                }
            }
            switch(name)
            {
                case "upSkin":
                case "overSkin":
                {
                    graphics.lineStyle(1, 15395303);
                    graphics.moveTo(0, param2 - 1);
                    graphics.lineTo(param1, param2 - 1);
                    graphics.lineStyle(1, 16777215);
                    graphics.moveTo(0, param2);
                    graphics.lineTo(param1, param2);
                    graphics.lineStyle();
                }
                default:
                {
                    break;
                }
            }
            graphics.beginGradientFill(GradientType.LINEAR, [16250871, 13619151, 16250871], [0, 1, 0], [0, 127, 255], _loc_7);
            graphics.drawRect(0, 0, 1, param2);
            graphics.endFill();
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
