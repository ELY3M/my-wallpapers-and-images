package net.sprd.components.producttypeappeaeranceselector
{
    import flash.display.*;
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.effects.easing.*;
    import mx.events.*;
    import mx.states.*;
    import net.sprd.common.utils.*;
    import net.sprd.entities.*;
    import net.sprd.events.*;
    import net.sprd.models.common.*;
    import net.sprd.models.product.*;

    public class ProductColorSelectorClass extends Canvas
    {
        public var bgImage:Image;
        public var openState:State;
        public var closedState:State;
        public var swatchContainer:Canvas;
        public var dummyContainer:UIComponent;
        public var bus:IEventDispatcher;
        public var productModel:IProductModel;
        private var _colorsChanged:Boolean;
        private var _currentColorChanged:Boolean;
        private var _currentSwatch:Swatch;
        private var _newProductColor:IProductTypeAppearance;
        private var _componentComplete:Boolean;

        public function ProductColorSelectorClass()
        {
            addEventListener(StateChangeEvent.CURRENT_STATE_CHANGE, this.onStateChange);
            return;
        }// end function

        public function init() : void
        {
            if (this.productModel.state == ModelState.INITIALIZED)
            {
                this._colorsChanged = true;
                this.checkComponentComplete();
                invalidateProperties();
            }
            return;
        }// end function

        protected function createEmptySwatch() : Sprite
        {
            var _loc_1:* = new Sprite();
            _loc_1.graphics.beginFill(10853781, 1);
            _loc_1.graphics.drawRoundRect(0, 0, 20, 20, 8, 8);
            _loc_1.graphics.beginFill(16777215, 1);
            _loc_1.graphics.drawRoundRect(1, 1, 18, 18, 8, 8);
            return _loc_1;
        }// end function

        protected function swapStates() : void
        {
            currentState = currentState == this.openState.name ? (this.closedState.name) : (this.openState.name);
            return;
        }// end function

        private function onStateChange(param1:StateChangeEvent) : void
        {
            if (param1.newState == this.openState.name)
            {
                this.showColors();
            }
            else
            {
                this.hideColors();
            }
            return;
        }// end function

        private function createSwatches() : void
        {
            var _loc_1:IProductTypeAppearance;
            var _loc_2:Swatch;
            this.swatchContainer.removeAllChildren();
            for each (_loc_1 in this.productModel.appearances)
            {
                
                if (!this.productModel.isAppearanceOnStock(_loc_1))
                {
                    continue;
                }
                _loc_2 = new Swatch();
                _loc_2.setActualSize(20, 20);
                _loc_2.appearance = _loc_1;
                this.swatchContainer.addChild(_loc_2);
                _loc_2.endEffectsStarted();
                _loc_2.visible = false;
                _loc_2.toolTip = StringUtil.ucwords(_loc_1.name);
                _loc_2.selected = _loc_1 == this.productModel.currentAppearance;
                _loc_2.addEventListener(MouseEvent.CLICK, this.onColorSelect);
            }
            invalidateDisplayList();
            currentState = this.openState.name;
            this.showColors();
            return;
        }// end function

        private function showColors() : void
        {
            var _loc_3:Swatch;
            var _loc_4:Move;
            var _loc_1:uint;
            this.dummyContainer.endEffectsStarted();
            this.dummyContainer.visible = false;
            var _loc_2:uint;
            while (_loc_2++ < this.swatchContainer.numChildren)
            {
                
                _loc_3 = Swatch(this.swatchContainer.getChildAt(this.swatchContainer.numChildren - 1 - _loc_2));
                _loc_4 = new Move(_loc_3);
                _loc_4.duration = 300;
                _loc_4.startDelay = 20 * _loc_2;
                _loc_4.easingFunction = Cubic.easeInOut;
                _loc_4.xTo = 20 * _loc_1++;
                _loc_4.addEventListener(EffectEvent.EFFECT_START, this.onMoveInStart);
                _loc_4.play([_loc_3]);
            }
            return;
        }// end function

        private function hideColors() : void
        {
            var _loc_2:Swatch;
            var _loc_3:Move;
            var _loc_1:uint;
            for each (_loc_2 in this.swatchContainer.getChildren())
            {
                
                _loc_3 = new Move(_loc_2);
                _loc_3.duration = 300;
                _loc_3.startDelay = 20 * _loc_1++;
                _loc_3.easingFunction = Cubic.easeOut;
                _loc_3.xTo = 0;
                _loc_3.addEventListener(EffectEvent.EFFECT_END, this.onMoveOutEnd);
                if (_loc_1 == this.swatchContainer.numChildren)
                {
                    _loc_3.addEventListener(EffectEvent.EFFECT_END, this.onStackClosed);
                }
                _loc_3.play([_loc_2]);
            }
            return;
        }// end function

        private function onStackClosed(param1:EffectEvent) : void
        {
            IEventDispatcher(param1.target).removeEventListener(EffectEvent.EFFECT_END, this.onStackClosed);
            this.dummyContainer.endEffectsStarted();
            this.dummyContainer.visible = true;
            return;
        }// end function

        private function onMoveInStart(param1:EffectEvent) : void
        {
            var _loc_2:* = Swatch(Effect(param1.target).target);
            _loc_2.endEffectsStarted();
            _loc_2.visible = true;
            return;
        }// end function

        private function onMoveOutEnd(param1:EffectEvent) : void
        {
            var _loc_2:* = Swatch(Effect(param1.target).target);
            _loc_2.endEffectsStarted();
            _loc_2.visible = false;
            return;
        }// end function

        private function updateSelection() : void
        {
            var _loc_1:Swatch;
            for each (_loc_1 in this.swatchContainer.getChildren())
            {
                
                _loc_1.selected = _loc_1.appearance == this.productModel.currentAppearance;
            }
            this._currentSwatch.appearance = this.productModel.currentAppearance;
            return;
        }// end function

        private function doProductColorChange() : void
        {
            if (this._newProductColor)
            {
            }
            if (this._newProductColor == this.productModel.currentAppearance)
            {
                return;
            }
            this.productModel.currentAppearance = this._newProductColor;
            this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(this.productModel));
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            var _loc_1:* = this.createEmptySwatch();
            var _loc_2:* = this.createEmptySwatch();
            var _loc_3:* = this.createEmptySwatch();
            _loc_2.width = _loc_2.width - 2;
            _loc_2.height = _loc_2.height - 2;
            _loc_2.x = 5;
            _loc_2.y = 1;
            _loc_3.width = _loc_3.width - 4;
            _loc_3.height = _loc_3.height - 4;
            _loc_3.x = 10;
            _loc_3.y = 2;
            this.dummyContainer = new UIComponent();
            this.dummyContainer.addChild(_loc_3);
            this.dummyContainer.addChild(_loc_2);
            this.dummyContainer.addChild(_loc_1);
            addChild(this.dummyContainer);
            this.dummyContainer.move(28, 28);
            this._currentSwatch = new Swatch();
            this._currentSwatch.setActualSize(20, 20);
            this._currentSwatch.mouseEnabled = false;
            this._currentSwatch.move(0, 0);
            this.dummyContainer.addChild(this._currentSwatch);
            this.dummyContainer.buttonMode = true;
            this.dummyContainer.addEventListener(MouseEvent.CLICK, this.onDummyStackClick);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this._colorsChanged)
            {
                this._colorsChanged = false;
                this.updateSelection();
                currentState = this.openState.name;
                callLater(this.createSwatches);
            }
            if (this._currentColorChanged)
            {
                this._currentColorChanged = false;
                this.updateSelection();
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            if (!visible)
            {
            }
            if (this.productModel)
            {
            }
            if (this.productModel.currentAppearance)
            {
                if (!stage)
                {
                    callLater(invalidateDisplayList);
                    return;
                }
                endEffectsStarted();
                visible = true;
            }
            return;
        }// end function

        private function onDummyStackClick(param1:MouseEvent) : void
        {
            this.swapStates();
            return;
        }// end function

        private function onColorSelect(param1:MouseEvent) : void
        {
            this._newProductColor = Swatch(param1.target).appearance;
            var _loc_2:* = this.productModel.canChangeAppearance(this._newProductColor);
            if (_loc_2.hasConstraints)
            {
                Alert.show(_loc_2.toString(), resourceManager.getString("confomat7", "universal.notice"), Alert.OK | Alert.CANCEL, null, this.onAlertClose);
            }
            else
            {
                this.doProductColorChange();
            }
            return;
        }// end function

        private function onAlertClose(param1:CloseEvent) : void
        {
            if (param1.detail == Alert.OK)
            {
                this.doProductColorChange();
            }
            return;
        }// end function

        private function checkComponentComplete() : void
        {
            if (!this._componentComplete)
            {
                this._componentComplete = true;
                dispatchEvent(new ApplicationEvent(ApplicationEvent.COMPONENT_COMPLETE, true));
            }
            return;
        }// end function

        public function bus_productTypeChangedHandler(param1:Event) : void
        {
            this._colorsChanged = true;
            invalidateProperties();
            this.checkComponentComplete();
            return;
        }// end function

        public function bus_appearanceChangedHandler(param1:ProductTypeEvent) : void
        {
            this._currentColorChanged = true;
            invalidateProperties();
            return;
        }// end function

    }
}
