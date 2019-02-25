package net.sprd.models.product
{
    import mx.resources.*;
    import net.sprd.entities.*;

    public class ProductTypeUsageConstraints extends Object
    {
        private var _hasConstraints:Boolean;
        private var _missingViews:Array;
        private var _missingPrintTypes:Array;
        private var _unfittingConfiurations:Array;

        public function ProductTypeUsageConstraints()
        {
            this._missingViews = [];
            this._missingPrintTypes = [];
            this._unfittingConfiurations = [];
            return;
        }// end function

        public function get hasConstraints() : Boolean
        {
            return this._hasConstraints;
        }// end function

        public function addMissingView(param1:IProductTypeView) : void
        {
            if (this._missingViews.indexOf(param1) > -1)
            {
                return;
            }
            this._hasConstraints = true;
            this._missingViews.push(param1);
            return;
        }// end function

        public function addMissingPrintType(param1:IPrintType) : void
        {
            if (this._missingPrintTypes.indexOf(param1.id) > -1)
            {
                return;
            }
            this._hasConstraints = true;
            this._missingPrintTypes.push(param1.id);
            return;
        }// end function

        public function addUnfittingConfiguration(param1:IConfigurationModel) : void
        {
            if (this._unfittingConfiurations.indexOf(param1) > -1)
            {
                return;
            }
            this._hasConstraints = true;
            this._unfittingConfiurations.push(param1);
            return;
        }// end function

        public function toString() : String
        {
            var _loc_1:String;
            var _loc_2:* = ResourceManager.getInstance();
            if (this._unfittingConfiurations.length > 0)
            {
                _loc_1 = _loc_2.getString("confomat7", "messages_system.producttype_conflict_printarea_size");
            }
            if (this._missingViews.length > 0)
            {
                _loc_1 = _loc_2.getString("confomat7", "messages_system.producttype_conflict_perspectives");
            }
            if (this._missingPrintTypes.length > 0)
            {
                _loc_1 = _loc_2.getString("confomat7", "messages_system.producttype_conflict_printtypes");
            }
            return _loc_1;
        }// end function

    }
}
