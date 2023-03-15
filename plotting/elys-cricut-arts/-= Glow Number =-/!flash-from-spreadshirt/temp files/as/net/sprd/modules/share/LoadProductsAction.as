package net.sprd.modules.share
{
    import flash.events.*;
    import flash.net.*;
    import net.sprd.api.*;
    import net.sprd.api.plan.*;
    import net.sprd.common.actions.*;
    import net.sprd.entities.*;
    import net.sprd.services.externalapi.*;

    class LoadProductsAction extends EventDispatcher implements IAsyncAction
    {
        private var _state:int = 0;
        private var offset:uint;
        private var loggedIn:Boolean;
        private var _result:IQueryResult;

        function LoadProductsAction(param1:uint, param2:Boolean)
        {
            this.offset = param1;
            this.loggedIn = param2;
            return;
        }// end function

        public function cancel() : Boolean
        {
            return false;
        }// end function

        public function get state() : int
        {
            return this._state;
        }// end function

        public function execute() : void
        {
            var _loc_1:* = FetchPlan.lazyPlan();
            var _loc_2:* = Query.buildSearchTerm(["categoryIds", "token"], [502, ExternalAPI.getToken()]);
            var _loc_3:* = Query.findAll(APIRegistry.PRODUCT, this.offset, ProductSelectorModel.BATCH_SIZE, null, _loc_2);
            if (this.loggedIn)
            {
                _loc_3.additionalParameters = new URLVariables();
                _loc_3.additionalParameters.loggedIn = true;
            }
            this._state = ActionState.EXECUTING;
            API.em.find(_loc_3, this.onProductsComplete, this.onProductsFault, _loc_1);
            return;
        }// end function

        private function onProductsComplete(param1:Event) : void
        {
            this._state = ActionState.COMPLETED;
            this._result = IQueryResult(param1.target);
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        private function onProductsFault(param1:IOErrorEvent) : void
        {
            this._state = ActionState.ABORTED;
            dispatchEvent(param1.clone());
            return;
        }// end function

        function get result() : IQueryResult
        {
            return this._result;
        }// end function

    }
}
