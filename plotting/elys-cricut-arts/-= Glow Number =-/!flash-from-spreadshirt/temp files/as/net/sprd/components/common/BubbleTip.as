package net.sprd.components.common
{
    import mx.controls.*;

    public class BubbleTip extends ToolTip
    {

        public function BubbleTip()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            if (styleName == "errorTipBelow")
            {
                return;
            }
            textField.move(-10, -48);
            border.width = Math.round(border.width + 10);
            border.move(-20, -50);
            return;
        }// end function

    }
}
