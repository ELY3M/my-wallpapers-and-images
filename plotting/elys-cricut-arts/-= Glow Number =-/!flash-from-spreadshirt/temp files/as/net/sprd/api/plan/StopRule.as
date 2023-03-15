package net.sprd.api.plan
{

    public class StopRule extends Object
    {
        private var _child:String;
        private var _parent:String;

        public function StopRule(param1:String, param2:String = null)
        {
            this._parent = param2;
            this._child = param1;
            return;
        }// end function

        public function get child() : String
        {
            return this._child;
        }// end function

        public function get parent() : String
        {
            return this._parent;
        }// end function

    }
}
