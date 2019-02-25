package net.sprd.entities.impl
{

    public class Shop extends BaseEntity implements IShop
    {
        private var _user:String;
        private var _country:String;
        private var _language:String;
        private var _currency:String;

        public function Shop()
        {
            return;
        }// end function

        public function get user() : String
        {
            return this._user;
        }// end function

        public function set user(param1:String) : void
        {
            this._user = param1;
            return;
        }// end function

        public function get country() : String
        {
            return this._country;
        }// end function

        public function set country(param1:String) : void
        {
            this._country = param1;
            return;
        }// end function

        public function get language() : String
        {
            return this._language;
        }// end function

        public function set language(param1:String) : void
        {
            this._language = param1;
            return;
        }// end function

        public function get currency() : String
        {
            return this._currency;
        }// end function

        public function set currency(param1:String) : void
        {
            this._currency = param1;
            return;
        }// end function

    }
}
