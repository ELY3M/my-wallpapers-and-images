package net.sprd.components.productviewer
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.containers.*;
    import mx.core.*;
    import mx.managers.*;
    import mx.styles.*;
    import net.sprd.models.product.*;

    public class ConstraintInfoVisualizer extends Canvas
    {
        private var _constraint:ConstraintViolationInfo;
        private var _constraintsChanged:Boolean;
        private var errorIcon:DisplayObject = null;
        private var _tip:IToolTip;
        private var _showExplanation:Boolean;
        private var _showExplanationChanged:Boolean;
        private var text:String;
        private var _configuration:IConfigurationModel;

        public function ConstraintInfoVisualizer(param1:IConfigurationModel)
        {
            this._configuration = param1;
            return;
        }// end function

        public function get constraintInfo() : ConstraintViolationInfo
        {
            return this._constraint;
        }// end function

        public function set constraintInfo(param1:ConstraintViolationInfo) : void
        {
            this._constraint = param1;
            this._constraintsChanged = true;
            invalidateProperties();
            return;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            if (param1 != super.visible)
            {
            }
            if (param1 == false)
            {
                this.destroyToolTip();
            }
            super.visible = param1;
            if (this.errorIcon)
            {
                this.errorIcon.visible = param1;
            }
            return;
        }// end function

        public function set showExplanation(param1:Boolean) : void
        {
            this._showExplanation = param1;
            this._showExplanationChanged = true;
            invalidateProperties();
            return;
        }// end function

        private function updateConstraints() : void
        {
            var _loc_1:String;
            if (this.constraintInfo)
            {
            }
            if (this.constraintInfo.configurationCollisions.size > 0)
            {
                _loc_1 = "conflict_overlap";
            }
            if (this.constraintInfo)
            {
            }
            if (this.constraintInfo.boundaryCollision)
            {
                _loc_1 = "conflict_printarea";
            }
            if (this.constraintInfo)
            {
            }
            if (this.constraintInfo.minBoundViolation)
            {
                _loc_1 = "conflict_scale_down";
            }
            if (this.constraintInfo)
            {
            }
            if (this.constraintInfo.maxBoundViolation)
            {
                _loc_1 = "conflict_scale_up";
            }
            if (this.constraintInfo)
            {
            }
            if (this.constraintInfo.multiCollision)
            {
                _loc_1 = "conflict_layers";
            }
            this.text = _loc_1 != "" ? (resourceManager.getString("confomat7", "messages_system." + _loc_1)) : (null);
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_2:IFlexDisplayObject;
            super.createChildren();
            var _loc_1:* = getStyle("icon") as Class;
            if (_loc_1)
            {
                _loc_2 = IFlexDisplayObject(new _loc_1);
                _loc_2.name = "icon";
                if (_loc_2 is ISimpleStyleClient)
                {
                    ISimpleStyleClient(_loc_2).styleName = this;
                }
                this.errorIcon = DisplayObject(_loc_2);
                rawChildren.addChild(this.errorIcon);
            }
            this.errorIcon.visible = false;
            return;
        }// end function

        override protected function childrenCreated() : void
        {
            super.childrenCreated();
            addEventListener(MouseEvent.MOUSE_OVER, this.errorIcon_onMouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT, this.errorIcon_onMouseOutHandler);
            return;
        }// end function

        private function errorIcon_onMouseOverHandler(param1:MouseEvent) : void
        {
            if (visible)
            {
            }
            if (this.errorIcon)
            {
            }
            if (!this._showExplanation)
            {
                this.createToolTip();
            }
            return;
        }// end function

        private function errorIcon_onMouseOutHandler(param1:MouseEvent) : void
        {
            if (!this._showExplanation)
            {
                this.destroyToolTip();
            }
            return;
        }// end function

        override public function move(param1:Number, param2:Number) : void
        {
            super.move(param1, param2);
            if (this._tip)
            {
                this.updateToolTip();
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            if (this._showExplanation)
            {
            }
            if (visible)
            {
            }
            if (this.text)
            {
            }
            if (stage)
            {
                this.createToolTip();
            }
            else
            {
                this.destroyToolTip();
            }
            return;
        }// end function

        private function createToolTip() : void
        {
            var _loc_1:Point;
            if (this._tip)
            {
                this.updateToolTip();
            }
            else
            {
                _loc_1 = getBounds(stage).topLeft.subtract(new Point(0, 32));
                this._tip = ToolTipManager.createToolTip(this.text, Math.round(_loc_1.x), Math.round(_loc_1.y));
                ToolTipManager.enabled = false;
            }
            return;
        }// end function

        private function updateToolTip() : void
        {
            var _loc_1:* = getBounds(stage).topLeft.subtract(new Point(0, 32));
            this._tip.mx.core:IToolTip::text = this.text;
            this._tip.x = Math.round(_loc_1.x);
            this._tip.y = Math.round(_loc_1.y);
            return;
        }// end function

        public function destroyToolTip() : void
        {
            try
            {
                this._tip.setVisible(false);
                ToolTipManager.destroyToolTip(this._tip);
                ToolTipManager.enabled = true;
                this._tip = null;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public function tearDown() : void
        {
            try
            {
                this.destroyToolTip();
                if (this.errorIcon)
                {
                    rawChildren.removeChild(this.errorIcon);
                }
                removeEventListener(MouseEvent.MOUSE_OVER, this.errorIcon_onMouseOverHandler);
                removeEventListener(MouseEvent.MOUSE_OUT, this.errorIcon_onMouseOutHandler);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this._constraintsChanged)
            {
                this._constraintsChanged = false;
                this.updateConstraints();
                invalidateDisplayList();
            }
            if (this._showExplanationChanged)
            {
                this._showExplanationChanged = false;
                invalidateDisplayList();
            }
            return;
        }// end function

        override protected function measure() : void
        {
            if (!this.errorIcon)
            {
                return;
            }
            measuredMinHeight = this.errorIcon.width;
            measuredMinWidth = this.errorIcon.height;
            measuredHeight = measuredMinHeight;
            measuredWidth = measuredMinWidth;
            super.measure();
            return;
        }// end function

    }
}
