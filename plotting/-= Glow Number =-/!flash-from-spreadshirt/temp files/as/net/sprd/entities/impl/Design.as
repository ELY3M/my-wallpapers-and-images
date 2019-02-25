package net.sprd.entities.impl
{
    import net.sprd.common.collections.*;
    import net.sprd.valueObjects.*;

    public class Design extends BaseEntity implements IDesign
    {
        private var _name:String;
        private var _description:String;
        private var _user:String;
        private var _hasFixedColors:Boolean;
        private var _allowsText:Boolean;
        private var _isObligatory:Boolean;
        private var _isMovable:Boolean;
        private var _targetView:String;
        private var _minScale:Number;
        private var _isVisible:Boolean;
        private var _width:Number;
        private var _height:Number;
        private var _colors:Array;
        private var _layerIndizies:Array;
        private var _printTypes:ICollection;
        private var _price:Money;
        private var _age:Date;
        private var _imageId:String;

        public function Design()
        {
            this._price = new Money(0, "1");
            this._colors = [];
            this._layerIndizies = [];
            this._printTypes = new ArrayList();
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function get description() : String
        {
            return this._description;
        }// end function

        public function set description(param1:String) : void
        {
            this._description = param1;
            return;
        }// end function

        public function get user() : String
        {
            return this._user;
        }// end function

        public function set user(param1:String) : void
        {
            this._user = param1;
            return;
        }// end function

        public function get hasFixedColors() : Boolean
        {
            return this._hasFixedColors;
        }// end function

        public function set hasFixedColors(param1:Boolean) : void
        {
            this._hasFixedColors = param1;
            return;
        }// end function

        public function get allowsText() : Boolean
        {
            return this._allowsText;
        }// end function

        public function set allowsText(param1:Boolean) : void
        {
            this._allowsText = param1;
            return;
        }// end function

        public function get isObligatory() : Boolean
        {
            return this._isObligatory;
        }// end function

        public function set isObligatory(param1:Boolean) : void
        {
            this._isObligatory = param1;
            return;
        }// end function

        public function get isMovable() : Boolean
        {
            return this._isMovable;
        }// end function

        public function set isMovable(param1:Boolean) : void
        {
            this._isMovable = param1;
            return;
        }// end function

        public function get targetView() : String
        {
            return this._targetView;
        }// end function

        public function get isVectorDesign() : Boolean
        {
            return this._colors.length > 0;
        }// end function

        public function set targetView(param1:String) : void
        {
            this._targetView = param1;
            return;
        }// end function

        public function get minScale() : Number
        {
            return this._minScale;
        }// end function

        public function set minScale(param1:Number) : void
        {
            this._minScale = param1;
            return;
        }// end function

        public function get isVisible() : Boolean
        {
            return this._isVisible;
        }// end function

        public function set isVisible(param1:Boolean) : void
        {
            this._isVisible = param1;
            return;
        }// end function

        public function get width() : Number
        {
            return this._width;
        }// end function

        public function set width(param1:Number) : void
        {
            this._width = param1;
            return;
        }// end function

        public function get height() : Number
        {
            return this._height;
        }// end function

        public function set height(param1:Number) : void
        {
            this._height = param1;
            return;
        }// end function

        public function get colors() : Array
        {
            return this._colors.slice();
        }// end function

        public function addColor(param1:uint, param2:uint, param3:uint) : void
        {
            this._colors[param2] = param1;
            this._layerIndizies[param3] = param2;
            return;
        }// end function

        public function get printTypes() : Array
        {
            return this._printTypes.toArray();
        }// end function

        public function addPrintType(param1:String) : void
        {
            this._printTypes.add(param1);
            return;
        }// end function

        public function removePrintType(param1:String) : void
        {
            this._printTypes.remove(param1);
            return;
        }// end function

        public function get price() : Money
        {
            return this._price;
        }// end function

        public function set price(param1:Money) : void
        {
            this._price = param1;
            return;
        }// end function

        public function get age() : Date
        {
            return this._age;
        }// end function

        public function set age(param1:Date) : void
        {
            this._age = param1;
            return;
        }// end function

        public function get imageId() : String
        {
            return this._imageId;
        }// end function

        public function set imageId(param1:String) : void
        {
            this._imageId = param1;
            return;
        }// end function

        public function get layerIndizies() : Array
        {
            return this._layerIndizies;
        }// end function

    }
}
