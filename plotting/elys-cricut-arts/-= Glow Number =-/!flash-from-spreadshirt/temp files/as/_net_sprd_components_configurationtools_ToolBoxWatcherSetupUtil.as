package 
{
    import mx.binding.*;
    import mx.core.*;
    import net.sprd.components.configurationtools.*;

    public class _net_sprd_components_configurationtools_ToolBoxWatcherSetupUtil extends Object implements IWatcherSetupUtil2
    {

        public function _net_sprd_components_configurationtools_ToolBoxWatcherSetupUtil()
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
            watchers[7] = new PropertyWatcher("positions", {propertyChange:true}, [bindings[8]], propertyGetter);
            watchers[8] = new PropertyWatcher("width", {widthChanged:true}, [bindings[8]], null);
            watchers[9] = new PropertyWatcher("resourceManager", {unused:true}, [bindings[9]], propertyGetter);
            watchers[10] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "toolbox.color_notice"];
            }// end function
            , {change:true}, [bindings[9]], null);
            watchers[3] = new PropertyWatcher("colors", null, [bindings[5]], propertyGetter);
            watchers[4] = new PropertyWatcher("width", {widthChanged:true}, [bindings[5]], null);
            watchers[2] = new PropertyWatcher("width", {widthChanged:true}, [bindings[4]], propertyGetter);
            watchers[7].updateParent(target);
            watchers[7].addChild(watchers[8]);
            watchers[9].updateParent(target);
            watchers[10].parentWatcher = watchers[9];
            watchers[9].addChild(watchers[10]);
            watchers[3].updateParent(target);
            watchers[3].addChild(watchers[4]);
            watchers[2].updateParent(target);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            ToolBox.watcherSetupUtil = new _net_sprd_components_configurationtools_ToolBoxWatcherSetupUtil;
            return;
        }// end function

    }
}
