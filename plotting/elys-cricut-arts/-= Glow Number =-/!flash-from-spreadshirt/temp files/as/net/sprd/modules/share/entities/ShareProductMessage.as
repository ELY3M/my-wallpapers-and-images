package net.sprd.modules.share.entities
{
    import flash.utils.*;

    public class ShareProductMessage extends Message
    {
        protected var _mailFrom:String;
        protected var _mailTo:String;
        protected var _productDeeplinkURL:String;
        protected var _productId:String;
        protected var _viewIds:Array;
        protected var _shopId:String;
        protected var _locale:String;
        protected var _message:String;
        protected var _nameFrom:String;
        protected var _nameTo:String;
        protected var _userId:String;

        public function ShareProductMessage()
        {
            this._viewIds = [];
            super._type = "sprd:shareProduct";
            return;
        }// end function

        override public function properties() : Dictionary
        {
            var _loc_1:* = super.properties();
            _loc_1["mailFrom"] = this.mailFrom;
            _loc_1["mailTo"] = this.mailTo;
            _loc_1["productDeeplinkURL"] = this.productDeeplinkURL;
            _loc_1["productId"] = this.productId;
            _loc_1["viewIds"] = this.viewIds.join(",");
            _loc_1["shopId"] = this.shopId;
            _loc_1["locale"] = this.locale;
            _loc_1["message"] = this.message;
            if (this.userId)
            {
                _loc_1["userId"] = this.userId;
            }
            if (this.nameFrom)
            {
                _loc_1["nameFrom"] = this.nameFrom;
            }
            if (this.nameTo)
            {
                _loc_1["nameTo"] = this.nameTo;
            }
            return _loc_1;
        }// end function

        public function get mailFrom() : String
        {
            return this._mailFrom;
        }// end function

        public function set mailFrom(param1:String) : void
        {
            this._mailFrom = param1;
            return;
        }// end function

        public function get mailTo() : String
        {
            return this._mailTo;
        }// end function

        public function set mailTo(param1:String) : void
        {
            this._mailTo = param1;
            return;
        }// end function

        public function get productDeeplinkURL() : String
        {
            return this._productDeeplinkURL;
        }// end function

        public function set productDeeplinkURL(param1:String) : void
        {
            this._productDeeplinkURL = param1;
            return;
        }// end function

        public function get productId() : String
        {
            return this._productId;
        }// end function

        public function set productId(param1:String) : void
        {
            this._productId = param1;
            return;
        }// end function

        public function get shopId() : String
        {
            return this._shopId;
        }// end function

        public function set shopId(param1:String) : void
        {
            this._shopId = param1;
            return;
        }// end function

        public function get locale() : String
        {
            return this._locale;
        }// end function

        public function set locale(param1:String) : void
        {
            this._locale = param1;
            return;
        }// end function

        public function get message() : String
        {
            return this._message;
        }// end function

        public function set message(param1:String) : void
        {
            this._message = param1;
            return;
        }// end function

        public function get nameFrom() : String
        {
            return this._nameFrom;
        }// end function

        public function set nameFrom(param1:String) : void
        {
            this._nameFrom = param1;
            return;
        }// end function

        public function get nameTo() : String
        {
            return this._nameTo;
        }// end function

        public function set nameTo(param1:String) : void
        {
            this._nameTo = param1;
            return;
        }// end function

        public function get userId() : String
        {
            return this._userId;
        }// end function

        public function set userId(param1:String) : void
        {
            this._userId = param1;
            return;
        }// end function

        public function get viewIds() : Array
        {
            return this._viewIds;
        }// end function

    }
}
