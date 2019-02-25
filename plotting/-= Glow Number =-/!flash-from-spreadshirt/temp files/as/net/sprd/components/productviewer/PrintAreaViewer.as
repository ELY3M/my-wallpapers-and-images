package net.sprd.components.productviewer
{
    import flash.display.*;
    import flash.events.*;
    import mx.core.*;
    import net.sprd.common.collections.*;
    import net.sprd.entities.*;
    import net.sprd.events.*;
    import net.sprd.graphics.svg.utils.*;
    import net.sprd.models.product.*;

    public class PrintAreaViewer extends Container
    {
        public var bus:IEventDispatcher;
        public var productModel:IProductModel;
        private var _viewScale:Number = 1;
        private var _viewScaleChanged:Boolean = false;
        private var _printArea:IPrintArea;
        private var configurationViewers:IMap;
        private var _dataProviderChanged:Boolean = false;
        private var _softBoundaryMask:Sprite;
        private var _isOnBrightFabric:Boolean;
        private var _isOnBrightFabricChanged:Boolean = false;
        private var zOrderChanged:Boolean = false;

        public function PrintAreaViewer(param1:IPrintArea, param2:Number, param3:Number, param4:Number)
        {
            this.configurationViewers = new DictionaryMap();
            addEventListener(Event.REMOVED_FROM_STAGE, this.removedFromStageHandler);
            this._printArea = param1;
            this._viewScale = param2;
            this.x = param3;
            this.y = param4;
            this._viewScaleChanged = true;
            this._dataProviderChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get configurations() : IMap
        {
            return this.configurationViewers;
        }// end function

        public function get viewScale() : Number
        {
            return this._viewScale;
        }// end function

        override public function set x(param1:Number) : void
        {
            super.x = param1 / this.viewScale;
            return;
        }// end function

        override public function set y(param1:Number) : void
        {
            super.y = param1 / this.viewScale;
            return;
        }// end function

        public function get isOnBrightFabric() : Boolean
        {
            return this._isOnBrightFabric;
        }// end function

        public function set isOnBrightFabric(param1:Boolean) : void
        {
            if (param1 == this.isOnBrightFabric)
            {
                return;
            }
            this._isOnBrightFabric = param1;
            this._isOnBrightFabricChanged = true;
            invalidateProperties();
            return;
        }// end function

        private function updateViewScale() : void
        {
            var _loc_1:ConfigurationViewer;
            for each (_loc_1 in getChildren())
            {
                
                _loc_1.viewScale = this.viewScale;
            }
            if (this._softBoundaryMask)
            {
                var _loc_2:* = 1 / this.viewScale;
                this._softBoundaryMask.scaleY = 1 / this.viewScale;
                this._softBoundaryMask.scaleX = _loc_2;
            }
            invalidateDisplayList();
            return;
        }// end function

        private function updateIsOnBrightFabric() : void
        {
            var _loc_1:ConfigurationViewer;
            for each (_loc_1 in getChildren())
            {
                
                _loc_1.isOnBrightFabric = this._isOnBrightFabric;
            }
            return;
        }// end function

        private function updateMask() : void
        {
            return;
        }// end function

        private function hasSelectedConfigurations() : Boolean
        {
            var _loc_1:ConfigurationViewer;
            for each (_loc_1 in getChildren())
            {
                
                if (_loc_1.isSelected)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function addConfigurationViewer(param1:ConfigurationViewer) : DisplayObject
        {
            var _loc_2:* = param1.configuration;
            if (this.configurationViewers.get(_loc_2.configurationID))
            {
                return param1;
            }
            this.configurationViewers.put(_loc_2.configurationID, param1);
            param1.viewScale = this.viewScale;
            param1.addEventListener(MouseEvent.MOUSE_DOWN, this.configurationViewer_mouseDownHandler);
            return super.addChild(param1);
        }// end function

        public function removeConfigurationViewer(param1:DisplayObject) : DisplayObject
        {
            var _loc_2:* = ConfigurationViewer(param1);
            this.configurationViewers.remove(_loc_2.configuration.configurationID);
            _loc_2.removeEventListener(MouseEvent.MOUSE_DOWN, this.configurationViewer_mouseDownHandler);
            return super.removeChild(param1);
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            graphics.clear();
            var _loc_3:* = this.hasSelectedConfigurations() ? (0.3) : (0);
            var _loc_4:* = this.isOnBrightFabric ? (getStyle("darkBorderColor")) : (getStyle("brightBorderColor"));
            graphics.lineStyle(1, _loc_4, _loc_3);
            graphics.drawGraphicsData(SVGShapeUtil.toGraphicsData(this._printArea.softBoundary, 1 / this.viewScale));
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:Boolean;
            var _loc_2:Array;
            var _loc_3:int;
            var _loc_4:ConfigurationViewer;
            var _loc_5:ConfigurationViewer;
            super.commitProperties();
            if (this._dataProviderChanged)
            {
                this._dataProviderChanged = false;
                this.updateMask();
            }
            if (this._viewScaleChanged)
            {
                this._viewScaleChanged = false;
                this.updateViewScale();
            }
            if (this._isOnBrightFabricChanged)
            {
                this.updateIsOnBrightFabric();
                invalidateDisplayList();
            }
            if (this.zOrderChanged)
            {
                this.zOrderChanged = false;
                _loc_1 = false;
                _loc_2 = this.productModel.getConfigurationsForPrintArea(this._printArea.id);
                do
                {
                    
                    _loc_1 = false;
                    _loc_3 = 0;
                    while (_loc_3++ < _loc_2.length - 1)
                    {
                        
                        _loc_4 = ConfigurationViewer(getChildAt(_loc_3));
                        _loc_5 = ConfigurationViewer(getChildAt(_loc_3 + 1));
                        if (_loc_2.indexOf(_loc_4.configuration) > _loc_2.indexOf(_loc_5.configuration))
                        {
                            swapChildren(_loc_4, _loc_5);
                            _loc_1 = true;
                        }
                    }
                }while (_loc_1)
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = this._printArea.width / this.viewScale;
            measuredMinWidth = this._printArea.width / this.viewScale;
            measuredWidth = _loc_1;
            var _loc_1:* = this._printArea.height / this.viewScale;
            measuredMinHeight = this._printArea.height / this.viewScale;
            measuredHeight = _loc_1;
            setActualSize(measuredWidth, measuredHeight);
            return;
        }// end function

        public function bus_zOrderChangedHandler(param1:ProductEvent) : void
        {
            this.zOrderChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function bus_selectionChangedHandler(param1:ConfigurationEvent) : void
        {
            invalidateDisplayList();
            return;
        }// end function

        private function configurationViewer_mouseDownHandler(param1:MouseEvent) : void
        {
            var _loc_2:* = ConfigurationViewer(param1.currentTarget).configuration;
            var _loc_3:Boolean;
            if (this.productModel.selectedConfiguration != _loc_2)
            {
            }
            if (_loc_2.isChangeable)
            {
                _loc_3 = true;
            }
            _loc_2.setSelection(true);
            if (_loc_3)
            {
                this.bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(_loc_2.product));
            }
            return;
        }// end function

        private function removedFromStageHandler(param1:Event) : void
        {
            while (numChildren > 0)
            {
                
                this.removeConfigurationViewer(getChildAt(0));
            }
            removeEventListener(Event.REMOVED_FROM_STAGE, this.removedFromStageHandler);
            return;
        }// end function

    }
}
