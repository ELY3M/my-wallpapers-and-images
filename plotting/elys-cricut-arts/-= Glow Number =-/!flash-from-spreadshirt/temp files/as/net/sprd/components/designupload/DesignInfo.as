package net.sprd.components.designupload
{
    import flash.events.*;
    import flash.net.*;
    import net.sprd.entities.*;
    import net.sprd.models.product.*;

    public class DesignInfo extends EventDispatcher
    {
        public var design:IDesign;
        public var isUpLoading:Boolean = false;
        public var fileReference:FileReference;
        public var constraints:ConfigurationUsageConstraints;

        public function DesignInfo(param1:IDesign)
        {
            this.design = param1;
            return;
        }// end function

        public function get designId() : String
        {
            return this.design ? (this.design.id) : ("null");
        }// end function

    }
}
