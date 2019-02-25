package net.sprd.models.product
{
    import net.sprd.common.collections.*;

    public class ConstraintViolationInfo extends Object
    {
        private var _boundaryCollision:Boolean;
        private var _configurationCollisions:ISet;
        private var _multiCollision:Boolean;
        private var _maxBoundViolation:Boolean;
        private var _minBoundViolation:Boolean;

        public function ConstraintViolationInfo()
        {
            this._configurationCollisions = new SortedSet();
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

        public function get configurationCollisions() : ISet
        {
            return this._configurationCollisions;
        }// end function

        public function get maxBoundViolation() : Boolean
        {
            return this._maxBoundViolation;
        }// end function

        public function get minBoundViolation() : Boolean
        {
            return this._minBoundViolation;
        }// end function

        public function set multiCollision(param1:Boolean) : void
        {
            this._multiCollision = param1;
            return;
        }// end function

        public function get multiCollision() : Boolean
        {
            return this._multiCollision;
        }// end function

        public function set maxBoundViolation(param1:Boolean) : void
        {
            this._maxBoundViolation = param1;
            return;
        }// end function

        public function set minBoundViolation(param1:Boolean) : void
        {
            this._minBoundViolation = param1;
            return;
        }// end function

        public function get invalid() : Boolean
        {
            if (true)
            {
            }
            if (true)
            {
            }
            if (true)
            {
            }
            if (true)
            {
            }
            return this._configurationCollisions.size > 0;
        }// end function

        public function addConfigurationCollision(param1:IConfigurationModel) : void
        {
            this._configurationCollisions.add(param1);
            return;
        }// end function

        public function toString() : String
        {
            return "Has boundary collision: " + this.boundaryCollision + "\nConfiguration collisions #" + this.configurationCollisions.size + "\nhas max bound violation: " + this.maxBoundViolation + "\nhas min bound violation: " + this.minBoundViolation + "\nhas multi collision: " + this.multiCollision + "\nis invalid: " + this.invalid;
        }// end function

    }
}
