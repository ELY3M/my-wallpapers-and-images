package net.sprd.components.configurationtools
{
    import flash.events.*;
    import mx.controls.*;
    import mx.core.*;

    public class NoticeMarker extends Container
    {
        private var _notice:String;
        private var _labelField:Label;

        public function NoticeMarker()
        {
            return;
        }// end function

        public function get notice() : String
        {
            return this._notice;
        }// end function

        public function set notice(param1:String) : void
        {
            this._notice = param1;
            invalidateProperties();
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this._labelField = new Label();
            this._labelField.styleName = styleName;
            addChild(this._labelField);
            buttonMode = true;
            useHandCursor = true;
            mouseChildren = false;
            return;
        }// end function

        override protected function childrenCreated() : void
        {
            super.childrenCreated();
            addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:Number;
            var _loc_5:Number;
            super.updateDisplayList(param1, param2);
            _loc_3 = getStyle("paddingLeft");
            var _loc_4:* = getStyle("paddingRight");
            _loc_5 = getStyle("paddingTop");
            var _loc_6:* = getStyle("paddingBottom");
            this._labelField.width = param1 - _loc_3 - _loc_4;
            this._labelField.height = param2 - _loc_5 - _loc_6;
            this._labelField.x = _loc_3;
            this._labelField.y = _loc_5 - 2;
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this._labelField.text != this._notice)
            {
                this._labelField.text = this._notice;
                invalidateDisplayList();
            }
            return;
        }// end function

        private function onMouseOut(param1:MouseEvent) : void
        {
            this._labelField.setStyle("color", getStyle("color"));
            return;
        }// end function

        private function onMouseOver(param1:MouseEvent) : void
        {
            this._labelField.setStyle("color", getStyle("overColor"));
            return;
        }// end function

    }
}
