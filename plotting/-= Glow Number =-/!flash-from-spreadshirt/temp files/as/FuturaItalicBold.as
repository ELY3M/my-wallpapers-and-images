package 
{
    import FuturaItalicBold.*;
    import flash.display.*;
    import flash.system.*;
    import flash.text.*;

    public class FuturaItalicBold extends Sprite
    {
        private static var _font:Class = FuturaItalicBold__font;

        public function FuturaItalicBold()
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
