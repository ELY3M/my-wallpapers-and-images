package net.sprd.services.memento
{
    import flash.events.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.entities.*;
    import net.sprd.events.*;
    import net.sprd.models.product.*;
    import net.sprd.services.localstorage.*;
    import net.sprd.services.memento.serializers.*;
    import net.sprd.services.undo.*;

    public class MementoManager extends Object
    {
        public var productModel:IProductModel;
        public var localStorage:ILocalStorage;
        public var undoManager:UndoManager;
        private var productSerializer:ProductSerializer;
        private static const log:ILogger = LogContext.getLogger(this);

        public function MementoManager()
        {
            return;
        }// end function

        public function init() : void
        {
            this.productSerializer = new ProductSerializer();
            return;
        }// end function

        public function isProductAvailable() : Boolean
        {
            return this.localStorage.productMemento;
        }// end function

        public function getAppearanceID() : String
        {
            if (!this.localStorage.appearance)
            {
                return null;
            }
            return this.localStorage.appearance.indexOf("_") == -1 ? (this.localStorage.appearance) : (this.localStorage.appearance.split("_")[1]);
        }// end function

        public function getViewID() : String
        {
            return this.localStorage.view;
        }// end function

        public function getSizeID() : String
        {
            return this.localStorage.size;
        }// end function

        public function getProduct() : IProduct
        {
            if (this.isProductAvailable())
            {
                try
                {
                    return IProduct(this.productSerializer.deserialize(this.localStorage.productMemento));
                }
                catch (e:Error)
                {
                    log.warn(e.toString());
                }
            }
            return null;
        }// end function

        public function saveProduct(param1:Event) : void
        {
            var c:IConfigurationModel;
            var memento:Object;
            var e:* = param1;
            if (e is ProductEvent)
            {
            }
            if (ProductEvent(e).type == ProductEvent.ERROR)
            {
                log.info("reseting product memento");
                this.localStorage.setProductMemento(null, null, null, null);
            }
            else
            {
                try
                {
                    var _loc_3:int;
                    var _loc_4:* = this.productModel.configurations;
                    while (_loc_4 in _loc_3)
                    {
                        
                        c = _loc_4[_loc_3];
                        if (c.configuration.modified)
                        {
                            c.updateSVGContent();
                        }
                    }
                    memento = this.productSerializer.serialize(this.productModel.product);
                    this.localStorage.setProductMemento(memento, this.productModel.currentAppearance ? (this.productModel.currentAppearance.id) : (null), this.productModel.currentSize ? (this.productModel.currentSize.id) : (null), this.productModel.currentView ? (this.productModel.currentView.id) : (null));
                }
                catch (e:Error)
                {
                    log.info("Failed to save memento:" + e);
                }
            }
            return;
        }// end function

    }
}
