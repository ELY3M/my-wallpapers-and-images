package net.sprd.utils
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import net.sprd.common.actions.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;

    public class AssetLoadAction extends AbstractAsyncAction
    {
        private var url:String;
        private var loader:Loader;
        private static const log:ILogger = LogContext.getLogger(this);

        public function AssetLoadAction(param1:String)
        {
            this.loader = new Loader();
            this.url = param1;
            return;
        }// end function

        override protected function doExecute() : void
        {
            var _loc_1:* = new URLRequest(this.url);
            log.debug("Loading asset " + this.url);
            var _loc_2:* = new LoaderContext();
            _loc_2.applicationDomain = ApplicationDomain.currentDomain;
            _loc_2.securityDomain = SecurityDomain.currentDomain;
            this.loader.load(_loc_1, _loc_2);
            return;
        }// end function

        override protected function doCancel() : Boolean
        {
            return false;
        }// end function

        override protected function registerCanonicalListeners() : void
        {
            EventUtil.registerOnetimeListeners(this.loader.contentLoaderInfo, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [actionComplete, actionError]);
            return;
        }// end function

    }
}
