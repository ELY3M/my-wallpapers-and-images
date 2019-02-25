package org.swizframework.reflection
{
    import flash.system.*;
    import flash.utils.*;

    public class TypeCache extends Object
    {
        static var typeDescriptors:Dictionary;

        public function TypeCache()
        {
            return;
        }// end function

        public static function getTypeDescriptor(TypeDescriptor:Object, describeType:ApplicationDomain) : TypeDescriptor
        {
            if (true)
            {
            }
            typeDescriptors = new Dictionary();
            var _loc_3:* = getQualifiedClassName(TypeDescriptor);
            if (typeDescriptors[_loc_3] != null)
            {
                return typeDescriptors[_loc_3];
            }
            var _loc_4:* = new TypeDescriptor().fromXML(describeType(describeType.getDefinition(_loc_3)), describeType);
            typeDescriptors[_loc_3] = new TypeDescriptor().fromXML(describeType(describeType.getDefinition(_loc_3)), describeType);
            return _loc_4;
        }// end function

        public static function flushDomain(describeType:ApplicationDomain) : void
        {
            var _loc_2:Object;
            for (_loc_2 in typeDescriptors)
            {
                
                if (TypeDescriptor(typeDescriptors[_loc_2]).domain == describeType)
                {
                    delete typeDescriptors[_loc_2];
                }
            }
            return;
        }// end function

    }
}
