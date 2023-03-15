package net.sprd.components.common
{
    import flash.display.*;
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.managers.*;

    public class ErrorDialog extends TitleWindow
    {
        private var textField:UITextField;
        var proceedButton:Button;
        private var closeHandler:Function = null;

        public function ErrorDialog()
        {
            this.textField = new UITextField();
            this.proceedButton = new Button();
            return;
        }// end function

        public function show(param1:String, param2:String, param3:Function = null) : void
        {
            this.title = param2;
            this.textField.text = param1;
            this.closeHandler = param3;
            PopUpManager.addPopUp(this, DisplayObject(FlexGlobals.topLevelApplication), true);
            PopUpManager.centerPopUp(this);
            return;
        }// end function

        override protected function createChildren() : void
        {
            width = 350;
            super.createChildren();
            var _loc_1:* = new HBox();
            addChild(_loc_1);
            this.textField.multiline = true;
            this.textField.wordWrap = true;
            this.textField.styleName = getStyle("message-style-name");
            this.textField.width = 320;
            _loc_1.addChild(this.textField);
            var _loc_2:* = new HBox();
            addChild(_loc_2);
            this.proceedButton.label = resourceManager.getString("confomat7", "universal.proceed");
            this.proceedButton.styleName = getStyle("buttonStyleName");
            this.proceedButton.height = 20;
            _loc_2.addChild(this.proceedButton);
            this.proceedButton.addEventListener(MouseEvent.CLICK, this.ok_handler);
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            this.proceedButton.x = (350 - this.proceedButton.measuredWidth) / 2;
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            return;
        }// end function

        private function ok_handler(param1:Event) : void
        {
            PopUpManager.removePopUp(this);
            if (this.closeHandler)
            {
                this.closeHandler();
            }
            return;
        }// end function

    }
}
