package 
{
    import mx.binding.*;
    import mx.core.*;
    import net.sprd.components.common.categoryselector.*;

    public class _net_sprd_components_common_categoryselector_CategorySelectorWatcherSetupUtil extends Object implements IWatcherSetupUtil2
    {

        public function _net_sprd_components_common_categoryselector_CategorySelectorWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
        {
            param5[1] = new PropertyWatcher("sub", {propertyChange:true}, [param4[3], param4[5]], param2);
            param5[2] = new PropertyWatcher("_dataProvider", {propertyChange:true}, [param4[6], param4[7]], param2);
            param5[4] = new PropertyWatcher("selectedTopCategory", null, [param4[7]], null);
            param5[3] = new PropertyWatcher("topCategories", null, [param4[6]], null);
            param5[1].updateParent(param1);
            param5[2].updateParent(param1);
            param5[2].addChild(param5[4]);
            param5[2].addChild(param5[3]);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            CategorySelector.watcherSetupUtil = new _net_sprd_components_common_categoryselector_CategorySelectorWatcherSetupUtil;
            return;
        }// end function

    }
}
