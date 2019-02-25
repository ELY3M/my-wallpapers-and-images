package org.swizframework.utils.async
{
    import mx.rpc.*;

    public interface IAsynchronousOperation
    {

        public function IAsynchronousOperation();

        function addResponder(Object:IResponder) : void;

        function complete(IAsynchronousOperation:Object) : void;

        function fail(:Object) : void;

    }
}
