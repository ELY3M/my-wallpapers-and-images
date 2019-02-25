package net.sprd.entities.impl
{
    import net.sprd.valueObjects.*;

    public class Article extends BaseEntity implements IArticle
    {
        private var _name:String;
        private var _description:String;
        private var _price:Money;
        private var _shop:String;
        private var _product:String;

        public function Article()
        {
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function get description() : String
        {
            return this._description;
        }// end function

        public function set description(param1:String) : void
        {
            this._description = param1;
            return;
        }// end function

        public function get price() : Money
        {
            return this._price;
        }// end function

        public function set price(param1:Money) : void
        {
            this._price = param1;
            return;
        }// end function

        public function get shop() : String
        {
            return this._shop;
        }// end function

        public function set shop(param1:String) : void
        {
            this._shop = param1;
            return;
        }// end function

        public function get product() : String
        {
            return this._product;
        }// end function

        public function set product(param1:String) : void
        {
            this._product = param1;
            return;
        }// end function

    }
}
