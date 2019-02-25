package 
{
    import mx.binding.*;
    import mx.core.*;

    public class _ConfomatWatcherSetupUtil extends Object implements IWatcherSetupUtil2
    {

        public function _ConfomatWatcherSetupUtil()
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
            watchers[2] = new PropertyWatcher("productViewer", {propertyChange:true}, [bindings[2]], propertyGetter);
            watchers[3] = new PropertyWatcher("width", {widthChanged:true}, [bindings[2]], null);
            watchers[1] = new PropertyWatcher("height", {heightChanged:true}, [bindings[1]], propertyGetter);
            watchers[5] = new PropertyWatcher("resourceManager", {unused:true}, [bindings[5], bindings[6], bindings[7], bindings[8]], propertyGetter);
            watchers[6] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return [target.C7, "main_navi.btn_pick_product"];
            }// end function
            , {change:true}, [bindings[5]], null);
            watchers[8] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return [target.C7, "main_navi.btn_select_design"];
            }// end function
            , {change:true}, [bindings[6]], null);
            watchers[9] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return [target.C7, "main_navi.btn_add_text"];
            }// end function
            , {change:true}, [bindings[7]], null);
            watchers[10] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return [target.C7, "main_navi.btn_upload_photos"];
            }// end function
            , {change:true}, [bindings[8]], null);
            watchers[11] = new StaticPropertyWatcher("mode", null, [bindings[9], bindings[10]], null);
            watchers[0] = new PropertyWatcher("width", {widthChanged:true}, [bindings[0], bindings[2], bindings[11]], propertyGetter);
            watchers[15] = new PropertyWatcher("hideRightPalette", {propertyChange:true}, [bindings[17]], propertyGetter);
            watchers[2].updateParent(target);
            watchers[2].addChild(watchers[3]);
            watchers[1].updateParent(target);
            watchers[5].updateParent(target);
            watchers[6].parentWatcher = watchers[5];
            watchers[5].addChild(watchers[6]);
            watchers[8].parentWatcher = watchers[5];
            watchers[5].addChild(watchers[8]);
            watchers[9].parentWatcher = watchers[5];
            watchers[5].addChild(watchers[9]);
            watchers[10].parentWatcher = watchers[5];
            watchers[5].addChild(watchers[10]);
            watchers[11].updateParent(ConfomatConfiguration);
            watchers[0].updateParent(target);
            watchers[15].updateParent(target);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            Confomat.watcherSetupUtil = new _ConfomatWatcherSetupUtil;
            return;
        }// end function

    }
}
