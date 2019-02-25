package 
{
    import mx.binding.*;
    import mx.core.*;
    import net.sprd.skins.d2c.alert.*;

    public class _net_sprd_skins_d2c_alert_AlertButtonSkinWatcherSetupUtil extends Object implements IWatcherSetupUtil2
    {

        public function _net_sprd_skins_d2c_alert_AlertButtonSkinWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
        {
            param5[0] = new PropertyWatcher("parent", null, [param4[15]], param2);
            param5[0].updateParent(param1);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            AlertButtonSkin.watcherSetupUtil = new _net_sprd_skins_d2c_alert_AlertButtonSkinWatcherSetupUtil;
            return;
        }// end function

    }
}
