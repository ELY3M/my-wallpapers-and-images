package 
{
    import ArialItalicBold.*;
    import flash.display.*;
    import flash.system.*;
    import flash.text.*;

    public class ArialItalicBold extends Sprite
    {
        private static var _font:Class = ArialItalicBold__font;

        public function ArialItalicBold()
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
