package net.sprd.components.producttypeselector.colorfilter
{
    import flash.display.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;

    public class ColorTileList extends TileList
    {

        public function ColorTileList()
        {
            return;
        }// end function

        override protected function drawSelectionIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
        {
            return;
        }// end function

        override protected function drawHighlightIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
        {
            var _loc_8:* = param1.graphics;
            _loc_8.clear();
            _loc_8.beginFill(16734208, 1);
            _loc_8.lineStyle(4, 16734208);
            _loc_8.drawRoundRect(param2 + 2, param3 + 2, 18, 10, 3, 3);
            _loc_8.endFill();
            return;
        }// end function

    }
}
