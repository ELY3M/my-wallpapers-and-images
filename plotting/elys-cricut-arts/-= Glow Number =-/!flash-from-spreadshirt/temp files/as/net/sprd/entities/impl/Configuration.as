package net.sprd.entities.impl
{
    import flash.geom.*;
    import net.sprd.entities.*;
    import net.sprd.graphics.svg.*;

    public class Configuration extends BaseEntity implements IConfiguration
    {
        private var _type:String;
        private var _printArea:String;
        private var _printType:String;
        private var _svgContent:ISVGShape;
        private var _changeable:Boolean = true;
        private var _offset:Point;
        private var _designId:String;

        public function Configuration()
        {
            this._offset = new Point();
            return;
        }// end function

        public function get type() : String
        {
            return this._type;
        }// end function

        public function set type(param1:String) : void
        {
            if (param1 == this._type)
            {
                return;
            }
            this._type = param1;
            this.markModified();
            return;
        }// end function

        public function get printArea() : String
        {
            return this._printArea;
        }// end function

        public function set printArea(param1:String) : void
        {
            if (this._printArea == param1)
            {
                return;
            }
            this._printArea = param1;
            this.markModified();
            return;
        }// end function

        public function get printType() : String
        {
            return this._printType;
        }// end function

        public function set printType(param1:String) : void
        {
            if (param1 == this._printType)
            {
                return;
            }
            this._printType = param1;
            this.markModified();
            return;
        }// end function

        public function get svgContent() : ISVGShape
        {
            return this._svgContent;
        }// end function

        public function set svgContent(param1:ISVGShape) : void
        {
            this._svgContent = param1;
            this.markModified();
            return;
        }// end function

        public function get isChangeable() : Boolean
        {
            return this._changeable;
        }// end function

        public function set isChangeable(param1:Boolean) : void
        {
            if (param1 == this._changeable)
            {
                return;
            }
            this._changeable = param1;
            this.markModified();
            return;
        }// end function

        public function get offset() : Point
        {
            return this._offset;
        }// end function

        public function set offset(param1:Point) : void
        {
            if (param1 == this._offset)
            {
                return;
            }
            this._offset = param1;
            this.markModified();
            return;
        }// end function

        override public function markModified(param1:Boolean = true) : void
        {
            super.markModified(param1);
            if (param1 == false)
            {
            }
            if (this._svgContent)
            {
                this._svgContent.markModified(false);
            }
            return;
        }// end function

        override public function get modified() : Boolean
        {
            if (true)
            {
            }
            return this._svgContent.modified;
        }// end function

        public function get designId() : String
        {
            return this._designId;
        }// end function

        public function set designId(param1:String) : void
        {
            if (this._designId == param1)
            {
                return;
            }
            this._designId = param1;
            this.markModified();
            return;
        }// end function

        public function clone() : IConfiguration
        {
            var _loc_1:* = new Configuration();
            _loc_1.id = id;
            _loc_1.state = state;
            _loc_1.resource = resource;
            _loc_1.type = this.type;
            _loc_1.printArea = this.printArea;
            _loc_1.printType = this.printType;
            _loc_1.svgContent = this.svgContent.clone();
            _loc_1.isChangeable = this.isChangeable;
            _loc_1.offset = this.offset.clone();
            _loc_1.designId = this.designId;
            return _loc_1;
        }// end function

    }
}
