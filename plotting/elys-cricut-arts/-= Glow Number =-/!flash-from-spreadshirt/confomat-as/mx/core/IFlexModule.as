package mx.core
{

    public interface IFlexModule
    {

        public function IFlexModule();

        function set moduleFactory(moduleFactory:IFlexModuleFactory) : void;

        function get moduleFactory() : IFlexModuleFactory;

    }
}
