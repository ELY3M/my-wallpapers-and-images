package net.sprd.common.modules
{

    public class Module extends Object implements IModule
    {

        public function Module()
        {
            return;
        }// end function

        public function get name() : String
        {
            throw new Error("Abstract method");
        }// end function

        public function init() : void
        {
            return;
        }// end function

    }
}
