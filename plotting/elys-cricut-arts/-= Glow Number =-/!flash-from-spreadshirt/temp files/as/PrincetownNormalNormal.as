package 
{
    import PrincetownNormalNormal.*;
    import flash.display.*;
    import flash.system.*;
    import flash.text.*;

    public class PrincetownNormalNormal extends Sprite
    {
        private static var _font:Class = PrincetownNormalNormal__font;

        public function PrincetownNormalNormal()
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
