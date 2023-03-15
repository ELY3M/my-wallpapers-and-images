package net.sprd.api.plan
{

    public interface IFetchPlan
    {

        public function IFetchPlan();

        function get evict() : Boolean;

        function set evict(param1:Boolean) : void;

        function get eager() : Boolean;

        function get partial() : Boolean;

        function set partial(param1:Boolean) : void;

        function get stopRules() : Array;

        function get uniqueHash() : Boolean;

        function set uniqueHash(param1:Boolean) : void;

    }
}
