package org.swizframework.processors
{
    import org.swizframework.core.*;

    public interface IProcessor
    {

        public function IProcessor();

        function init(int:ISwiz) : void;

        function get priority() : int;

    }
}
