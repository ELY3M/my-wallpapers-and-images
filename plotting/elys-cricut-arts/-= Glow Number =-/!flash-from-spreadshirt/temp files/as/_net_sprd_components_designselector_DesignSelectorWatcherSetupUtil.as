package 
{
    import mx.binding.*;
    import mx.core.*;
    import net.sprd.components.designselector.*;

    public class _net_sprd_components_designselector_DesignSelectorWatcherSetupUtil extends Object implements IWatcherSetupUtil2
    {

        public function _net_sprd_components_designselector_DesignSelectorWatcherSetupUtil()
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
            watchers[2] = new PropertyWatcher("resourceManager", {unused:true}, [bindings[4], bindings[10], bindings[11], bindings[12], bindings[22]], propertyGetter);
            watchers[3] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "design_gallery.label_section_header"];
            }// end function
            , {change:true}, [bindings[4]], null);
            watchers[7] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "universal.label_searchbox"];
            }// end function
            , {change:true}, [bindings[10]], null);
            watchers[8] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "universal.btn_search"];
            }// end function
            , {change:true}, [bindings[11]], null);
            watchers[9] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "universal.btn_search"];
            }// end function
            , {change:true}, [bindings[12]], null);
            watchers[11] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "messages_system.printarea_disallow_designs"];
            }// end function
            , {change:true}, [bindings[22]], null);
            watchers[12] = new PropertyWatcher("allowDesignsOnPrintArea", {propertyChange:true}, [bindings[24]], propertyGetter);
            watchers[4] = new PropertyWatcher("palette", {propertyChange:true}, [bindings[5], bindings[6], bindings[7], bindings[13], bindings[16], bindings[17], bindings[19], bindings[20], bindings[21], bindings[23], bindings[25], bindings[26]], propertyGetter);
            watchers[5] = new PropertyWatcher("width", {widthChanged:true}, [bindings[5], bindings[6], bindings[7], bindings[13], bindings[16], bindings[17], bindings[19], bindings[20], bindings[21], bindings[23], bindings[25], bindings[26]], null);
            watchers[6] = new PropertyWatcher("showDesignSearch", {propertyChange:true}, [bindings[8], bindings[9], bindings[14], bindings[15]], propertyGetter);
            watchers[10] = new PropertyWatcher("_designModel", {propertyChange:true}, [bindings[18], bindings[27], bindings[28]], propertyGetter);
            watchers[13] = new PropertyWatcher("designs", {pageChanged:true}, [bindings[27]], null);
            watchers[0] = new PropertyWatcher("warning", {propertyChange:true}, [bindings[0], bindings[1], bindings[2], bindings[3]], propertyGetter);
            watchers[2].updateParent(target);
            watchers[3].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[3]);
            watchers[7].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[7]);
            watchers[8].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[8]);
            watchers[9].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[9]);
            watchers[11].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[11]);
            watchers[12].updateParent(target);
            watchers[4].updateParent(target);
            watchers[4].addChild(watchers[5]);
            watchers[6].updateParent(target);
            watchers[10].updateParent(target);
            watchers[10].addChild(watchers[13]);
            watchers[0].updateParent(target);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            DesignSelector.watcherSetupUtil = new _net_sprd_components_designselector_DesignSelectorWatcherSetupUtil;
            return;
        }// end function

    }
}
