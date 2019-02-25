package org.swizframework.utils.chain
{

    public interface IChainStep
    {

        public function IChainStep();

        function get chain() : IChain;

        function set chain(complete:IChain) : void;

        function get isComplete() : Boolean;

        function complete() : void;

        function error() : void;

    }
}
