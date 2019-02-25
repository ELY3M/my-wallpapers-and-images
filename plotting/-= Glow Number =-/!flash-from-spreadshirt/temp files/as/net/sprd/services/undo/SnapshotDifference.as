package net.sprd.services.undo
{
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.entities.*;

    public class SnapshotDifference extends Object
    {
        private var _currentSnapshot:ApplicationSnapshot;
        private var _targetSnapshot:ApplicationSnapshot;
        private var _deletedConfigurations:Array;
        private var _addedConfigurations:Array;
        private var _currentZOrder:Array;
        private var _targetZOrder:Array;
        private var _changedConfigurations:Array;
        private static const log:ILogger = LogContext.getLogger(this);

        public function SnapshotDifference(param1:ApplicationSnapshot, param2:ApplicationSnapshot)
        {
            if (param1)
            {
            }
            if (!param2)
            {
                throw new Error("Snapshot is null");
            }
            this._currentSnapshot = param1;
            this._targetSnapshot = param2;
            this._currentZOrder = this.average(this._currentSnapshot.product.configurations, this._targetSnapshot.product.configurations);
            this._targetZOrder = this.average(this._targetSnapshot.product.configurations, this._currentSnapshot.product.configurations);
            if (this._currentZOrder.length != this._targetZOrder.length)
            {
                log.error("IDs in configuration duplicated");
            }
            return;
        }// end function

        public function get currentSnapshot() : ApplicationSnapshot
        {
            return this._currentSnapshot;
        }// end function

        public function get targetSnapshot() : ApplicationSnapshot
        {
            return this._targetSnapshot;
        }// end function

        public function get sizeChanged() : Boolean
        {
            return this._currentSnapshot.sizeId != this._targetSnapshot.sizeId;
        }// end function

        public function get appearanceChanged() : Boolean
        {
            return this._currentSnapshot.appearanceId != this._targetSnapshot.appearanceId;
        }// end function

        public function get viewChanged() : Boolean
        {
            return this._currentSnapshot.viewId != this._targetSnapshot.viewId;
        }// end function

        public function get productTypeChanged() : Boolean
        {
            return this._currentSnapshot.product.productType != this._targetSnapshot.product.productType;
        }// end function

        public function addedConfigurations() : Array
        {
            if (!this._addedConfigurations)
            {
                this._addedConfigurations = this.diff(this._targetSnapshot.product.configurations, this._currentSnapshot.product.configurations);
            }
            return this._addedConfigurations;
        }// end function

        public function deletedConfigurations() : Array
        {
            if (!this._deletedConfigurations)
            {
                this._deletedConfigurations = this.diff(this._currentSnapshot.product.configurations, this._targetSnapshot.product.configurations);
            }
            return this._deletedConfigurations;
        }// end function

        public function changedConfigurations() : Array
        {
            var _loc_1:Array;
            var _loc_2:IConfiguration;
            var _loc_3:int;
            if (!this._changedConfigurations)
            {
                _loc_1 = [];
                for each (_loc_2 in this._currentZOrder)
                {
                    
                    _loc_3 = this.containsEntity(this._targetZOrder, _loc_2);
                    if (_loc_3 != -1)
                    {
                    }
                    if (!this.configurationsAreEqual(_loc_2, this._targetZOrder[_loc_3]))
                    {
                        _loc_1.push(this._targetZOrder[_loc_3]);
                    }
                }
                this._changedConfigurations = _loc_1;
            }
            return this._changedConfigurations;
        }// end function

        private function configurationsAreEqual(param1:IConfiguration, param2:IConfiguration) : Boolean
        {
            if (param1.designId != param2.designId)
            {
                return false;
            }
            return param1.svgContent.equals(param2.svgContent);
        }// end function

        public function get zOrderChanged() : Boolean
        {
            var _loc_1:uint;
            while (_loc_1++ < this._currentZOrder.length)
            {
                
                if (this._currentZOrder[_loc_1].id != this._targetZOrder[_loc_1].id)
                {
                    return true;
                }
            }
            return false;
        }// end function

        private function average(param1:Array, param2:Array) : Array
        {
            var _loc_4:IBaseEntity;
            var _loc_3:Array;
            for each (_loc_4 in param1)
            {
                
                if (this.containsEntity(param2, _loc_4) != -1)
                {
                    _loc_3.push(_loc_4);
                }
            }
            return _loc_3;
        }// end function

        private function diff(param1:Array, param2:Array) : Array
        {
            var _loc_4:IBaseEntity;
            var _loc_3:Array;
            for each (_loc_4 in param2)
            {
                
                if (this.containsEntity(param1, _loc_4) == -1)
                {
                    _loc_3.push(_loc_4);
                }
            }
            return _loc_3;
        }// end function

        private function containsEntity(param1:Array, param2:IBaseEntity) : int
        {
            var _loc_4:IBaseEntity;
            var _loc_3:int;
            for each (_loc_4 in param1)
            {
                
                if (param2.id == _loc_4.id)
                {
                    return _loc_3;
                }
            }
            return -1;
        }// end function

        public function get hasChanges() : Boolean
        {
            if (true)
            {
            }
            if (true)
            {
            }
            if (true)
            {
            }
            if (true)
            {
            }
            if (this.addedConfigurations().length <= 0)
            {
            }
            if (this.deletedConfigurations().length <= 0)
            {
            }
            if (true)
            {
            }
            return this.changedConfigurations().length > 0;
        }// end function

        public function get selectionChanged() : Boolean
        {
            return this._currentSnapshot.selectedConfiguration != this._targetSnapshot.selectedConfiguration;
        }// end function

    }
}
