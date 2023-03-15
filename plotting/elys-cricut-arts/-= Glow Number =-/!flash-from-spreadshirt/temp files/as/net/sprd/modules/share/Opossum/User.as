package net.sprd.modules.share.Opossum
{
    import flash.events.*;
    import mx.events.*;

    public class User extends Object implements IEventDispatcher
    {
        protected var _email:String;
        protected var _isAuthentificated:Boolean;
        protected var _username:String;
        protected var _id:String;
        protected var _surName:String;
        protected var _firstName:String;
        private var _bindingEventDispatcher:EventDispatcher;

        public function User()
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            return;
        }// end function

        public function get surName() : String
        {
            return this._surName;
        }// end function

        public function set surName(param1:String) : void
        {
            this._surName = param1;
            return;
        }// end function

        public function get firstName() : String
        {
            return this._firstName;
        }// end function

        public function set firstName(param1:String) : void
        {
            this._firstName = param1;
            return;
        }// end function

        public function get email() : String
        {
            return this._email;
        }// end function

        public function set email(param1:String) : void
        {
            this._email = param1;
            return;
        }// end function

        public function get isAuthentificated() : Boolean
        {
            return this._isAuthentificated;
        }// end function

        private function set _176147390isAuthentificated(param1:Boolean) : void
        {
            this._isAuthentificated = param1;
            return;
        }// end function

        public function get username() : String
        {
            return this._username;
        }// end function

        public function set username(param1:String) : void
        {
            this._username = param1;
            return;
        }// end function

        public function get id() : String
        {
            return this._id;
        }// end function

        public function set id(param1:String) : void
        {
            this._id = param1;
            return;
        }// end function

        public function clone() : User
        {
            var _loc_1:* = new User();
            _loc_1.email = this.email;
            _loc_1.username = this.username;
            _loc_1.id = this.id;
            _loc_1.isAuthentificated = this.isAuthentificated;
            return _loc_1;
        }// end function

        public function set isAuthentificated(param1:Boolean) : void
        {
            var _loc_2:* = this.isAuthentificated;
            if (_loc_2 !== param1)
            {
                this._176147390isAuthentificated = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isAuthentificated", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            this._bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return this._bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return this._bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            this._bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return this._bindingEventDispatcher.willTrigger(param1);
        }// end function

    }
}
