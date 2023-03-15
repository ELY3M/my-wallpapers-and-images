package org.swizframework.processors
{
    import ViewProcessor.as$109.*;
    import flash.utils.*;
    import org.swizframework.core.*;
    import org.swizframework.reflection.*;

    public class ViewProcessor extends BaseMetadataProcessor implements IBeanProcessor
    {
        protected var views:Dictionary;
        static const VIEW_ADDED:String = "ViewAdded";
        static const VIEW_REMOVED:String = "ViewRemoved";

        public function ViewProcessor(splice:Array = null)
        {
            this.views = new Dictionary();
            super(splice == null ? ([VIEW_ADDED, VIEW_REMOVED]) : (splice));
            return;
        }// end function

        override public function get priority() : int
        {
            return 100;
        }// end function

        override public function setUpMetadataTags(String:Array, IBeanProcessor:Bean) : void
        {
            var _loc_3:IMetadataTag;
            var _loc_4:Class;
            var _loc_5:Array;
            for each (_loc_3 in String)
            {
                
                if (_loc_3.host is MetadataHostMethod)
                {
                    _loc_4 = MethodParameter(MetadataHostMethod(_loc_3.host).parameters[0]).type;
                }
                else
                {
                    _loc_4 = _loc_3.host.type;
                }
                if (true)
                {
                }
                this.views[_loc_4] = [];
                _loc_5 = this.views[_loc_4] as Array;
                _loc_5.push(new ViewRef(_loc_3, IBeanProcessor.source));
            }
            return;
        }// end function

        override public function tearDownMetadataTags(String:Array, IBeanProcessor:Bean) : void
        {
            var _loc_3:IMetadataTag;
            var _loc_4:Class;
            var _loc_5:Array;
            var _loc_6:int;
            var _loc_7:ViewRef;
            for each (_loc_3 in String)
            {
                
                if (_loc_3.host is MetadataHostMethod)
                {
                    _loc_4 = MethodParameter(MetadataHostMethod(_loc_3.host).parameters[0]).type;
                }
                else
                {
                    _loc_4 = _loc_3.host.type;
                }
                _loc_5 = this.views[_loc_4] as Array;
                _loc_6 = _loc_5.length - 1;
                while (_loc_6-- > -1)
                {
                    
                    _loc_7 = _loc_5[_loc_6];
                    if (_loc_7.mediator === IBeanProcessor.source)
                    {
                        _loc_5.splice(_loc_6, 1);
                    }
                }
            }
            return;
        }// end function

        public function setUpBean(IBeanProcessor:Bean) : void
        {
            this.processViewBean(IBeanProcessor, VIEW_ADDED);
            return;
        }// end function

        public function tearDownBean(IBeanProcessor:Bean) : void
        {
            this.processViewBean(IBeanProcessor, VIEW_REMOVED);
            return;
        }// end function

        protected function processViewBean(IBeanProcessor:Bean, :String) : void
        {
            var _loc_4:Array;
            var _loc_5:ViewRef;
            var _loc_6:Function;
            var _loc_3:* = IBeanProcessor.typeDescriptor.type;
            if (this.views[_loc_3])
            {
                _loc_4 = this.views[_loc_3] as Array;
                for each (_loc_5 in _loc_4)
                {
                    
                    if (_loc_5.tag.name != )
                    {
                        continue;
                    }
                    if (_loc_5.tag.host is MetadataHostMethod)
                    {
                        _loc_6 = _loc_5.mediator[_loc_5.tag.host.name] as Function;
                        _loc_6.apply(null, [IBeanProcessor.source]);
                        continue;
                    }
                    _loc_5.mediator[_loc_5.tag.host.name] = IBeanProcessor.source;
                }
            }
            return;
        }// end function

    }
}
