package net.sprd.common.collections
{

    public interface INavigable extends IIterable, IWithSize
    {

        public function INavigable();

        function get(param1:uint) : Object;

        function toArray() : Array;

    }
}
