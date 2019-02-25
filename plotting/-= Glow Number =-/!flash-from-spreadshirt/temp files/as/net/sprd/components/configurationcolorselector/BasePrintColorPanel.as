package net.sprd.components.configurationcolorselector
{
    import net.sprd.components.common.toolpanel.*;
    import net.sprd.models.product.*;

    public class BasePrintColorPanel extends ToolPanel
    {
        private var _targetColorIndex:uint;
        protected var _targetColorIndexChanged:Boolean;

        public function BasePrintColorPanel()
        {
            return;
        }// end function

        public function set configuration(param1:IConfigurationModel) : void
        {
            throw new Error("override me");
        }// end function

        public function get targetColorIndex() : uint
        {
            return this._targetColorIndex;
        }// end function

        public function set targetColorIndex(param1:uint) : void
        {
            this._targetColorIndex = param1;
            this._targetColorIndexChanged = true;
            invalidateProperties();
            return;
        }// end function

    }
}
