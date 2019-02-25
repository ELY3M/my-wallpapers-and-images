package org.swizframework.utils.services
{
    import mx.rpc.*;
    import org.swizframework.core.*;

    public class ServiceHelper extends Object implements IServiceHelper, ISwizAware
    {
        protected var _swiz:ISwiz;

        public function ServiceHelper()
        {
            return;
        }// end function

        public function set swiz(config:ISwiz) : void
        {
            this._swiz = config;
            return;
        }// end function

        public function executeServiceCall(Array:AsyncToken, IServiceHelper:Function, ISwizAware:Function = null, swiz:Array = null) : AsyncToken
        {
            if (ISwizAware == null)
            {
            }
            if (this._swiz != null)
            {
            }
            if (this._swiz.config.defaultFaultHandler != null)
            {
                ISwizAware = this._swiz.config.defaultFaultHandler;
            }
            Array.addResponder(new SwizResponder(IServiceHelper, ISwizAware, swiz));
            return Array;
        }// end function

    }
}
