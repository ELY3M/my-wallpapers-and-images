package net.sprd.services.undo
{
    import net.sprd.entities.*;

    public class ApplicationSnapshot extends Object
    {
        private var _product:IProduct;
        private var _appearanceId:String;
        private var _sizeId:String;
        private var _viewId:String;
        private var _selectedConfigurationId:String;

        public function ApplicationSnapshot(param1:IProduct, param2:String, param3:String, param4:String, param5:String)
        {
            this._product = param1;
            this._appearanceId = param2;
            this._sizeId = param3;
            this._viewId = param4;
            this._selectedConfigurationId = param5;
            return;
        }// end function

        public function get product() : IProduct
        {
            return this._product;
        }// end function

        public function get appearanceId() : String
        {
            return this._appearanceId;
        }// end function

        public function get sizeId() : String
        {
            return this._sizeId;
        }// end function

        public function get viewId() : String
        {
            return this._viewId;
        }// end function

        public function get selectedConfiguration() : String
        {
            return this._selectedConfigurationId;
        }// end function

    }
}
