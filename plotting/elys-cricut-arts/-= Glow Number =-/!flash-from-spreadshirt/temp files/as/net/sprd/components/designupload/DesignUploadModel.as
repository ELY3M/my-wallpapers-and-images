package net.sprd.components.designupload
{
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import mx.resources.*;
    import net.sprd.api.*;
    import net.sprd.api.plan.*;
    import net.sprd.api.resource.*;
    import net.sprd.common.collections.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.components.common.*;
    import net.sprd.entities.*;
    import net.sprd.events.*;
    import net.sprd.models.basket.*;
    import net.sprd.models.product.*;
    import net.sprd.services.image.*;
    import net.sprd.services.localstorage.*;
    import net.sprd.services.statistics.*;

    public class DesignUploadModel extends EventDispatcher implements IPageable
    {
        public var localStorage:ILocalStorage;
        public var productModel:IProductModel;
        public var statistics:IStatistics;
        public var confomatError:ConfomatErrorDialog;
        public var bus:IEventDispatcher;
        private var initialized:Boolean;
        private var _currentPage:int = 0;
        private var _pages:Pages;
        private var _designs:INavigable;
        private static const log:ILogger = LogContext.getLogger(this);
        private static const ITEMS_PER_PAGE:uint = 9;
        private static const UPLOAD_CATEGORY_ID:String = "502";
        private static const TRACKING_TIMEOUT:Number = 30000;

        public function DesignUploadModel(param1:IEventDispatcher = null)
        {
            this._pages = new Pages(this._designs, ITEMS_PER_PAGE);
            this._designs = new ArrayList();
            super(param1);
            return;
        }// end function

        public function initialize() : void
        {
            if (this.initialized)
            {
                return;
            }
            this.loadDesigns();
            return;
        }// end function

        public function get designs() : Array
        {
            return this._designs.size > 0 ? (CollectionUtil.asArray(this._pages.get(this._currentPage - 1))) : ([]);
        }// end function

        public function upload(param1:FileReference) : void
        {
            var design:IDesign;
            var loadDesignEntityRetryCount:int;
            var httpStatus:int;
            var timeoutTimer:Timer;
            var info:DesignInfo;
            var file_uploadCompleteHandler:Function;
            var file_uploadErrorHandler:Function;
            var design_reloadCompleteHandler:Function;
            var file:* = param1;
            design = IDesign(API.em.create(APIRegistry.DESIGN));
            design.name = file.name;
            loadDesignEntityRetryCount;
            info = new DesignInfo(design);
            info.isUpLoading = true;
            info.fileReference = file;
            var design_saveCompleteHandler:* = function (param1:Event) : void
            {
                var designId:String;
                var e:* = param1;
                ArrayList(_designs).add(info);
                currentPage = Math.ceil(_designs.size / ITEMS_PER_PAGE);
                dispatchEvent(new Event("pageChanged"));
                designId = design.id;
                var uri:* = ImageService.getInstance().endPoint + "/v1/designs/" + designId.substring(1);
                var request:* = new URLRequest(ResourceUtil.signURI(uri, "PUT", API.rm.apiKey, API.rm.secret));
                EventUtil.registerOnetimeListeners(file, [Event.COMPLETE, IOErrorEvent.IO_ERROR, SecurityErrorEvent.SECURITY_ERROR], [file_uploadCompleteHandler, file_uploadErrorHandler, file_uploadErrorHandler]);
                file.addEventListener(HTTPStatusEvent.HTTP_STATUS, function (param1:HTTPStatusEvent) : void
                {
                    httpStatus = param1.status;
                    log.warn("Upload status of \'" + file.name + "\': " + param1.status);
                    return;
                }// end function
                );
                timeoutTimer = new Timer(TRACKING_TIMEOUT, 1);
                EventUtil.registerOnetimeListeners(timeoutTimer, [TimerEvent.TIMER_COMPLETE], [function (param1) : void
                {
                    var _loc_2:* = "Upload timeout, id = " + designId;
                    statistics.track(T.getGenericErrorEvent(TrackingErrorCodes.DESIGN_UPLOAD_TIMEOUT, _loc_2));
                    return;
                }// end function
                ]);
                timeoutTimer.start();
                file.upload(request, "upload_field");
                return;
            }// end function
            ;
            file_uploadCompleteHandler = function (param1:Event) : void
            {
                var event:* = param1;
                timeoutTimer.stop();
                info.isUpLoading = false;
                API.em.evict(design);
                var fetchPlan:* = APIRegistry.getFetchPlan(APIRegistry.DESIGN);
                fetchPlan.uniqueHash = true;
                with ({})
                {
                    {}.design_reloadErrorHandler = function (param1:Event) : void
                {
                    var _loc_2:String;
                    log.warn(_loc_2);
                    confomatError.error(ResourceManager.getInstance().getString("confomat7", "messages_system.error_uploading_design"), TrackingErrorCodes.DESIGN_RELOAD_ERROR, _loc_2);
                    return;
                }// end function
                ;
                }
                API.em.load(design.id, APIRegistry.DESIGN, design_reloadCompleteHandler, function (param1:Event) : void
                {
                    var _loc_2:String;
                    log.warn(_loc_2);
                    confomatError.error(ResourceManager.getInstance().getString("confomat7", "messages_system.error_uploading_design"), TrackingErrorCodes.DESIGN_RELOAD_ERROR, _loc_2);
                    return;
                }// end function
                , fetchPlan);
                return;
            }// end function
            ;
            file_uploadErrorHandler = function (param1:Event) : void
            {
                timeoutTimer.stop();
                info.isUpLoading = false;
                ArrayList(_designs).remove(info);
                currentPage = Math.ceil(_designs.size / ITEMS_PER_PAGE);
                dispatchEvent(new Event("pageChanged"));
                confomatError.error(ResourceManager.getInstance().getString("confomat7", "messages_system.error_uploading_design"), TrackingErrorCodes.DESIGN_UPLOAD_ERROR, "Http status:" + httpStatus + ", id: " + info.designId);
                log.warn("Design upload error: " + param1 + ", " + FileReference(param1.target).name);
                return;
            }// end function
            ;
            design_reloadCompleteHandler = function (param1:Event) : void
            {
                var message:String;
                var info:DesignInfo;
                var fetchPlan:IFetchPlan;
                var event:* = param1;
                var reloadedDesign:* = IDesign(event.target);
                if (reloadedDesign.width == 0)
                {
                    if (loadDesignEntityRetryCount == 0)
                    {
                        message = "Design width 0, id = " + reloadedDesign.id;
                        log.warn(message);
                        statistics.track(T.getGenericErrorEvent(TrackingErrorCodes.DESIGN_RELOAD_ZERO_WIDTH, message));
                    }
                    if (loadDesignEntityRetryCount > 3)
                    {
                        message = "Design could no be correctly reloaded after " + "upload, id = " + reloadedDesign.id;
                        log.warn(message);
                        confomatError.error(ResourceManager.getInstance().getString("confomat7", "messages_system.error_uploading_design"), TrackingErrorCodes.DESIGN_RELOAD_ZERO_WIDTH_NOT_FIXABLE, message);
                        return;
                    }
                    loadDesignEntityRetryCount++;
                    API.em.evict(reloadedDesign);
                    fetchPlan = APIRegistry.getFetchPlan(APIRegistry.DESIGN);
                    fetchPlan.uniqueHash = true;
                    with ({})
                    {
                        {}.design_reloadErrorHandler = function (param1:Event) : void
                {
                    var _loc_2:String;
                    log.warn(_loc_2);
                    confomatError.error(ResourceManager.getInstance().getString("confomat7", "messages_system.error_uploading_design"), TrackingErrorCodes.DESIGN_RELOAD_ERROR, _loc_2);
                    return;
                }// end function
                ;
                    }
                    API.em.load(reloadedDesign.id, APIRegistry.DESIGN, design_reloadCompleteHandler, function (param1:Event) : void
                {
                    var _loc_2:String;
                    log.warn(_loc_2);
                    confomatError.error(ResourceManager.getInstance().getString("confomat7", "messages_system.error_uploading_design"), TrackingErrorCodes.DESIGN_RELOAD_ERROR, _loc_2);
                    return;
                }// end function
                , fetchPlan);
                    return;
                }
                writeUploadedDesignsToLocalStorage();
                var _loc_3:int;
                var _loc_4:* = _designs;
                while (_loc_4 in _loc_3)
                {
                    
                    info = _loc_4[_loc_3];
                    if (info.design.id == reloadedDesign.id)
                    {
                        info.design = reloadedDesign;
                        info.constraints = canAddDesign(info.design);
                        addDesignToProduct(info);
                        dispatchEvent(new Event("pageChanged"));
                        info.dispatchEvent(new DesignUploadEvent(DesignUploadEvent.UPLOAD_COMPLETE));
                        break;
                    }
                }
                return;
            }// end function
            ;
            with ({})
            {
                {}.design_saveErrorHandler = function (param1:IOErrorEvent) : void
            {
                var _loc_2:* = param1.text + ", FileName: " + file.name;
                log.warn("Design could not be saved. " + _loc_2);
                confomatError.error(ResourceManager.getInstance().getString("confomat7", "messages_system.error_uploading_design"), TrackingErrorCodes.DESIGN_SAVE_ERROR, _loc_2);
                return;
            }// end function
            ;
            }
            API.em.save(design, design_saveCompleteHandler, function (param1:IOErrorEvent) : void
            {
                var _loc_2:* = param1.text + ", FileName: " + file.name;
                log.warn("Design could not be saved. " + _loc_2);
                confomatError.error(ResourceManager.getInstance().getString("confomat7", "messages_system.error_uploading_design"), TrackingErrorCodes.DESIGN_SAVE_ERROR, _loc_2);
                return;
            }// end function
            );
            return;
        }// end function

        public function get currentPage() : int
        {
            return this._currentPage;
        }// end function

        public function set currentPage(param1:int) : void
        {
            var _loc_2:* = this._pages.size;
            param1 = param1 > _loc_2 ? (_loc_2) : (param1);
            param1 = param1 < 1 ? (1) : (param1);
            if (param1 == this.currentPage)
            {
                return;
            }
            this._currentPage = param1;
            dispatchEvent(new Event("pageChanged"));
            return;
        }// end function

        public function get hasPreviousPage() : Boolean
        {
            return this._currentPage > 1;
        }// end function

        public function get hasNextPage() : Boolean
        {
            return this._currentPage < this._pages.size;
        }// end function

        public function get pageCount() : int
        {
            return this._pages.size;
        }// end function

        public function addDesignToProduct(param1:DesignInfo) : void
        {
            var design:* = param1;
            if (!design.constraints.isUsable)
            {
                log.warn("Design was not added to product after upload because of the " + "following constraints: " + design.constraints);
                return;
            }
            with ({})
            {
                {}.complete = function () : void
            {
                bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(productModel));
                return;
            }// end function
            ;
            }
            this.productModel.addDesignConfiguration(design.design, null, null, null, true, true, function () : void
            {
                bus.dispatchEvent(SnapShotEvent.createSnapShotEvent(productModel));
                return;
            }// end function
            );
            return;
        }// end function

        private function loadDesigns() : void
        {
            var _loc_1:* = ConfomatConfiguration.shopApplication.uploadMode;
            if (_loc_1 == UploadModeType.UPLOAD_MODE_COMMUNITY)
            {
                this.loadDesignsForCommunityMode();
            }
            if (_loc_1 == UploadModeType.UPLOAD_MODE_PRIVATE)
            {
                this.loadDesignsForPrivateMode();
            }
            return;
        }// end function

        private function loadDesignsForPrivateMode() : void
        {
            var storedDesigns:Array;
            var designID:String;
            var loadDesignsCompleteHandler:* = function (param1:Event) : void
            {
                rebuildDesignPages(storedDesigns);
                return;
            }// end function
            ;
            var batch:* = API.em.startBatch(loadDesignsCompleteHandler, this.loadDesignsErrorHandler);
            batch.allowsPartialError = true;
            storedDesigns;
            var _loc_2:int;
            var _loc_3:* = this.localStorage.uploadedDesigns;
            while (_loc_3 in _loc_2)
            {
                
                designID = _loc_3[_loc_2];
                storedDesigns.push(API.em.load(designID, APIRegistry.DESIGN));
            }
            API.em.commitBatch();
            return;
        }// end function

        private function loadDesignsForCommunityMode() : void
        {
            var loadDesignsCompleteHandler:* = function (param1:Event) : void
            {
                rebuildDesignPages(IQueryResult(param1.target).items);
                return;
            }// end function
            ;
            var plan:* = FetchPlan.lazyPlan();
            var query:* = Query.findAllInContext(APIRegistry.DESIGN, [API.rm.defaultContext, "designCategory"], [API.rm.defaultContextId, UPLOAD_CATEGORY_ID]);
            API.em.find(query, loadDesignsCompleteHandler, this.loadDesignsErrorHandler, plan);
            return;
        }// end function

        private function rebuildDesignPages(param1:Array) : void
        {
            var _loc_2:IDesign;
            this._designs = new ArrayList();
            for each (_loc_2 in param1)
            {
                
                if (_loc_2.state == EntityState.LOADED)
                {
                    ArrayList(this._designs).add(new DesignInfo(_loc_2));
                }
            }
            this.writeUploadedDesignsToLocalStorage();
            this._pages = new Pages(this._designs, ITEMS_PER_PAGE);
            this.currentPage = 1;
            if (!this.initialized)
            {
                dispatchEvent(new DesignUploadEvent(DesignUploadEvent.DESIGNS_COMPLETE));
                this.initialized = true;
            }
            return;
        }// end function

        private function loadDesignsErrorHandler(param1:Event) : void
        {
            log.warn("Retrieval of design upload category failed: " + param1);
            this.rebuildDesignPages([]);
            return;
        }// end function

        public function canAddDesign(param1:IDesign) : ConfigurationUsageConstraints
        {
            return this.productModel.canAddDesign(param1);
        }// end function

        private function writeUploadedDesignsToLocalStorage() : void
        {
            this.localStorage.uploadedDesigns = this._designs.toArray().slice(0, 100).map(function (param1:DesignInfo, param2:int, param3:Array) : String
            {
                return param1.design.id;
            }// end function
            );
            return;
        }// end function

    }
}
