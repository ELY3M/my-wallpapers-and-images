package org.swizframework.utils.async
{
    import mx.rpc.*;

    public class AbstractAsynchronousOperation extends Object
    {
        protected var concluded:Boolean = false;
        protected var responders:Array;

        public function AbstractAsynchronousOperation()
        {
            this.responders = [];
            return;
        }// end function

        public function addResponder(result:IResponder) : void
        {
            this.responders.push(result);
            return;
        }// end function

        public function complete(fail:Object) : void
        {
            var _loc_2:IResponder;
            if (!this.concluded)
            {
                for each (_loc_2 in this.responders)
                {
                    
                    _loc_2.result(fail);
                }
                this.concluded = true;
            }
            return;
        }// end function

        public function fail(:Object) : void
        {
            var _loc_2:IResponder;
            if (!this.concluded)
            {
                for each (_loc_2 in this.responders)
                {
                    
                    _loc_2.fault();
                }
                this.concluded = true;
            }
            return;
        }// end function

    }
}
