package org.swizframework.reflection
{

    public class BindableMetadataHost extends BaseMetadataHost
    {

        public function BindableMetadataHost()
        {
            return;
        }// end function

        public function get isBindable() : Boolean
        {
            var _loc_1:IMetadataTag;
            for each (_loc_1 in metadataTags)
            {
                
                if (_loc_1.name == "Bindable")
                {
                    return true;
                }
            }
            return false;
        }// end function

    }
}
