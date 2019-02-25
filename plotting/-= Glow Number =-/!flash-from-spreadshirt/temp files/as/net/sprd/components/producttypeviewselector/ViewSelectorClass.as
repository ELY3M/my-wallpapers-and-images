package net.sprd.components.producttypeviewselector
{
    import flash.events.*;
    import mx.containers.*;
    import mx.effects.*;
    import net.sprd.common.utils.*;
    import net.sprd.components.common.*;
    import net.sprd.entities.*;
    import net.sprd.events.*;
    import net.sprd.models.common.*;
    import net.sprd.models.product.*;

    public class ViewSelectorClass extends HBox
    {
        public var product:IProductModel;
        public var bus:IEventDispatcher;
        private var _thumbCount:uint;
        private var _visibleViews:Array;
        private var productTypeChanged:Boolean;
        private var _colorChanged:Boolean;
        private var _viewChanged:Boolean;
        private var _initialized:Boolean;
        private var useDelay:Boolean = true;
        private var moreButton:MoreButton;
        private const OPEN_STATE:String = "open";
        private const CLOSED_STATE:String = "closed";
        public var showThumb:Effect;
        public var hideThumb:Effect;
        public var positionComponent:Effect;

        public function ViewSelectorClass()
        {
            this._visibleViews = [];
            this.moreButton = new MoreButton();
            this._thumbCount = 10;
            states = [this.OPEN_STATE, this.CLOSED_STATE];
            currentState = this.CLOSED_STATE;
            return;
        }// end function

        public function init() : void
        {
            if (this.product.state == ModelState.INITIALIZED)
            {
                this.productTypeChanged = true;
                invalidateProperties();
            }
            return;
        }// end function

        private function updateThumbs() : void
        {
            var availableViews:Array;
            var currentIndex:int;
            var i:uint;
            if (!this.product.views)
            {
                return;
            }
            availableViews = this.product.views;
            var visibleViews:Array;
            switch(currentState)
            {
                case this.OPEN_STATE:
                {
                    visibleViews = availableViews;
                    break;
                }
                case this.CLOSED_STATE:
                {
                    if (availableViews.length <= this._thumbCount)
                    {
                        visibleViews = availableViews;
                        break;
                    }
                    currentIndex = availableViews.indexOf(this.product.currentView);
                    i;
                    while (i < this._thumbCount)
                    {
                        
                        visibleViews.push(availableViews[i]);
                        i = i++;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            visibleViews = visibleViews.sort(function (param1:IProductTypeView, param2:IProductTypeView) : Number
            {
                if (param1.id == param2.id)
                {
                    return 0;
                }
                return param1.id < param2.id ? (-1) : (1);
            }// end function
            );
            this._visibleViews = visibleViews;
            if (!this._initialized)
            {
                this._initialized = true;
                dispatchEvent(new ApplicationEvent(ApplicationEvent.COMPONENT_COMPLETE, true));
            }
            invalidateSize();
            invalidateDisplayList();
            return;
        }// end function

        private function updateColor() : void
        {
            var _loc_1:ThumbButton;
            if (this.product.appearances.indexOf(this.product.currentAppearance) == -1)
            {
                return;
            }
            for each (_loc_1 in getChildren())
            {
                
                _loc_1.productColorID = this.product.currentAppearance.id;
            }
            return;
        }// end function

        private function updateSelection() : void
        {
            var _loc_1:ThumbButton;
            for each (_loc_1 in getChildren())
            {
                
                _loc_1.selected = this.product.currentView == _loc_1.view;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.moreButton.label = "more";
            this.moreButton.name = "more";
            this.moreButton.addEventListener(MouseEvent.CLICK, this.moreButton_clickHandler);
            rawChildren.addChild(this.moreButton);
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:UIComponent;
            var _loc_4:uint;
            var _loc_5:IProductTypeView;
            var _loc_6:MoreButton;
            var _loc_7:ThumbButton;
            super.updateDisplayList(param1, param2);
            if (!this.product)
            {
                return;
            }
            for each (_loc_3 in getChildren())
            {
                
                if (_loc_3 is ThumbButton)
                {
                }
                if (this._visibleViews.indexOf(ThumbButton(_loc_3).view) == -1)
                {
                    _loc_3.endEffectsStarted();
                    removeChild(_loc_3);
                }
            }
            _loc_4 = 1;
            for each (_loc_5 in this._visibleViews)
            {
                
                if (this._visibleViews.indexOf(_loc_5) > -1)
                {
                }
                if (!getChildByName(_loc_5.id))
                {
                    _loc_7 = new ThumbButton();
                    _loc_7.alpha = 0;
                    _loc_7.name = _loc_5.id;
                    _loc_7.view = _loc_5;
                    _loc_7.productTypeID = this.product.productTypeID;
                    _loc_7.productColorID = this.product.currentAppearance.id;
                    _loc_7.addEventListener(MouseEvent.CLICK, this.thumb_clickHandler);
                    _loc_7.toolTip = StringUtil.ucwords(_loc_5.name);
                    if (this.useDelay)
                    {
                        this.showThumb.startDelay = 200 * _loc_4++;
                    }
                    else
                    {
                        this.showThumb.startDelay = 0;
                    }
                    _loc_7.setStyle("addedEffect", this.showThumb);
                    addChildAt(_loc_7, this._visibleViews.indexOf(_loc_5));
                }
            }
            _loc_6 = MoreButton(rawChildren.getChildByName("more"));
            _loc_6.width = _loc_6.getExplicitOrMeasuredWidth();
            _loc_6.height = _loc_6.getExplicitOrMeasuredHeight();
            _loc_6.x = measuredWidth;
            _loc_6.endEffectsStarted();
            if (currentState == this.CLOSED_STATE)
            {
            }
            _loc_6.visible = this._visibleViews.length < this.product.views.length;
            dispatchEvent(new Event("widthChanged"));
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.productTypeChanged)
            {
                this.productTypeChanged = false;
                this._colorChanged = true;
                this._viewChanged = true;
                this.updateThumbs();
                callLater(this.updateSelection);
            }
            if (this._colorChanged)
            {
                this._colorChanged = false;
                callLater(this.updateColor);
            }
            if (this._viewChanged)
            {
                this._viewChanged = false;
                this.updateSelection();
                if (currentState == this.OPEN_STATE)
                {
                    currentState = this.CLOSED_STATE;
                    this.updateThumbs();
                }
            }
            return;
        }// end function

        override protected function measure() : void
        {
            measuredMinWidth = 10;
            measuredMinHeight = 10;
            if (numChildren == 0)
            {
                measuredWidth = measuredMinWidth;
            }
            else
            {
                measuredHeight = 49;
                measuredWidth = this._visibleViews.length * (40 + getStyle("horizontalGap"));
            }
            return;
        }// end function

        public function bus_productTypeChangedHandler(param1:Event) : void
        {
            this.productTypeChanged = true;
            this.useDelay = true;
            invalidateProperties();
            return;
        }// end function

        public function bus_viewChangedHandler(param1:ProductTypeEvent) : void
        {
            this._viewChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function bus_appearanceChangedHandler(param1:ProductTypeEvent) : void
        {
            this.productTypeChanged = true;
            this.useDelay = false;
            invalidateProperties();
            return;
        }// end function

        private function thumb_clickHandler(param1:MouseEvent) : void
        {
            this.product.currentView = (param1.target as ThumbButton).view;
            this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(this.product));
            return;
        }// end function

        private function moreButton_clickHandler(param1:MouseEvent) : void
        {
            currentState = this.OPEN_STATE;
            this.updateThumbs();
            return;
        }// end function

    }
}
