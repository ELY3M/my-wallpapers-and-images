package ResourceManagerImpl.as$130
{
    import flash.events.*;
    import mx.events.*;
    import mx.modules.*;

    private class ResourceEventDispatcher extends EventDispatcher
    {

        private function ResourceEventDispatcher(IModuleInfo:IModuleInfo)
        {
            IModuleInfo.addEventListener(ModuleEvent.ERROR, this.moduleInfo_errorHandler, false, 0, true);
            IModuleInfo.addEventListener(ModuleEvent.PROGRESS, this.moduleInfo_progressHandler, false, 0, true);
            IModuleInfo.addEventListener(ModuleEvent.READY, this.moduleInfo_readyHandler, false, 0, true);
            return;
        }// end function

        private function moduleInfo_errorHandler(topLevelSystemManagers:ModuleEvent) : void
        {
            var _loc_2:* = new ResourceEvent(ResourceEvent.ERROR, topLevelSystemManagers.bubbles, topLevelSystemManagers.cancelable);
            _loc_2.bytesLoaded = topLevelSystemManagers.bytesLoaded;
            _loc_2.bytesTotal = topLevelSystemManagers.bytesTotal;
            _loc_2.errorText = topLevelSystemManagers.errorText;
            dispatchEvent(_loc_2);
            return;
        }// end function

        private function moduleInfo_progressHandler(topLevelSystemManagers:ModuleEvent) : void
        {
            var _loc_2:* = new ResourceEvent(ResourceEvent.PROGRESS, topLevelSystemManagers.bubbles, topLevelSystemManagers.cancelable);
            _loc_2.bytesLoaded = topLevelSystemManagers.bytesLoaded;
            _loc_2.bytesTotal = topLevelSystemManagers.bytesTotal;
            dispatchEvent(_loc_2);
            return;
        }// end function

        private function moduleInfo_readyHandler(topLevelSystemManagers:ModuleEvent) : void
        {
            var _loc_2:* = new ResourceEvent(ResourceEvent.COMPLETE);
            dispatchEvent(_loc_2);
            return;
        }// end function

    }
}
