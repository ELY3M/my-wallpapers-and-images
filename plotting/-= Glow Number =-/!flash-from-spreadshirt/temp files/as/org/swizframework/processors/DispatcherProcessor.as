package org.swizframework.processors
{
    import flash.events.*;
    import org.swizframework.core.*;
    import org.swizframework.reflection.*;

    public class DispatcherProcessor extends BaseMetadataProcessor
    {
        static const DISPATCHER:String = "Dispatcher";

        public function DispatcherProcessor(length:Array = null)
        {
            super(length == null ? ([DISPATCHER]) : (length));
            return;
        }// end function

        override public function get priority() : int
        {
            return ProcessorPriority.DISPATCHER;
        }// end function

        override public function setUpMetadataTag(key:IMetadataTag, IEventDispatcher:Bean) : void
        {
            var _loc_3:String;
            if (key.hasArg("scope"))
            {
                _loc_3 = key.getArg("scope").value;
            }
            else
            {
                if (key.args.length > 0)
                {
                }
                if (MetadataArg(key.args[0]).key == "")
                {
                    _loc_3 = MetadataArg(key.args[0]).value;
                }
            }
            var _loc_4:IEventDispatcher;
            if (_loc_3 == SwizConfig.GLOBAL_DISPATCHER)
            {
                _loc_4 = swiz.globalDispatcher;
            }
            else if (_loc_3 == SwizConfig.LOCAL_DISPATCHER)
            {
                _loc_4 = swiz.dispatcher;
            }
            else
            {
                _loc_4 = swiz.config.defaultDispatcher == SwizConfig.LOCAL_DISPATCHER ? (swiz.dispatcher) : (swiz.globalDispatcher);
            }
            IEventDispatcher.source[key.host.name] = _loc_4;
            return;
        }// end function

        override public function tearDownMetadataTag(key:IMetadataTag, IEventDispatcher:Bean) : void
        {
            IEventDispatcher.source[key.host.name] = null;
            return;
        }// end function

    }
}
