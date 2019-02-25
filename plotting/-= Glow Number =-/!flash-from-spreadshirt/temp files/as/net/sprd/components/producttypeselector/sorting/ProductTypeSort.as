package net.sprd.components.producttypeselector.sorting
{
    import flash.events.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;
    import net.sprd.components.producttypeselector.*;
    import net.sprd.components.producttypeselector.colorfilter.*;

    public class ProductTypeSort extends VBox implements IBindingClient
    {
        public var _ProductTypeSort_Label1:Label;
        public var _ProductTypeSort_Label2:Label;
        private var _599691451colorFilter:ColorFilter;
        private var _109453458sizes:ComboBox;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;
        private var _dataProviderChanged:Boolean;
        private var _1763739238_dataProvider:ProductTypeSelectorModel;
        private var _1465744493_sizes:Array;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function ProductTypeSort()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._documentDescriptor_ = new UIComponentDescriptor({type:VBox, stylesFactory:function () : void
            {
                this.borderColor = 12433331;
                this.paddingLeft = 5;
                this.paddingTop = 0;
                return;
            }// end function
            , propertiesFactory:function () : Object
            {
                return {width:269, height:22, childDescriptors:[new UIComponentDescriptor({type:HBox, propertiesFactory:function () : Object
                {
                    return {childDescriptors:[new UIComponentDescriptor({type:Label, id:"_ProductTypeSort_Label1"}), new UIComponentDescriptor({type:ComboBox, id:"sizes", events:{change:"__sizes_change"}, propertiesFactory:function () : Object
                    {
                        return {height:18, width:112, rowCount:13, buttonMode:true, labelField:"name"};
                    }// end function
                    }), new UIComponentDescriptor({type:Label, id:"_ProductTypeSort_Label2"}), new UIComponentDescriptor({type:ColorFilter, id:"colorFilter"})]};
                }// end function
                })]};
            }// end function
            });
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            var bindings:* = this._ProductTypeSort_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_net_sprd_components_producttypeselector_sorting_ProductTypeSortWatcherSetupUtil");
                var _loc_2:* = watcherSetupUtilClass;
                _loc_2.watcherSetupUtilClass["init"](null);
            }
            _watcherSetupUtil.setup(this, function (param1:String)
            {
                return target[param1];
            }// end function
            , function (param1:String)
            {
                return [param1];
            }// end function
            , bindings, watchers);
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.width = 269;
            this.height = 22;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            var i:uint;
            while (i < bindings.length)
            {
                
                Binding(bindings[i]).execute();
                i = i++;
            }
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
                this.borderColor = 12433331;
                this.paddingLeft = 5;
                this.paddingTop = 0;
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

        public function set dataProvider(param1:ProductTypeSelectorModel) : void
        {
            if (this._dataProvider == param1)
            {
                return;
            }
            this._dataProvider = param1 as ProductTypeSelectorModel;
            this._dataProviderChanged = true;
            invalidateProperties();
            return;
        }// end function

        private function onSizeChange(param1:ListEvent) : void
        {
            this._dataProvider.sortBySize(param1.target.selectedItem);
            return;
        }// end function

        private function onPriceChange(param1:MouseEvent) : void
        {
            switch(param1.target.name)
            {
                case "high":
                {
                    this._dataProvider.sortByPrice(ProductTypeSorting.SORT_ASCENDING);
                    break;
                }
                case "low":
                {
                    this._dataProvider.sortByPrice(ProductTypeSorting.SORT_DESCENDING);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this._dataProviderChanged)
            {
                this._dataProviderChanged = false;
                this.colorFilter.dataProvider = this._dataProvider;
            }
            return;
        }// end function

        public function __sizes_change(param1:ListEvent) : void
        {
            this.onSizeChange(param1);
            return;
        }// end function

        private function _ProductTypeSort_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "universal.label_sort_size");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "_ProductTypeSort_Label1.text");
            result[1] = new Binding(this, function () : Object
            {
                return _dataProvider.sortSizes;
            }// end function
            , null, "sizes.dataProvider");
            result[2] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "universal.label_sort_colour");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "_ProductTypeSort_Label2.text");
            return result;
        }// end function

        public function get colorFilter() : ColorFilter
        {
            return this._599691451colorFilter;
        }// end function

        public function set colorFilter(param1:ColorFilter) : void
        {
            var _loc_2:* = this._599691451colorFilter;
            if (_loc_2 !== param1)
            {
                this._599691451colorFilter = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colorFilter", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get sizes() : ComboBox
        {
            return this._109453458sizes;
        }// end function

        public function set sizes(param1:ComboBox) : void
        {
            var _loc_2:* = this._109453458sizes;
            if (_loc_2 !== param1)
            {
                this._109453458sizes = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sizes", _loc_2, param1));
                }
            }
            return;
        }// end function

        private function get _dataProvider() : ProductTypeSelectorModel
        {
            return this._1763739238_dataProvider;
        }// end function

        private function set _dataProvider(param1:ProductTypeSelectorModel) : void
        {
            var _loc_2:* = this._1763739238_dataProvider;
            if (_loc_2 !== param1)
            {
                this._1763739238_dataProvider = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_dataProvider", _loc_2, param1));
                }
            }
            return;
        }// end function

        private function get _sizes() : Array
        {
            return this._1465744493_sizes;
        }// end function

        private function set _sizes(param1:Array) : void
        {
            var _loc_2:* = this._1465744493_sizes;
            if (_loc_2 !== param1)
            {
                this._1465744493_sizes = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_sizes", _loc_2, param1));
                }
            }
            return;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
        {
            _watcherSetupUtil = param1;
            return;
        }// end function

    }
}
