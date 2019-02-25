package org.swizframework.processors
{
    import org.swizframework.core.*;

    public interface IBeanProcessor extends IProcessor
    {

        public function IBeanProcessor();

        function setUpBean(IProcessor:Bean) : void;

        function tearDownBean(IProcessor:Bean) : void;

    }
}
