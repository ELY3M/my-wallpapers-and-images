package net.sprd.models.product
{
    import flash.geom.*;

    public interface IConstraintViolationDetector
    {

        public function IConstraintViolationDetector();

        function getConstraintViolationInfo(param1:IConfigurationModel, param2:Number, param3:int, param4:int, param5:Point, param6:Point) : ConstraintViolationInfo;

        function hardBoundaryCollision(param1:IConfigurationModel, param2:Matrix = null) : Boolean;

        function maxBoundViolation(param1:IConfigurationModel, param2:Point = null) : Boolean;

        function minBoundViolation(param1:IConfigurationModel, param2:Point = null) : Boolean;

    }
}
