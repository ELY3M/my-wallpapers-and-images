package org.swizframework.core
{

    public class SwizConfig extends Object implements ISwizConfig
    {
        protected var _strict:Boolean = true;
        protected var _setUpEventType:String = "addedToStage";
        protected var _setUpEventPriority:int = 50;
        protected var _setUpEventPhase:uint = 1;
        protected var _tearDownEventType:String = "removedFromStage";
        protected var _tearDownEventPriority:int = 50;
        protected var _tearDownEventPhase:uint = 1;
        protected var _eventPackages:Array;
        protected var _viewPackages:Array;
        protected var _defaultFaultHandler:Function;
        protected var _defaultDispatcher:String = "global";
        public static const GLOBAL_DISPATCHER:String = "global";
        public static const LOCAL_DISPATCHER:String = "local";
        static const WILDCARD_PACKAGE:RegExp = /\A(.*)(\.\**)\Z/;

        public function SwizConfig()
        {
            this._eventPackages = [];
            this._viewPackages = [];
            return;
        }// end function

        public function get strict() : Boolean
        {
            return this._strict;
        }// end function

        public function set strict(_tearDownEventType:Boolean) : void
        {
            this._strict = _tearDownEventType;
            return;
        }// end function

        public function get setUpEventType() : String
        {
            return this._setUpEventType;
        }// end function

        public function set setUpEventType(_tearDownEventType:String) : void
        {
            this._setUpEventType = _tearDownEventType;
            return;
        }// end function

        public function get setUpEventPriority() : int
        {
            return this._setUpEventPriority;
        }// end function

        public function set setUpEventPriority(_tearDownEventType:int) : void
        {
            this._setUpEventPriority = _tearDownEventType;
            return;
        }// end function

        public function get setUpEventPhase() : uint
        {
            return this._setUpEventPhase;
        }// end function

        public function set setUpEventPhase(_tearDownEventType:uint) : void
        {
            this._setUpEventPhase = _tearDownEventType;
            return;
        }// end function

        public function get tearDownEventType() : String
        {
            return this._tearDownEventType;
        }// end function

        public function set tearDownEventType(_tearDownEventType:String) : void
        {
            this._tearDownEventType = _tearDownEventType;
            return;
        }// end function

        public function get tearDownEventPriority() : int
        {
            return this._tearDownEventPriority;
        }// end function

        public function set tearDownEventPriority(_tearDownEventType:int) : void
        {
            this._tearDownEventPriority = _tearDownEventType;
            return;
        }// end function

        public function get tearDownEventPhase() : uint
        {
            return this._tearDownEventPhase;
        }// end function

        public function set tearDownEventPhase(_tearDownEventType:uint) : void
        {
            this._tearDownEventPhase = _tearDownEventType;
            return;
        }// end function

        public function get eventPackages() : Array
        {
            return this._eventPackages;
        }// end function

        public function set eventPackages(_tearDownEventType) : void
        {
            this.setEventPackages(_tearDownEventType);
            return;
        }// end function

        public function get viewPackages() : Array
        {
            return this._viewPackages;
        }// end function

        public function set viewPackages(_tearDownEventType) : void
        {
            this.setViewPackages(_tearDownEventType);
            return;
        }// end function

        public function get defaultFaultHandler() : Function
        {
            return this._defaultFaultHandler;
        }// end function

        public function set defaultFaultHandler(:Function) : void
        {
            this._defaultFaultHandler = ;
            return;
        }// end function

        public function get defaultDispatcher() : String
        {
            return this._defaultDispatcher;
        }// end function

        public function set defaultDispatcher(:String) : void
        {
            this._defaultDispatcher = ;
            return;
        }// end function

        protected function setEventPackages(_tearDownEventType) : void
        {
            this._eventPackages = this.parsePackageValue(_tearDownEventType);
            return;
        }// end function

        protected function setViewPackages(_tearDownEventType) : void
        {
            this._viewPackages = this.parsePackageValue(_tearDownEventType);
            return;
        }// end function

        protected function parsePackageValue(_tearDownEventType) : Array
        {
            if (_tearDownEventType == null)
            {
                return [];
            }
            if (_tearDownEventType is Array)
            {
                return this.parsePackageNames(_tearDownEventType as Array);
            }
            if (_tearDownEventType is String)
            {
                return this.parsePackageNames(_tearDownEventType.replace(/\ /g, "").split(","));
            }
            throw new Error("Package specified using unknown type. Supported types are Array or String.");
        }// end function

        protected function parsePackageNames(:Array) : Array
        {
            var _loc_3:String;
            var _loc_2:Array;
            for each (_loc_3 in )
            {
                
                _loc_2.push(this.parsePackageName(_loc_3));
            }
            return _loc_2;
        }// end function

        protected function parsePackageName(:String) : String
        {
            var _loc_2:* = WILDCARD_PACKAGE.exec();
            if (_loc_2)
            {
                return _loc_2[1];
            }
            return ;
        }// end function

    }
}
