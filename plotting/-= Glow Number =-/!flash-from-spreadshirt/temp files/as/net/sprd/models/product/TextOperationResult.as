package net.sprd.models.product
{
    import flash.geom.*;
    import flashx.textLayout.operations.*;

    public class TextOperationResult extends Object
    {
        private var _operation:FlowOperation;
        private var _geometryChange:Boolean;
        private var _collisionAllowed:Boolean;
        private var _fontSizeViolation:Boolean;
        private var _configuration:IConfigurationModel;
        private var _originalOffset:Point;
        private var _originalWidth:Number;
        private var _originalHeight:Number;
        private var _fontSizeReduction:Number = 1;
        private var _unknownError:Boolean = false;
        private var _boundaryCollision:Boolean = false;

        public function TextOperationResult(param1:IConfigurationModel, param2:FlowOperation, param3:Boolean)
        {
            this._configuration = param1;
            this._operation = param2;
            this._collisionAllowed = param3;
            this._originalOffset = this._configuration.offset;
            this._originalWidth = this._configuration.width;
            this._originalHeight = this._configuration.height;
            return;
        }// end function

        public function get geometryChange() : Boolean
        {
            return this._geometryChange;
        }// end function

        public function set geometryChange(param1:Boolean) : void
        {
            this._geometryChange = param1;
            return;
        }// end function

        public function get collisionAllowed() : Boolean
        {
            return this._collisionAllowed;
        }// end function

        public function get fontSizeViolation() : Boolean
        {
            return this._fontSizeViolation;
        }// end function

        public function set fontSizeViolation(param1:Boolean) : void
        {
            this._fontSizeViolation = param1;
            return;
        }// end function

        public function undo() : void
        {
            this._operation.undo();
            var _loc_1:* = this._configuration.allowConstraintError;
            this._configuration.allowConstraintError = true;
            this._configuration.offset = this._originalOffset;
            this._configuration.setTextBox(this._originalWidth, this._originalHeight);
            this._configuration.allowConstraintError = _loc_1;
            return;
        }// end function

        public function get invalid() : Boolean
        {
            if (this._unknownError)
            {
                return true;
            }
            return false;
        }// end function

        public function set fontSizeReduction(param1:Number) : void
        {
            this._fontSizeReduction = param1;
            return;
        }// end function

        public function get fontSizeReduction() : Number
        {
            return this._fontSizeReduction;
        }// end function

        public function set unknownError(param1:Boolean) : void
        {
            this._unknownError = param1;
            return;
        }// end function

        public function set boundaryCollision(param1:Boolean) : void
        {
            this._boundaryCollision = param1;
            return;
        }// end function

        public function get boundaryCollision() : Boolean
        {
            return this._boundaryCollision;
        }// end function

    }
}
