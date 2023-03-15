package net.sprd.modules.share
{
    import net.sprd.api.io.xml.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.modules.share.entities.*;

    public class ShareProductMessageProcessor extends XMLSupport implements IResourceSerializer
    {
        private static const log:ILogger = LogContext.getLogger(this);

        public function ShareProductMessageProcessor()
        {
            return;
        }// end function

        public function serialize(param1:Object) : Object
        {
            var _loc_5:String;
            var _loc_2:* = ShareProductMessage(param1);
            var _loc_3:* = new XML("<message type=\"" + _loc_2.type + "\"><properties/></message>");
            var _loc_4:* = _loc_2.properties();
            for (_loc_5 in _loc_4)
            {
                
                _loc_3.properties.appendChild(new XML("<property key=\"" + _loc_5 + "\">" + _loc_4[_loc_5] + "</property>"));
            }
            return _loc_3;
        }// end function

    }
}
