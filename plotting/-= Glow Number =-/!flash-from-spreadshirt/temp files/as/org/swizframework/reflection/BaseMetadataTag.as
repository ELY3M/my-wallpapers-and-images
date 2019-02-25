package org.swizframework.reflection
{

    public class BaseMetadataTag extends Object implements IMetadataTag
    {
        protected var _name:String;
        protected var _args:Array;
        protected var _host:IMetadataHost;
        protected var _defaultArgName:String;

        public function BaseMetadataTag()
        {
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(IMetadataHost:String) : void
        {
            this._name = IMetadataHost;
            return;
        }// end function

        public function get args() : Array
        {
            return this._args;
        }// end function

        public function set args(IMetadataHost:Array) : void
        {
            this._args = IMetadataHost;
            return;
        }// end function

        public function get host() : IMetadataHost
        {
            return this._host;
        }// end function

        public function set host(IMetadataHost:IMetadataHost) : void
        {
            this._host = IMetadataHost;
            return;
        }// end function

        public function get defaultArgName() : String
        {
            return this._defaultArgName;
        }// end function

        public function set defaultArgName(IMetadataHost:String) : void
        {
            this._defaultArgName = IMetadataHost;
            return;
        }// end function

        public function get asTag() : String
        {
            return this.toString();
        }// end function

        public function hasArg(hasArg:String) : Boolean
        {
            var _loc_2:MetadataArg;
            for each (_loc_2 in this.args)
            {
                
                if (_loc_2.key != hasArg)
                {
                    if (_loc_2.key == "")
                    {
                    }
                }
                if (hasArg == this.defaultArgName)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function getArg(hasArg:String) : MetadataArg
        {
            var _loc_2:MetadataArg;
            for each (_loc_2 in this.args)
            {
                
                if (_loc_2.key != hasArg)
                {
                    if (_loc_2.key == "")
                    {
                    }
                }
                if (hasArg == this.defaultArgName)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function copyFrom(:IMetadataTag) : void
        {
            this.name = name;
            this.args = args;
            this.host = host;
            return;
        }// end function

        public function toString() : String
        {
            var _loc_2:int;
            var _loc_3:MetadataArg;
            var _loc_1:* = "[" + this.name;
            if (this.args != null)
            {
            }
            if (this.args.length > 0)
            {
                _loc_1 = _loc_1 + "( ";
                _loc_2 = 0;
                while (_loc_2++ < this.args.length)
                {
                    
                    _loc_3 = this.args[_loc_2];
                    if (_loc_3.key != "")
                    {
                        _loc_1 = _loc_1 + (_loc_3.key + "=");
                    }
                    _loc_1 = _loc_1 + ("\"" + _loc_3.value + "\"");
                    if (_loc_2 + 1 < this.args.length)
                    {
                        _loc_1 = _loc_1 + ", ";
                    }
                }
                _loc_1 = _loc_1 + " )";
            }
            _loc_1 = _loc_1 + "]";
            return _loc_1;
        }// end function

    }
}
