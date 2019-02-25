package org.swizframework.metadata
{
    import org.swizframework.reflection.*;

    public class PreDestroyMetadataTag extends BaseMetadataTag
    {
        protected var _order:int = 1;

        public function PreDestroyMetadataTag()
        {
            defaultArgName = "order";
            return;
        }// end function

        public function get order() : int
        {
            return this._order;
        }// end function

        override public function copyFrom(order:IMetadataTag) : void
        {
            super.copyFrom(order);
            if (hasArg("order"))
            {
                this._order = int(getArg("order").value);
            }
            return;
        }// end function

    }
}
