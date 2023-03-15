package net.sprd.models.product.rules
{
    import flash.geom.*;
    import net.sprd.models.product.*;

    public class NullConstraintViolationDetector extends Object implements IConstraintViolationDetector
    {
        private var info:ConstraintViolationInfo;
        private static var _instance:IConstraintViolationDetector = new NullConstraintViolationDetector;

        public function NullConstraintViolationDetector()
        {
            this.info = new ConstraintViolationInfo();
            return;
        }// end function

        public function getConstraintViolationInfo(param1:IConfigurationModel, param2:Number, param3:int, param4:int, param5:Point, param6:Point) : ConstraintViolationInfo
        {
            return this.info;
        }// end function

        public function hardBoundaryCollision(param1:IConfigurationModel, param2:Matrix = null) : Boolean
        {
            return false;
        }// end function

        public function maxBoundViolation(param1:IConfigurationModel, param2:Point = null) : Boolean
        {
            return false;
        }// end function

        public function minBoundViolation(param1:IConfigurationModel, param2:Point = null) : Boolean
        {
            return false;
        }// end function

        public static function get instance() : IConstraintViolationDetector
        {
            return _instance;
        }// end function

    }
}
