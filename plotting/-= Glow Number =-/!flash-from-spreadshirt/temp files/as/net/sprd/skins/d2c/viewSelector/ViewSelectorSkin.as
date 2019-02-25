package net.sprd.skins.d2c.viewSelector
{
    import mx.core.*;
    import mx.skins.*;

    public class ViewSelectorSkin extends Border
    {

        public function ViewSelectorSkin()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_4:uint;
            var _loc_5:uint;
            super.updateDisplayList(param1, param2);
            var _loc_3:String;
            if (parent)
            {
                _loc_3 = UIComponent(parent).currentState;
            }
            switch(_loc_3)
            {
                case "open":
                {
                    _loc_4 = getStyle("backgroundColor");
                    _loc_5 = getStyle("borderColor");
                    graphics.beginFill(_loc_5);
                    graphics.drawRoundRect(-10, -2, param1 + 20, param2, 4, 4);
                    graphics.beginFill(_loc_4);
                    graphics.drawRoundRect(-9, -1, param1 + 18, param2 - 2, 4, 4);
                    break;
                }
                case "closed":
                {
                    graphics.clear();
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
