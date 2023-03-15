package net.sprd.entities.impl
{
    import net.sprd.api.*;
    import net.sprd.entities.*;

    public class QueryResult extends BaseEntity implements IQueryResult
    {
        private var _query:IQuery;
        private var _items:Array;
        private var _totalCount:uint;

        public function QueryResult(param1:IQuery = null)
        {
            this._items = new Array();
            this.query = param1;
            return;
        }// end function

        public function from(param1:QueryResult) : void
        {
            this._items = param1._items;
            state = param1.state;
            this._totalCount = param1._totalCount;
            return;
        }// end function

        public function push(param1:IBaseEntity) : void
        {
            this._items.push(param1);
            return;
        }// end function

        public function get items() : Array
        {
            return this._items;
        }// end function

        public function set query(param1:IQuery) : void
        {
            this._query = param1;
            if (this._query != null)
            {
                id = this._query.id;
            }
            return;
        }// end function

        public function get query() : IQuery
        {
            return this._query;
        }// end function

        public function set totalCount(param1:uint) : void
        {
            this._totalCount = param1;
            return;
        }// end function

        public function get totalCount() : uint
        {
            return this._totalCount;
        }// end function

    }
}
