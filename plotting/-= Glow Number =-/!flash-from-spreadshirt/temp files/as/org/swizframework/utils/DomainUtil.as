package org.swizframework.utils
{
    import flash.system.*;
    import mx.modules.*;

    public class DomainUtil extends Object
    {

        public function DomainUtil()
        {
            return;
        }// end function

        public static function getDomain(Object:Object) : ApplicationDomain
        {
            var _loc_2:* = getModuleDomain(Object);
            if (_loc_2 == null)
            {
                _loc_2 = ApplicationDomain.currentDomain;
            }
            return _loc_2;
        }// end function

        public static function getModuleDomain(Object:Object) : ApplicationDomain
        {
            var _loc_2:Object;
            if (Object is ModuleTypeUtil.MODULE_TYPE)
            {
                _loc_2 = ModuleManager.getAssociatedFactory(Object).info();
                return _loc_2.currentDomain;
            }
            return null;
        }// end function

    }
}
