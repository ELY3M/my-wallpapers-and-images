package 
{
    import mx.binding.*;
    import mx.core.*;
    import net.sprd.skins.d2c.*;

    public class _net_sprd_skins_d2c_ButtonSkinWatcherSetupUtil extends Object implements IWatcherSetupUtil2
    {

        public function _net_sprd_skins_d2c_ButtonSkinWatcherSetupUtil()
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
                return ["color"];
            }// end function
            , null, [bindings[13]], propertyGetter, true);
            watchers[1] = new FunctionReturnWatcher("getStyle", target, function () : Array
            {
                return ["textRollOverColor"];
            }// end function
            , null, [bindings[8]], propertyGetter, true);
            watchers[0] = new FunctionReturnWatcher("getStyle", target, function () : Array
            {
                return ["color"];
            }// end function
            , null, [bindings[3]], propertyGetter, true);
            watchers[6] = new FunctionReturnWatcher("getStyle", target, function () : Array
            {
                return ["disabledColor"];
            }// end function
            , null, [bindings[31]], propertyGetter, true);
            watchers[5] = new FunctionReturnWatcher("getStyle", target, function () : Array
            {
                return ["textSelectedColor"];
            }// end function
            , null, [bindings[27]], propertyGetter, true);
            watchers[4] = new FunctionReturnWatcher("getStyle", target, function () : Array
            {
                return ["textSelectedColor"];
            }// end function
            , null, [bindings[23]], propertyGetter, true);
            watchers[3] = new FunctionReturnWatcher("getStyle", target, function () : Array
            {
                return ["textSelectedColor"];
            }// end function
            , null, [bindings[18]], propertyGetter, true);
            watchers[7] = new FunctionReturnWatcher("getStyle", target, function () : Array
            {
                return ["textSelectedColor"];
            }// end function
            , null, [bindings[36]], propertyGetter, true);
            watchers[2].updateParent(target);
            watchers[1].updateParent(target);
            watchers[0].updateParent(target);
            watchers[6].updateParent(target);
            watchers[5].updateParent(target);
            watchers[4].updateParent(target);
            watchers[3].updateParent(target);
            watchers[7].updateParent(target);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            ButtonSkin.watcherSetupUtil = new _net_sprd_skins_d2c_ButtonSkinWatcherSetupUtil;
            return;
        }// end function

    }
}
