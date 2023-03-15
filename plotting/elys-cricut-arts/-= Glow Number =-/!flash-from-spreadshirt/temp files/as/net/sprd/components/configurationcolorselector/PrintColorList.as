package net.sprd.components.configurationcolorselector
{
    import flash.display.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;

    public class PrintColorList extends TileList
    {

        public function PrintColorList()
        {
            return;
        }// end function

        override protected function drawHighlightIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
        {
            var _loc_8:* = Sprite(param1).graphics;
            _loc_8.clear();
            _loc_8.beginFill(param6);
            _loc_8.drawRoundRect(1, 1, param4 - 2, param5 - 2, 10, 10);
            _loc_8.endFill();
            param1.x = param2;
            param1.y = param3;
            return;
        }// end function

        override protected function drawSelectionIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
        {
            var _loc_8:* = Sprite(param1).graphics;
            _loc_8.clear();
            _loc_8.beginFill(param6);
            _loc_8.drawRoundRect(0, 0, param4, param5, 10, 10);
            _loc_8.endFill();
            param1.x = param2;
            param1.y = param3;
            return;
        }// end function

    }
}
