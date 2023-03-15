package net.sprd.modules.share
{
    import mx.core.*;

    public class ShareTab extends Object
    {
        protected var _panel:Container;
        private var _click:Function;
        private var _openMultiple:Boolean;

        public function ShareTab(param1:Container, param2:Function, param3:Boolean = false)
        {
            this._panel = param1;
            this._click = param2;
            this._openMultiple = param3;
            return;
        }// end function

        public function get icon() : Class
        {
            return this._panel.icon;
        }// end function

        public function get label() : String
        {
            return this._panel.label;
        }// end function

        public function get panel() : Container
        {
            return this._panel;
        }// end function

        public function get click() : Function
        {
            return this._click;
        }// end function

        public function get openMultiple() : Boolean
        {
            return this._openMultiple;
        }// end function

    }
}
