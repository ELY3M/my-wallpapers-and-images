package org.swizframework.processors
{
    import org.swizframework.core.*;

    public interface IFactoryProcessor extends IProcessor
    {

        public function IFactoryProcessor();

        function setUpFactory(IProcessor:IBeanFactory) : void;

    }
}
