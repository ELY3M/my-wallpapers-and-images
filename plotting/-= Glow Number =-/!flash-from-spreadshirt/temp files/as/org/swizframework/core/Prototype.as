package org.swizframework.core
{

    public class Prototype extends Bean
    {
        public var constructorArguments:Object;
        public var singleton:Boolean = false;
        protected var _type:Class;

        public function Prototype(setUpBean:Class = null)
        {
            this.type = setUpBean;
            return;
        }// end function

        override public function get type()
        {
            return this._type;
        }// end function

        public function set type(_source:Class) : void
        {
            this._type = _source;
            return;
        }// end function

        override public function get source()
        {
            return this.getObject();
        }// end function

        protected function getObject()
        {
            var _loc_1:* = _source;
            if (_loc_1 == null)
            {
                var _loc_2:* = this.createInstance();
                _loc_1 = this.createInstance();
                _source = _loc_2;
                beanFactory.setUpBean(new Bean(_source, name, typeDescriptor));
                if (!this.singleton)
                {
                    _source = null;
                }
                else
                {
                    initialized = true;
                }
            }
            return _loc_1;
        }// end function

        protected function createInstance() : Object
        {
            var _loc_1:*;
            var _loc_2:Array;
            if (this.type == null)
            {
                throw new Error("Bean Creation exception! You must supply type to Prototype!");
            }
            if (this.constructorArguments != null)
            {
                _loc_2 = this.constructorArguments is Array ? (this.constructorArguments) : ([this.constructorArguments]);
                switch(_loc_2.length)
                {
                    case 1:
                    {
                        _loc_1 = new this.type(_loc_2[0]);
                        break;
                    }
                    case 2:
                    {
                        _loc_1 = new this.type(_loc_2[0], _loc_2[1]);
                        break;
                    }
                    case 3:
                    {
                        _loc_1 = new this.type(_loc_2[0], _loc_2[1], _loc_2[2]);
                        break;
                    }
                    case 4:
                    {
                        _loc_1 = new this.type(_loc_2[0], _loc_2[1], _loc_2[2], _loc_2[3]);
                        break;
                    }
                    case 5:
                    {
                        _loc_1 = new this.type(_loc_2[0], _loc_2[1], _loc_2[2], _loc_2[3], _loc_2[4]);
                        break;
                    }
                    case 6:
                    {
                        _loc_1 = new this.type(_loc_2[0], _loc_2[1], _loc_2[2], _loc_2[3], _loc_2[4], _loc_2[5]);
                        break;
                    }
                    case 7:
                    {
                        _loc_1 = new this.type(_loc_2[0], _loc_2[1], _loc_2[2], _loc_2[3], _loc_2[4], _loc_2[5], _loc_2[6]);
                        break;
                    }
                    case 8:
                    {
                        _loc_1 = new this.type(_loc_2[0], _loc_2[1], _loc_2[2], _loc_2[3], _loc_2[4], _loc_2[5], _loc_2[6], _loc_2[7]);
                        break;
                    }
                    default:
                    {
                        throw new Error("No more than 8 constructor arguments are support by Prototype.");
                        break;
                    }
                }
            }
            else
            {
                _loc_1 = new this.type();
            }
            return _loc_1;
        }// end function

        override public function toString() : String
        {
            return "Prototype{ type: " + this.type + ", name: " + name + " }";
        }// end function

    }
}
