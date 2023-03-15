package net.sprd.components.productinfo
{
    import mx.controls.*;
    import mx.core.*;
    import mx.styles.*;

    public class ProductInfo extends ProductInfoClass
    {
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;

        public function ProductInfo()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:ProductInfoClass, stylesFactory:function () : void
            {
                this.verticalGap = -10;
                this.paddingLeft = 20;
                this.paddingTop = 4;
                return;
            }// end function
            , propertiesFactory:function () : Object
            {
                return {width:300, height:70, childDescriptors:[new UIComponentDescriptor({type:Label, id:"productTypeName", propertiesFactory:function () : Object
                {
                    return {styleName:"productInfoName"};
                }// end function
                }), new UIComponentDescriptor({type:Label, id:"productTypeBrand", propertiesFactory:function () : Object
                {
                    return {styleName:"productInfoBrand"};
                }// end function
                })]};
            }// end function
            });
            mx_internal::_document = this;
            this.width = 300;
            this.height = 70;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            return;
        }// end function

        override public function set moduleFactory(param1:IFlexModuleFactory) : void
        {
            var factory:* = param1;
            super.moduleFactory = factory;
            if (this.__moduleFactoryInitialized)
            {
                return;
            }
            this.__moduleFactoryInitialized = true;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration(null, styleManager);
            }
            this.styleDeclaration.defaultFactory = function () : void
            {
                this.verticalGap = -10;
                this.paddingLeft = 20;
                this.paddingTop = 4;
                return;
            }// end function
            ;
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
