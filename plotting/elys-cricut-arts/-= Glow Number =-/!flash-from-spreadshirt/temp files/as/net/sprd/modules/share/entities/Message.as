package net.sprd.modules.share.entities
{
    import Message.as$612.*;
    import flash.utils.*;
    import net.sprd.api.*;
    import net.sprd.entities.impl.*;

    public class Message extends BaseEntity
    {
        protected var _type:String = "sprd:message";

        public function Message()
        {
            this.context = new EmptyContext();
            return;
        }// end function

        public function get type() : String
        {
            return this._type;
        }// end function

        public function properties() : Dictionary
        {
            return new Dictionary();
        }// end function

        public function sendMessage(param1:Function, param2:Function) : void
        {
            API.em.save(this, param1, param2);
            return;
        }// end function

    }
}
