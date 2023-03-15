package 
{
    import mx.binding.*;
    import mx.core.*;
    import net.sprd.components.producttypeselector.colorfilter.*;

    public class _net_sprd_components_producttypeselector_colorfilter_ColorRendererWatcherSetupUtil extends Object implements IWatcherSetupUtil2
    {

        public function _net_sprd_components_producttypeselector_colorfilter_ColorRendererWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
        {
            param5[0] = new PropertyWatcher("data", {dataChange:true}, [param4[0]], param2);
            param5[2] = new PropertyWatcher("glow", {propertyChange:true}, [param4[1]], param2);
            param5[1] = new PropertyWatcher("bevel", {propertyChange:true}, [param4[1]], param2);
            param5[0].updateParent(param1);
            param5[2].updateParent(param1);
            param5[1].updateParent(param1);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            ColorRenderer.watcherSetupUtil = new _net_sprd_components_producttypeselector_colorfilter_ColorRendererWatcherSetupUtil;
            return;
        }// end function

    }
}
