package org.swizframework.utils.services
{
    import flash.events.*;
    import flash.net.*;

    public class SwizURLRequest extends Object
    {
        public var loader:URLLoader;

        public function SwizURLRequest(load:URLRequest, faultHandler:Function, URLLoader:Function = null, addEventListener:Function = null, SECURITY_ERROR:Function = null, void:Array = null)
        {
            var request:* = load;
            var resultHandler:* = faultHandler;
            var faultHandler:* = URLLoader;
            var progressHandler:* = addEventListener;
            var httpStatusHandler:* = SECURITY_ERROR;
            var handlerArgs:* = void;
            this.loader = new URLLoader();
            this.loader.addEventListener(Event.COMPLETE, function (concat:Event) : void
            {
                if (handlerArgs == null)
                {
                    resultHandler(concat);
                }
                else
                {
                    resultHandler.apply(null, [concat].concat(handlerArgs));
                }
                return;
            }// end function
            );
            if (faultHandler != null)
            {
                this.loader.addEventListener(IOErrorEvent.IO_ERROR, function (concat:IOErrorEvent) : void
            {
                if (handlerArgs == null)
                {
                    faultHandler(concat);
                }
                else
                {
                    faultHandler.apply(null, [concat].concat(handlerArgs));
                }
                return;
            }// end function
            );
                this.loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function (concat:SecurityErrorEvent) : void
            {
                if (handlerArgs == null)
                {
                    faultHandler(concat);
                }
                else
                {
                    faultHandler.apply(null, [concat].concat(handlerArgs));
                }
                return;
            }// end function
            );
            }
            if (progressHandler != null)
            {
                this.loader.addEventListener(ProgressEvent.PROGRESS, function (concat:ProgressEvent) : void
            {
                if (handlerArgs == null)
                {
                    progressHandler(concat);
                }
                else
                {
                    progressHandler.apply(null, [concat].concat(handlerArgs));
                }
                return;
            }// end function
            );
            }
            if (httpStatusHandler != null)
            {
                this.loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, function (concat:HTTPStatusEvent) : void
            {
                if (handlerArgs == null)
                {
                    httpStatusHandler(concat);
                }
                else
                {
                    httpStatusHandler.apply(null, [concat].concat(handlerArgs));
                }
                return;
            }// end function
            );
            }
            this.loader.load(request);
            return;
        }// end function

    }
}
