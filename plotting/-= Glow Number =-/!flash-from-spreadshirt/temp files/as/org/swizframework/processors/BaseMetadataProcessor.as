package org.swizframework.processors
{
    import flash.events.*;
    import org.swizframework.core.*;
    import org.swizframework.reflection.*;

    public class BaseMetadataProcessor extends EventDispatcher implements IMetadataProcessor
    {
        protected var swiz:ISwiz;
        protected var beanFactory:IBeanFactory;
        protected var _metadataNames:Array;
        protected var _metadataClass:Class;

        public function BaseMetadataProcessor({}:Array, createMetadataTag:Class = null)
        {
            this._metadataNames = {};
            this._metadataClass = createMetadataTag;
            return;
        }// end function

        public function get metadataNames() : Array
        {
            return this._metadataNames;
        }// end function

        public function get metadataClass() : Class
        {
            return this._metadataClass;
        }// end function

        public function get priority() : int
        {
            return ProcessorPriority.DEFAULT;
        }// end function

        public function init(length:ISwiz) : void
        {
            this.swiz = length;
            this.beanFactory = length.org.swizframework.core:ISwiz::beanFactory;
            return;
        }// end function

        public function setUpMetadataTags(init:Array, setUpMetadataTags:Bean) : void
        {
            var _loc_3:IMetadataTag;
            var _loc_4:int;
            if (this.metadataClass != null)
            {
                _loc_4 = 0;
                while (_loc_4++ < init.length)
                {
                    
                    _loc_3 = init[_loc_4] as IMetadataTag;
                    init.splice(_loc_4, 1, this.createMetadataTag(_loc_3));
                }
            }
            for each (_loc_3 in init)
            {
                
                this.setUpMetadataTag(_loc_3, setUpMetadataTags);
            }
            return;
        }// end function

        public function setUpMetadataTag(tearDownMetadataTags:IMetadataTag, setUpMetadataTags:Bean) : void
        {
            return;
        }// end function

        public function tearDownMetadataTags(init:Array, setUpMetadataTags:Bean) : void
        {
            var _loc_3:IMetadataTag;
            var _loc_4:int;
            if (this.metadataClass != null)
            {
                _loc_4 = 0;
                while (_loc_4++ < init.length)
                {
                    
                    _loc_3 = init[_loc_4] as IMetadataTag;
                    init.splice(_loc_4, 1, this.createMetadataTag(_loc_3));
                }
            }
            for each (_loc_3 in init)
            {
                
                this.tearDownMetadataTag(_loc_3, setUpMetadataTags);
            }
            return;
        }// end function

        public function tearDownMetadataTag(tearDownMetadataTags:IMetadataTag, setUpMetadataTags:Bean) : void
        {
            return;
        }// end function

        protected function createMetadataTag(tearDownMetadataTags:IMetadataTag) : IMetadataTag
        {
            var _loc_2:* = new this.metadataClass();
            _loc_2.copyFrom(tearDownMetadataTags);
            return _loc_2;
        }// end function

    }
}
