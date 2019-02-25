package net.sprd.components.common
{
    import flash.events.*;
    import mx.controls.*;

    public class ValidationTextInput extends AdvancedTextInput
    {
        private var _validationCallback:Function;
        private var _showInvalidStatePermanent:Boolean;
        private var _validState:Boolean;
        private var _validStateChanged:Boolean;
        private var _validMarker:Button;
        private var _invalidMarker:Button;
        private var _validTipText:String;
        private var _invalidTipText:String;
        private var _invalidTipTextChanged:Boolean;
        private var _validTipTextChanged:Boolean;
        private var _validationInvoked:Boolean;
        private var _initialTextValided:Boolean;

        public function ValidationTextInput()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this._validMarker = new Button();
            this._validMarker.styleName = "valid";
            this._validMarker.height = 12;
            this._validMarker.width = 12;
            this._validMarker.visible = false;
            this._validMarker.focusEnabled = false;
            addChild(this._validMarker);
            this._invalidMarker = new Button();
            this._invalidMarker.styleName = "invalid";
            this._invalidMarker.height = 12;
            this._invalidMarker.width = 12;
            this._invalidMarker.visible = false;
            this._invalidMarker.focusEnabled = false;
            addChild(this._invalidMarker);
            return;
        }// end function

        override protected function onChange(param1:Event) : void
        {
            super.onChange(param1);
            this.validateInternal();
            return;
        }// end function

        public function validate() : void
        {
            this.validateInternal(true);
            return;
        }// end function

        public function get isValid() : Boolean
        {
            return this._validState;
        }// end function

        private function validateInternal(param1:Boolean = false) : void
        {
            var _loc_2:Boolean;
            this._validationInvoked = param1;
            if (this.validationCallback)
            {
                _loc_2 = this.validationCallback(this, this.text);
                invalidateProperties();
                this._validStateChanged = true;
                if (_loc_2 != this._validState)
                {
                    this._validState = _loc_2;
                    dispatchEvent(new Event("validationChange"));
                }
            }
            return;
        }// end function

        public function get validationCallback() : Function
        {
            return this._validationCallback;
        }// end function

        public function set validationCallback(param1:Function) : void
        {
            this._validationCallback = param1;
            return;
        }// end function

        public function get showInvalidStatePermanent() : Boolean
        {
            return this._showInvalidStatePermanent;
        }// end function

        public function set showInvalidStatePermanent(param1:Boolean) : void
        {
            this._showInvalidStatePermanent = param1;
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this._validStateChanged)
            {
            }
            if (this._validMarker)
            {
            }
            if (this._invalidMarker)
            {
                this._validStateChanged = false;
                if (this._validState)
                {
                    this._validMarker.visible = true;
                    this._invalidMarker.visible = false;
                    _resetButton.visible = false;
                }
                else
                {
                    this._validMarker.visible = false;
                    this._invalidMarker.visible = false;
                    if (true)
                    {
                    }
                    if (this._validationInvoked)
                    {
                        this._invalidMarker.visible = true;
                        _resetButton.visible = false;
                    }
                }
            }
            if (hasFocus)
            {
                if (this._validMarker)
                {
                }
                if (true)
                {
                    if (this._invalidMarker)
                    {
                    }
                }
            }
            if (this._invalidMarker.visible)
            {
                _resetButton.visible = false;
            }
            if (this._invalidTipTextChanged)
            {
                this._invalidTipTextChanged = false;
                this._invalidMarker.toolTip = this._invalidTipText;
            }
            if (this._validTipTextChanged)
            {
                this._validTipTextChanged = false;
                this._validMarker.toolTip = this._validTipText;
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            if (this._invalidMarker)
            {
            }
            if (this._validMarker)
            {
            }
            if (this._invalidMarker.parent)
            {
            }
            if (this._validMarker.parent)
            {
                if (hasReset)
                {
                    this._invalidMarker.x = _resetButton.x;
                    this._invalidMarker.y = _resetButton.y;
                }
                else
                {
                    this._invalidMarker.x = textField.width - this._invalidMarker.width + 4;
                    this._invalidMarker.y = (textField.height - this._invalidMarker.height) / 2 + 1;
                }
                this._validMarker.x = this._invalidMarker.x;
                this._validMarker.y = this._invalidMarker.y;
                setChildIndex(this._invalidMarker, numChildren - 1);
                setChildIndex(this._validMarker, numChildren - 1);
            }
            return;
        }// end function

        override public function set text(param1:String) : void
        {
            super.text = param1;
            this.validateInternal();
            return;
        }// end function

    }
}
