package net.sprd.entities
{
    import net.sprd.api.resource.*;

    public interface IBaseEntity extends IEventDispatcher
    {

        public function IBaseEntity();

        function get state() : int;

        function set state(param1:int) : void;

        function get id() : String;

        function set id(param1:String) : void;

        function get resource() : Resource;

        function set resource(param1:Resource) : void;

        function get oid() : String;

        function get entityType() : String;

        function get partial() : Boolean;

        function get context() : IBaseEntity;

        function set context(param1:IBaseEntity) : void;

        function get modified() : Boolean;

        function markModified(param1:Boolean = true) : void;

        function get immutable() : Boolean;

    }
}
