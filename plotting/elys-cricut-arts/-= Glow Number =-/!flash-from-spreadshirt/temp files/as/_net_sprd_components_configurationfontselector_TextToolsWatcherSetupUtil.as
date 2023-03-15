package 
{
    import mx.binding.*;
    import mx.core.*;
    import net.sprd.components.configurationfontselector.*;

    public class _net_sprd_components_configurationfontselector_TextToolsWatcherSetupUtil extends Object implements IWatcherSetupUtil2
    {

        public function _net_sprd_components_configurationfontselector_TextToolsWatcherSetupUtil()
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
            watchers[0] = new PropertyWatcher("resourceManager", {unused:true}, [bindings[0], bindings[1], bindings[2], bindings[3], bindings[4], bindings[5], bindings[6], bindings[8], bindings[10], bindings[12]], propertyGetter);
            watchers[1] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "text_config_section.label_section_header"];
            }// end function
            , {change:true}, [bindings[0]], null);
            watchers[2] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "text_config_section.tooltip_font_selection"];
            }// end function
            , {change:true}, [bindings[1]], null);
            watchers[3] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "text_config_section.tooltip_bold"];
            }// end function
            , {change:true}, [bindings[2]], null);
            watchers[4] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "text_config_section.btn_bold"];
            }// end function
            , {change:true}, [bindings[3]], null);
            watchers[5] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "text_config_section.tooltip_italic"];
            }// end function
            , {change:true}, [bindings[4]], null);
            watchers[6] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "text_config_section.btn_italic"];
            }// end function
            , {change:true}, [bindings[5]], null);
            watchers[7] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "text_config_section.tooltip_fontsize_slider"];
            }// end function
            , {change:true}, [bindings[6]], null);
            watchers[9] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "text_config_section.tooltip_text_align_left"];
            }// end function
            , {change:true}, [bindings[8]], null);
            watchers[11] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "text_config_section.tooltip_text_align_center"];
            }// end function
            , {change:true}, [bindings[10]], null);
            watchers[13] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "text_config_section.tooltip_text_align_right"];
            }// end function
            , {change:true}, [bindings[12]], null);
            watchers[0].updateParent(target);
            watchers[1].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[1]);
            watchers[2].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[2]);
            watchers[3].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[3]);
            watchers[4].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[4]);
            watchers[5].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[5]);
            watchers[6].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[6]);
            watchers[7].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[7]);
            watchers[9].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[9]);
            watchers[11].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[11]);
            watchers[13].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[13]);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            TextTools.watcherSetupUtil = new _net_sprd_components_configurationfontselector_TextToolsWatcherSetupUtil;
            return;
        }// end function

    }
}
