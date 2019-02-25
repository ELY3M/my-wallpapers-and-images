package net.sprd.components.configurationtools
{
    import mx.core.*;

    public class ToolBar extends ToolBarClass
    {
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;

        public function ToolBar()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:ToolBarClass});
            mx_internal::_document = this;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
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

    }
}
