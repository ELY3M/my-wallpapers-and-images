package net.sprd.components.producttypesizeselector
{
    import flash.events.*;
    import flash.utils.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.managers.*;
    import net.sprd.components.common.*;
    import net.sprd.entities.*;
    import net.sprd.events.*;
    import net.sprd.models.common.*;
    import net.sprd.models.product.*;

    public class SizeSelectorClass extends HBox
    {
        public var product:IProductModel;
        public var bus:IEventDispatcher;
        private var _productTypeChanged:Boolean;
        private var _colorChanged:Boolean;
        private var _sizeChanged:Boolean;
        private var _displaysButtons:Boolean;
        private var _label:Label;
        private var _componentComplete:Boolean;

        public function SizeSelectorClass()
        {
            return;
        }// end function

        public function init() : void
        {
            if (this.product.state == ModelState.INITIALIZED)
            {
                this._productTypeChanged = true;
                this.checkComponentComplete();
                invalidateProperties();
            }
            return;
        }// end function

        private function createControls() : void
        {
            var defaultSizes:Array;
            var size:IProductTypeSize;
            var btn:Button;
            var combo:ComboBox;
            removeAllChildren();
            if (!this.product)
            {
                return;
            }
            defaultSizes;
            this._displaysButtons = this.product.sizes.every(function (param1:IProductTypeSize, param2:int, param3:Array) : Boolean
            {
                return defaultSizes.indexOf(param1.name.toLowerCase()) > -1;
            }// end function
            );
            if (this.product.sizes.length == 1)
            {
                this._label = new Label();
                this._label.styleName = "defaultLabel";
                this._label.text = resourceManager.getString("confomat7", "sizinginfo.label_unisize");
                addChild(this._label);
                return;
            }
            if (this._displaysButtons)
            {
                var _loc_2:int;
                var _loc_3:* = this.product.sizes;
                while (_loc_3 in _loc_2)
                {
                    
                    size = _loc_3[_loc_2];
                    btn = new Button();
                    btn.styleName = "sizeButton";
                    btn.label = size.name;
                    btn.name = size.id;
                    btn.data = size;
                    btn.height = 20;
                    btn.width = 40;
                    btn.addEventListener(MouseEvent.CLICK, this.onSizeSelect);
                    addChild(btn);
                }
            }
            else
            {
                combo = new ComboBox();
                combo.name = "combo";
                combo.height = 20;
                combo.labelField = "name";
                combo.prompt = resourceManager.getString("confomat7", "sizinginfo.label_sizing_dropdown");
                combo.dataProvider = this.product.sizes;
                combo.addEventListener(Event.CHANGE, this.onSizeSelect);
                addChild(combo);
            }
            return;
        }// end function

        private function updateControls() : void
        {
            var child:DisplayObject;
            var btn:Button;
            var comboBox:ComboBox;
            if (this._displaysButtons)
            {
                var _loc_2:int;
                var _loc_3:* = getChildren();
                while (_loc_3 in _loc_2)
                {
                    
                    child = _loc_3[_loc_2];
                    btn = child as Button;
                    if (!btn)
                    {
                        continue;
                    }
                    btn.selected = btn.data == this.product.currentSize;
                    btn.enabled = this.product.isOnStock(this.product.currentAppearance, IProductTypeSize(btn.data));
                }
            }
            else if (getChildByName("combo"))
            {
                comboBox = ComboBox(getChildByName("combo"));
                comboBox.dataProvider = this.product.sizes.filter(function (param1:IProductTypeSize, param2, param3) : Boolean
            {
                return product.isOnStock(product.currentAppearance, param1);
            }// end function
            );
                comboBox.selectedItem = this.product.currentSize;
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this._productTypeChanged)
            {
                this._productTypeChanged = false;
                this.createControls();
                callLater(this.updateControls);
            }
            if (this._sizeChanged)
            {
                this._sizeChanged = false;
                this.updateControls();
            }
            if (this._colorChanged)
            {
                this._colorChanged = false;
                callLater(this.updateControls);
            }
            return;
        }// end function

        private function onSizeSelect(param1:Event) : void
        {
            var _loc_2:IProductTypeSize;
            if (param1.currentTarget is Button)
            {
                _loc_2 = IProductTypeSize(param1.currentTarget.data);
            }
            if (param1.currentTarget is ComboBox)
            {
                _loc_2 = IProductTypeSize(param1.currentTarget.selectedItem);
            }
            this.product.currentSize = _loc_2;
            this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(this.product));
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
            this._productTypeChanged = true;
            invalidateProperties();
            this.checkComponentComplete();
            return;
        }// end function

        public function bus_appearanceChangedHandler(param1:ProductTypeEvent) : void
        {
            this._colorChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function bus_sizeChangedHandler(param1:ProductTypeEvent) : void
        {
            this._sizeChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function bus_noSizeSelectedHandler(param1:ApplicationEvent) : void
        {
            var errorTip:ToolTip;
            var e:* = param1;
            var tipText:* = resourceManager.getString("confomat7", "messages_system.select_size_headline");
            var bounds:* = getBounds(stage);
            var ref:* = bounds.bottomRight;
            ref.x = ref.x - bounds.width;
            errorTip = ToolTipManager.createToolTip(tipText, ref.x, ref.y, "errorTipBelow") as ToolTip;
            var timer:* = new Timer(FXDefaults.ERROR_TIP_DISPLAY_DURATION, 1);
            with ({})
            {
                {}.onTimerComplete = function (param1:TimerEvent) : void
            {
                if (errorTip)
                {
                    ToolTipManager.destroyToolTip(errorTip);
                }
                return;
            }// end function
            ;
            }
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, function (param1:TimerEvent) : void
            {
                if (errorTip)
                {
                    ToolTipManager.destroyToolTip(errorTip);
                }
                return;
            }// end function
            );
            timer.start();
            return;
        }// end function

    }
}
