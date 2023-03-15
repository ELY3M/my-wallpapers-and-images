package net.sprd.modules.share
{
    import flash.display.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.events.*;
    import net.sprd.common.utils.*;

    public class ProductTileList extends TileList
    {

        public function ProductTileList()
        {
            EventUtil.registerOnetimeListeners(this, [FlexEvent.CREATION_COMPLETE], [function (param1:FlexEvent) : void
            {
                listContent.name = "productsListContainer";
                return;
            }// end function
            ]);
            return;
        }// end function

        override protected function drawSelectionIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
        {
            return;
        }// end function

        override protected function drawHighlightIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
        {
            return;
        }// end function

    }
}
