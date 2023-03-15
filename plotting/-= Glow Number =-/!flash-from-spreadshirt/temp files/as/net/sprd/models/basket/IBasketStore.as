package net.sprd.models.basket
{
    import net.sprd.entities.*;

    public interface IBasketStore
    {

        public function IBasketStore();

        function saveItem(param1:IBasketItem, param2:Boolean, param3:Function, param4:Function) : void;

        function loadItem(param1:String, param2:Function, param3:Function) : void;

    }
}
