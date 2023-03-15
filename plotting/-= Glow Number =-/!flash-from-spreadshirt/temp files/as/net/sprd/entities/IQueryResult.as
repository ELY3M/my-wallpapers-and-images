package net.sprd.entities
{
    import net.sprd.api.*;

    public interface IQueryResult extends IBaseEntity
    {

        public function IQueryResult();

        function push(param1:IBaseEntity) : void;

        function get items() : Array;

        function get query() : IQuery;

        function set query(param1:IQuery) : void;

        function set totalCount(param1:uint) : void;

        function get totalCount() : uint;

    }
}
