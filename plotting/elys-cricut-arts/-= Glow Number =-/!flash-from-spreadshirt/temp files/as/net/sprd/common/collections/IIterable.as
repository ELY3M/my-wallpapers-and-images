package net.sprd.common.collections
{

    public interface IIterable
    {

        public function IIterable();

        function iterator() : IIterator;

        function contains(param1:Object) : Boolean;

        function containsAll(param1:IIterable) : Boolean;

    }
}
