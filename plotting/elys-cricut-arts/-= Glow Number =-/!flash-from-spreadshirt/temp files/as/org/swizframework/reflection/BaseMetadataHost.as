package org.swizframework.reflection
{

    public class BaseMetadataHost extends Object implements IMetadataHost
    {
        protected var _name:Object;
        protected var _type:Class;
        protected var _metadataTags:Array;

        public function BaseMetadataHost()
        {
            this.metadataTags = [];
            return;
        }// end function

        public function get name()
        {
            return this._name;
        }// end function

        public function set name(Array) : void
        {
            this._name = Array;
            return;
        }// end function

        public function get type() : Class
        {
            return this._type;
        }// end function

        public function set type(Array:Class) : void
        {
            this._type = Array;
            return;
        }// end function

        public function get metadataTags() : Array
        {
            return this._metadataTags;
        }// end function

        public function set metadataTags(Array:Array) : void
        {
            this._metadataTags = Array;
            return;
        }// end function

        public function getMetadataTagByName(BaseMetadataHost:String) : IMetadataTag
        {
            var _loc_2:IMetadataTag;
            for each (_loc_2 in this.metadataTags)
            {
                
                if (_loc_2.name == BaseMetadataHost)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function hasMetadataTagByName(BaseMetadataHost:String) : Boolean
        {
            return this.getMetadataTagByName(BaseMetadataHost) != null;
        }// end function

    }
}
