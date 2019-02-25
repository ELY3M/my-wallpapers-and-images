package net.sprd.skins.d2c.viewSelector
{
    import mx.skins.*;

    public class ViewButtonSkin extends ProgrammaticSkin
    {

        public function ViewButtonSkin()
        {
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return 44;
        }// end function

        override public function get measuredHeight() : Number
        {
            return 44;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("selectionColor");
            var _loc_4:* = getStyle("borderColor");
            var _loc_5:* = getStyle("borderAlpha");
            var _loc_6:* = getStyle("backgroundColor");
            graphics.clear();
            switch(name)
            {
                case "upSkin":
                {
                    graphics.beginFill(_loc_4, _loc_5);
                    graphics.drawRoundRect(1, 1, width + 2, height + 2, 4, 4);
                    graphics.endFill();
                    graphics.beginFill(_loc_6);
                    graphics.drawRoundRect(2, 2, width, height, 4, 4);
                    break;
                }
                case "overSkin":
                case "downSkin":
                {
                    graphics.beginFill(_loc_3);
                    graphics.drawRoundRect(1, 1, width + 2, height + 2, 4, 4);
                    graphics.endFill();
                    graphics.beginFill(_loc_6);
                    graphics.drawRoundRect(2, 2, width, height, 4, 4);
                    break;
                }
                case "selectedUpSkin":
                case "selectedOverSkin":
                case "selectedDownSkin":
                {
                    graphics.beginFill(_loc_3);
                    graphics.drawRoundRect(0, 0, width + 4, height + 4, 6, 6);
                    graphics.endFill();
                    graphics.beginFill(_loc_6);
                    graphics.drawRoundRect(2, 2, width, height, 4, 4);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
