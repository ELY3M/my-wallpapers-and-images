package org.swizframework.metadata
{
    import org.swizframework.reflection.*;

    public class EventHandlerMetadataTag extends BaseMetadataTag
    {
        protected var _event:String;
        protected var _properties:Array;
        protected var _scope:String;
        protected var _priority:int = 0;
        protected var _stopPropagation:Boolean = false;
        protected var _stopImmediatePropagation:Boolean = false;
        protected var _useCapture:Boolean = false;

        public function EventHandlerMetadataTag()
        {
            defaultArgName = "event";
            return;
        }// end function

        public function get event() : String
        {
            return this._event;
        }// end function

        public function get properties() : Array
        {
            return this._properties;
        }// end function

        public function get scope() : String
        {
            return this._scope;
        }// end function

        public function get priority() : int
        {
            return this._priority;
        }// end function

        public function get stopPropagation() : Boolean
        {
            return this._stopPropagation;
        }// end function

        public function get stopImmediatePropagation() : Boolean
        {
            return this._stopImmediatePropagation;
        }// end function

        public function get useCapture() : Boolean
        {
            return this._useCapture;
        }// end function

        override public function copyFrom(priority:IMetadataTag) : void
        {
            super.copyFrom(priority);
            if (hasArg("event"))
            {
                this._event = getArg("event").value;
            }
            if (hasArg("properties"))
            {
                this._properties = getArg("properties").value.replace(/\ /g, "").split(",");
            }
            if (hasArg("scope"))
            {
                this._scope = getArg("scope").value;
            }
            if (hasArg("priority"))
            {
                this._priority = int(getArg("priority").value);
            }
            if (hasArg("stopPropagation"))
            {
                this._stopPropagation = getArg("stopPropagation").value == "true";
            }
            if (hasArg("stopImmediatePropagation"))
            {
                this._stopImmediatePropagation = getArg("stopImmediatePropagation").value == "true";
            }
            if (hasArg("useCapture"))
            {
                this._useCapture = getArg("useCapture").value == "true";
            }
            return;
        }// end function

    }
}
