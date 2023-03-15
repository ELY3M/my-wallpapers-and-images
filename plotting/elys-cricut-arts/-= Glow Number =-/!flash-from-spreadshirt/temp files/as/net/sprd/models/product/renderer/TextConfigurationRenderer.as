package net.sprd.models.product.renderer
{
    import flash.display.*;
    import flash.events.*;
    import net.sprd.common.actions.*;
    import net.sprd.common.collections.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.graphics.svg.*;
    import net.sprd.models.product.*;
    import net.sprd.models.product.texthandling.*;
    import net.sprd.text.*;

    public class TextConfigurationRenderer extends EventDispatcher implements IConfigurationRenderer
    {
        private var loadingFonts:ISet;
        private var loadingErrors:Boolean = false;
        private var configurationModel:IConfigurationModel;
        private static const log:ILogger = LogContext.getLogger(this);

        public function TextConfigurationRenderer(param1:IConfigurationModel)
        {
            this.loadingFonts = new SortedSet();
            this.configurationModel = param1;
            return;
        }// end function

        public function loadAssets() : void
        {
            var _loc_1:String;
            this.addFontAssets(SVGText(this.configurationModel.svgContent));
            if (this.checkLoadingComplete())
            {
                return;
            }
            for each (_loc_1 in this.loadingFonts.toArray().slice())
            {
                
                this.loadFont(_loc_1);
            }
            return;
        }// end function

        private function loadFont(param1:String) : void
        {
            var fontStyleId:* = param1;
            with ({})
            {
                {}.fontCompleteHandler = function (param1:ActionEvent) : void
            {
                loadingFonts.remove(fontStyleId);
                checkLoadingComplete();
                return;
            }// end function
            ;
            }
            with ({})
            {
                {}.fontFaultHandler = function (param1:ActionEvent) : void
            {
                loadingFonts.remove(fontStyleId);
                log.warn("Couldn\'t load font \'" + fontStyleId + "\'. ");
                loadingErrors = true;
                checkLoadingComplete();
                return;
            }// end function
            ;
            }
            FontManager.getInstance().loadFontAssetById(fontStyleId, function (param1:ActionEvent) : void
            {
                loadingFonts.remove(fontStyleId);
                checkLoadingComplete();
                return;
            }// end function
            , function (param1:ActionEvent) : void
            {
                loadingFonts.remove(fontStyleId);
                log.warn("Couldn\'t load font \'" + fontStyleId + "\'. ");
                loadingErrors = true;
                checkLoadingComplete();
                return;
            }// end function
            );
            return;
        }// end function

        private function checkLoadingComplete() : Boolean
        {
            if (this.loadingFonts.size == 0)
            {
                if (this.loadingErrors)
                {
                    dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
                }
                else
                {
                    dispatchEvent(new Event(Event.COMPLETE));
                }
                return true;
            }
            else
            {
                return false;
            }
        }// end function

        public function render() : Sprite
        {
            if (this.configurationModel.textFlow.flowComposer)
            {
            }
            if (this.configurationModel.textFlow.flowComposer.numControllers > 0)
            {
                return this.configurationModel.textFlow.flowComposer.getControllerAt(0).container;
            }
            TextFlowUtil.render(this.configurationModel.testTextFlow, this.configurationModel.width, this.configurationModel.height);
            return TextFlowUtil.render(this.configurationModel.textFlow, this.configurationModel.width, this.configurationModel.height);
        }// end function

        public function layers() : Array
        {
            return [];
        }// end function

        private function addFontAssets(param1:SVGText) : void
        {
            var _loc_2:SVGText;
            if (param1.fontID)
            {
                this.loadingFonts.add(param1.fontID);
            }
            for each (_loc_2 in param1.tspans)
            {
                
                this.addFontAssets(_loc_2);
            }
            return;
        }// end function

    }
}
