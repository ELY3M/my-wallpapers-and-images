package net.sprd.components.common.statusbutton
{

    public class Status extends Object implements IStatus
    {
        private var _styleName:String;
        private var _iconClass:Class;
        private var _name:String;
        private var _text:String;

        public function Status()
        {
            return;
        }// end function

        public function set styleName(param1:String) : void
        {
            this._styleName = param1;
            return;
        }// end function

        public function set iconClass(param1:Class) : void
        {
            this._iconClass = param1;
            return;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function set text(param1:String) : void
        {
            this._text = param1;
            return;
        }// end function

        public function get styleName() : String
        {
            return this._styleName;
        }// end function

        public function get iconClass() : Class
        {
            return this._iconClass;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get text() : String
        {
            return this._text;
        }// end function

    }
}
