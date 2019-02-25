package 
{
    import mx.binding.*;
    import mx.core.*;
    import net.sprd.components.configurationcolorselector.*;

    public class _net_sprd_components_configurationcolorselector_D2CPrintColorPanelWatcherSetupUtil extends Object implements IWatcherSetupUtil2
    {

        public function _net_sprd_components_configurationcolorselector_D2CPrintColorPanelWatcherSetupUtil()
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
            watchers[0] = new PropertyWatcher("resourceManager", {unused:true}, [bindings[0], bindings[1], bindings[2], bindings[3], bindings[6], bindings[8]], propertyGetter);
            watchers[1] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "printtype_section.label_section_header"];
            }// end function
            , {change:true}, [bindings[0]], null);
            watchers[2] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "printtype_section.tab_foil_print"];
            }// end function
            , {change:true}, [bindings[1]], null);
            watchers[3] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "printtype_section.label_flex_print"];
            }// end function
            , {change:true}, [bindings[2]], null);
            watchers[4] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "printtype_section.label_flock_print"];
            }// end function
            , {change:true}, [bindings[3]], null);
            watchers[7] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "printtype_section.label_special_print"];
            }// end function
            , {change:true}, [bindings[6]], null);
            watchers[8] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "printtype_section.tab_digital_print"];
            }// end function
            , {change:true}, [bindings[8]], null);
            watchers[6] = new PropertyWatcher("width", {widthChanged:true}, [bindings[5]], propertyGetter);
            watchers[0].updateParent(target);
            watchers[1].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[1]);
            watchers[2].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[2]);
            watchers[3].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[3]);
            watchers[4].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[4]);
            watchers[7].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[7]);
            watchers[8].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[8]);
            watchers[6].updateParent(target);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            D2CPrintColorPanel.watcherSetupUtil = new _net_sprd_components_configurationcolorselector_D2CPrintColorPanelWatcherSetupUtil;
            return;
        }// end function

    }
}
