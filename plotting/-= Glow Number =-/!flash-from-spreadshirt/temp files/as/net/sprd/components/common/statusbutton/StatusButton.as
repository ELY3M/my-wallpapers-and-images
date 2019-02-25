package net.sprd.components.common.statusbutton
{
    import flash.display.*;
    import mx.controls.*;
    import mx.core.*;

    public class StatusButton extends Button
    {
        private var _stati:Array;
        private var _currentStatus:IStatus;
        private var iconChanged:Boolean;
        private var icon:DisplayObject;
        private var iconHeight:Number;
        private var iconWidth:Number;

        public function StatusButton()
        {
            this._stati = [];
            return;
        }// end function

        public function get stati() : Array
        {
            return this._stati;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            labelPlacement = ButtonLabelPlacement.RIGHT;
            return;
        }// end function

        public function set stati(param1:Array) : void
        {
            this._stati = param1;
            if (this._stati)
            {
            }
            if (this._stati.length > 0)
            {
                this.currentStatus = this._stati[0];
            }
            return;
        }// end function

        public function selectStatusByName(param1:String) : Boolean
        {
            var _loc_2:IStatus;
            for each (_loc_2 in this.stati)
            {
                
                if (_loc_2)
                {
                }
                if (_loc_2.name == param1)
                {
                    this.currentStatus = _loc_2;
                }
            }
            return false;
        }// end function

        public function set currentStatus(param1:IStatus) : void
        {
            if (param1 != this._currentStatus)
            {
            }
            if (this.stati.indexOf(param1) == -1)
            {
                return;
            }
            if (!param1)
            {
            }
            if (this.stati)
            {
            }
            if (this.stati.length > 0)
            {
                param1 = this.stati[0];
                return;
            }
            if (this._currentStatus)
            {
            }
            if (param1.iconClass != this._currentStatus.iconClass)
            {
                this.iconChanged = true;
            }
            this._currentStatus = param1;
            styleName = this._currentStatus.styleName;
            label = this._currentStatus.text;
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
            return;
        }// end function

        public function get currentStatus() : IStatus
        {
            return this._currentStatus;
        }// end function

        override protected function commitProperties() : void
        {
            var tmp:DisplayObject;
            var bounds:Rectangle;
            super.commitProperties();
            if (this.iconChanged)
            {
                this.iconChanged = false;
                if (this.icon)
                {
                    removeChild(this.icon);
                }
                this.icon = null;
                if (this._currentStatus)
                {
                }
                if (this._currentStatus.iconClass)
                {
                    try
                    {
                        tmp = new this._currentStatus.iconClass() as DisplayObject;
                        if (tmp)
                        {
                            this.icon = new UIComponent();
                            this.iconHeight = tmp.height;
                            this.iconWidth = tmp.width;
                            bounds = tmp.getBounds(this.icon);
                            tmp.x = tmp.x - bounds.x;
                            tmp.y = tmp.y - bounds.y;
                            UIComponent(this.icon).addChild(tmp);
                        }
                    }
                    catch (e:Error)
                    {
                    }
                }
            }
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_1:Number;
            var _loc_2:Number;
            super.measure();
            if (this.icon)
            {
                _loc_1 = getStyle("paddingTop");
                _loc_2 = getStyle("paddingBottom");
                _loc_1 = _loc_1 < 4 ? (4) : (_loc_1);
                _loc_2 = _loc_2 < 4 ? (4) : (_loc_2);
                measuredWidth = measuredWidth + (measuredHeight - _loc_2 - _loc_1 + 4);
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_7:Number;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("paddingLeft");
            var _loc_4:* = getStyle("paddingRight");
            var _loc_5:* = getStyle("paddingTop");
            var _loc_6:* = getStyle("paddingBottom");
            if (this.icon)
            {
                _loc_5 = _loc_5 < 4 ? (4) : (_loc_5);
                _loc_6 = _loc_6 < 4 ? (4) : (_loc_6);
                _loc_7 = param2 - _loc_5 - _loc_6;
                var _loc_8:* = _loc_7 / this.iconHeight;
                this.icon.scaleX = _loc_7 / this.iconHeight;
                this.icon.scaleY = _loc_8;
                this.icon.x = _loc_3;
                this.icon.y = param2 / 2 - _loc_7 / 2;
                textField.x = _loc_3 + _loc_7 + 4;
                if (!this.icon.parent)
                {
                    addChild(this.icon);
                }
                setChildIndex(this.icon, numChildren - 1);
                setChildIndex(DisplayObject(textField), numChildren - 1);
            }
            else
            {
                textField.x = _loc_3;
            }
            return;
        }// end function

    }
}
