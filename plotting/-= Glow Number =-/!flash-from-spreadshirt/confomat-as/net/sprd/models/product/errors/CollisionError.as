package net.sprd.models.product.errors
{
    import net.sprd.models.product.*;

    public class CollisionError extends Error
    {
        private var collisionInfo:ConstraintViolationInfo;

        public function CollisionError(param1:ConstraintViolationInfo)
        {
            this.collisionInfo = param1;
            return;
        }// end function

    }
}
