package net.sprd.components.common
{
    import flash.display.*;
    import flash.geom.*;
    import mx.controls.*;

    public class ArrowButton extends Button
    {
        private var _arrow:Sprite;

        public function ArrowButton()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this._arrow = new Sprite();
            var _loc_2:* = this._arrow.graphics;
            with (this._arrow.graphics)
            {
                clear();
                beginFill(getStyle("arrowColor"), getStyle("arrowAlpha"));
                moveTo(5, 5);
                lineTo(9, 0);
                lineTo(9, 9);
                lineTo(5, 5);
            }
            addChild(this._arrow);
            this._arrow.y = (height - this._arrow.height) / 2 + 2;
            this._arrow.x = -2;
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            this._arrow.visible = param2 > 1;
            var _loc_3:* = new Matrix();
            var _loc_4:* = this._arrow.getBounds(this);
            _loc_3.translate(-_loc_4.width / 2, -_loc_4.height / 2);
            _loc_3.rotate(selected ? (Math.PI) : (0));
            _loc_3.translate(_loc_4.width / 2 - 2, _loc_4.height / 2 + (param2 - this._arrow.height) / 2);
            setChildIndex(this._arrow, numChildren - 1);
            return;
        }// end function

    }
}
