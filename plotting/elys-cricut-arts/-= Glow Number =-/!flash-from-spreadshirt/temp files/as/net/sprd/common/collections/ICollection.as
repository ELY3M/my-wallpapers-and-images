package net.sprd.common.collections
{

    public interface ICollection extends IIterable, IWithSize
    {

        public function ICollection();

        function add(param1:Object) : Boolean;

        function addAll(param1:ICollection) : Boolean;

        function addArray(param1:Array) : Boolean;

        function clear() : void;

        function remove(param1:Object) : Boolean;

        function removeAll(param1:ICollection) : Boolean;

        function retainAll(param1:ICollection) : Boolean;

        function toArray() : Array;

    }
}
