package net.sprd.components.designselector
{
    import flash.display.*;
    import flash.utils.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.events.*;

    public class DesignTileList extends TileList
    {
        private var _designConstraints:Dictionary;
        private var _progressProviders:Dictionary;

        public function DesignTileList()
        {
            addEventListener(FlexEvent.CREATION_COMPLETE, this.onComplete);
            this._designConstraints = new Dictionary();
            this._progressProviders = new Dictionary(true);
            return;
        }// end function

        public function get designConstraints() : Dictionary
        {
            return this._designConstraints;
        }// end function

        public function set designConstraints(param1:Dictionary) : void
        {
            this._designConstraints = param1;
            invalidateList();
            return;
        }// end function

        private function onComplete(param1:FlexEvent) : void
        {
            removeEventListener(FlexEvent.CREATION_COMPLETE, this.onComplete);
            this.listContent.name = "designListContainer";
            return;
        }// end function

        override public function isItemSelectable(param1:Object) : Boolean
        {
            if (!param1)
            {
                return false;
            }
            var _loc_2:* = this._designConstraints[param1.id];
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
