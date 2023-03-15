package net.sprd.modules.share
{
    import mx.controls.tabBarClasses.*;

    public class ShareTabComponent extends Tab
    {

        public function ShareTabComponent()
        {
            return;
        }// end function

        override function layoutContents(param1:Number, param2:Number, param3:Boolean) : void
        {
            super.layoutContents(param1, param2, param3);
            this.labelPlacement = "bottom";
            if (currentIcon)
            {
                currentIcon.y = currentIcon.y + 3;
            }
            if (textField)
            {
                textField.y = textField.y + 5;
                textField.x = textField.x - 5;
                textField.width = textField.width + 6;
            }
            if (selected)
            {
                var _loc_4:* = textField;
                _loc_4.y = textField.y--;
                if (currentIcon)
                {
                    var _loc_4:* = currentIcon;
                    _loc_4.y = currentIcon.y--;
                }
            }
            return;
        }// end function

    }
}
