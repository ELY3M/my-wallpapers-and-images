package net.sprd.modules.share.Opossum
{
    import flash.events.*;

    public class LoginEvent extends Event
    {
        private var _user:User;
        public static const LOGIN_SUCCESS:String = "loginSuccess";
        public static const LOGIN_FAIL:String = "loginFail";
        public static const LOGIN_ERROR:String = "loginError";

        public function LoginEvent(param1:String, param2:User = null, param3:Boolean = false, param4:Boolean = false)
        {
            super(param1, param3, param4);
            this._user = param2;
            return;
        }// end function

        public function get user() : User
        {
            return this._user;
        }// end function

        override public function clone() : Event
        {
            return new LoginEvent(type, this.user.clone(), bubbles, cancelable);
        }// end function

    }
}
