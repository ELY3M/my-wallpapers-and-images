package net.sprd.graphics.svg.xml
{
    import net.sprd.graphics.svg.*;

    public class XMLUtil extends Object
    {

        public function XMLUtil()
        {
            return;
        }// end function

        public static function transformationAsString(param1:ISVGShape) : String
        {
            var _loc_2:String;
            var _loc_3:ISVGTransformation;
            if (param1.transformations.length > 0)
            {
                _loc_2 = "";
                for each (_loc_3 in param1.transformations)
                {
                    
                    _loc_2 = _loc_3.svgAttribute + " " + _loc_2;
                }
                return _loc_2;
            }
            return null;
        }// end function

    }
}
