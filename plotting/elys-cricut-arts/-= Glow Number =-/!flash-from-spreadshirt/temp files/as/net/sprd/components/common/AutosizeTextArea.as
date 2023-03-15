package net.sprd.components.common
{
    import mx.controls.*;
    import mx.events.*;

    public class AutosizeTextArea extends TextArea
    {
        private var textChanged:Boolean;

        public function AutosizeTextArea()
        {
            return;
        }// end function

        override public function set htmlText(param1:String) : void
        {
            super.htmlText = param1;
            this.textChanged = true;
            invalidateProperties();
            invalidateSize();
            return;
        }// end function

        override public function set text(param1:String) : void
        {
            super.text = param1;
            this.textChanged = true;
            invalidateProperties();
            invalidateSize();
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = Math.max(textField.textHeight, measureText(this.text).height, minHeight);
            measuredHeight = Math.max(textField.textHeight, measureText(this.text).height, minHeight);
            measuredMinHeight = _loc_1;
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:Number;
            super.commitProperties();
            if (this.textChanged)
            {
                this.textChanged = false;
                textField.validateNow();
                _loc_1 = Math.max(textField.measuredHeight, measureText(this.text).height, minHeight) + 2;
                if (this.height != _loc_1)
                {
                    this.height = _loc_1;
                    dispatchEvent(new ResizeEvent(ResizeEvent.RESIZE));
                }
            }
            return;
        }// end function

    }
}
