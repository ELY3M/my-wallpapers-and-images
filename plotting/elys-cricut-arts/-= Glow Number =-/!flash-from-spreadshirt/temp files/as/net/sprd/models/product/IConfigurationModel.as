package net.sprd.models.product
{
    import flash.display.*;
    import flash.geom.*;
    import flashx.textLayout.edit.*;
    import flashx.textLayout.elements.*;
    import net.sprd.entities.*;
    import net.sprd.graphics.svg.*;
    import net.sprd.models.product.renderer.*;
    import net.sprd.valueObjects.*;

    public interface IConfigurationModel extends IEventDispatcher
    {

        public function IConfigurationModel();

        function initializeFromSVG(param1:ISVGShape, param2:Point, param3:Number, param4:Number, param5:IProductModel, param6:Boolean = true) : void;

        function initializeFromDeserializedConfiguration(param1:IConfiguration, param2:IProductModel) : void;

        function get configurationID() : String;

        function get type() : String;

        function set type(param1:String) : void;

        function get printArea() : IPrintArea;

        function set printArea(param1:IPrintArea) : void;

        function getPossiblePrintTypes() : Array;

        function doesFitIntoPrintTypeMaxBounds(param1:IPrintType) : Boolean;

        function get printType() : IPrintType;

        function set printType(param1:IPrintType) : void;

        function get unscaledWidth() : Number;

        function get unscaledHeight() : Number;

        function get width() : Number;

        function set width(param1:Number) : void;

        function get height() : Number;

        function set height(param1:Number) : void;

        function get offset() : Point;

        function set offset(param1:Point) : void;

        function get svgContent() : ISVGShape;

        function get isChangeable() : Boolean;

        function set isChangeable(param1:Boolean) : void;

        function get bitmap() : Boolean;

        function get rgbColors() : Array;

        function set rgbColors(param1:Array) : void;

        function get printColors() : Array;

        function set printColors(param1:Array) : void;

        function get rotation() : Number;

        function set rotation(param1:Number) : void;

        function set centerScale(param1:Point) : void;

        function get flipX() : int;

        function set flipX(param1:int) : void;

        function get flipY() : int;

        function set flipY(param1:int) : void;

        function get transformation() : Matrix;

        function moveToDefaultPosition(param1:String) : void;

        function getMinimumFontSize() : Number;

        function getMaximumFontSize() : Number;

        function remove() : int;

        function getConstraintViolationInfo(param1:Number, param2:int, param3:int, param4:Point, param5:Point) : ConstraintViolationInfo;

        function getTransformation(param1:Number, param2:int, param3:int, param4:Point, param5:Point) : Matrix;

        function createConfigurationRenderer() : IConfigurationRenderer;

        function get testSprite() : DisplayObject;

        function get layers() : Array;

        function get product() : IProductModel;

        function get design() : IDesign;

        function get horizontalTextAutoStretch() : Boolean;

        function set horizontalTextAutoStretch(param1:Boolean) : void;

        function setTextBox(param1:Number, param2:Number) : void;

        function get testTextFlow() : TextFlow;

        function get textFlow() : TextFlow;

        function getCurrentConstraintViolationInfo() : ConstraintViolationInfo;

        function get constraintViolationDetector() : IConstraintViolationDetector;

        function get allowConstraintError() : Boolean;

        function set allowConstraintError(param1:Boolean) : void;

        function adjustHeightToTextFit() : Number;

        function get price() : Money;

        function setColorOnTextSelection(param1:SelectionState, param2:IPrintColor) : void;

        function get textOfferedForDeletion() : Boolean;

        function set textOfferedForDeletion(param1:Boolean) : void;

        function get isEmpty() : Boolean;

        function get isDefaultConfiguration() : Boolean;

        function set isDefaultConfiguration(param1:Boolean) : void;

        function get canBeRemoved() : Boolean;

        function get configuration() : IConfiguration;

        function setSelection(param1:Boolean) : void;

        function get textOperationStrategy() : ITextOperationStrategy;

        function get state() : int;

        function updateSVGContent() : void;

        function set designId(param1:String) : void;

        function get designId() : String;

        function get modified() : Boolean;

        function markModified(param1:Boolean = true);

        function set autoCorrection(param1:Boolean) : void;

        function get selectedLayerIndex() : int;

        function set selectedLayerIndex(param1:int) : void;

    }
}
