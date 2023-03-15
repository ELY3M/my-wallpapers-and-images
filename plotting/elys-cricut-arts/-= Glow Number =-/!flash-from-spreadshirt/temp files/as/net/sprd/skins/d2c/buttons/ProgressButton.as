package net.sprd.skins.d2c.buttons
{
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    import net.sprd.components.common.*;

    public class ProgressButton extends MultilineButton
    {
        private var _progressLabel:String;
        private var _isInProgress:Boolean;
        private var _cachedIndicator:DisplayObject;
        private var _autoSetEnabled:Boolean = true;
        private var progressIndicator:Class;
        var _orginalWidth:Number = 1.#QNAN;
        var _orginalHeight:Number = 1.#QNAN;
        var _colorChanged:Boolean = true;

        public function ProgressButton()
        {
            this.progressIndicator = ProgressButton_progressIndicator;
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this._cachedIndicator = new this.progressIndicator() as DisplayObject;
            this._orginalWidth = this._cachedIndicator.width;
            this._orginalHeight = this._cachedIndicator.height;
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:ColorTransform;
            super.commitProperties();
            if (this._colorChanged)
            {
                _loc_1 = new ColorTransform();
                _loc_1.color = getStyle("disabledColor");
                this._cachedIndicator.transform.colorTransform = _loc_1;
                this._colorChanged = false;
            }
            return;
        }// end function

        public function get autoSetEnabled() : Boolean
        {
            return this._autoSetEnabled;
        }// end function

        public function set autoSetEnabled(param1:Boolean) : void
        {
            this._autoSetEnabled = param1;
            return;
        }// end function

        public function get progressLabel() : String
        {
            return this._progressLabel;
        }// end function

        public function set progressLabel(param1:String) : void
        {
            this._progressLabel = param1;
            return;
        }// end function

        public function get isInProgress() : Boolean
        {
            return this._isInProgress;
        }// end function

        public function set isInProgress(param1:Boolean) : void
        {
            this._isInProgress = param1;
            invalidateSize();
            invalidateDisplayList();
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_5:Number;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("paddingLeft");
            var _loc_4:* = getStyle("paddingRight");
            if (this._isInProgress)
            {
                if (!this._cachedIndicator.parent)
                {
                    addChild(this._cachedIndicator);
                }
                _loc_5 = param2 - 4 - (getStyle("paddingTop") + getStyle("paddingBottom"));
                this._cachedIndicator.height = _loc_5;
                this._cachedIndicator.width = _loc_5 * this._orginalWidth / this._orginalHeight;
                this._cachedIndicator.visible = true;
                if (this.autoSetEnabled)
                {
                    useHandCursor = false;
                    enabled = false;
                }
                alpha = 0.7;
                textField.text = this._progressLabel;
                textField.autoSize = TextFieldAutoSize.LEFT;
                this._cachedIndicator.x = _loc_3 + this._cachedIndicator.width / 2;
                this._cachedIndicator.y = param2 / 2;
                textField.x = this._cachedIndicator.width + _loc_3;
                setChildIndex(DisplayObject(textField), numChildren - 1);
                setChildIndex(this._cachedIndicator, numChildren - 1);
                textField.setActualSize(param1 - textField.x, textField.height);
            }
            else
            {
                if (this.autoSetEnabled)
                {
                    enabled = true;
                    useHandCursor = true;
                }
                if (this._cachedIndicator.parent)
                {
                    removeChild(this._cachedIndicator);
                }
                this._cachedIndicator.visible = false;
                textField.text = label;
                textField.width = param1 - _loc_3 - _loc_4;
                textField.x = _loc_3;
                alpha = 1;
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            if (this.isInProgress)
            {
                measuredWidth = measuredWidth + this._orginalWidth + 10;
            }
            return;
        }// end function

    }
}
