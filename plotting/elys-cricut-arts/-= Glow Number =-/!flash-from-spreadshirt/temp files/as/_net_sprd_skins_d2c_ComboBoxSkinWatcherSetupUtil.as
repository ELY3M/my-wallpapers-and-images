package 
{
    import mx.binding.*;
    import mx.core.*;
    import net.sprd.skins.d2c.*;

    public class _net_sprd_skins_d2c_ComboBoxSkinWatcherSetupUtil extends Object implements IWatcherSetupUtil2
    {

        public function _net_sprd_skins_d2c_ComboBoxSkinWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
        {
            var target:* = param1;
            var propertyGetter:* = param2;
            var staticPropertyGetter:* = param3;
            var bindings:* = param4;
            var watchers:* = param5;
            watchers[2] = new FunctionReturnWatcher("getStyle", target, function () : Array
            {
                return ["selectionColor"];
            }// end function
            , null, [bindings[6]], propertyGetter, true);
            watchers[1] = new FunctionReturnWatcher("getStyle", target, function () : Array
            {
                return ["selectionColor"];
            }// end function
            , null, [bindings[3]], propertyGetter, true);
            watchers[0] = new FunctionReturnWatcher("getStyle", target, function () : Array
            {
                return ["arrowColor"];
            }// end function
            , null, [bindings[0]], propertyGetter, true);
            watchers[2].updateParent(target);
            watchers[1].updateParent(target);
            watchers[0].updateParent(target);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            ComboBoxSkin.watcherSetupUtil = new _net_sprd_skins_d2c_ComboBoxSkinWatcherSetupUtil;
            return;
        }// end function

    }
}
