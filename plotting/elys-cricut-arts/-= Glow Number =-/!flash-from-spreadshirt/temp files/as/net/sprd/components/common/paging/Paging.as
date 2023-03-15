package net.sprd.components.common.paging
{
    import flash.events.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;

    public class Paging extends Canvas implements IBindingClient
    {
        public var _Paging_Label1:Label;
        public var _Paging_Label2:Label;
        private var _205678947btnBack:Button;
        private var _206040943btnNext:Button;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;
        private var _1763739238_dataProvider:IPageable;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function Paging()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, events:{initialize:"___Paging_Canvas1_initialize"}, propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Button, id:"btnBack", events:{click:"__btnBack_click"}, propertiesFactory:function () : Object
                {
                    return {styleName:"prevButton", left:5, verticalCenter:-5};
                }// end function
                }), new UIComponentDescriptor({type:Label, id:"_Paging_Label1", propertiesFactory:function () : Object
                {
                    return {verticalCenter:-5, horizontalCenter:0};
                }// end function
                }), new UIComponentDescriptor({type:Button, id:"btnNext", events:{click:"__btnNext_click"}, propertiesFactory:function () : Object
                {
                    return {styleName:"nextButton", labelPlacement:"left", right:5, verticalCenter:-5};
                }// end function
                }), new UIComponentDescriptor({type:Label, id:"_Paging_Label2", propertiesFactory:function () : Object
                {
                    return {verticalCenter:9, horizontalCenter:0};
                }// end function
                })]};
            }// end function
            });
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            var bindings:* = this._Paging_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_net_sprd_components_common_paging_PagingWatcherSetupUtil");
                var _loc_2:* = watcherSetupUtilClass;
                _loc_2.watcherSetupUtilClass["init"](null);
            }
            _watcherSetupUtil.setup(this, function (param1:String)
            {
                return target[param1];
            }// end function
            , function (param1:String)
            {
                return Paging[param1];
            }// end function
            , bindings, watchers);
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.addEventListener("initialize", this.___Paging_Canvas1_initialize);
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

        protected function init(param1:FlexEvent) : void
        {
            this.btnBack.enabled = false;
            this.btnNext.enabled = false;
            return;
        }// end function

        public function set dataProvider(param1:IPageable) : void
        {
            this._dataProvider = param1;
            return;
        }// end function

        private function nextPage(param1:MouseEvent = null) : void
        {
            if (this._dataProvider.currentPage < this._dataProvider.pageCount)
            {
                this._dataProvider.currentPage = this._dataProvider.currentPage + 1;
            }
            return;
        }// end function

        private function prevPage(param1:MouseEvent = null) : void
        {
            if (this._dataProvider.currentPage <= this._dataProvider.pageCount)
            {
            }
            if (this._dataProvider.currentPage > 1)
            {
                this._dataProvider.currentPage = this._dataProvider.currentPage - 1;
            }
            return;
        }// end function

        public function ___Paging_Canvas1_initialize(param1:FlexEvent) : void
        {
            this.init(param1);
            return;
        }// end function

        public function __btnBack_click(param1:MouseEvent) : void
        {
            this.prevPage(param1);
            return;
        }// end function

        public function __btnNext_click(param1:MouseEvent) : void
        {
            this.nextPage(param1);
            return;
        }// end function

        private function _Paging_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "universal.label_pagination_previous");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "btnBack.label");
            result[1] = new Binding(this, function () : Boolean
            {
                return _dataProvider.hasPreviousPage;
            }// end function
            , null, "btnBack.enabled");
            result[2] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "universal.label_pagination");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "_Paging_Label1.text");
            result[3] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "universal.label_pagination_next");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "btnNext.label");
            result[4] = new Binding(this, function () : Boolean
            {
                return _dataProvider.hasNextPage;
            }// end function
            , null, "btnNext.enabled");
            result[5] = new Binding(this, function () : String
            {
                var _loc_1:* = (_dataProvider.pageCount == 0 ? ("0") : (_dataProvider.currentPage.toString())) + "/" + _dataProvider.pageCount;
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "_Paging_Label2.text");
            return result;
        }// end function

        public function get btnBack() : Button
        {
            return this._205678947btnBack;
        }// end function

        public function set btnBack(param1:Button) : void
        {
            var _loc_2:* = this._205678947btnBack;
            if (_loc_2 !== param1)
            {
                this._205678947btnBack = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnBack", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get btnNext() : Button
        {
            return this._206040943btnNext;
        }// end function

        public function set btnNext(param1:Button) : void
        {
            var _loc_2:* = this._206040943btnNext;
            if (_loc_2 !== param1)
            {
                this._206040943btnNext = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnNext", _loc_2, param1));
                }
            }
            return;
        }// end function

        private function get _dataProvider() : IPageable
        {
            return this._1763739238_dataProvider;
        }// end function

        private function set _dataProvider(param1:IPageable) : void
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

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
        {
            Paging._watcherSetupUtil = param1;
            return;
        }// end function

    }
}
