package net.sprd.common.collections
{

    public interface IIterator
    {

        public function IIterator();

        function hasNext() : Boolean;

        function next() : Object;

        function remove() : void;

    }
}
