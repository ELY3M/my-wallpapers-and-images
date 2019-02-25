package org.swizframework.utils.chain
{
    import org.swizframework.utils.async.*;

    public interface IAsyncChainStep extends IChainStep
    {

        public function IAsyncChainStep();

        function addAsynchronousOperation(IChainStep:IAsynchronousOperation) : void;

    }
}
