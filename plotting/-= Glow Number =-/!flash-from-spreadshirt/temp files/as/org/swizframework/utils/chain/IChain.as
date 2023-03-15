package org.swizframework.utils.chain
{

    public interface IChain extends IEventDispatcher
    {

        public function IChain();

        function get position() : int;

        function set position(IChainStep:int) : void;

        function get isComplete() : Boolean;

        function get stopOnError() : Boolean;

        function set stopOnError(IChainStep:Boolean) : void;

        function hasNext() : Boolean;

        function stepComplete() : void;

        function stepError() : void;

        function addStep(doProceed:IChainStep) : IChain;

        function start() : void;

        function doProceed() : void;

    }
}
