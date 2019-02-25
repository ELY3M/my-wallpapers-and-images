package net.sprd.events
{
    import flash.events.*;
    import net.sprd.models.product.*;
    import net.sprd.services.undo.*;

    public class SnapShotEvent extends Event
    {
        private var _snapShot:ApplicationSnapshot;
        public static const CREATE_SNAPSHOT:String = "createSnapShot";
        public static const CURRENT_STATE_CHANGED:String = "currentStateChanged";

        public function SnapShotEvent(param1:String, param2:ApplicationSnapshot = null, param3:Boolean = false, param4:Boolean = false)
        {
            super(param1, param3, param4);
            this._snapShot = param2;
            return;
        }// end function

        public function get snapShot() : ApplicationSnapshot
        {
            return this._snapShot;
        }// end function

        override public function clone() : Event
        {
            return new SnapShotEvent(type, this._snapShot, bubbles, cancelable);
        }// end function

        public static function createSnapShotEvent(param1:IProductModel) : SnapShotEvent
        {
            var _loc_2:* = param1.product.clone();
            var _loc_3:* = param1.currentAppearance ? (param1.currentAppearance.id) : (null);
            var _loc_4:* = param1.currentSize ? (param1.currentSize.id) : (null);
            var _loc_5:* = param1.currentView ? (param1.currentView.id) : (null);
            var _loc_6:* = param1.selectedConfiguration ? (param1.selectedConfiguration.configurationID) : (null);
            var _loc_7:* = new SnapShotEvent(SnapShotEvent.CREATE_SNAPSHOT, new ApplicationSnapshot(_loc_2, _loc_3, _loc_4, _loc_5, _loc_6));
            return _loc_7;
        }// end function

    }
}
