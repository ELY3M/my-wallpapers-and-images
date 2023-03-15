package 
{
    import mx.binding.*;
    import mx.core.*;
    import net.sprd.components.producttypeappeaeranceselector.*;

    public class _net_sprd_components_producttypeappeaeranceselector_ProductColorSelectorWatcherSetupUtil extends Object implements IWatcherSetupUtil2
    {

        public function _net_sprd_components_producttypeappeaeranceselector_ProductColorSelectorWatcherSetupUtil()
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
                return ["image"];
            }// end function
            , null, [bindings[2]], propertyGetter, true);
            watchers[0] = new PropertyWatcher("fadeIn", {propertyChange:true}, [bindings[0]], propertyGetter);
            watchers[2].updateParent(target);
            watchers[0].updateParent(target);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            ProductColorSelector.watcherSetupUtil = new _net_sprd_components_producttypeappeaeranceselector_ProductColorSelectorWatcherSetupUtil;
            return;
        }// end function

    }
}
