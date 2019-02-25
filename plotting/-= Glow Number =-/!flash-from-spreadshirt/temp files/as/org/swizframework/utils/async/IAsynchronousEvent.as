package org.swizframework.utils.async
{
    import org.swizframework.utils.chain.*;

    public interface IAsynchronousEvent
    {

        public function IAsynchronousEvent();

        function get step() : IAsyncChainStep;

        function set step(:IAsyncChainStep) : void;

    }
}
