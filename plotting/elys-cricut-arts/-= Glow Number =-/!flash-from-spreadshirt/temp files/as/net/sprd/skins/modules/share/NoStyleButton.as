package net.sprd.skins.modules.share
{
    import mx.skins.*;

    public class NoStyleButton extends ProgrammaticSkin
    {

        public function NoStyleButton()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            graphics.clear();
            graphics.beginFill(16777215, 0.01);
            graphics.drawRect(0, 0, param1, param2);
            return;
        }// end function

    }
}
