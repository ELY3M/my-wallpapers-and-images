package 
{
    import mx.binding.*;
    import mx.core.*;
    import net.sprd.components.basket.*;

    public class _net_sprd_components_basket_BasketWatcherSetupUtil extends Object implements IWatcherSetupUtil2
    {

        public function _net_sprd_components_basket_BasketWatcherSetupUtil()
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
            watchers[6] = new PropertyWatcher("addToBasketButton", null, [bindings[5], bindings[7]], propertyGetter);
            watchers[7] = new PropertyWatcher("x", {xChanged:true}, [bindings[5], bindings[7]], null);
            watchers[3] = new PropertyWatcher("resourceManager", {unused:true}, [bindings[3], bindings[4], bindings[6]], propertyGetter);
            watchers[4] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "universal.in_progress"];
            }// end function
            , {change:true}, [bindings[3]], null);
            watchers[5] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "basket_section.label_incl_VAT"];
            }// end function
            , {change:true}, [bindings[4]], null);
            watchers[8] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "basket_section.label_excl_shipping"];
            }// end function
            , {change:true}, [bindings[6]], null);
            watchers[0] = new PropertyWatcher("fadeIn", {propertyChange:true}, [bindings[0]], propertyGetter);
            watchers[9] = new StaticPropertyWatcher("platform", null, [bindings[8]], null);
            watchers[6].updateParent(target);
            watchers[6].addChild(watchers[7]);
            watchers[3].updateParent(target);
            watchers[4].parentWatcher = watchers[3];
            watchers[3].addChild(watchers[4]);
            watchers[5].parentWatcher = watchers[3];
            watchers[3].addChild(watchers[5]);
            watchers[8].parentWatcher = watchers[3];
            watchers[3].addChild(watchers[8]);
            watchers[0].updateParent(target);
            watchers[9].updateParent(ConfomatConfiguration);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            Basket.watcherSetupUtil = new _net_sprd_components_basket_BasketWatcherSetupUtil;
            return;
        }// end function

    }
}
