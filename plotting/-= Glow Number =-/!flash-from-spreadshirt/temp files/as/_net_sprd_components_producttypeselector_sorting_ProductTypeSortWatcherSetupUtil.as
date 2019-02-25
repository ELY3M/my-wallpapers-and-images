package 
{
    import mx.binding.*;
    import mx.core.*;
    import net.sprd.components.producttypeselector.sorting.*;

    public class _net_sprd_components_producttypeselector_sorting_ProductTypeSortWatcherSetupUtil extends Object implements IWatcherSetupUtil2
    {

        public function _net_sprd_components_producttypeselector_sorting_ProductTypeSortWatcherSetupUtil()
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
            watchers[0] = new PropertyWatcher("resourceManager", {unused:true}, [bindings[0], bindings[2]], propertyGetter);
            watchers[1] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "universal.label_sort_size"];
            }// end function
            , {change:true}, [bindings[0]], null);
            watchers[4] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "universal.label_sort_colour"];
            }// end function
            , {change:true}, [bindings[2]], null);
            watchers[2] = new PropertyWatcher("_dataProvider", {propertyChange:true}, [bindings[1]], propertyGetter);
            watchers[3] = new PropertyWatcher("sortSizes", {sizesChanged:true}, [bindings[1]], null);
            watchers[0].updateParent(target);
            watchers[1].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[1]);
            watchers[4].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[4]);
            watchers[2].updateParent(target);
            watchers[2].addChild(watchers[3]);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            ProductTypeSort.watcherSetupUtil = new _net_sprd_components_producttypeselector_sorting_ProductTypeSortWatcherSetupUtil;
            return;
        }// end function

    }
}
