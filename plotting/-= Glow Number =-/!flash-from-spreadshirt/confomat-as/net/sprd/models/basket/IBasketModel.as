package net.sprd.models.basket
{
    import net.sprd.models.product.*;

    public interface IBasketModel extends IEventDispatcher
    {

        public function IBasketModel();

        function addOrUpdateItem(param1:IProductModel, param2:Boolean, param3:Function = null, param4:Function = null) : void;

        function loadItem(param1:String, param2:Function = null, param3:Function = null) : void;

    }
}
