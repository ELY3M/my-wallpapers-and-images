package net.sprd.models.product.texthandling
{
    import flash.display.*;
    import flash.geom.*;
    import flash.text.engine.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.edit.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.operations.*;
    import net.sprd.common.collections.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.text.*;

    public class TextFlowUtil extends Object
    {
        private static const log:ILogger = LogContext.getLogger(this);
        private static var fm:FontManager = FontManager.getInstance();

        public function TextFlowUtil()
        {
            return;
        }// end function

        public static function render(param1:TextFlow, param2:Number, param3:Number) : Sprite
        {
            var _loc_4:* = new Sprite();
            _loc_4.name = "textContainer";
            var _loc_5:* = new ContainerController(_loc_4, param2, param3);
            _loc_5.verticalScrollPolicy = ScrollPolicy.OFF;
            param1.flowComposer.removeAllControllers();
            param1.flowComposer.addController(_loc_5);
            param1.flowComposer.updateAllControllers();
            return _loc_4;
        }// end function

        public static function textHeight(param1:TextFlow, param2:Boolean) : Number
        {
            var _loc_3:* = param1.flowComposer;
            var _loc_4:* = _loc_3.getControllerAt(0);
            var _loc_5:* = _loc_4.compositionHeight;
            _loc_4.setCompositionSize(_loc_4.compositionWidth, 100000);
            _loc_3.updateAllControllers();
            var _loc_6:* = _loc_3.getLineAt(_loc_3.numLines - 1);
            var _loc_7:* = _loc_6.y + _loc_6.textHeight;
            if (param2)
            {
                _loc_4.setCompositionSize(_loc_4.compositionWidth, _loc_7);
            }
            else
            {
                _loc_4.setCompositionSize(_loc_4.compositionWidth, _loc_5);
            }
            return _loc_7;
        }// end function

        public static function realBounds(param1:TextFlow, param2:DisplayObject) : Rectangle
        {
            var _loc_6:Rectangle;
            if (param1.flowComposer.numLines == 0)
            {
                return new Rectangle();
            }
            var _loc_3:Number;
            var _loc_4:Number;
            var _loc_5:int;
            while (_loc_5++ < param1.flowComposer.numLines)
            {
                
                _loc_6 = param1.flowComposer.getLineAt(_loc_5).getBounds();
                _loc_3 = Math.min(_loc_3, _loc_6.x);
                _loc_4 = Math.max(_loc_4, _loc_6.x + _loc_6.width);
            }
            return new Rectangle(_loc_3, 0, _loc_4 - _loc_3, textHeight(param1, false));
        }// end function

        public static function usedColors(param1:TextFlow, param2:Boolean = false) : Array
        {
            var _loc_5:ParagraphElement;
            var _loc_6:uint;
            var _loc_7:SpanElement;
            var _loc_8:*;
            var _loc_3:* = new SortedSet();
            var _loc_4:uint;
            while (_loc_4++ < param1.numChildren)
            {
                
                _loc_5 = ParagraphElement(param1.getChildAt(_loc_4));
                _loc_6 = 0;
                while (_loc_6++ < _loc_5.numChildren)
                {
                    
                    _loc_7 = SpanElement(_loc_5.getChildAt(_loc_6));
                    if (param2)
                    {
                    }
                    if (_loc_7.text.replace(/ /g, "").length == 0)
                    {
                        continue;
                    }
                    _loc_8 = _loc_7.computedFormat.color;
                    if (!isNaN(_loc_8))
                    {
                    }
                    if (_loc_8 != null)
                    {
                        _loc_3.add(_loc_8);
                    }
                }
            }
            return _loc_3.toArray();
        }// end function

        public static function cloneSelectionState(param1:TextFlow, param2:SelectionState) : SelectionState
        {
            if (!param2)
            {
                return null;
            }
            return new SelectionState(param1, param2.anchorPosition, param2.activePosition, param2.pointFormat);
        }// end function

        public static function cloneFlowOperation(param1:FlowOperation, param2:TextFlow) : FlowOperation
        {
            var _loc_3:SelectionState;
            if (param1 is FlowTextOperation)
            {
                _loc_3 = cloneSelectionState(param2, FlowTextOperation(param1).originalSelectionState);
                if (param1 is InsertTextOperation)
                {
                    return new InsertTextOperation(_loc_3, InsertTextOperation(param1).text, cloneSelectionState(param2, InsertTextOperation(param1).deleteSelectionState));
                }
                if (param1 is DeleteTextOperation)
                {
                    return new DeleteTextOperation(_loc_3, cloneSelectionState(param2, DeleteTextOperation(param1).deleteSelectionState), DeleteTextOperation(param1).allowMerge);
                }
                if (param1 is ApplyFormatOperation)
                {
                    return new ApplyFormatOperation(_loc_3, ApplyFormatOperation(param1).leafFormat, ApplyFormatOperation(param1).paragraphFormat, ApplyFormatOperation(param1).containerFormat);
                }
                if (param1 is PasteOperation)
                {
                    return new PasteOperation(_loc_3, PasteOperation(param1).textScrap);
                }
                if (param1 is CopyOperation)
                {
                    return new CopyOperation(_loc_3);
                }
                if (param1 is CutOperation)
                {
                    return new CutOperation(_loc_3, CutOperation(param1).scrapToCut);
                }
                if (param1 is SplitParagraphOperation)
                {
                    return new SplitParagraphOperation(_loc_3);
                }
            }
            log.error("unhandled op: " + param1);
            return null;
        }// end function

        public static function decreaseFontSize(param1:TextFlow, param2:Number, param3:Number, param4:Number) : Boolean
        {
            var _loc_5:* = adjustFontSizeRecursively(param1, param2, param3, true, param4);
            if (_loc_5)
            {
                adjustFontSizeRecursively(param1, param2, param3, false, param4);
            }
            return _loc_5;
        }// end function

        public static function canDecreaseFontSize(param1:TextFlow, param2:Number, param3:Number, param4) : Boolean
        {
            return adjustFontSizeRecursively(param1, param2, param3, true, param4);
        }// end function

        private static function adjustFontSizeRecursively(param1:FlowElement, param2:Number, param3:Number, param4:Boolean, param5:Number) : Boolean
        {
            var _loc_6:int;
            var _loc_7:Boolean;
            var _loc_8:ITextLayoutFormat;
            var _loc_9:IFontFamily;
            var _loc_10:IFontStyle;
            if (param1 is FlowGroupElement)
            {
                _loc_6 = 0;
                while (_loc_6++ < FlowGroupElement(param1).numChildren)
                {
                    
                    _loc_7 = adjustFontSizeRecursively(FlowGroupElement(param1).getChildAt(_loc_6), param2, param3, param4, param5);
                    if (param4)
                    {
                    }
                    if (!_loc_7)
                    {
                        return false;
                    }
                }
            }
            else
            {
                _loc_8 = param1.computedFormat;
                if (_loc_8)
                {
                }
                if (_loc_8.fontSize)
                {
                }
                if (_loc_8.fontFamily)
                {
                    if (param4)
                    {
                        _loc_9 = fm.getFontFamilyFromEmbbededName(_loc_8.fontFamily);
                        _loc_10 = fm.getFontStyle(_loc_9.id, _loc_8.fontWeight == FontWeight.BOLD, _loc_8.fontStyle == FontPosture.ITALIC);
                        if (_loc_10)
                        {
                            if (param5 > _loc_8.fontSize * param2 * param3)
                            {
                                return false;
                            }
                            if (_loc_8.fontSize * param2 * param3 > 720)
                            {
                                return false;
                            }
                        }
                        else
                        {
                            return false;
                        }
                    }
                    else
                    {
                        param1.fontSize = _loc_8.fontSize * param2;
                    }
                }
            }
            return true;
        }// end function

        public static function getMaximumFontSizeAsPixel(param1:TextFlow) : Number
        {
            var _loc_5:FlowLeafElement;
            var _loc_6:IFontFamily;
            var _loc_7:IFontStyle;
            var _loc_2:Number;
            var _loc_3:FlowLeafElement;
            var _loc_4:int;
            while (_loc_4++ < param1.textLength)
            {
                
                _loc_5 = param1.findLeaf(_loc_4);
                if (_loc_5)
                {
                }
                if (_loc_5 == _loc_3)
                {
                    continue;
                }
                _loc_3 = _loc_5;
                _loc_6 = fm.getFontFamilyFromEmbbededName(_loc_5.computedFormat.fontFamily);
                if (_loc_6)
                {
                    _loc_7 = fm.getFontStyle(_loc_6.id, _loc_5.computedFormat.fontWeight == FontWeight.BOLD, _loc_5.computedFormat.fontStyle == FontPosture.ITALIC);
                    if (_loc_7)
                    {
                        _loc_2 = Math.max(_loc_5.computedFormat.fontSize, _loc_2);
                    }
                    else
                    {
                        log.warn("Could not load unknown font style \'" + _loc_5.computedFormat.fontFamily + ":" + _loc_5.computedFormat.fontWeight + ":" + _loc_5.computedFormat.fontStyle + "\'.");
                    }
                    continue;
                }
                log.warn("Could not load unknown font family \'" + _loc_5.computedFormat.fontFamily + "\'.");
            }
            return _loc_2;
        }// end function

        public static function computeEffectiveMinimumFontSize(param1:TextFlow, param2:SelectionState, param3:Number) : Number
        {
            if (!param2)
            {
                return param3;
            }
            if (param2.absoluteStart == param2.absoluteEnd)
            {
                return _computeEffectiveMinimumFontSize(param1, param2.absoluteStart, param2.absoluteEnd + 1, param3);
            }
            return _computeEffectiveMinimumFontSize(param1, param2.absoluteStart, param2.absoluteEnd, param3);
        }// end function

        private static function _computeEffectiveMinimumFontSize(param1:TextFlow, param2:int, param3:int, param4:int) : Number
        {
            var _loc_7:FlowLeafElement;
            var _loc_8:IFontFamily;
            var _loc_9:IFontStyle;
            var _loc_5:* = param4;
            var _loc_6:* = param2;
            while (_loc_6++ < param3)
            {
                
                _loc_7 = param1.findLeaf(_loc_6);
                if (!_loc_7)
                {
                    continue;
                }
                _loc_8 = fm.getFontFamilyFromEmbbededName(_loc_7.computedFormat.fontFamily);
                if (_loc_8)
                {
                    _loc_9 = fm.getFontStyle(_loc_8.id, _loc_7.computedFormat.fontWeight == FontWeight.BOLD, _loc_7.computedFormat.fontStyle == FontPosture.ITALIC);
                    if (_loc_9)
                    {
                        _loc_5 = Math.max(_loc_9.minSize, _loc_5);
                    }
                    else
                    {
                        log.warn("Could not set font size on unknown font style \'" + _loc_7.computedFormat.fontFamily + ":" + _loc_7.computedFormat.fontWeight + ":" + _loc_7.computedFormat.fontStyle + "\'.");
                    }
                    continue;
                }
                log.warn("Could not set font size on unknown font family \'" + _loc_7.computedFormat.fontFamily + "\'.");
            }
            return _loc_5;
        }// end function

    }
}
