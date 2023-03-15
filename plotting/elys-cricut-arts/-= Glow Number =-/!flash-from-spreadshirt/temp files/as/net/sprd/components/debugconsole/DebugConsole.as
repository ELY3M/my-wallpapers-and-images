package net.sprd.components.debugconsole
{
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;

    public class DebugConsole extends DebugConsoleClass
    {
        private var _336633169loadXML:Button;
        private var _2067282906showXML:Button;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;

        public function DebugConsole()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:DebugConsoleClass, propertiesFactory:function () : Object
            {
                return {width:400, height:300, childDescriptors:[new UIComponentDescriptor({type:TextArea, id:"debugInput", propertiesFactory:function () : Object
                {
                    return {percentWidth:100, percentHeight:100};
                }// end function
                }), new UIComponentDescriptor({type:ControlBar, propertiesFactory:function () : Object
                {
                    return {childDescriptors:[new UIComponentDescriptor({type:Button, id:"loadXML", events:{click:"__loadXML_click"}, propertiesFactory:function () : Object
                    {
                        return {label:"Create product from XML"};
                    }// end function
                    }), new UIComponentDescriptor({type:Button, id:"showXML", events:{click:"__showXML_click"}, propertiesFactory:function () : Object
                    {
                        return {label:"Show XML for product"};
                    }// end function
                    })]};
                }// end function
                })]};
            }// end function
            });
            mx_internal::_document = this;
            this.layout = "absolute";
            this.width = 400;
            this.height = 300;
            return;
        }// end function

        override public function set moduleFactory(param1:IFlexModuleFactory) : void
        {
            super.moduleFactory = param1;
            if (this.__moduleFactoryInitialized)
            {
                return;
            }
            this.__moduleFactoryInitialized = true;
            return;
        }// end function

        override public function initialize() : void
        {
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            super.initialize();
            return;
        }// end function

        public function __loadXML_click(param1:MouseEvent) : void
        {
            onCreateFromXMLClick(param1);
            return;
        }// end function

        public function __showXML_click(param1:MouseEvent) : void
        {
            onXMLFromProductClick(param1);
            return;
        }// end function

        public function get loadXML() : Button
        {
            return this._336633169loadXML;
        }// end function

        public function set loadXML(param1:Button) : void
        {
            var _loc_2:* = this._336633169loadXML;
            if (_loc_2 !== param1)
            {
                this._336633169loadXML = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loadXML", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get showXML() : Button
        {
            return this._2067282906showXML;
        }// end function

        public function set showXML(param1:Button) : void
        {
            var _loc_2:* = this._2067282906showXML;
            if (_loc_2 !== param1)
            {
                this._2067282906showXML = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showXML", _loc_2, param1));
                }
            }
            return;
        }// end function

    }
}
