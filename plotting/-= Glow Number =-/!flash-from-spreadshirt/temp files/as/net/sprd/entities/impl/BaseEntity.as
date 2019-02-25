package net.sprd.entities.impl
{
    import flash.events.*;
    import flash.utils.*;
    import net.sprd.api.*;
    import net.sprd.api.resource.*;
    import net.sprd.api.utils.*;
    import net.sprd.entities.*;

    public class BaseEntity extends EventDispatcher implements IBaseEntity
    {
        private var _id:String;
        private var _state:int = 0;
        private var _context:IBaseEntity = null;
        private var _resource:Resource = null;
        private var _modified:Boolean = true;

        public function BaseEntity()
        {
            this._id = IdentityGenerator.createID();
            return;
        }// end function

        public function get id() : String
        {
            return this._id;
        }// end function

        public function set id(param1:String) : void
        {
            if (this._id == param1)
            {
                return;
            }
            this._id = param1;
            this.markModified();
            return;
        }// end function

        public function get resource() : Resource
        {
            return this._resource;
        }// end function

        public function set resource(param1:Resource) : void
        {
            this._resource = param1;
            return;
        }// end function

        public function get oid() : String
        {
            return this.entityType + "_" + this.id;
        }// end function

        public function get state() : int
        {
            return this._state;
        }// end function

        public function set state(param1:int) : void
        {
            this._state = param1;
            return;
        }// end function

        public function get partial() : Boolean
        {
            return this._state == EntityState.PARTIAL;
        }// end function

        public function get entityType() : String
        {
            return APIRegistry.getType(getDefinitionByName(getQualifiedClassName(this)));
        }// end function

        public function get context() : IBaseEntity
        {
            return this._context;
        }// end function

        public function set context(param1:IBaseEntity) : void
        {
            this._context = param1;
            return;
        }// end function

        public function get modified() : Boolean
        {
            return this._modified;
        }// end function

        public function markModified(param1:Boolean = true) : void
        {
            this._modified = param1;
            return;
        }// end function

        public function get immutable() : Boolean
        {
            return true;
        }// end function

        override public function toString() : String
        {
            return getQualifiedClassName(this) + "#" + this.id;
        }// end function

    }
}
