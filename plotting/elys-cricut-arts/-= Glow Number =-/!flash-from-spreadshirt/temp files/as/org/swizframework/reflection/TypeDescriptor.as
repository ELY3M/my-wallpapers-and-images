package org.swizframework.reflection
{
    import flash.system.*;
    import flash.utils.*;
    import org.swizframework.core.*;
    import org.swizframework.factories.*;

    public class TypeDescriptor extends Object
    {
        public var domain:ApplicationDomain;
        public var description:XML;
        public var type:Class;
        public var className:String;
        public var constants:Array;
        public var superClasses:Array;
        public var interfaces:Array;
        public var metadataHosts:Dictionary;

        public function TypeDescriptor()
        {
            this.constants = [];
            this.superClasses = [];
            this.interfaces = [];
            return;
        }// end function

        protected function getMetadataHosts(SwizManager:XML) : Dictionary
        {
            var _loc_2:XML;
            var _loc_3:String;
            var _loc_4:Array;
            var _loc_5:XML;
            var _loc_6:IMetadataHost;
            var _loc_7:IMetadataTag;
            if (this.metadataHosts != null)
            {
                return this.metadataHosts;
            }
            this.metadataHosts = new Dictionary();
            for each (_loc_2 in SwizManager..metadata)
            {
                
                _loc_3 = _loc_2.@name;
                if (_loc_3.indexOf("_") != 0)
                {
                }
                if (SwizManager.metadataNames.indexOf(_loc_3) < 0)
                {
                    continue;
                }
                _loc_4 = [];
                for each (_loc_5 in _loc_2.arg)
                {
                    
                    _loc_4.push(new MetadataArg(_loc_5.@key.toString(), _loc_5.@value.toString()));
                }
                _loc_6 = this.getMetadataHost(_loc_2.parent());
                _loc_7 = new BaseMetadataTag();
                _loc_7.name = _loc_3;
                _loc_7.args = _loc_4;
                _loc_7.host = _loc_6;
                _loc_6.metadataTags.push(_loc_7);
            }
            return this.metadataHosts;
        }// end function

        protected function getMetadataHost(ApplicationDomain:XML) : IMetadataHost
        {
            var _loc_2:* = ApplicationDomain.@name.toString();
            if (this.metadataHosts[_loc_2] != null)
            {
                return IMetadataHost(this.metadataHosts[_loc_2]);
            }
            var _loc_3:* = MetadataHostFactory.getMetadataHost(ApplicationDomain, this.domain);
            this.metadataHosts[_loc_2] = MetadataHostFactory.getMetadataHost(ApplicationDomain, this.domain);
            return _loc_3;
        }// end function

        public function fromXML(MetadataHostMethod:XML, name:ApplicationDomain) : TypeDescriptor
        {
            var _loc_4:XML;
            var _loc_5:XML;
            var _loc_6:XML;
            this.description = MetadataHostMethod;
            this.domain = name;
            var _loc_3:XML;
            if (this.description.factory == undefined)
            {
                _loc_3 = this.description;
                this.className = _loc_3.@name;
            }
            else
            {
                _loc_3 = this.description.factory[0];
                this.className = _loc_3.@type;
            }
            this.type = name.getDefinition(this.className) as Class;
            for each (_loc_4 in this.description.constant)
            {
                
                this.constants.push(new Constant(_loc_4.@name, this.type[_loc_4.@name]));
            }
            for each (_loc_5 in _loc_3.extendsClass)
            {
                
                this.superClasses.push(_loc_5.@type.toString());
            }
            for each (_loc_6 in _loc_3.implementsInterface)
            {
                
                this.interfaces.push(_loc_6.@type.toString());
            }
            this.metadataHosts = this.getMetadataHosts(this.description);
            return this;
        }// end function

        public function hasMetadataTag(:String) : Boolean
        {
            var _loc_2:IMetadataHost;
            var _loc_3:IMetadataTag;
            for each (_loc_2 in this.metadataHosts)
            {
                
                for each (_loc_3 in _loc_2.metadataTags)
                {
                    
                    if (_loc_3.name.toLowerCase() == toLowerCase())
                    {
                        return true;
                    }
                }
            }
            return false;
        }// end function

        public function getMetadataHostsWithTag(:String) : Array
        {
            var _loc_3:IMetadataHost;
            var _loc_4:IMetadataTag;
            var _loc_2:Array;
            for each (_loc_3 in this.metadataHosts)
            {
                
                for each (_loc_4 in _loc_3.metadataTags)
                {
                    
                    if (_loc_4.name.toLowerCase() == toLowerCase())
                    {
                        _loc_2.push(_loc_3);
                        continue;
                    }
                }
            }
            return _loc_2;
        }// end function

        public function getMetadataTagsByName(:String) : Array
        {
            var _loc_3:IMetadataHost;
            var _loc_4:IMetadataTag;
            var _loc_2:Array;
            for each (_loc_3 in this.metadataHosts)
            {
                
                for each (_loc_4 in _loc_3.metadataTags)
                {
                    
                    if (_loc_4.name.toLowerCase() == toLowerCase())
                    {
                        _loc_2.push(_loc_4);
                    }
                }
            }
            return _loc_2;
        }// end function

        public function getMetadataTagsForMember(:String) : Array
        {
            var _loc_2:Array;
            var _loc_3:IMetadataHost;
            for each (_loc_3 in this.metadataHosts)
            {
                
                if (_loc_3.name == )
                {
                    _loc_2 = _loc_3.metadataTags;
                }
            }
            return _loc_2;
        }// end function

        public function getMetadataHostProperties() : Array
        {
            var _loc_2:IMetadataHost;
            var _loc_1:Array;
            for each (_loc_2 in this.metadataHosts)
            {
                
                if (_loc_2 is MetadataHostProperty)
                {
                    _loc_1.push(_loc_2);
                    continue;
                }
            }
            return _loc_1;
        }// end function

        public function getMetadataHostMethods() : Array
        {
            var _loc_2:IMetadataHost;
            var _loc_1:Array;
            for each (_loc_2 in this.metadataHosts)
            {
                
                if (_loc_2 is MetadataHostMethod)
                {
                    _loc_1.push(_loc_2);
                    continue;
                }
            }
            return _loc_1;
        }// end function

        public function satisfiesType(:String) : Boolean
        {
            var _loc_2:String;
            var _loc_3:String;
            if (this.className == )
            {
                return true;
            }
            for each (_loc_2 in this.superClasses)
            {
                
                if (_loc_2 == )
                {
                    return true;
                }
            }
            for each (_loc_3 in this.interfaces)
            {
                
                if (_loc_3 == )
                {
                    return true;
                }
            }
            return false;
        }// end function

    }
}
