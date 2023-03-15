package org.swizframework.reflection
{
    import flash.system.*;
    import flash.utils.*;

    public class ClassConstant extends Object
    {
        static const CLASS_CONSTANT_PATTERN:RegExp = /([^.]+)\.([A-Z0-9_*]+)$/;
        static const CLASS_PACKAGE_CONSTANT_PATTERN:RegExp = /^(.*)\.([^.]+)\.([A-Z0-9_*]+)$/;

        public function ClassConstant()
        {
            return;
        }// end function

        public static function isClassConstant(TypeDescriptor:String) : Boolean
        {
            return CLASS_CONSTANT_PATTERN.exec(TypeDescriptor);
        }// end function

        public static function getClassName(@name:String) : String
        {
            var _loc_2:* = CLASS_CONSTANT_PATTERN.exec(@name);
            if (_loc_2)
            {
                return _loc_2[1] as String;
            }
            return null;
        }// end function

        public static function getConstantName(@name:String) : String
        {
            var _loc_2:* = CLASS_CONSTANT_PATTERN.exec(@name);
            if (_loc_2)
            {
                return _loc_2[2] as String;
            }
            return null;
        }// end function

        public static function getConstantValue(Class:ApplicationDomain, constantName:Class, constantType:String, descriptor:String = "String")
        {
            var descriptor:TypeDescriptor;
            var node:XMLList;
            var variableNode:XMLList;
            var nodeType:String;
            var domain:* = Class;
            var definition:* = constantName;
            var constantName:* = constantType;
            var constantType:* = descriptor;
            descriptor = TypeCache.getTypeDescriptor(definition, domain);
            var _loc_7:int;
            var _loc_8:* = descriptor.description.constant;
            var _loc_6:* = new XMLList("");
            for each (_loc_9 in _loc_8)
            {
                
                var _loc_10:* = _loc_9;
                with (_loc_9)
                {
                    if (@name == constantName)
                    {
                        _loc_6[_loc_7] = _loc_9;
                    }
                }
            }
            node = _loc_6;
            var _loc_7:int;
            var _loc_8:* = descriptor.description.variable;
            var _loc_6:* = new XMLList("");
            for each (_loc_9 in _loc_8)
            {
                
                var _loc_10:* = _loc_9;
                with (_loc_9)
                {
                    if (@name == constantName)
                    {
                        _loc_6[_loc_7] = _loc_9;
                    }
                }
            }
            variableNode = _loc_6;
            if (node.length() == 0)
            {
                throw new Error(getQualifiedClassName(definition) + " has no constant named " + constantName + ".");
            }
            nodeType = node.@type;
            if (nodeType != constantType)
            {
                throw new Error(getQualifiedClassName(definition) + "." + constantName + " is not typed " + constantType + " but instead is typed as " + nodeType + ".");
            }
            return definition[constantName];
        }// end function

        public static function getClass(Class:ApplicationDomain, @name:String, :Array = null) : Class
        {
            var _loc_5:String;
            var _loc_6:String;
            var _loc_7:Object;
            var _loc_8:String;
            var _loc_4:* = CLASS_CONSTANT_PATTERN.exec(@name);
            if (_loc_4)
            {
                _loc_5 = _loc_4[1] as String;
                _loc_6 = _loc_4[2] as String;
                _loc_7 = CLASS_PACKAGE_CONSTANT_PATTERN.exec(@name);
                if (_loc_7)
                {
                    _loc_8 = _loc_7[1] as String;
                    return getClassDefinition(Class, _loc_8 + "." + _loc_5);
                }
                return findClassDefinition(Class, _loc_5, );
            }
            return null;
        }// end function

        static function findClassDefinition(Class:ApplicationDomain, :String, :Array) : Class
        {
            var _loc_4:String;
            var _loc_5:Class;
            for each (_loc_4 in )
            {
                
                _loc_5 = getClassDefinition(Class, _loc_4 + "." + );
                if (_loc_5 != null)
                {
                    return _loc_5;
                }
            }
            return null;
        }// end function

        static function getClassDefinition(Class:ApplicationDomain, getClassDefinition:String) : Class
        {
            var domain:* = Class;
            var name:* = getClassDefinition;
            try
            {
                return domain.getDefinition(name) as Class;
            }
            catch (e:ReferenceError)
            {
            }
            return null;
        }// end function

    }
}
