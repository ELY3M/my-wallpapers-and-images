package 
{
    import TekniaGreekNormalNormal.*;
    import flash.display.*;
    import flash.system.*;
    import flash.text.*;

    public class TekniaGreekNormalNormal extends Sprite
    {
        private static var _font:Class = TekniaGreekNormalNormal__font;

        public function TekniaGreekNormalNormal()
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
