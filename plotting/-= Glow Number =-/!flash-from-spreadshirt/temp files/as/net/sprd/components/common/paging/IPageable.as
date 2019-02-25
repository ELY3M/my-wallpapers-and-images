package net.sprd.components.common.paging
{

    public interface IPageable
    {

        public function IPageable();

        function get currentPage() : int;

        function set currentPage(param1:int) : void;

        function get hasPreviousPage() : Boolean;

        function get hasNextPage() : Boolean;

        function get pageCount() : int;

    }
}
