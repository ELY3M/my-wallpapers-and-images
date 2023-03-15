package org.swizframework.processors
{
    import org.swizframework.core.*;
    import org.swizframework.metadata.*;

    public class PostConstructProcessor extends BaseMetadataProcessor
    {
        static const POST_CONSTRUCT:String = "PostConstruct";

        public function PostConstructProcessor(NUMERIC:Array = null)
        {
            super(NUMERIC == null ? ([POST_CONSTRUCT]) : (NUMERIC), PostConstructMetadataTag);
            return;
        }// end function

        override public function get priority() : int
        {
            return ProcessorPriority.POST_CONSTRUCT;
        }// end function

        override public function setUpMetadataTags(Bean:Array, String:Bean) : void
        {
            var _loc_3:IMetadataTag;
            var _loc_4:Function;
            super.setUpMetadataTags(Bean, String);
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
