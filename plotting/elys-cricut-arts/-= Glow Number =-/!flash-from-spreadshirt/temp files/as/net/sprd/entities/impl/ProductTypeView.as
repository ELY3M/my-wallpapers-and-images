package net.sprd.entities.impl
{
    import flash.geom.*;
    import flash.utils.*;

    public class ProductTypeView extends BaseEntity implements IProductTypeView
    {
        private var _name:String;
        private var _width:Number;
        private var _height:Number;
        private var _perspective:String;
        private var _printAreas:Dictionary;
        public static const PERSPECTIVE_FRONT:String = "front";
        public static const PERSPECTIVE_BACK:String = "back";
        public static const PERSPECTIVE_LEFT:String = "left";
        public static const PERSPECTIVE_RIGHT:String = "right";
        public static const PERSPECTIVE_HOOD_RIGHT:String = "hood_right";
        public static const PERSPECTIVE_HOOD_LEFT:String = "hood_left";

        public function ProductTypeView(param1:String, param2:String)
        {
            this._printAreas = new Dictionary();
            this.id = param1;
            this._name = param2;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
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

        public function get perspective() : String
        {
            return this._perspective;
        }// end function

        public function set perspective(param1:String) : void
        {
            this._perspective = param1;
            return;
        }// end function

        public function get printAreas() : Array
        {
            var _loc_2:String;
            var _loc_1:* = new Array();
            for (_loc_2 in this._printAreas)
            {
                
                _loc_1.push(_loc_2);
            }
            return _loc_1;
        }// end function

        public function addPrintAreaOffset(param1:String, param2:Point) : void
        {
            this._printAreas[param1] = param2;
            return;
        }// end function

        public function getPrintAreaOffset(param1:String) : Point
        {
            return Point(this._printAreas[param1]);
        }// end function

    }
}
