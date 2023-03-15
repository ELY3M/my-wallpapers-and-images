package net.sprd.components.designupload
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.states.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.components.common.*;
    import net.sprd.components.common.paging.*;
    import net.sprd.components.common.palette.*;
    import net.sprd.events.*;
    import net.sprd.services.localstorage.*;

    public class DesignUpload extends Canvas implements IBindingClient
    {
        public var _DesignUpload_Button1:Button;
        public var _DesignUpload_Button2:Button;
        public var _DesignUpload_Move1:Move;
        public var _DesignUpload_Move2:Move;
        public var _DesignUpload_Move3:Move;
        public var _DesignUpload_Move4:Move;
        public var _DesignUpload_Resize1:Resize;
        public var _DesignUpload_Resize2:Resize;
        private var _1833908542addImageBtn:Button;
        private var _2094019848btnPanel:Canvas;
        private var _1613953098designTileList:DesignTileList;
        private var _541975020legalSection:VBox;
        private var _529103266overTile:OverTile;
        private var _995747956paging:Paging;
        private var _798910853palette:Palette;
        private var _294458116restrictionTxt:TextArea;
        private var _1339673329tileFadeIn:Fade;
        private var _1419805860tileFadeOut:Fade;
        private var _1471891927txtLegal:TextArea;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;
        public var localStorage:ILocalStorage;
        public var model:DesignUploadModel;
        private var _isAvailable:Boolean;
        private var errorTip:ToolTip;
        private var legalTextFormatted:Boolean = false;
        private var restrictionTextFormatted:Boolean = false;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static const log:ILogger = LogContext.getLogger(this);
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function DesignUpload()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, events:{creationComplete:"___DesignUpload_Canvas1_creationComplete"}, propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Palette, id:"palette", propertiesFactory:function () : Object
                {
                    return {width:270, height:460, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", children:[_DesignUpload_Canvas2_i(), _DesignUpload_DesignTileList1_i(), _DesignUpload_Paging1_i()]};
                }// end function
                }), new UIComponentDescriptor({type:OverTile, id:"overTile", events:{rollOut:"__overTile_rollOut", click:"__overTile_click"}, effects:["showEffect", "hideEffect"], stylesFactory:function () : void
                {
                    this.showEffect = "tileFadeIn";
                    this.hideEffect = "tileFadeOut";
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {styleName:"tileOver", width:98, height:98, visible:false};
                }// end function
                })]};
            }// end function
            });
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            var bindings:* = this._DesignUpload_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_net_sprd_components_designupload_DesignUploadWatcherSetupUtil");
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
            this.minWidth = 290;
            this.clipContent = false;
            this.states = [this._DesignUpload_State1_c()];
            this.transitions = [this._DesignUpload_Transition1_c(), this._DesignUpload_Transition2_c()];
            this._DesignUpload_Fade1_i();
            this._DesignUpload_Fade2_i();
            this.addEventListener("creationComplete", this.___DesignUpload_Canvas1_creationComplete);
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

        public function init() : void
        {
            if (ConfomatConfiguration.shop)
            {
                this.available = ConfomatConfiguration.shopApplication.showDesignUpload;
            }
            EventUtil.registerOnetimeListeners(this.model, [DesignUploadEvent.DESIGNS_COMPLETE, DesignUploadEvent.DESIGNS_ERROR], [this.model_designsCompleteHandler, this.model_loadErrorHandler]);
            this.model.addEventListener("pageChanged", this.model_pageChangedHandler);
            this.model.initialize();
            currentState = this.localStorage.agreedUploadDisclaimer ? ("") : ("legalDisclaimer");
            return;
        }// end function

        public function get pagingProvider() : IPageable
        {
            return this.model;
        }// end function

        private function set _1022741091pagingProvider(param1:IPageable) : void
        {
            return;
        }// end function

        protected function onItemClick(param1:ListEvent) : void
        {
            this.model.addDesignToProduct(DesignInfo(UploadedDesignRenderer(param1.itemRenderer).data));
            return;
        }// end function

        protected function onOverTileClick(param1:MouseEvent) : void
        {
            this.model.addDesignToProduct(OverTile(param1.currentTarget).dataProvider);
            return;
        }// end function

        protected function onItemOver(param1:ListEvent) : void
        {
            var _loc_2:DesignInfo;
            var _loc_3:Point;
            _loc_2 = DesignInfo(UploadedDesignRenderer(param1.itemRenderer).data);
            if (_loc_2.isUpLoading)
            {
                return;
            }
            if (!_loc_2.constraints.isUsable)
            {
                this.overTile.endEffectsStarted();
                this.overTile.visible = false;
                this.resetTips();
                _loc_3 = UploadedDesignRenderer(param1.itemRenderer).getBounds(this).bottomRight;
                _loc_3.x = _loc_3.x - param1.itemRenderer.width / 2;
                _loc_3 = localToGlobal(_loc_3);
                this.errorTip = ToolTipManager.createToolTip(_loc_2.constraints.toString(), _loc_3.x, _loc_3.y, "errorTipBelow") as ToolTip;
                return;
            }
            this.overTile.dataProvider = _loc_2;
            this.overTile.x = param1.itemRenderer.x + this.designTileList.x - 4;
            this.overTile.y = param1.itemRenderer.y + this.designTileList.y - 4;
            this.overTile.endEffectsStarted();
            this.overTile.visible = true;
            return;
        }// end function

        protected function onItemOut(param1:ListEvent) : void
        {
            this.resetTips();
            return;
        }// end function

        protected function onTileOut(param1:MouseEvent) : void
        {
            var _loc_2:Boolean;
            var _loc_4:DisplayObject;
            var _loc_3:* = getObjectsUnderPoint(new Point(param1.stageX, param1.stageY));
            if (_loc_3.length > 0)
            {
                for each (_loc_4 in _loc_3)
                {
                    
                    if (_loc_4 is UploadedDesignRenderer)
                    {
                        _loc_2 = true;
                        break;
                    }
                }
            }
            this.overTile.endEffectsStarted();
            this.overTile.visible = _loc_2;
            return;
        }// end function

        protected function onUploadClick(param1:MouseEvent) : void
        {
            var _loc_2:FileReference;
            if (!this.localStorage.agreedUploadDisclaimer)
            {
                currentState = "legalDisclaimer";
            }
            else
            {
                currentState = "";
                _loc_2 = new FileReference();
                _loc_2.addEventListener(Event.SELECT, this.file_selectedHandler);
                _loc_2.browse([new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg;*.jpeg;*.gif;*.png")]);
            }
            return;
        }// end function

        protected function agreeTNC(param1:MouseEvent) : void
        {
            this.localStorage.agreedUploadDisclaimer = true;
            this.onUploadClick(null);
            return;
        }// end function

        private function set available(param1:Boolean)
        {
            this._isAvailable = param1;
            if (!param1)
            {
                dispatchEvent(new ApplicationEvent(ApplicationEvent.COMPONENT_UNAVAILABLE, true));
            }
            return;
        }// end function

        public function updateAvailability() : void
        {
            var _loc_1:DesignInfo;
            if (!this.model)
            {
                return;
            }
            for each (_loc_1 in this.model.designs)
            {
                
                _loc_1.constraints = this.model.canAddDesign(_loc_1.design);
            }
            invalidateDisplayList();
            this.designTileList.invalidateList();
            return;
        }// end function

        private function resetTips() : void
        {
            if (this.errorTip)
            {
                ToolTipManager.destroyToolTip(this.errorTip);
                this.errorTip = null;
            }
            return;
        }// end function

        private function model_pageChangedHandler(param1:Event) : void
        {
            this.updateAvailability();
            this.designTileList.dataProvider = this.model.designs;
            return;
        }// end function

        private function model_designsCompleteHandler(param1:Event) : void
        {
            dispatchEvent(new ApplicationEvent(ApplicationEvent.COMPONENT_COMPLETE, true));
            this.pagingProvider = null;
            return;
        }// end function

        private function model_loadErrorHandler(param1:Event) : void
        {
            return;
        }// end function

        private function file_selectedHandler(param1:Event) : void
        {
            var file:FileReference;
            var event:* = param1;
            file = FileReference(event.target);
            EventUtil.registerOnetimeListeners(file, [Event.COMPLETE], [function () : void
            {
                model.upload(file);
                return;
            }// end function
            ]);
            file.load();
            return;
        }// end function

        private function creationCompleteHandler(param1:FlexEvent) : void
        {
            var event:* = param1;
            with ({})
            {
                {}.close = function (param1:MouseEvent) : void
            {
                endEffectsStarted();
                visible = false;
                return;
            }// end function
            ;
            }
            this.palette.closeButton.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent) : void
            {
                endEffectsStarted();
                visible = false;
                return;
            }// end function
            );
            return;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            var tmr:Timer;
            var count:int;
            var value:* = param1;
            super.visible = value;
            if (value)
            {
                if (true)
                {
                }
            }
            if (this.restrictionTxt)
            {
                if (this.legalTextFormatted)
                {
                }
            }
            if (!this.restrictionTextFormatted)
            {
                tmr = new Timer(200, 50);
                count;
                with ({})
                {
                    {}.timer = function (param1:TimerEvent) : void
            {
                count++;
                if (txtLegal)
                {
                }
                if (!legalTextFormatted)
                {
                    txtLegal.htmlText = resourceManager.getString("confomat7", "upload_gallery.description_legal_advise");
                }
                if (restrictionTxt)
                {
                }
                if (!restrictionTextFormatted)
                {
                    restrictionTxt.htmlText = resourceManager.getString("confomat7", "upload_gallery.description_file_restrictions");
                }
                if (txtLegal)
                {
                }
                if (txtLegal.textWidth > 200)
                {
                    legalTextFormatted = true;
                }
                if (restrictionTxt)
                {
                }
                if (restrictionTxt.textWidth > 100)
                {
                    restrictionTextFormatted = true;
                }
                if (count < 50)
                {
                    if (legalTextFormatted)
                    {
                    }
                }
                if (restrictionTextFormatted)
                {
                    tmr.stop();
                    tmr.removeEventListener(param1.type, _loc_2.callee);
                }
                return;
            }// end function
            ;
                }
                tmr.addEventListener(TimerEvent.TIMER, function (param1:TimerEvent) : void
            {
                count++;
                if (txtLegal)
                {
                }
                if (!legalTextFormatted)
                {
                    txtLegal.htmlText = resourceManager.getString("confomat7", "upload_gallery.description_legal_advise");
                }
                if (restrictionTxt)
                {
                }
                if (!restrictionTextFormatted)
                {
                    restrictionTxt.htmlText = resourceManager.getString("confomat7", "upload_gallery.description_file_restrictions");
                }
                if (txtLegal)
                {
                }
                if (txtLegal.textWidth > 200)
                {
                    legalTextFormatted = true;
                }
                if (restrictionTxt)
                {
                }
                if (restrictionTxt.textWidth > 100)
                {
                    restrictionTextFormatted = true;
                }
                if (count < 50)
                {
                    if (legalTextFormatted)
                    {
                    }
                }
                if (restrictionTextFormatted)
                {
                    tmr.stop();
                    tmr.removeEventListener(param1.type, _loc_2.callee);
                }
                return;
            }// end function
            );
                tmr.start();
            }
            return;
        }// end function

        private function _DesignUpload_Fade1_i() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaFrom = 0;
            _loc_1.alphaTo = 1;
            _loc_1.addEventListener("effectStart", this.__tileFadeIn_effectStart);
            this.tileFadeIn = _loc_1;
            BindingManager.executeBindings(this, "tileFadeIn", this.tileFadeIn);
            return _loc_1;
        }// end function

        public function __tileFadeIn_effectStart(param1:EffectEvent) : void
        {
            DisplayObject(param1.effectInstance.mx.effects:IEffectInstance::target).visible = true;
            return;
        }// end function

        private function _DesignUpload_Fade2_i() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaFrom = 1;
            _loc_1.alphaTo = 0;
            this.tileFadeOut = _loc_1;
            BindingManager.executeBindings(this, "tileFadeOut", this.tileFadeOut);
            return _loc_1;
        }// end function

        private function _DesignUpload_State1_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "legalDisclaimer";
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _DesignUpload_Transition1_c() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "*";
            _loc_1.toState = "legalDisclaimer";
            _loc_1.effect = this._DesignUpload_Parallel1_c();
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _DesignUpload_Parallel1_c() : Parallel
        {
            var _loc_1:* = new Parallel();
            _loc_1.children = [this._DesignUpload_Resize1_i(), this._DesignUpload_Move1_i(), this._DesignUpload_Move2_i()];
            _loc_1.addEventListener("effectStart", this.___DesignUpload_Parallel1_effectStart);
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _DesignUpload_Resize1_i() : Resize
        {
            var _loc_1:* = new Resize();
            _loc_1.heightBy = 385;
            this._DesignUpload_Resize1 = _loc_1;
            BindingManager.executeBindings(this, "_DesignUpload_Resize1", this._DesignUpload_Resize1);
            return _loc_1;
        }// end function

        private function _DesignUpload_Move1_i() : Move
        {
            var _loc_1:* = new Move();
            _loc_1.yBy = 385;
            this._DesignUpload_Move1 = _loc_1;
            BindingManager.executeBindings(this, "_DesignUpload_Move1", this._DesignUpload_Move1);
            return _loc_1;
        }// end function

        private function _DesignUpload_Move2_i() : Move
        {
            var _loc_1:* = new Move();
            _loc_1.yBy = 415;
            this._DesignUpload_Move2 = _loc_1;
            BindingManager.executeBindings(this, "_DesignUpload_Move2", this._DesignUpload_Move2);
            return _loc_1;
        }// end function

        public function ___DesignUpload_Parallel1_effectStart(param1:EffectEvent) : void
        {
            this.clipContent = true;
            return;
        }// end function

        private function _DesignUpload_Transition2_c() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "legalDisclaimer";
            _loc_1.toState = "*";
            _loc_1.effect = this._DesignUpload_Parallel2_c();
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _DesignUpload_Parallel2_c() : Parallel
        {
            var _loc_1:* = new Parallel();
            _loc_1.children = [this._DesignUpload_Resize2_i(), this._DesignUpload_Move3_i(), this._DesignUpload_Move4_i()];
            _loc_1.addEventListener("effectEnd", this.___DesignUpload_Parallel2_effectEnd);
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _DesignUpload_Resize2_i() : Resize
        {
            var _loc_1:* = new Resize();
            _loc_1.heightBy = -385;
            this._DesignUpload_Resize2 = _loc_1;
            BindingManager.executeBindings(this, "_DesignUpload_Resize2", this._DesignUpload_Resize2);
            return _loc_1;
        }// end function

        private function _DesignUpload_Move3_i() : Move
        {
            var _loc_1:* = new Move();
            _loc_1.yBy = -385;
            this._DesignUpload_Move3 = _loc_1;
            BindingManager.executeBindings(this, "_DesignUpload_Move3", this._DesignUpload_Move3);
            return _loc_1;
        }// end function

        private function _DesignUpload_Move4_i() : Move
        {
            var _loc_1:* = new Move();
            _loc_1.yBy = -415;
            this._DesignUpload_Move4 = _loc_1;
            BindingManager.executeBindings(this, "_DesignUpload_Move4", this._DesignUpload_Move4);
            return _loc_1;
        }// end function

        public function ___DesignUpload_Parallel2_effectEnd(param1:EffectEvent) : void
        {
            this.clipContent = false;
            return;
        }// end function

        public function ___DesignUpload_Canvas1_creationComplete(param1:FlexEvent) : void
        {
            this.creationCompleteHandler(param1);
            return;
        }// end function

        private function _DesignUpload_Canvas2_i() : Canvas
        {
            var temp:* = new Canvas();
            temp.styleName = "functionGroup";
            temp.height = 112;
            temp.left = 1;
            temp.right = 1;
            temp.y = 35;
            temp.verticalScrollPolicy = "off";
            temp.id = "btnPanel";
            if (!temp.document)
            {
                temp.document = this;
            }
            mx_internal::_documentDescriptor = new UIComponentDescriptor({type:Canvas, id:"btnPanel", propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:VBox, id:"legalSection", stylesFactory:function () : void
                {
                    this.horizontalAlign = "center";
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {y:-365, x:20, childDescriptors:[new UIComponentDescriptor({type:TextArea, id:"txtLegal", stylesFactory:function () : void
                    {
                        this.borderThickness = 0;
                        this.backgroundAlpha = 0;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {htmlText:"", width:230, height:300, condenseWhite:true, wordWrap:true, editable:false, horizontalScrollPolicy:"off", verticalScrollPolicy:"off"};
                    }// end function
                    }), new UIComponentDescriptor({type:HBox, propertiesFactory:function () : Object
                    {
                        return {childDescriptors:[new UIComponentDescriptor({type:Button, id:"_DesignUpload_Button1", events:{click:"___DesignUpload_Button1_click"}, propertiesFactory:function () : Object
                        {
                            return {styleName:"formButton"};
                        }// end function
                        }), new UIComponentDescriptor({type:Button, id:"_DesignUpload_Button2", events:{click:"___DesignUpload_Button2_click"}, propertiesFactory:function () : Object
                        {
                            return {styleName:"formButton"};
                        }// end function
                        })]};
                    }// end function
                    })]};
                }// end function
                }), new UIComponentDescriptor({type:TextArea, id:"restrictionTxt", stylesFactory:function () : void
                {
                    this.borderThickness = 0;
                    this.backgroundAlpha = 0;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {width:230, condenseWhite:true, height:100, editable:false, wordWrap:true, horizontalScrollPolicy:"off", verticalScrollPolicy:"off", y:5};
                }// end function
                }), new UIComponentDescriptor({type:Button, id:"addImageBtn", events:{click:"__addImageBtn_click"}, propertiesFactory:function () : Object
                {
                    return {bottom:15};
                }// end function
                })]};
            }// end function
            });
            mx_internal::_documentDescriptor.document = this;
            this.btnPanel = temp;
            BindingManager.executeBindings(this, "btnPanel", this.btnPanel);
            return temp;
        }// end function

        public function ___DesignUpload_Button1_click(param1:MouseEvent) : void
        {
            this.agreeTNC(param1);
            return;
        }// end function

        public function ___DesignUpload_Button2_click(param1:MouseEvent) : void
        {
            this.visible = false;
            return;
        }// end function

        public function __addImageBtn_click(param1:MouseEvent) : void
        {
            this.onUploadClick(param1);
            return;
        }// end function

        private function _DesignUpload_DesignTileList1_i() : DesignTileList
        {
            var _loc_1:* = new DesignTileList();
            _loc_1.columnCount = 3;
            _loc_1.rowCount = 3;
            _loc_1.height = 270;
            _loc_1.width = 270;
            _loc_1.y = 155;
            _loc_1.x = 1;
            _loc_1.rowHeight = 90;
            _loc_1.columnWidth = 90;
            _loc_1.itemRenderer = this._DesignUpload_ClassFactory1_c();
            _loc_1.setStyle("backgroundAlpha", 0);
            _loc_1.setStyle("borderStyle", "none");
            _loc_1.addEventListener("itemClick", this.__designTileList_itemClick);
            _loc_1.addEventListener("itemRollOver", this.__designTileList_itemRollOver);
            _loc_1.addEventListener("itemRollOut", this.__designTileList_itemRollOut);
            _loc_1.id = "designTileList";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this.designTileList = _loc_1;
            BindingManager.executeBindings(this, "designTileList", this.designTileList);
            return _loc_1;
        }// end function

        private function _DesignUpload_ClassFactory1_c() : ClassFactory
        {
            var _loc_1:* = new ClassFactory();
            _loc_1.generator = UploadedDesignRenderer;
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        public function __designTileList_itemClick(param1:ListEvent) : void
        {
            this.onItemClick(param1);
            return;
        }// end function

        public function __designTileList_itemRollOver(param1:ListEvent) : void
        {
            this.onItemOver(param1);
            return;
        }// end function

        public function __designTileList_itemRollOut(param1:ListEvent) : void
        {
            this.onItemOut(param1);
            return;
        }// end function

        private function _DesignUpload_Paging1_i() : Paging
        {
            var _loc_1:* = new Paging();
            _loc_1.width = 270;
            _loc_1.height = 30;
            _loc_1.setStyle("backgroundAlpha", 0);
            _loc_1.id = "paging";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this.paging = _loc_1;
            BindingManager.executeBindings(this, "paging", this.paging);
            return _loc_1;
        }// end function

        public function __overTile_rollOut(param1:MouseEvent) : void
        {
            this.onTileOut(param1);
            return;
        }// end function

        public function __overTile_click(param1:MouseEvent) : void
        {
            this.onOverTileClick(param1);
            return;
        }// end function

        private function _DesignUpload_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, null, null, "_DesignUpload_Resize1.target", "btnPanel");
            result[1] = new Binding(this, function () : Array
            {
                var _loc_1:*;
                if (_loc_1 != null)
                {
                }
                if (!(_loc_1 is Array))
                {
                }
                return _loc_1 is Proxy ? (_loc_1) : ([_loc_1]);
            }// end function
            , null, "_DesignUpload_Move1.targets");
            result[2] = new Binding(this, function () : Array
            {
                var _loc_1:*;
                if (_loc_1 != null)
                {
                }
                if (!(_loc_1 is Array))
                {
                }
                return _loc_1 is Proxy ? (_loc_1) : ([_loc_1]);
            }// end function
            , null, "_DesignUpload_Move2.targets");
            result[3] = new Binding(this, null, null, "_DesignUpload_Resize2.target", "btnPanel");
            result[4] = new Binding(this, function () : Array
            {
                var _loc_1:*;
                if (_loc_1 != null)
                {
                }
                if (!(_loc_1 is Array))
                {
                }
                return _loc_1 is Proxy ? (_loc_1) : ([_loc_1]);
            }// end function
            , null, "_DesignUpload_Move3.targets");
            result[5] = new Binding(this, function () : Array
            {
                var _loc_1:*;
                if (_loc_1 != null)
                {
                }
                if (!(_loc_1 is Array))
                {
                }
                return _loc_1 is Proxy ? (_loc_1) : ([_loc_1]);
            }// end function
            , null, "_DesignUpload_Move4.targets");
            result[6] = new Binding(this, function () : Number
            {
                return FXDefaults.FADE_DURATION;
            }// end function
            , null, "tileFadeIn.duration");
            result[7] = new Binding(this, function () : Number
            {
                return FXDefaults.FADE_DURATION;
            }// end function
            , null, "tileFadeOut.duration");
            result[8] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "upload_gallery.label_section_header");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "palette.caption");
            result[9] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "universal.proceed");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "_DesignUpload_Button1.label");
            result[10] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "universal.cancel");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "_DesignUpload_Button2.label");
            result[11] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "upload_gallery.description_file_restrictions");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "restrictionTxt.htmlText");
            result[12] = new Binding(this, function () : String
            {
                var _loc_1:* = resourceManager.getString("confomat7", "main_navi.btn_upload_photos");
                return _loc_1 == undefined ? (null) : (String(_loc_1));
            }// end function
            , null, "addImageBtn.label");
            result[13] = new Binding(this, function () : Number
            {
                return (btnPanel.width - addImageBtn.width) / 2;
            }// end function
            , null, "addImageBtn.x");
            result[14] = new Binding(this, null, null, "paging.dataProvider", "pagingProvider");
            result[15] = new Binding(this, function () : Number
            {
                return designTileList.y + designTileList.height;
            }// end function
            , null, "paging.y");
            return result;
        }// end function

        public function get addImageBtn() : Button
        {
            return this._1833908542addImageBtn;
        }// end function

        public function set addImageBtn(param1:Button) : void
        {
            var _loc_2:* = this._1833908542addImageBtn;
            if (_loc_2 !== param1)
            {
                this._1833908542addImageBtn = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "addImageBtn", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get btnPanel() : Canvas
        {
            return this._2094019848btnPanel;
        }// end function

        public function set btnPanel(param1:Canvas) : void
        {
            var _loc_2:* = this._2094019848btnPanel;
            if (_loc_2 !== param1)
            {
                this._2094019848btnPanel = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnPanel", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get designTileList() : DesignTileList
        {
            return this._1613953098designTileList;
        }// end function

        public function set designTileList(param1:DesignTileList) : void
        {
            var _loc_2:* = this._1613953098designTileList;
            if (_loc_2 !== param1)
            {
                this._1613953098designTileList = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "designTileList", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get legalSection() : VBox
        {
            return this._541975020legalSection;
        }// end function

        public function set legalSection(param1:VBox) : void
        {
            var _loc_2:* = this._541975020legalSection;
            if (_loc_2 !== param1)
            {
                this._541975020legalSection = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "legalSection", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get overTile() : OverTile
        {
            return this._529103266overTile;
        }// end function

        public function set overTile(param1:OverTile) : void
        {
            var _loc_2:* = this._529103266overTile;
            if (_loc_2 !== param1)
            {
                this._529103266overTile = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "overTile", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get paging() : Paging
        {
            return this._995747956paging;
        }// end function

        public function set paging(param1:Paging) : void
        {
            var _loc_2:* = this._995747956paging;
            if (_loc_2 !== param1)
            {
                this._995747956paging = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "paging", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get palette() : Palette
        {
            return this._798910853palette;
        }// end function

        public function set palette(param1:Palette) : void
        {
            var _loc_2:* = this._798910853palette;
            if (_loc_2 !== param1)
            {
                this._798910853palette = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "palette", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get restrictionTxt() : TextArea
        {
            return this._294458116restrictionTxt;
        }// end function

        public function set restrictionTxt(param1:TextArea) : void
        {
            var _loc_2:* = this._294458116restrictionTxt;
            if (_loc_2 !== param1)
            {
                this._294458116restrictionTxt = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "restrictionTxt", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get tileFadeIn() : Fade
        {
            return this._1339673329tileFadeIn;
        }// end function

        public function set tileFadeIn(param1:Fade) : void
        {
            var _loc_2:* = this._1339673329tileFadeIn;
            if (_loc_2 !== param1)
            {
                this._1339673329tileFadeIn = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tileFadeIn", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get tileFadeOut() : Fade
        {
            return this._1419805860tileFadeOut;
        }// end function

        public function set tileFadeOut(param1:Fade) : void
        {
            var _loc_2:* = this._1419805860tileFadeOut;
            if (_loc_2 !== param1)
            {
                this._1419805860tileFadeOut = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tileFadeOut", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get txtLegal() : TextArea
        {
            return this._1471891927txtLegal;
        }// end function

        public function set txtLegal(param1:TextArea) : void
        {
            var _loc_2:* = this._1471891927txtLegal;
            if (_loc_2 !== param1)
            {
                this._1471891927txtLegal = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "txtLegal", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function set pagingProvider(param1:IPageable) : void
        {
            var _loc_2:* = this.pagingProvider;
            if (_loc_2 !== param1)
            {
                this._1022741091pagingProvider = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pagingProvider", _loc_2, param1));
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
