package net.sprd.models.product.rules
{
    import flash.display.*;
    import flash.geom.*;
    import net.sprd.common.graphics.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.entities.*;
    import net.sprd.graphics.svg.utils.*;
    import net.sprd.models.product.*;
    import net.sprd.models.product.texthandling.*;

    public class DefaultConstraintViolationDetector extends Object implements IConstraintViolationDetector
    {
        private var printArea:IPrintArea;
        private var product:IProductModel;
        private var testPrintArea:Sprite;
        private var boxBasedCollisionDetection:Boolean = false;
        private var printAreaBounds:Rectangle;
        private static const log:ILogger = LogContext.getLogger(this);

        public function DefaultConstraintViolationDetector(param1:IProductModel, param2:IPrintArea)
        {
            this.testPrintArea = new Sprite();
            this.printArea = param2;
            this.printAreaBounds = new Rectangle(0, 0, param2.width, param2.height);
            this.product = param1;
            this.initTestPrintArea();
            return;
        }// end function

        public function initTestPrintArea() : void
        {
            this.testPrintArea.graphics.clear();
            this.testPrintArea.graphics.lineStyle(0);
            this.testPrintArea.graphics.beginFill(131071);
            this.testPrintArea.graphics.drawGraphicsData(SVGShapeUtil.toGraphicsData(this.printArea.hardBoundary, 1));
            return;
        }// end function

        public function getConstraintViolationInfo(param1:IConfigurationModel, param2:Number, param3:int, param4:int, param5:Point, param6:Point) : ConstraintViolationInfo
        {
            var _loc_10:Boolean;
            var _loc_11:IConfigurationModel;
            var _loc_12:int;
            var _loc_7:* = param1.getTransformation(param2, param3, param4, param5, param6);
            var _loc_8:* = new ConstraintViolationInfo();
            _loc_8.boundaryCollision = this.hardBoundaryCollision(param1, _loc_7);
            var _loc_9:Array;
            for each (_loc_11 in this.product.getConfigurationsForPrintArea(this.printArea.id))
            {
                
                if (_loc_11 == param1)
                {
                    continue;
                }
                _loc_12 = GeometryUtil.containment(param1.testSprite, _loc_11.testSprite, _loc_7, _loc_11.transformation, 2, 2, 4, false);
                if (_loc_12 != GeometryUtil.DISJOINT)
                {
                    _loc_9.push(_loc_11);
                    if (PrintTypeRules.canPrintAbove(param1.printType, _loc_11.printType))
                    {
                        if (param1.printType.colorSpace == ColorSpace.PRINTCOLORS)
                        {
                        }
                        if (_loc_11.printType.colorSpace == ColorSpace.PRINTCOLORS)
                        {
                        }
                        continue;
                    }
                    _loc_8.addConfigurationCollision(_loc_11);
                }
            }
            if (_loc_9.length > 1)
            {
                _loc_10 = this.hasMultipleMaximumLayerConflict(param1, _loc_7, _loc_9);
                if (_loc_10)
                {
                    _loc_8.multiCollision = true;
                }
            }
            _loc_8.maxBoundViolation = this.maxBoundViolation(param1, param5);
            _loc_8.minBoundViolation = this.minBoundViolation(param1, param5);
            return _loc_8;
        }// end function

        public function maxBoundViolation(param1:IConfigurationModel, param2:Point = null) : Boolean
        {
            var _loc_5:Rectangle;
            var _loc_6:Rectangle;
            var _loc_7:Rectangle;
            if (!param2)
            {
                param2 = ConfigurationModelConstants.NO_SCALE;
            }
            if (param1.type == ConfigurationType.DESIGN)
            {
            }
            if (ConfigurationSizeRules.isBitmapDesign(param1.design))
            {
                ConfigurationSizeRules.isBitmapDesign(param1.design);
            }
            if (param1.printType.scalability == PrintTypeScalability.SHRINKABLE)
            {
                _loc_5 = ConfigurationSizeRules.metricBounds(param1.design, param1.printType);
                if (int(param2.x * param1.height * 100) <= int(_loc_5.height * 100))
                {
                }
                if (int(param2.y * param1.width * 100) > int(_loc_5.width * 100))
                {
                    return true;
                }
            }
            var _loc_3:* = new Rectangle();
            if (param1.type == ConfigurationType.TEXT)
            {
                _loc_6 = getOptimizedBoundingBox(param1);
                _loc_7 = new Rectangle(0, 0, _loc_6.width * 1.02 * param2.x, _loc_6.height * 1.02 * param2.y);
            }
            else
            {
                _loc_7 = new Rectangle(0, 0, param1.width * param2.x, param1.height * param2.y);
            }
            var _loc_4:* = new Matrix();
            _loc_4.rotate(UnitUtil.deg2rad(param1.rotation));
            _loc_3 = GeometryUtil.getBounds(_loc_7, _loc_4);
            if (int(_loc_3.width * 100) <= int(param1.printType.width * 100))
            {
            }
            return int(_loc_3.height * 100) > int(param1.printType.height * 100);
        }// end function

        public function minBoundViolation(param1:IConfigurationModel, param2:Point = null) : Boolean
        {
            var _loc_3:Number;
            var _loc_4:Number;
            var _loc_5:Number;
            var _loc_6:Number;
            var _loc_7:Number;
            if (param1.printType.scalability != PrintTypeScalability.ENLARGEABLE)
            {
                return false;
            }
            if (!param2)
            {
                param2 = ConfigurationModelConstants.NO_SCALE;
            }
            if (param1.type == ConfigurationType.DESIGN)
            {
                _loc_3 = int(param1.width * param2.x * 100);
                _loc_4 = int(param1.height * param2.y * 100);
                _loc_5 = int(param1.design.net.sprd.entities:IDesign::width * (param1.design.minScale / 100) * 100);
                _loc_6 = int(param1.design.height * (param1.design.minScale / 100) * 100);
                if (_loc_3 >= _loc_5)
                {
                }
                return _loc_4 < _loc_6;
            }
            _loc_7 = ConfigurationSizeRules.calculateMinimumFontSize(param1);
            return !TextFlowUtil.canDecreaseFontSize(param1.textFlow, 1, param2.x * param1.width / param1.unscaledWidth, _loc_7);
        }// end function

        public function hardBoundaryCollision(param1:IConfigurationModel, param2:Matrix = null) : Boolean
        {
            var _loc_3:int;
            var _loc_4:int;
            if (this.boxBasedCollisionDetection)
            {
                return !GeometryUtil.containsRectangle(getOptimizedBoundingBox(param1), this.printAreaBounds, param2, null);
            }
            if (!param2)
            {
                param2 = param1.transformation;
            }
            if (param1.type == ConfigurationType.TEXT)
            {
                _loc_3 = 8;
                _loc_4 = 0.2 * TextFlowUtil.getMaximumFontSizeAsPixel(param1.textFlow);
            }
            else
            {
                _loc_3 = 0;
                _loc_4 = 0;
            }
            return GeometryUtil.containment(param1.testSprite, this.testPrintArea, param2, null, _loc_3, 0, _loc_4, false) != GeometryUtil.CONTAINED;
        }// end function

        private function hasPrintColorAboveConflict(param1:DisplayObject, param2:Matrix, param3:String, param4:DisplayObject, param5:Matrix, param6:String) : Boolean
        {
            if (!PrintTypeRules.canPrintColorAbove(param3, param6))
            {
                if (GeometryUtil.containment(param1, param4, param2, param5, 2, 2) != GeometryUtil.DISJOINT)
                {
                    return true;
                }
            }
            return false;
        }// end function

        private function hasMaximumLayerConflict(param1:IConfigurationModel, param2:Matrix, param3:IConfigurationModel, param4:Matrix, param5:int) : Boolean
        {
            var _loc_12:DisplayObject;
            var _loc_13:int;
            var _loc_6:* = param1.testSprite;
            var _loc_7:* = param3.testSprite;
            if (_loc_6)
            {
            }
            if (!_loc_7)
            {
                return false;
            }
            var _loc_8:* = GeometryUtil.getBounds(_loc_6.getBounds(_loc_6), param2);
            var _loc_9:* = GeometryUtil.getBounds(_loc_7.getBounds(_loc_7), param4);
            var _loc_10:* = _loc_9.intersection(_loc_8);
            var _loc_11:Array;
            for each (_loc_12 in param1.layers)
            {
                
                _loc_11.push(new TransformedDisplayObject(_loc_12, param2));
            }
            for each (_loc_12 in param3.layers)
            {
                
                _loc_11.push(new TransformedDisplayObject(_loc_12, param4));
            }
            _loc_13 = GeometryUtil.intersectionDepth(_loc_10, _loc_11, true);
            return _loc_13 > param5;
        }// end function

        private function hasMultipleMaximumLayerConflict(param1:IConfigurationModel, param2:Matrix, param3:Array) : Boolean
        {
            var _loc_8:DisplayObject;
            var _loc_9:IConfigurationModel;
            var _loc_4:* = param1.testSprite;
            if (!_loc_4)
            {
                return false;
            }
            var _loc_5:* = param1.printType.maxPrintColorLayers;
            var _loc_6:* = GeometryUtil.getBounds(_loc_4.getBounds(_loc_4), param2);
            var _loc_7:Array;
            for each (_loc_8 in param1.layers)
            {
                
                _loc_7.push(new TransformedDisplayObject(_loc_8, param2));
            }
            for each (_loc_9 in param3)
            {
                
                _loc_5 = Math.min(_loc_5, _loc_9.printType.maxPrintColorLayers);
                for each (_loc_8 in _loc_9.layers)
                {
                    
                    _loc_7.push(new TransformedDisplayObject(_loc_8, _loc_9.transformation));
                }
            }
            return GeometryUtil.intersectionDepth(_loc_6, _loc_7, false) > _loc_5;
        }// end function

        public static function getOptimizedBoundingBox(param1:IConfigurationModel) : Rectangle
        {
            if (param1.type == ConfigurationType.TEXT)
            {
                return TextFlowUtil.realBounds(param1.textFlow, param1.testSprite);
            }
            return new Rectangle(0, 0, param1.unscaledWidth, param1.unscaledHeight);
        }// end function

    }
}
