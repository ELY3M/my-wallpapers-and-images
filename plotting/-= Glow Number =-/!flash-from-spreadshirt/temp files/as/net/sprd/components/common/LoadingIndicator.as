package net.sprd.components.common
{
    import flash.display.*;
    import mx.core.*;

    public class LoadingIndicator extends UIComponent
    {
        private var progressIndicator:Class;
        private var loader:Sprite;

        public function LoadingIndicator()
        {
            this.progressIndicator = LoadingIndicator_progressIndicator;
            this.width = 20;
            this.height = 20;
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.loader = Sprite(new this.progressIndicator());
            this.loader.mouseEnabled = false;
            this.loader.mouseChildren = false;
            this.loader.name = "loader";
            this.loader.x = 10;
            this.loader.y = 10;
            return;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            super.visible = param1;
            if (param1)
            {
                if (!this.loader.parent)
                {
                    addChild(this.loader);
                }
            }
            else if (this.loader.parent)
            {
                removeChild(this.loader);
            }
            return;
        }// end function

    }
}
