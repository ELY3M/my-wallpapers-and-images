package net.sprd.models.product
{
    import flash.geom.*;
    import net.sprd.models.product.texthandling.*;

    public class ConstraintViolationFixes extends Object
    {

        public function ConstraintViolationFixes()
        {
            return;
        }// end function

        public static function shrinkToRemoveBoundaryCollision(param1:IConfigurationModel) : void
        {
            var _loc_2:int;
            while (_loc_2++ < 10)
            {
                
                if (param1.getCurrentConstraintViolationInfo().boundaryCollision)
                {
                    param1.centerScale = new Point(0.99, 0.99);
                    continue;
                }
                return;
            }
            return;
        }// end function

        public static function shrinkToRemoveMaxBoundViolation(param1:ConfigurationModel) : void
        {
            var _loc_2:int;
            while (_loc_2++ < 10)
            {
                
                if (param1.getCurrentConstraintViolationInfo().maxBoundViolation)
                {
                    param1.centerScale = new Point(0.99, 0.99);
                    continue;
                }
                return;
            }
            return;
        }// end function

        public static function expandToRemoveMinBoundViolation(param1:ConfigurationModel) : void
        {
            var _loc_2:int;
            while (_loc_2++ < 10)
            {
                
                if (param1.getCurrentConstraintViolationInfo().minBoundViolation)
                {
                    param1.centerScale = new Point(1.01, 1.01);
                    continue;
                }
                return;
            }
            return;
        }// end function

        public static function shrinkFontSizeToFitLineNumber(param1:ConfigurationModel, param2:uint) : void
        {
            var _loc_3:int;
            while (_loc_3++ < 10)
            {
                
                if (param1.testTextFlow.flowComposer.numLines > param2)
                {
                    TextFlowUtil.decreaseFontSize(param1.textFlow, 0.9, 1, 0);
                    param1.textFlow.flowComposer.updateAllControllers();
                    TextFlowUtil.decreaseFontSize(param1.testTextFlow, 0.9, 1, 0);
                    param1.testTextFlow.flowComposer.updateAllControllers();
                    continue;
                }
                return;
            }
            return;
        }// end function

    }
}
