package net.sprd.components.common
{
    import flash.events.*;
    import mx.controls.*;

    public class AdvancedTextInput extends TextInput
    {
        private var _hasReset:Boolean;
        private var _resetTipText:String;
        private var _resetTipTextChanged:Boolean;
        protected var _resetButton:Button;
        private var _textChanged:Boolean;
        private var _defaultTextLabel:Label;
        private var _defaultTextChanged:Boolean;
        private var _defaultText:String;
        private var _hasFocus:Boolean;
        private var _focusChanged:Boolean;

        public function AdvancedTextInput()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this._resetButton = new Button();
            this._resetButton.styleName = "resetButton";
            this._resetButton.addEventListener(MouseEvent.CLICK, this.onResetClick);
            this._resetButton.width = 12;
            this._resetButton.height = 12;
            this._resetButton.focusEnabled = false;
            addChild(this._resetButton);
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

        public function get hasReset() : Boolean
        {
            return this._hasReset;
        }// end function

        public function set hasReset(param1:Boolean) : void
        {
            this._hasReset = param1;
            return;
        }// end function

        public function get resetTipText() : String
        {
            return this._resetTipText;
        }// end function

        public function set resetTipText(param1:String) : void
        {
            this._resetTipText = param1;
            this._resetTipTextChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get hasFocus() : Boolean
        {
            return this._hasFocus;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this._resetTipTextChanged)
            {
                this._resetTipTextChanged = false;
                this._resetButton.toolTip = this._resetTipText;
            }
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

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            this.updateVisibilities();
            if (this._defaultTextLabel)
            {
                this._defaultTextLabel.width = textField.width;
                this._defaultTextLabel.height = textField.height;
                this._defaultTextLabel.y = param2 / 2 - this._defaultTextLabel.height / 2;
                this._defaultTextLabel.x = textField.x;
                setChildIndex(this._defaultTextLabel, numChildren - 1);
                this._defaultTextLabel.invalidateProperties();
                this._defaultTextLabel.invalidateDisplayList();
            }
            if (this.hasReset)
            {
                this._resetButton.useHandCursor = true;
                this._resetButton.x = textField.width - this._resetButton.width + 4;
                this._resetButton.y = (textField.height - this._resetButton.height) / 2 + 1;
                setChildIndex(this._resetButton, numChildren - 1);
                textField.width = param1 - textField.x - 20;
            }
            return;
        }// end function

        private function updateVisibilities() : void
        {
            if (this.hasReset)
            {
            }
            if (this._hasFocus)
            {
            }
            this._resetButton.visible = text != "";
            this._defaultTextLabel.visible = text == "";
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

        protected function onChange(param1:Event) : void
        {
            this._textChanged = true;
            invalidateProperties();
            return;
        }// end function

        private function onResetClick(param1:MouseEvent) : void
        {
            if (!this._resetButton.enabled)
            {
                return;
            }
            param1.stopImmediatePropagation();
            text = "";
            dispatchEvent(new Event("onReset"));
            this._textChanged = true;
            invalidateProperties();
            invalidateDisplayList();
            return;
        }// end function

    }
}
