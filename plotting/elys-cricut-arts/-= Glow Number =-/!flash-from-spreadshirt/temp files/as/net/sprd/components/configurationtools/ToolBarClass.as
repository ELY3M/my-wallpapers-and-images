package net.sprd.components.configurationtools
{
    import mx.containers.*;

    public class ToolBarClass extends VBox
    {

        public function ToolBarClass()
        {
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_4:UIComponent;
            super.measure();
            measuredMinWidth = 41;
            measuredMinHeight = 100;
            var _loc_1:* = getStyle("paddingLeft");
            var _loc_2:* = getStyle("paddingRight");
            var _loc_3:Number;
            for each (_loc_4 in getChildren())
            {
                
                _loc_3 = Math.max(_loc_3, _loc_4.getExplicitOrMeasuredWidth());
            }
            measuredWidth = _loc_3 + _loc_1 + _loc_2;
            return;
        }// end function

    }
}
