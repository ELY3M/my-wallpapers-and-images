package ResourceManagerImpl.as$130
{
    import mx.modules.*;
    import mx.resources.*;

    private class ResourceModuleInfo extends Object
    {
        public var errorHandler:Function;
        public var moduleInfo:IModuleInfo;
        public var readyHandler:Function;
        public var resourceModule:IResourceModule;

        private function ResourceModuleInfo(IModuleInfo:IModuleInfo, Function:Function, resourceModule:Function)
        {
            this.moduleInfo = IModuleInfo;
            this.readyHandler = Function;
            this.errorHandler = resourceModule;
            return;
        }// end function

    }
}
