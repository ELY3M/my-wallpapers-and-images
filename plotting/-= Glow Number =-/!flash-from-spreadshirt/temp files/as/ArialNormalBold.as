package 
{
    import ArialNormalBold.*;
    import flash.display.*;
    import flash.system.*;
    import flash.text.*;

    public class ArialNormalBold extends Sprite
    {
        private static var _font:Class = ArialNormalBold__font;

        public function ArialNormalBold()
        {
            Security.allowDomain("*");
            this.registerFonts();
            return;
        }// end function

        private function registerFonts() : void
        {
            Font.registerFont(_font);
            return;
        }// end function

    }
}
