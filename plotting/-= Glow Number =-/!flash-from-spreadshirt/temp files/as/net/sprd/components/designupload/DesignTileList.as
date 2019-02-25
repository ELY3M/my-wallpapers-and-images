package net.sprd.components.designupload
{
    import flash.display.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.events.*;
    import net.sprd.common.utils.*;

    public class DesignTileList extends TileList
    {

        public function DesignTileList()
        {
            EventUtil.registerOnetimeListeners(this, [FlexEvent.CREATION_COMPLETE], [function (param1:FlexEvent) : void
            {
                listContent.name = "designListContainer";
                return;
            }// end function
            ]);
            return;
        }// end function

        override public function isItemSelectable(param1:Object) : Boolean
        {
            if (!param1)
            {
                return false;
            }
            var _loc_2:* = DesignInfo(param1).constraints;
            if (_loc_2)
            {
                if (!_loc_2.isUsable)
                {
                    return false;
                }
            }
            return super.isItemSelectable(param1);
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
