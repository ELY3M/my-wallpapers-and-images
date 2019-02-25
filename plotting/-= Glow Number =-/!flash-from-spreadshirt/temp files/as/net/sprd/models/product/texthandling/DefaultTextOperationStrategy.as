package net.sprd.models.product.texthandling
{
    import flash.geom.*;
    import flashx.textLayout.edit.*;
    import flashx.textLayout.operations.*;
    import net.sprd.common.graphics.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.models.product.*;
    import net.sprd.models.product.rules.*;

    public class DefaultTextOperationStrategy extends Object implements ITextOperationStrategy
    {
        private var configuration:IConfigurationModel;
        private var _decreaseFontSize:Boolean = true;
        private var _checkMaxBounds:Boolean = false;
        private var _collisionAllowed:Boolean = true;
        private var _adjustY:Boolean = true;
        private var result:TextOperationResult;
        private static const log:ILogger = LogContext.getLogger(this);

        public function DefaultTextOperationStrategy(param1:IConfigurationModel)
        {
            this.configuration = param1;
            this.result = new TextOperationResult(param1, null, this._collisionAllowed);
            return;
        }// end function

        public function execute(param1:FlowOperation) : TextOperationResult
        {
            var maxHeight:Number;
            var allowConstraintError:Boolean;
            var operation:* = param1;
            var targetOp:* = TextFlowUtil.cloneFlowOperation(operation, this.configuration.testTextFlow);
            if (!targetOp)
            {
                this.result = new TextOperationResult(this.configuration, null, this._collisionAllowed);
                this.result.unknownError = true;
                return this.result;
            }
            this.result = new TextOperationResult(this.configuration, targetOp, this._collisionAllowed);
            var composer:* = this.configuration.testTextFlow.flowComposer;
            IEditManager(this.configuration.testTextFlow.interactionManager).doOperation(targetOp);
            maxHeight = this.configuration.printType.height;
            var dy:* = this.configuration.adjustHeightToTextFit();
            if (!(targetOp is DeleteTextOperation))
            {
            }
            if (targetOp is CutOperation)
            {
                return this.result;
            }
            if (!(targetOp is InsertTextOperation))
            {
            }
            if (targetOp is PasteOperation)
            {
                this.adjustFontSize(this.result, function () : Boolean
            {
                return configuration.height <= maxHeight;
            }// end function
            );
            }
            if (this.result.fontSizeViolation)
            {
                return this.result;
            }
            composer.updateAllControllers();
            if (!this.boundaryCollision())
            {
                return this.result;
            }
            var dx:Number;
            var i:int;
            var lastValidX:* = this.configuration.offset.x;
            var lastValidWidth:* = this.configuration.width;
            if (this.configuration.horizontalTextAutoStretch)
            {
                while (i < 100)
                {
                    
                    this.result.geometryChange = true;
                    this.adjustWidth(dx);
                    dy = this.configuration.adjustHeightToTextFit();
                    if (this.boundaryCollision())
                    {
                        if (this.adjustXTentatively(dx, 3))
                        {
                            dy = this.configuration.adjustHeightToTextFit();
                            return this.result;
                        }
                        break;
                    }
                    else
                    {
                        return this.result;
                    }
                    i = i++;
                }
                allowConstraintError = this.configuration.allowConstraintError;
                this.configuration.allowConstraintError = true;
                this.configuration.setTextBox(lastValidWidth, this.configuration.height);
                this.configuration.offset.x = lastValidX;
                this.configuration.allowConstraintError = allowConstraintError;
                if (!this.boundaryCollision())
                {
                    return this.result;
                }
            }
            if (this._adjustY)
            {
            }
            if (this.adjustYTentatively(4, Math.max(dy / 4 + 1, 5)))
            {
                return this.result;
            }
            if (this._decreaseFontSize)
            {
                this.adjustFontSize(this.result, function () : Boolean
            {
                return !boundaryCollision();
            }// end function
            );
            }
            this.configuration.adjustHeightToTextFit();
            return this.result;
        }// end function

        public function set checkMaxBounds(param1:Boolean) : void
        {
            this._checkMaxBounds = param1;
            return;
        }// end function

        public function set decreaseFontSize(param1:Boolean) : void
        {
            this._decreaseFontSize = param1;
            return;
        }// end function

        public function set collisionAllowed(param1:Boolean) : void
        {
            this._collisionAllowed = param1;
            return;
        }// end function

        public function set adjustY(param1:Boolean) : void
        {
            this._adjustY = param1;
            return;
        }// end function

        public function get lastResult() : TextOperationResult
        {
            return this.result;
        }// end function

        private function adjustFontSize(param1:TextOperationResult, param2:Function) : void
        {
            if (!this._decreaseFontSize)
            {
                return;
            }
            var _loc_3:int;
            var _loc_4:Number;
            var _loc_5:Number;
            var _loc_6:* = ConfigurationSizeRules.calculateMinimumFontSize(this.configuration);
            do
            {
                
                if (!TextFlowUtil.decreaseFontSize(this.configuration.testTextFlow, _loc_4, this.configuration.width / this.configuration.unscaledWidth, _loc_6))
                {
                    param1.fontSizeViolation = true;
                    break;
                }
                else
                {
                    _loc_5 = _loc_5 * _loc_4;
                }
                this.configuration.adjustHeightToTextFit();
                if (!this.param2())
                {
                }
            }while (_loc_3++ < 50)
            if (param1.fontSizeViolation)
            {
                TextFlowUtil.decreaseFontSize(this.configuration.testTextFlow, 1 / _loc_5, this.configuration.width / this.configuration.unscaledWidth, _loc_6);
            }
            else
            {
                param1.fontSizeReduction = param1.fontSizeReduction * _loc_5;
            }
            return;
        }// end function

        private function boundaryCollision() : Boolean
        {
            var _loc_1:* = this.configuration.constraintViolationDetector.hardBoundaryCollision(this.configuration);
            if (this._checkMaxBounds)
            {
                if (true)
                {
                }
                this.result.boundaryCollision = this.configuration.constraintViolationDetector.maxBoundViolation(this.configuration);
            }
            else
            {
                this.result.boundaryCollision = _loc_1;
            }
            return this.result.boundaryCollision;
        }// end function

        private function adjustWidth(param1:Number) : void
        {
            this.configuration.setTextBox(this.configuration.width + param1, this.configuration.height);
            return;
        }// end function

        private function adjustXTentatively(param1:Number, param2:Number) : Boolean
        {
            var _loc_4:int;
            var _loc_5:Number;
            var _loc_6:Point;
            var _loc_7:ConstraintViolationInfo;
            var _loc_3:* = this.configuration.allowConstraintError;
            this.configuration.allowConstraintError = true;
            while (_loc_4++ < param2)
            {
                
                _loc_5 = UnitUtil.deg2rad(this.configuration.rotation);
                _loc_6 = new Point(this.configuration.offset.x - (_loc_4 + 1) * param1 * Math.cos(_loc_5), this.configuration.offset.y - (_loc_4 + 1) * param1 * Math.sin(_loc_5));
                _loc_7 = this.configuration.getConstraintViolationInfo(this.configuration.rotation, this.configuration.flipX, this.configuration.flipY, new Point(1, 1), _loc_6);
                if (!_loc_7.boundaryCollision)
                {
                    this.configuration.offset = _loc_6;
                    this.configuration.allowConstraintError = _loc_3;
                    return true;
                }
            }
            this.configuration.allowConstraintError = _loc_3;
            return false;
        }// end function

        private function adjustYTentatively(param1:Number, param2:Number) : Boolean
        {
            var _loc_4:int;
            var _loc_5:Number;
            var _loc_6:Point;
            var _loc_7:ConstraintViolationInfo;
            var _loc_3:* = this.configuration.allowConstraintError;
            this.configuration.allowConstraintError = true;
            while (_loc_4++ < param2)
            {
                
                _loc_5 = UnitUtil.deg2rad(this.configuration.rotation);
                _loc_6 = new Point(this.configuration.offset.x + (_loc_4 + 1) * param1 * Math.sin(_loc_5), this.configuration.offset.y - (_loc_4 + 1) * param1 * Math.cos(_loc_5));
                _loc_7 = this.configuration.getConstraintViolationInfo(this.configuration.rotation, this.configuration.flipX, this.configuration.flipY, new Point(1, 1), _loc_6);
                if (_loc_6.x >= 0)
                {
                }
                if (_loc_6.y >= 0)
                {
                }
                if (!_loc_7.boundaryCollision)
                {
                    this.configuration.offset = _loc_6;
                    this.configuration.allowConstraintError = _loc_3;
                    return true;
                }
            }
            this.configuration.allowConstraintError = _loc_3;
            return false;
        }// end function

    }
}
