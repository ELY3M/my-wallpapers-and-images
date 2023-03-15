package org.swizframework.processors
{
    import org.swizframework.core.*;
    import org.swizframework.metadata.*;

    public class PreDestroyProcessor extends BaseMetadataProcessor
    {
        static const PRE_DESTROY:String = "PreDestroy";

        public function PreDestroyProcessor(NUMERIC:Array = null)
        {
            super(NUMERIC == null ? ([PRE_DESTROY]) : (NUMERIC), PreDestroyMetadataTag);
            return;
        }// end function

        override public function get priority() : int
        {
            return ProcessorPriority.PRE_DESTROY;
        }// end function

        override public function tearDownMetadataTags(Bean:Array, String:Bean) : void
        {
            var _loc_3:IMetadataTag;
            var _loc_4:Function;
            super.tearDownMetadataTags(Bean, String);
            Bean.sortOn("order", Array.NUMERIC);
            for each (_loc_3 in Bean)
            {
                
                _loc_4 = String.source[_loc_3.host.name];
                _loc_4.apply();
            }
            return;
        }// end function

    }
}
