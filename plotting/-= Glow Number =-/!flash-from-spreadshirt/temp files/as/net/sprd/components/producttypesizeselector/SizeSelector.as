package net.sprd.components.producttypesizeselector
{
    import mx.core.*;

    public class SizeSelector extends SizeSelectorClass
    {
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;

        public function SizeSelector()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:SizeSelectorClass});
            mx_internal::_document = this;
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
