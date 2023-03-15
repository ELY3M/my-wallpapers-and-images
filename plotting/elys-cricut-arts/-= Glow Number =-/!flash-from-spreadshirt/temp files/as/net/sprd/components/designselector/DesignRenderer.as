package net.sprd.components.designselector
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;
    import net.sprd.api.resource.*;
    import net.sprd.common.utils.*;
    import net.sprd.entities.*;
    import net.sprd.models.common.*;
    import net.sprd.services.image.*;
    import net.sprd.services.image.model.*;

    public class DesignRenderer extends Canvas implements IDropInListItemRenderer
    {
        private var _1391345023loadingImage:Image;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;
        private var _design:IDesign;
        private var _designImage:ConfigurationImage;
        private var _listData:BaseListData;
        private var _loadingState:int;
        private var _cachedIndicator:UIComponent;
        private var progressIndicator:Class;

        public function DesignRenderer()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Image, id:"loadingImage", propertiesFactory:function () : Object
                {
                    return {width:75, height:75, mouseEnabled:false, mouseChildren:false};
                }// end function
                })]};
            }// end function
            });
            this.progressIndicator = DesignRenderer_progressIndicator;
            mx_internal::_document = this;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.useHandCursor = true;
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

        public function get listData() : BaseListData
        {
            return this._listData;
        }// end function

        public function set listData(param1:BaseListData) : void
        {
            this._listData = param1;
            return;
        }// end function

        override public function set data(param1:Object) : void
        {
            super.data = param1;
            this.removeImage();
            this.removeLoader();
            this._design = IDesign(param1);
            id = "design" + this._design.id;
            this.loadImage();
            return;
        }// end function

        private function removeImage() : void
        {
            if (getChildByName("design"))
            {
                removeChild(getChildByName("design"));
            }
            return;
        }// end function

        private function removeLoader() : void
        {
            if (this._cachedIndicator)
            {
            }
            if (this._cachedIndicator.parent)
            {
                this._cachedIndicator.parent.removeChild(this._cachedIndicator);
                this._cachedIndicator = null;
            }
            return;
        }// end function

        override public function get data() : Object
        {
            return this._design;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = DesignTileList(this.listData.owner).designConstraints[this._design.id];
            if (_loc_3)
            {
            }
            if (_loc_3.isUsable)
            {
                alpha = 1;
            }
            else
            {
                alpha = 0.3;
            }
            return;
        }// end function

        private function loadImage() : void
        {
            var _loc_1:Sprite;
            if (!this._cachedIndicator)
            {
                _loc_1 = new this.progressIndicator() as Sprite;
                _loc_1.mouseEnabled = false;
                _loc_1.mouseChildren = false;
                _loc_1.name = "spinner";
                this._cachedIndicator = new UIComponent();
                this._cachedIndicator.addChild(_loc_1);
                this._cachedIndicator.verticalCenter = 0;
                this._cachedIndicator.horizontalCenter = 0;
                addChild(this._cachedIndicator);
            }
            if (this._designImage)
            {
                this._designImage.endEffectsStarted();
                this._designImage.visible = false;
            }
            this._designImage = ImageService.getInstance().designImage(this._design.imageId, 75, 75);
            if (this._designImage.isLoaded)
            {
                this._loadingState = ResourceLoadingState.LOADED;
                this.removeLoader();
                this.showDesign();
            }
            else
            {
                this._loadingState = ResourceLoadingState.LOADING;
                EventUtil.registerOnetimeListeners(this._designImage, [Event.COMPLETE, IOErrorEvent.IO_ERROR], [this.onImageComplete, this.onImageFault]);
                this._designImage.load();
            }
            return;
        }// end function

        private function onImageComplete(param1:Event) : void
        {
            this._loadingState = ResourceLoadingState.LOADED;
            this.removeLoader();
            this.showDesign();
            return;
        }// end function

        private function onImageFault(param1:IOErrorEvent) : void
        {
            this.removeLoader();
            this._loadingState = ResourceLoadingState.ERROR;
            return;
        }// end function

        private function showDesign() : void
        {
            if (width != 0)
            {
            }
            if (height == 0)
            {
                callLater(this.showDesign);
            }
            if (getChildByName("design"))
            {
                removeChild(getChildByName("design"));
            }
            this._designImage.mouseEnabled = false;
            this._designImage.mouseChildren = false;
            this._designImage.name = "design";
            addChild(this._designImage);
            var _loc_1:* = this._designImage.getBounds(this._designImage);
            var _loc_2:* = new Rectangle(0, 0, 75, 75);
            BoundsUtil.trimBoundsProportionally(_loc_1, _loc_2);
            this._designImage.width = _loc_1.width;
            this._designImage.height = _loc_1.height;
            this._designImage.x = (width - _loc_1.width) / 2;
            this._designImage.y = (height - _loc_1.height) / 2;
            this.loadingImage.endEffectsStarted();
            this.loadingImage.visible = false;
            this._designImage.endEffectsStarted();
            this._designImage.visible = true;
            return;
        }// end function

        public function get loadingImage() : Image
        {
            return this._1391345023loadingImage;
        }// end function

        public function set loadingImage(param1:Image) : void
        {
            var _loc_2:* = this._1391345023loadingImage;
            if (_loc_2 !== param1)
            {
                this._1391345023loadingImage = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loadingImage", _loc_2, param1));
                }
            }
            return;
        }// end function

    }
}
