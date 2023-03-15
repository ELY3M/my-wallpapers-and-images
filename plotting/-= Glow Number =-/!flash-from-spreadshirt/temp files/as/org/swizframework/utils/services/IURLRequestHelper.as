package org.swizframework.utils.services
{
    import flash.net.*;

    public interface IURLRequestHelper
    {

        public function IURLRequestHelper();

        function executeURLRequest(Function:URLRequest, Array:Function, executeURLRequest:Function = null, IURLRequestHelper:Function = null, IURLRequestHelper:Function = null, :Array = null) : URLLoader;

    }
}
