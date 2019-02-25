package net.sprd.components.common.statusbutton
{

    public interface IStatus
    {

        public function IStatus();

        function get styleName() : String;

        function get iconClass() : Class;

        function get name() : String;

        function get text() : String;

    }
}
