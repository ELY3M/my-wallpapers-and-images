package net.sprd.components.common.gallerytilelist
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.events.*;
    import net.sprd.entities.*;

    public class GalleryTileList extends TileList
    {
        private var _currentData:IProductType;
        private var _descrCords:Point;

        public function GalleryTileList()
        {
            addEventListener(FlexEvent.CREATION_COMPLETE, this.onComplete);
            return;
        }// end function

        public function get currentData() : IProductType
        {
            return this._currentData;
        }// end function

        public function get descrCords() : Point
        {
            return this._descrCords;
        }// end function

        public function dispatchDataLoaded(param1:IProductType) : void
        {
            this._currentData = param1;
            dispatchEvent(new Event("dataLoaded"));
            return;
        }// end function

        public function dispatchShowDescriptionEvent(param1:IProductType, param2:Point) : void
        {
            this._descrCords = param2;
            dispatchEvent(new Event("showDescription"));
            return;
        }// end function

        public function dispatchHideDescriptionEvent() : void
        {
            dispatchEvent(new Event("hideDescription"));
            return;
        }// end function

        private function onComplete(param1:FlexEvent) : void
        {
            this.listContent.name = "productListContainer";
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
