package org.swizframework.factories
{
    import flash.system.*;
    import org.swizframework.reflection.*;

    public class MetadataHostFactory extends Object
    {

        public function MetadataHostFactory()
        {
            return;
        }// end function

        public static function getMetadataHost(getDefinition:XML, type:ApplicationDomain) : IMetadataHost
        {
            var _loc_3:IMetadataHost;
            var _loc_5:XML;
            var _loc_6:Class;
            var _loc_4:* = getDefinition.name();
            if (_loc_4 != "type")
            {
            }
            if (_loc_4 == "factory")
            {
                _loc_3 = new MetadataHostClass();
                if (_loc_4 == "type")
                {
                    _loc_3.type = type.getDefinition(getDefinition.@name.toString()) as Class;
                }
                else
                {
                    _loc_3.type = type.getDefinition(getDefinition.@type.toString()) as Class;
                }
            }
            else if (_loc_4 == "method")
            {
                _loc_3 = new MetadataHostMethod();
                if (getDefinition.@returnType != "void")
                {
                }
                if (getDefinition.@returnType != "*")
                {
                    MetadataHostMethod(_loc_3).returnType = Class(type.getDefinition(getDefinition.@returnType));
                }
                for each (_loc_5 in getDefinition.parameter)
                {
                    
                    _loc_6 = _loc_5.@type == "*" ? (Object) : (Class(type.getDefinition(_loc_5.@type)));
                    MetadataHostMethod(_loc_3).parameters.push(new MethodParameter(int(_loc_5.@index), _loc_6, _loc_5.@optional == "true"));
                }
            }
            else
            {
                _loc_3 = new MetadataHostProperty();
                _loc_3.type = getDefinition.@type == "*" ? (Object) : (Class(type.getDefinition(getDefinition.@type)));
            }
            _loc_3.name = getDefinition.@uri == undefined ? (String(getDefinition.@name[0])) : (new QName(getDefinition.@uri, getDefinition.@name));
            return _loc_3;
        }// end function

    }
}
