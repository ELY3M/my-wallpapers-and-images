package net.sprd.components.common.toolpanel
{
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;

    public class ToolPanel extends Panel
    {
        private var _closeButton:Button;
        private var _isDragable:Boolean;
        private var _hasCloseButton:Boolean;

        public function ToolPanel()
        {
            this._hasCloseButton = true;
            return;
        }// end function

        public function get isDragable() : Boolean
        {
            return this._isDragable;
        }// end function

        public function set isDragable(param1:Boolean) : void
        {
            if (param1 == this.isDragable)
            {
                return;
            }
            this._isDragable = param1;
            invalidateDisplayList();
            return;
        }// end function

        public function get hasCloseButton() : Boolean
        {
            return this._hasCloseButton;
        }// end function

        public function set hasCloseButton(param1:Boolean) : void
        {
            if (param1 == this.hasCloseButton)
            {
                return;
            }
            this._hasCloseButton = param1;
            invalidateDisplayList();
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this._closeButton = new Button();
            this._closeButton.setActualSize(15, 15);
            this._closeButton.styleName = "closeButton";
            this._closeButton.useHandCursor = true;
            this._closeButton.buttonMode = true;
            this._closeButton.addEventListener(MouseEvent.CLICK, this.onCloseButtonClick);
            rawChildren.addChild(this._closeButton);
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            this._closeButton.endEffectsStarted();
            this._closeButton.visible = this.hasCloseButton;
            this._closeButton.move(param1 - this._closeButton.width - 5, 5);
            return;
        }// end function

        private function onCloseButtonClick(param1:MouseEvent) : void
        {
            endEffectsStarted();
            visible = false;
            return;
        }// end function

    }
}
