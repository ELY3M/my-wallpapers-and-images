package net.sprd.services.externalapi
{
    import net.sprd.entities.*;

    public interface IExternalAPI
    {

        public function IExternalAPI();

        function checkout() : void;

        function onProductUpdated(param1:String, param2:String, param3:String, param4:String) : void;

        function onApplicationLoaded(param1:Number) : void;

        function onDesignChanged(param1:IDesign) : void;

        function displayTaxDetails() : void;

        function displayShippingDetails() : void;

    }
}
