package net.sprd.components.common
{
    import flash.events.*;
    import mx.controls.*;

    public class AdvancedTextArea extends TextArea
    {
        private var _textChanged:Boolean;
        private var _defaultTextLabel:Label;
        private var _defaultTextChanged:Boolean;
        private var _defaultText:String;
        private var _hasFocus:Boolean;
        private var _focusChanged:Boolean;

        public function AdvancedTextArea()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this._defaultTextLabel = new Label();
            this._defaultTextLabel.styleName = "defaultText";
            this._defaultTextLabel.visible = false;
            this._defaultTextLabel.focusEnabled = false;
            addChild(this._defaultTextLabel);
            textField.addEventListener(FocusEvent.FOCUS_IN, this.onFocusChange);
            textField.addEventListener(FocusEvent.FOCUS_OUT, this.onFocusChange);
            addEventListener(Event.CHANGE, this.onChange);
            return;
        }// end function

        public function get defaultText() : String
        {
            return this._defaultText;
        }// end function

        public function set defaultText(param1:String) : void
        {
            this._defaultText = param1;
            this._defaultTextChanged = true;
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this._defaultTextChanged)
            {
                this._defaultTextChanged = false;
                this._defaultTextLabel.text = this._defaultText;
                this._defaultTextLabel.invalidateProperties();
                this._defaultTextLabel.invalidateSize();
            }
            if (true)
            {
            }
            if (this._focusChanged)
            {
                this._textChanged = false;
                textField.text = text;
                this.updateVisibilities();
            }
            return;
        }// end function

        private function updateVisibilities() : void
        {
            this._defaultTextLabel.visible = text == "";
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            this.updateVisibilities();
            this._defaultTextLabel.width = textField.width;
            this._defaultTextLabel.height = textField.height;
            this._defaultTextLabel.y = textField.y;
            this._defaultTextLabel.x = textField.x;
            setChildIndex(this._defaultTextLabel, numChildren - 1);
            return;
        }// end function

        private function onFocusChange(param1:FocusEvent) : void
        {
            if (param1.type == FocusEvent.FOCUS_IN)
            {
                this._hasFocus = true;
            }
            if (param1.type == FocusEvent.FOCUS_OUT)
            {
                this._hasFocus = false;
            }
            this._focusChanged = true;
            invalidateProperties();
            return;
        }// end function

        private function onChange(param1:Event) : void
        {
            this._textChanged = true;
            invalidateProperties();
            return;
        }// end function

    }
}
