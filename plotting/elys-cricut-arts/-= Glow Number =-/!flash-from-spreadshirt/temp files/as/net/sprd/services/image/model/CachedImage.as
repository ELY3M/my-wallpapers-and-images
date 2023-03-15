package net.sprd.services.image.model
{
    import flash.display.*;
    import flash.events.*;
    import mx.controls.*;
    import net.sprd.api.resource.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;

    public class CachedImage extends Image
    {
        private var _loadingState:int = 0;
        private var debugSource:Object;
        private static const log:ILogger = LogContext.getLogger(this);

        public function CachedImage()
        {
            return;
        }// end function

        override public function load(param1:Object = null) : void
        {
            if (this._loadingState == ResourceLoadingState.LOADED)
            {
                dispatchEvent(new Event(Event.COMPLETE));
                return;
            }
            if (this._loadingState != ResourceLoadingState.CREATED)
            {
                return;
            }
            this._loadingState = ResourceLoadingState.LOADING;
            this.debugSource = param1 != null ? (param1) : (source);
            log.debug("Loading image: " + this.debugSource);
            EventUtil.registerOnetimeListeners(this, [Event.COMPLETE, IOErrorEvent.IO_ERROR, SecurityErrorEvent.SECURITY_ERROR], [this.completeHandler, this.errorHandler, this.errorHandler]);
            addEventListener(HTTPStatusEvent.HTTP_STATUS, this.httpStatusHandler);
            super.load(param1);
            return;
        }// end function

        public function cancel() : void
        {
            if (this._loadingState == ResourceLoadingState.LOADING)
            {
                try
                {
                    Loader(contentHolder).close();
                }
                catch (e:Error)
                {
                }
            }
            return;
        }// end function

        private function completeHandler(param1:Event) : void
        {
            this._loadingState = ResourceLoadingState.LOADED;
            log.debug("Loaded image: " + this.debugSource);
            return;
        }// end function

        private function httpStatusHandler(param1:HTTPStatusEvent) : void
        {
            if (param1.status != 200)
            {
                this._loadingState = ResourceLoadingState.ERROR;
                log.warn("http status " + param1.status + ", " + this.debugSource);
            }
            return;
        }// end function

        private function errorHandler(param1:Event) : void
        {
            this._loadingState = ResourceLoadingState.ERROR;
            log.warn("Error loading image: " + this.debugSource + ": " + param1);
            return;
        }// end function

        public function get isLoaded() : Boolean
        {
            return this._loadingState == ResourceLoadingState.LOADED;
        }// end function

        public function set isLoaded(param1:Boolean) : void
        {
            this._loadingState = param1 ? (ResourceLoadingState.LOADED) : (ResourceLoadingState.CREATED);
            return;
        }// end function

    }
}
