package net.sprd.common.collections
{

    public interface ISortedSet extends ISet
    {

        public function ISortedSet();

        function get comparator() : Function;

        function set comparator(param1:Function) : void;

        function subSet(param1:Object, param2:Object) : ISortedSet;

        function headSet(param1:Object) : ISortedSet;

        function tailSet(param1:Object) : ISortedSet;

        function first() : Object;

        function last() : Object;

        function poll() : Object;

    }
}
