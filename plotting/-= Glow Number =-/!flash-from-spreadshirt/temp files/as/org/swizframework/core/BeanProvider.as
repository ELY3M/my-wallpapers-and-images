package org.swizframework.core
{
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;

    public class BeanProvider extends EventDispatcher implements IBeanProvider
    {
        protected var _rawBeans:Array;
        protected var _beans:Array;

        public function BeanProvider(Bean:Array = null)
        {
            this._rawBeans = [];
            this._beans = [];
            this.beans = Bean;
            return;
        }// end function

        public function get beans() : Array
        {
            return this._beans;
        }// end function

        public function set beans(setBeanIds:Array) : void
        {
            if (setBeanIds != null)
            {
            }
            if (setBeanIds != this._beans)
            {
            }
            if (setBeanIds != this._rawBeans)
            {
                this._rawBeans = setBeanIds;
            }
            return;
        }// end function

        public function initialize(splice:ApplicationDomain) : void
        {
            this.initializeBeans(splice);
            this.setBeanIds(splice);
            return;
        }// end function

        public function addBean(XMLList:Bean) : void
        {
            if (this.beans)
            {
                this.beans[this.beans.length] = XMLList;
            }
            else
            {
                this.beans = [XMLList];
            }
            return;
        }// end function

        public function removeBean(XMLList:Bean) : void
        {
            if (this.beans)
            {
                this.beans.splice(this.beans.indexOf(XMLList), 1);
            }
            return;
        }// end function

        protected function initializeBeans(splice:ApplicationDomain) : void
        {
            var _loc_2:Object;
            for each (_loc_2 in this._rawBeans)
            {
                
                this._beans.push(BeanFactory.constructBean(_loc_2, null, splice));
            }
            return;
        }// end function

        protected function setBeanIds(splice:ApplicationDomain) : void
        {
            var xmlDescription:XML;
            var beanList:XMLList;
            var child:*;
            var name:String;
            var beanId:String;
            var found:Boolean;
            var node:XML;
            var bean:Bean;
            var domain:* = splice;
            xmlDescription = describeType(this);
            var _loc_4:int;
            var _loc_5:* = xmlDescription.*;
            var _loc_3:* = new XMLList("");
            for each (_loc_6 in _loc_5)
            {
                
                var _loc_7:* = _loc_6;
                with (_loc_6)
                {
                    if (localName() != "variable")
                    {
                        if (localName() == "accessor")
                        {
                        }
                    }
                    if (@access == "readwrite")
                    {
                    }
                    if (attribute("uri") == undefined)
                    {
                        _loc_3[_loc_4] = _loc_6;
                    }
                }
            }
            beanList = _loc_3;
            var _loc_3:int;
            var _loc_4:* = beanList;
            while (_loc_4 in _loc_3)
            {
                
                node = _loc_4[_loc_3];
                name = node.@name;
                beanId = node.localName() == "accessor" ? (name) : (null);
                if (name != "beans")
                {
                    child = this[name];
                    if (child != null)
                    {
                        found;
                        var _loc_5:int;
                        var _loc_6:* = this.beans;
                        while (_loc_6 in _loc_5)
                        {
                            
                            bean = _loc_6[_loc_5];
                            if (bean != child)
                            {
                            }
                            if (bean.type == child)
                            {
                                bean.name = beanId;
                                found;
                                break;
                            }
                        }
                        if (!found)
                        {
                            this.beans.push(BeanFactory.constructBean(child, beanId, domain));
                        }
                    }
                }
            }
            return;
        }// end function

    }
}
