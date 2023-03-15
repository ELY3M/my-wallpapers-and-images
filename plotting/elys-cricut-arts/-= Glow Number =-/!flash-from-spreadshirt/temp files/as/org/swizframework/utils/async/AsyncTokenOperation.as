package org.swizframework.utils.async
{
    import mx.rpc.*;
    import org.swizframework.utils.services.*;

    public class AsyncTokenOperation extends AbstractAsynchronousOperation implements IAsynchronousOperation
    {

        public function AsyncTokenOperation(addResponder:AsyncToken)
        {
            addResponder.addResponder(new SwizResponder(this.resultHandler, this.faultHandler));
            return;
        }// end function

        protected function resultHandler(AsyncTokenOperation:Object) : void
        {
            complete(AsyncTokenOperation);
            return;
        }// end function

        protected function faultHandler(:Object) : void
        {
            fail();
            return;
        }// end function

    }
}
