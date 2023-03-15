package 
{
    import mx.binding.*;
    import mx.core.*;
    import net.sprd.components.designupload.*;

    public class _net_sprd_components_designupload_DesignUploadWatcherSetupUtil extends Object implements IWatcherSetupUtil2
    {

        public function _net_sprd_components_designupload_DesignUploadWatcherSetupUtil()
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
            watchers[13] = new PropertyWatcher("addImageBtn", {propertyChange:true}, [bindings[13]], propertyGetter);
            watchers[14] = new PropertyWatcher("width", {widthChanged:true}, [bindings[13]], null);
            watchers[6] = new PropertyWatcher("resourceManager", {unused:true}, [bindings[8], bindings[9], bindings[10], bindings[11], bindings[12]], propertyGetter);
            watchers[7] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "upload_gallery.label_section_header"];
            }// end function
            , {change:true}, [bindings[8]], null);
            watchers[8] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "universal.proceed"];
            }// end function
            , {change:true}, [bindings[9]], null);
            watchers[9] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "universal.cancel"];
            }// end function
            , {change:true}, [bindings[10]], null);
            watchers[10] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "upload_gallery.description_file_restrictions"];
            }// end function
            , {change:true}, [bindings[11]], null);
            watchers[11] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "main_navi.btn_upload_photos"];
            }// end function
            , {change:true}, [bindings[12]], null);
            watchers[4] = new PropertyWatcher("restrictionTxt", {propertyChange:true}, [bindings[2], bindings[5]], propertyGetter);
            watchers[0] = new PropertyWatcher("btnPanel", {propertyChange:true}, [bindings[0], bindings[3], bindings[13]], propertyGetter);
            watchers[12] = new PropertyWatcher("width", {widthChanged:true}, [bindings[13]], null);
            watchers[2] = new PropertyWatcher("designTileList", {propertyChange:true}, [bindings[1], bindings[4], bindings[15]], propertyGetter);
            watchers[17] = new PropertyWatcher("height", {heightChanged:true}, [bindings[15]], null);
            watchers[16] = new PropertyWatcher("y", {yChanged:true}, [bindings[15]], null);
            watchers[1] = new PropertyWatcher("legalSection", {propertyChange:true}, [bindings[1], bindings[4]], propertyGetter);
            watchers[15] = new PropertyWatcher("pagingProvider", {propertyChange:true}, [bindings[14]], propertyGetter);
            watchers[3] = new PropertyWatcher("paging", {propertyChange:true}, [bindings[1], bindings[4]], propertyGetter);
            watchers[13].updateParent(target);
            watchers[13].addChild(watchers[14]);
            watchers[6].updateParent(target);
            watchers[7].parentWatcher = watchers[6];
            watchers[6].addChild(watchers[7]);
            watchers[8].parentWatcher = watchers[6];
            watchers[6].addChild(watchers[8]);
            watchers[9].parentWatcher = watchers[6];
            watchers[6].addChild(watchers[9]);
            watchers[10].parentWatcher = watchers[6];
            watchers[6].addChild(watchers[10]);
            watchers[11].parentWatcher = watchers[6];
            watchers[6].addChild(watchers[11]);
            watchers[4].updateParent(target);
            watchers[0].updateParent(target);
            watchers[0].addChild(watchers[12]);
            watchers[2].updateParent(target);
            watchers[2].addChild(watchers[17]);
            watchers[2].addChild(watchers[16]);
            watchers[1].updateParent(target);
            watchers[15].updateParent(target);
            watchers[3].updateParent(target);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            DesignUpload.watcherSetupUtil = new _net_sprd_components_designupload_DesignUploadWatcherSetupUtil;
            return;
        }// end function

    }
}
