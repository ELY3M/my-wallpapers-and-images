package org.swizframework.utils.services
{
    import flash.net.*;
    import org.swizframework.core.*;

    public class URLRequestHelper extends Object implements IURLRequestHelper, ISwizAware
    {
        protected var _swiz:ISwiz;

        public function URLRequestHelper()
        {
            return;
        }// end function

        public function set swiz(config:ISwiz) : void
        {
            this._swiz = config;
            return;
        }// end function

        public function executeURLRequest(URLRequest:URLRequest, Array:Function, IURLRequestHelper:Function = null, ISwizAware:Function = null, swiz:Function = null, executeURLRequest:Array = null) : URLLoader
        {
            if (IURLRequestHelper == null)
            {
            }
            if (this._swiz.config.defaultFaultHandler != null)
            {
                IURLRequestHelper = this._swiz.config.defaultFaultHandler;
            }
            return new SwizURLRequest(URLRequest, Array, IURLRequestHelper, ISwizAware, swiz, executeURLRequest).loader;
        }// end function

    }
}
