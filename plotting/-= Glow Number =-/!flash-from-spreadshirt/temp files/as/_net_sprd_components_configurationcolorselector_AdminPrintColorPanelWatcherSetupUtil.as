package 
{
    import mx.binding.*;
    import mx.core.*;
    import net.sprd.components.configurationcolorselector.*;

    public class _net_sprd_components_configurationcolorselector_AdminPrintColorPanelWatcherSetupUtil extends Object implements IWatcherSetupUtil2
    {

        public function _net_sprd_components_configurationcolorselector_AdminPrintColorPanelWatcherSetupUtil()
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
            watchers[0] = new PropertyWatcher("resourceManager", {unused:true}, [bindings[0]], propertyGetter);
            watchers[1] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "printtype_section.label_section_header"];
            }// end function
            , {change:true}, [bindings[0]], null);
            watchers[0].updateParent(target);
            watchers[1].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[1]);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            AdminPrintColorPanel.watcherSetupUtil = new _net_sprd_components_configurationcolorselector_AdminPrintColorPanelWatcherSetupUtil;
            return;
        }// end function

    }
}
