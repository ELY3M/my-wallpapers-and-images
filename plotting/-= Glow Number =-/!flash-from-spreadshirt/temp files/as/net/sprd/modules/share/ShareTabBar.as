package net.sprd.modules.share
{
    import flash.display.*;
    import flash.events.*;
    import mx.controls.*;
    import mx.core.*;

    public class ShareTabBar extends TabBar
    {
        private var mouseDown:Boolean;

        public function ShareTabBar()
        {
            navItemFactory = new ClassFactory(ShareTabComponent);
            return;
        }// end function

        override protected function createNavItem(param1:String, param2:Class = null) : IFlexDisplayObject
        {
            var _loc_3:* = super.createNavItem(param1, param2);
            DisplayObject(_loc_3).addEventListener(MouseEvent.MOUSE_DOWN, this.tab_mouseDownHandler, false, 100);
            DisplayObject(_loc_3).addEventListener(MouseEvent.MOUSE_UP, this.tab_mouseUpHandler);
            return _loc_3;
        }// end function

        override protected function clickHandler(param1:MouseEvent) : void
        {
            if (this.mouseDown)
            {
                return;
            }
            super.clickHandler(param1);
            return;
        }// end function

        private function tab_mouseDownHandler(param1:MouseEvent) : void
        {
            this.mouseDown = true;
            return;
        }// end function

        private function tab_mouseUpHandler(param1:MouseEvent) : void
        {
            this.mouseDown = false;
            return;
        }// end function

        private function tab_doubleClickHandler(param1:MouseEvent) : void
        {
            Button(param1.currentTarget).selected = true;
            return;
        }// end function

    }
}
