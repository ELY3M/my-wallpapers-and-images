package net.sprd.services.undo
{
    import flash.events.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.events.*;
    import net.sprd.models.product.*;

    public class UndoManager extends EventDispatcher
    {
        public var productModel:IProductModel;
        public var bus:IEventDispatcher;
        private var undoStack:Array;
        private var currentState:int = -1;
        private var _inProgress:Boolean = false;
        private static const log:ILogger = LogContext.getLogger(this);

        public function UndoManager()
        {
            this.undoStack = [];
            return;
        }// end function

        public function get undoAvailable() : Boolean
        {
            return this.currentState > 0;
        }// end function

        public function get redoAvailable() : Boolean
        {
            return this.currentState < this.undoStack.length - 1;
        }// end function

        public function undo() : void
        {
            if (true)
            {
            }
            if (!this.undoAvailable)
            {
                return;
            }
            this._inProgress = true;
            var _loc_1:* = this.undoStack[this.currentState];
            var _loc_3:String;
            _loc_3.currentState = this.currentState--;
            var _loc_2:* = ApplicationSnapshot(this.undoStack[this.currentState]);
            this.applySnapshot(new SnapshotDifference(_loc_1, _loc_2));
            this._inProgress = false;
            this.bus.dispatchEvent(new SnapShotEvent(SnapShotEvent.CURRENT_STATE_CHANGED));
            return;
        }// end function

        public function redo() : void
        {
            if (true)
            {
            }
            if (!this.redoAvailable)
            {
                return;
            }
            this._inProgress = true;
            var _loc_1:* = this.undoStack[this.currentState];
            var _loc_3:String;
            _loc_3.currentState = this.currentState++;
            var _loc_2:* = ApplicationSnapshot(this.undoStack[this.currentState]);
            this.applySnapshot(new SnapshotDifference(_loc_1, _loc_2));
            this._inProgress = false;
            return;
        }// end function

        private function applySnapshot(param1:SnapshotDifference) : void
        {
            var _loc_2:IConfiguration;
            var _loc_3:IConfigurationModel;
            if (param1.productTypeChanged)
            {
                this.productModel.changeProductType(param1.targetSnapshot.product.productType, param1.targetSnapshot.appearanceId, param1.targetSnapshot.viewId, param1.targetSnapshot.sizeId, false);
            }
            if (param1.sizeChanged)
            {
                this.productModel.currentSize = this.productModel.productType.getSizeById(param1.targetSnapshot.sizeId);
            }
            if (param1.viewChanged)
            {
                this.productModel.currentView = this.productModel.productType.getViewById(param1.targetSnapshot.viewId);
            }
            if (param1.appearanceChanged)
            {
                this.productModel.currentAppearance = this.productModel.productType.getAppearanceById(param1.targetSnapshot.appearanceId);
            }
            if (param1.addedConfigurations().length <= 0)
            {
            }
            if (param1.deletedConfigurations().length <= 0)
            {
            }
            if (true)
            {
            }
            if (param1.changedConfigurations().length <= 0)
            {
            }
            if (param1.productTypeChanged)
            {
                while (this.productModel.configurations.length > 0)
                {
                    
                    this.productModel.removeConfiguration(this.productModel.configurations[0]);
                }
                for each (_loc_2 in param1.targetSnapshot.product.configurations)
                {
                    
                    ProductModel(this.productModel).addConfiguration(_loc_2.clone());
                }
            }
            if (param1.selectionChanged)
            {
                for each (_loc_3 in this.productModel.configurations)
                {
                    
                    if (_loc_3.configurationID == param1.targetSnapshot.selectedConfiguration)
                    {
                        this.productModel.selectConfiguration(_loc_3);
                        break;
                    }
                }
            }
            return;
        }// end function

        private function pushChange(param1:ApplicationSnapshot) : void
        {
            var _loc_2:SnapshotDifference;
            if (this._inProgress)
            {
                return;
            }
            if (this.currentState >= 0)
            {
                _loc_2 = new SnapshotDifference(this.undoStack[this.currentState], param1);
                if (!_loc_2.hasChanges)
                {
                    log.warn("Snapshot has no differences");
                    return;
                }
            }
            this.undoStack.splice(this.currentState + 1);
            this.undoStack.push(param1);
            var _loc_3:String;
            _loc_3.currentState = this.currentState++;
            this.bus.dispatchEvent(new SnapShotEvent(SnapShotEvent.CURRENT_STATE_CHANGED, param1));
            return;
        }// end function

        public function saveSnapshot(param1:SnapShotEvent) : void
        {
            if (param1)
            {
            }
            if (param1.snapShot)
            {
                this.pushChange(param1.snapShot);
            }
            else
            {
                log.warn("CREATE_SNAPSHOT Event with empty snapshot");
            }
            return;
        }// end function

    }
}
