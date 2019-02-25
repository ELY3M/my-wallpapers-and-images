package net.sprd.components.common.palette
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;

    public class Palette extends Canvas
    {
        private var _label:UITextField;
        private var _caption:String;
        private var _closeButton:Button;
        private var _children:Array;
        private var _childrenChanged:Boolean = false;
        private var _gap:uint = 6;
        private static var classConstructed:Boolean = classConstruct();

        public function Palette()
        {
            this._children = [];
            return;
        }// end function

        public function get caption() : String
        {
            return this._caption;
        }// end function

        private function set _552573414caption(param1:String) : void
        {
            this._caption = param1;
            if (this._label)
            {
                this._label.text = param1;
            }
            return;
        }// end function

        public function set children(param1) : void
        {
            if (param1 is DisplayObject)
            {
                this._children = [param1];
            }
            else
            {
                this._children = param1;
            }
            this._childrenChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get closeButton() : Button
        {
            return this._closeButton;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this._closeButton = new Button();
            this._closeButton.buttonMode = true;
            this._closeButton.styleName = "closeButton";
            this._closeButton.label = "x";
            var _loc_1:int;
            this._closeButton.height = 15;
            this._closeButton.width = _loc_1;
            this._closeButton.x = this.width - this._closeButton.width - 5;
            this._closeButton.y = 5;
            this._label = new UITextField();
            this._label.autoSize = TextFieldAutoSize.LEFT;
            this._label.styleName = "labelStyle";
            this._label.width = 150;
            this._label.text = this._caption;
            this._label.x = 10;
            this._label.y = 10;
            rawChildren.addChild(this._closeButton);
            rawChildren.addChild(this._label);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:DisplayObject;
            super.commitProperties();
            if (this._childrenChanged)
            {
                this._childrenChanged = false;
                for each (_loc_1 in this._children)
                {
                    
                    _loc_1.addEventListener(ResizeEvent.RESIZE, this.child_onResizeComplete);
                    addChild(_loc_1);
                }
            }
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_2:DisplayObject;
            super.measure();
            var _loc_1:uint;
            for each (_loc_2 in this._children)
            {
                
                if (_loc_2.visible)
                {
                    _loc_1 = _loc_1 + (_loc_2.height + this.gap);
                }
            }
            var _loc_3:* = _loc_1;
            measuredMinHeight = _loc_1;
            measuredHeight = _loc_3;
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_4:DisplayObject;
            super.updateDisplayList(param1, param2);
            graphics.clear();
            graphics.lineStyle(1, getStyle("lineColor"));
            graphics.beginGradientFill(GradientType.LINEAR, getStyle("gradientBgColor"), [1, 1], [0, 255]);
            graphics.drawRoundRect(0, 0, this.width, this.height, getStyle("cornerRadius"));
            graphics.endFill();
            var _loc_3:uint;
            for each (_loc_4 in this._children)
            {
                
                _loc_4.y = _loc_3;
                if (_loc_4.visible)
                {
                    _loc_3 = _loc_3 + (_loc_4.height + this.gap);
                }
            }
            return;
        }// end function

        public function get gap() : uint
        {
            return this._gap;
        }// end function

        public function set gap(param1:uint) : void
        {
            this._gap = param1;
            invalidateDisplayList();
            return;
        }// end function

        private function child_onResizeComplete(param1:Event) : void
        {
            invalidateSize();
            invalidateDisplayList();
            return;
        }// end function

        public function set caption(param1:String) : void
        {
            var _loc_2:* = this.caption;
            if (_loc_2 !== param1)
            {
                this._552573414caption = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "caption", _loc_2, param1));
                }
            }
            return;
        }// end function

        private static function classConstruct() : Boolean
        {
            var myStyle:CSSStyleDeclaration;
            if (!StyleManager.getStyleDeclaration("Palette"))
            {
                myStyle = new CSSStyleDeclaration();
                myStyle.defaultFactory = function () : void
            {
                this.gradientBgColor = [16382457, 16119285];
                this.textColor = 8550511;
                this.lineColor = 12433331;
                this.cornerRadius = 8;
                return;
            }// end function
            ;
                StyleManager.setStyleDeclaration("Palette", myStyle, true);
            }
            return true;
        }// end function

    }
}
