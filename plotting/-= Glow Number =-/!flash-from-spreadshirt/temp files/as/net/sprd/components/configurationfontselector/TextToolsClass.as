package net.sprd.components.configurationfontselector
{
    import flash.events.*;
    import flash.text.engine.*;
    import flashx.textLayout.edit.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.events.*;
    import flashx.textLayout.formats.*;
    import mx.controls.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.styles.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.components.common.toolpanel.*;
    import net.sprd.entities.*;
    import net.sprd.events.*;
    import net.sprd.models.product.*;
    import net.sprd.models.product.texthandling.*;
    import net.sprd.text.*;

    public class TextToolsClass extends ToolPanel
    {
        public var bus:IEventDispatcher;
        public var fontFamilyCombo:ComboBox;
        public var fontWeightButton:Button;
        public var fontStyleButton:Button;
        public var fontSizeCombo:ComboBox;
        public var alignLeftButton:Button;
        public var alignCenterButton:Button;
        public var alignRightButton:Button;
        private var _configuration:IConfigurationModel;
        private var configurationChanged:Boolean;
        private var textSelectionChanged:Boolean;
        private var selectionState:SelectionState;
        private var cursorId:uint;
        private var configurationTransformed:Boolean;
        private static const log:ILogger = LogContext.getLogger(this);

        public function TextToolsClass()
        {
            return;
        }// end function

        protected function initFonts(param1:FlexEvent) : void
        {
            FontManager.getInstance().loadFontFamilies(this.fontsCompleteHandler, this.fontsFaultHandler);
            return;
        }// end function

        public function get textFlow() : TextFlow
        {
            return this._configuration ? (this._configuration.textFlow) : (null);
        }// end function

        public function get configuration() : IConfigurationModel
        {
            return this._configuration;
        }// end function

        public function set configuration(param1:IConfigurationModel) : void
        {
            if (this._configuration == param1)
            {
                return;
            }
            this._configuration = param1;
            if (this._configuration)
            {
                this.textFlow.addEventListener(SelectionEvent.SELECTION_CHANGE, this.onTextSelectionChanged);
            }
            this.configurationChanged = true;
            invalidateProperties();
            return;
        }// end function

        private function updateControls() : void
        {
            var charFormat:ITextLayoutFormat;
            var newIntegerSize:int;
            var fm:FontManager;
            var font:IFontFamily;
            if (this._configuration)
            {
            }
            if (!this.textFlow)
            {
                return;
            }
            if (!this.selectionState)
            {
                if (this.textFlow.interactionManager)
                {
                    this.selectionState = this.textFlow.interactionManager.getSelectionState();
                }
            }
            var minSize:* = Math.ceil(this._configuration.getMinimumFontSize());
            var maxSize:* = Math.floor(this._configuration.getMaximumFontSize());
            var size:* = Math.max(minSize, 1);
            var integerSize:* = minSize;
            var dataProvider:Array;
            while (size < maxSize)
            {
                
                size = size * 1.1;
                newIntegerSize = Math.floor(size);
                if (newIntegerSize > integerSize)
                {
                    dataProvider.push(newIntegerSize);
                    integerSize = newIntegerSize;
                }
            }
            this.fontSizeCombo.dataProvider = dataProvider;
            charFormat = this.textFlow.interactionManager.getCommonCharacterFormat();
            if (charFormat)
            {
                this.fontWeightButton.selected = charFormat.fontWeight == FontWeight.BOLD;
                this.fontStyleButton.selected = charFormat.fontStyle == FontPosture.ITALIC;
                callLater(function () : void
            {
                if (charFormat.fontSize)
                {
                    fontSizeCombo.text = Number(charFormat.fontSize).toFixed(1);
                }
                else
                {
                    fontSizeCombo.text = "";
                }
                return;
            }// end function
            );
                if (charFormat.fontFamily)
                {
                    fm = FontManager.getInstance();
                    font = fm.getFontFamilyFromEmbbededName(charFormat.fontFamily);
                    this.fontFamilyCombo.selectedItem = font;
                    if (true)
                    {
                        fm.hasFontStyle(font, true, false);
                    }
                    this.fontWeightButton.enabled = fm.hasFontStyle(font, true, true);
                    if (true)
                    {
                        fm.hasFontStyle(font, false, true);
                    }
                    this.fontStyleButton.enabled = fm.hasFontStyle(font, true, true);
                }
                else
                {
                    this.fontFamilyCombo.selectedItem = null;
                }
            }
            var paragraphFormat:* = this.textFlow.interactionManager.getCommonParagraphFormat();
            if (paragraphFormat)
            {
                this.alignLeftButton.selected = paragraphFormat.textAlign == TextAlign.LEFT;
                this.alignCenterButton.selected = paragraphFormat.textAlign == TextAlign.CENTER;
                this.alignRightButton.selected = paragraphFormat.textAlign == TextAlign.RIGHT;
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.configurationChanged)
            {
                this.configurationChanged = false;
                this.updateControls();
            }
            if (this.textSelectionChanged)
            {
                this.textSelectionChanged = false;
                this.updateControls();
            }
            if (this.configurationTransformed)
            {
                this.configurationTransformed = false;
                this.updateControls();
            }
            return;
        }// end function

        protected function onTextSelectionChanged(param1:SelectionEvent) : void
        {
            this.selectionState = param1.selectionState;
            this.textSelectionChanged = true;
            invalidateProperties();
            return;
        }// end function

        protected function onFontChange(param1:Event) : void
        {
            var _loc_6:IFontStyle;
            var _loc_7:TextLayoutFormat;
            var _loc_8:SelectionState;
            if (param1.currentTarget is Button)
            {
                Button(param1.currentTarget).selected = !Button(param1.currentTarget).selected;
            }
            var _loc_2:* = this.fontWeightButton.selected;
            var _loc_3:* = this.fontStyleButton.selected;
            var _loc_4:* = FontManager.getInstance();
            var _loc_5:* = IFontFamily(this.fontFamilyCombo.selectedItem);
            if (!_loc_4.hasFontStyle(_loc_5, _loc_2, _loc_3))
            {
                _loc_6 = _loc_4.getDefaultStyle(_loc_5);
                _loc_2 = _loc_6.weight == "bold";
                this.fontWeightButton.selected = _loc_2;
                _loc_3 = _loc_6.style == "italic";
                this.fontStyleButton.selected = _loc_3;
            }
            if (!_loc_4.isEmbeddedFontLoaded(_loc_5, _loc_2, _loc_3))
            {
                this.cursorId = CursorManager.setCursor(StyleManager.getStyleDeclaration("CursorManager").getStyle("busyCursor"), CursorManagerPriority.HIGH);
                _loc_4.loadFontAsset(_loc_5, this.fontWeightButton.selected, this.fontStyleButton.selected, this.onFontChange);
            }
            else
            {
                CursorManager.removeCursor(this.cursorId);
                _loc_7 = new TextLayoutFormat();
                _loc_7.fontWeight = this.fontWeightButton.selected ? (FontWeight.BOLD) : (FontWeight.NORMAL);
                _loc_7.fontStyle = this.fontStyleButton.selected ? (FontPosture.ITALIC) : (FontPosture.NORMAL);
                _loc_7.fontFamily = this.fontFamilyCombo.selectedItem.getEmbeddedFontName();
                _loc_8 = this.textFlow.interactionManager.getSelectionState();
                if (_loc_8.absoluteEnd == _loc_8.absoluteStart)
                {
                    _loc_8 = new SelectionState(this.textFlow, 0, this.textFlow.textLength);
                }
                IEditManager(this.textFlow.interactionManager).applyLeafFormat(_loc_7, _loc_8);
                this.textFlow.interactionManager.setFocus();
                this.updateControls();
            }
            this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.FONT_CHANGED, this._configuration));
            this.textFlow.interactionManager.setFocus();
            return;
        }// end function

        protected function onFontSizeChange(param1:Event) : void
        {
            var newValue:Number;
            var event:* = param1;
            var selection:* = this.textFlow.interactionManager.getSelectionState();
            if (selection.absoluteStart == selection.absoluteEnd)
            {
                selection = new SelectionState(this.textFlow, 0, this.textFlow.textLength);
            }
            if (event is DropdownEvent)
            {
                newValue = event.currentTarget.selectedItem;
            }
            else
            {
                newValue = parseFloat(this.fontSizeCombo.text);
            }
            if (isNaN(newValue))
            {
                return;
            }
            var format:* = new TextLayoutFormat();
            if (this._configuration.product.productTypeID != "125")
            {
            }
            if (this._configuration.product.productTypeID != "126")
            {
            }
            if (this._configuration.product.productTypeID == "127")
            {
                format.fontSize = Math.max(5, newValue);
            }
            else
            {
                format.fontSize = TextFlowUtil.computeEffectiveMinimumFontSize(this.textFlow, selection, newValue);
            }
            this._configuration.textOperationStrategy.decreaseFontSize = false;
            this._configuration.textOperationStrategy.checkMaxBounds = true;
            this._configuration.textOperationStrategy.collisionAllowed = true;
            this._configuration.textOperationStrategy.adjustY = false;
            IEditManager(this.textFlow.interactionManager).applyLeafFormat(format, selection);
            finally
            {
                var _loc_3:* = new catch0;
                throw null;
            }
            finally
            {
                this._configuration.textOperationStrategy.decreaseFontSize = true;
                this._configuration.textOperationStrategy.checkMaxBounds = false;
                this._configuration.textOperationStrategy.collisionAllowed = true;
                this._configuration.textOperationStrategy.adjustY = true;
            }
            this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.FONT_CHANGED, this._configuration));
            this.textFlow.flowComposer.updateAllControllers();
            this.textFlow.interactionManager.setFocus();
            return;
        }// end function

        protected function onAlignmentChange(param1:MouseEvent) : void
        {
            this.alignLeftButton.selected = false;
            this.alignCenterButton.selected = false;
            this.alignRightButton.selected = false;
            Button(param1.currentTarget).selected = !Button(param1.currentTarget).selected;
            var _loc_2:* = new TextLayoutFormat();
            _loc_2.textAlign = Button(param1.currentTarget).data;
            IEditManager(this.textFlow.interactionManager).applyParagraphFormat(_loc_2);
            this.bus.dispatchEvent(new ConfigurationEvent(ConfigurationEvent.FONT_CHANGED, this._configuration));
            this.textFlow.interactionManager.setFocus();
            this.updateControls();
            return;
        }// end function

        private function fontsFaultHandler(param1:IOErrorEvent) : void
        {
            log.warn("Could not load font definitions");
            return;
        }// end function

        private function fontsCompleteHandler(param1:Event) : void
        {
            var event:* = param1;
            this.fontFamilyCombo.dataProvider = IQueryResult(event.target).items.filter(function (param1:IFontFamily, param2, param3) : Object
            {
                return !param1.deprecated;
            }// end function
            );
            return;
        }// end function

        public function bus_configurationTransformed(param1:Event) : void
        {
            this.configurationTransformed = true;
            invalidateProperties();
            return;
        }// end function

    }
}
