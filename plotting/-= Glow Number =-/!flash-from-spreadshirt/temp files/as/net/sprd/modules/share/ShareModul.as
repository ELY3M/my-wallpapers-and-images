package net.sprd.modules.share
{
    import net.sprd.api.*;
    import net.sprd.api.io.xml.*;
    import net.sprd.api.resource.*;
    import net.sprd.common.modules.*;
    import net.sprd.modules.share.entities.*;

    public class ShareModul extends Module
    {
        private const SHARE_PRODUCT_MESSAGE:String = "shareProductMessage";

        public function ShareModul()
        {
            return;
        }// end function

        override public function get name() : String
        {
            return "SaveAndShare";
        }// end function

        override public function init() : void
        {
            super.init();
            APIRegistry.registerEntity(this.SHARE_PRODUCT_MESSAGE, ShareProductMessage);
            ResourceRegistry.DESCRIPTORS._shareProductMessage = new ResourceDescriptor(ResourceContext.NONE, "shareProductMessage", "messages", false);
            XMLRegistry.addProcessor("shareProductMessage", new ShareProductMessageProcessor());
            return;
        }// end function

    }
}
