package net.sprd.components.common
{
    import flash.text.*;
    import mx.controls.*;

    public class MultilineButton extends Button
    {

        public function MultilineButton()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            textField.wordWrap = true;
            textField.multiline = true;
            textField.autoSize = TextFieldAutoSize.CENTER;
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            textField.y = (height - textField.textHeight) / 2;
            return;
        }// end function

    }
}
