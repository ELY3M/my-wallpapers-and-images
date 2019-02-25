package net.sprd.common.actions
{

    public interface IAsyncAction extends IEventDispatcher, IAction
    {

        public function IAsyncAction();

        function cancel() : Boolean;

        function get state() : int;

    }
}
