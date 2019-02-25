package org.swizframework.utils.services
{
    import mx.rpc.*;

    public interface IServiceHelper
    {

        public function IServiceHelper();

        function executeServiceCall(Array:AsyncToken, executeServiceCall:Function, IServiceHelper:Function = null, IServiceHelper:Array = null) : AsyncToken;

    }
}
