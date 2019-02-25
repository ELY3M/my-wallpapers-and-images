package net.sprd.services.localstorage
{
    import flash.net.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;

    public class LocalStorage extends Object implements ILocalStorage
    {
        private var _lso:SharedObject;
        private var _isEnabled:Boolean;
        private var bootstrapped:Boolean = false;
        private var shopId:String;
        private static const log:ILogger = LogContext.getLogger(this);
        private static const PREFIX:String = "sprd_c7_";
        private static const MIN_SIZE:uint = 10;
        private static const PATH:String = "/";
        private static const VERSION:int = 3;

        public function LocalStorage()
        {
            return;
        }// end function

        public function init() : void
        {
            var date:Date;
            try
            {
                this.bootstrapped = true;
                this.shopId = ConfomatConfiguration.shopID;
                this._lso = SharedObject.getLocal(PREFIX + this.shopId, PATH);
                if (!this._lso.data.firstVisit)
                {
                    date = new Date();
                    this._lso.data.firstVisit = Math.round(date.getTime() / 1000);
                }
                this._isEnabled = true;
                this.matchToVersion();
                this._lso.data.visits = this.visitCount + 1;
                this._lso.flush(MIN_SIZE);
            }
            catch (error:Error)
            {
                _isEnabled = false;
                log.warn("Local shared object could not be created.\n" + error);
            }
            return;
        }// end function

        public function get uploadedDesigns() : Array
        {
            if (!this._isEnabled)
            {
                return [];
            }
            return this._lso.data.uploadedDesigns ? (this._lso.data.uploadedDesigns) : ([]);
        }// end function

        public function set uploadedDesigns(param1:Array) : void
        {
            if (!this._isEnabled)
            {
                return;
            }
            this._lso.data.uploadedDesigns = param1;
            this.flush();
            return;
        }// end function

        public function get isEnabled() : Boolean
        {
            return this._isEnabled;
        }// end function

        public function get agreedUploadDisclaimer() : Boolean
        {
            if (!this._isEnabled)
            {
                return false;
            }
            return this._lso.data.uploadTNCAgreed ? (this._lso.data.uploadTNCAgreed) : (false);
        }// end function

        public function set agreedUploadDisclaimer(param1:Boolean) : void
        {
            if (!this._isEnabled)
            {
                return;
            }
            this._lso.data.uploadTNCAgreed = param1;
            this.flush();
            return;
        }// end function

        public function get visitCount() : int
        {
            if (!this._isEnabled)
            {
                return -1;
            }
            return this._lso.data.visits ? (this._lso.data.visits) : (0);
        }// end function

        public function get productMemento() : Object
        {
            if (!this._isEnabled)
            {
                return null;
            }
            return this._lso.data.productMemento;
        }// end function

        public function setProductMemento(param1:Object, param2:String, param3:String, param4:String) : void
        {
            if (!this._isEnabled)
            {
                return;
            }
            if (param1 != null)
            {
                param1.id = null;
            }
            this._lso.data.productMemento = param1;
            this._lso.data.productMementoStamp = new Date().time;
            this._lso.data.currentAppearance = param2;
            this._lso.data.currentSize = param3;
            this._lso.data.currentView = param4;
            this.flush();
            return;
        }// end function

        public function clearProductMemento() : void
        {
            if (!this._isEnabled)
            {
                return;
            }
            delete this._lso.data.productMemento;
            delete this._lso.data.productMementoStamp;
            delete this._lso.data.currentAppearance;
            delete this._lso.data.currentSize;
            delete this._lso.data.currentView;
            this.flush();
            return;
        }// end function

        public function get appearance() : String
        {
            if (!this._isEnabled)
            {
                return null;
            }
            return this._lso.data.currentAppearance;
        }// end function

        public function get size() : String
        {
            if (!this._isEnabled)
            {
                return null;
            }
            return this._lso.data.currentSize;
        }// end function

        public function get view() : String
        {
            if (!this._isEnabled)
            {
                return null;
            }
            return this._lso.data.currentView;
        }// end function

        private function flush() : void
        {
            if (!this._isEnabled)
            {
                return;
            }
            try
            {
                this._lso.flush();
            }
            catch (e:Error)
            {
                log.warn("Couldn\'t flush local storage: " + e.message);
            }
            return;
        }// end function

        private function matchToVersion() : void
        {
            var _loc_1:* = this._lso.data.v;
            if (_loc_1)
            {
            }
            if (_loc_1 != VERSION)
            {
                this.clearProductMemento();
            }
            this._lso.data.v = VERSION;
            this.flush();
            return;
        }// end function

    }
}
