package 
{
    import mx.binding.*;
    import mx.core.*;
    import net.sprd.components.producttypeselector.*;

    public class _net_sprd_components_producttypeselector_ProductTypeSelectorWatcherSetupUtil extends Object implements IWatcherSetupUtil2
    {

        public function _net_sprd_components_producttypeselector_ProductTypeSelectorWatcherSetupUtil()
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
            watchers[4] = new PropertyWatcher("_selectionModel", {propertyChange:true}, [bindings[4], bindings[8], bindings[13], bindings[14]], propertyGetter);
            watchers[6] = new PropertyWatcher("productTypes", {pageChanged:true}, [bindings[13]], null);
            watchers[0] = new PropertyWatcher("resourceManager", {unused:true}, [bindings[0]], propertyGetter);
            watchers[1] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "product_gallery.label_section_header"];
            }// end function
            , {change:true}, [bindings[0]], null);
            watchers[7] = new PropertyWatcher("sizesMask", {propertyChange:true}, [bindings[15]], propertyGetter);
            watchers[5] = new PropertyWatcher("width", {widthChanged:true}, [bindings[12]], propertyGetter);
            watchers[2] = new PropertyWatcher("palette", {propertyChange:true}, [bindings[1], bindings[2], bindings[3], bindings[5], bindings[6], bindings[7], bindings[9], bindings[10], bindings[11]], propertyGetter);
            watchers[3] = new PropertyWatcher("width", {widthChanged:true}, [bindings[1], bindings[2], bindings[3], bindings[5], bindings[6], bindings[7], bindings[9], bindings[10], bindings[11]], null);
            watchers[4].updateParent(target);
            watchers[4].addChild(watchers[6]);
            watchers[0].updateParent(target);
            watchers[1].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[1]);
            watchers[7].updateParent(target);
            watchers[5].updateParent(target);
            watchers[2].updateParent(target);
            watchers[2].addChild(watchers[3]);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            ProductTypeSelector.watcherSetupUtil = new _net_sprd_components_producttypeselector_ProductTypeSelectorWatcherSetupUtil;
            return;
        }// end function

    }
}
