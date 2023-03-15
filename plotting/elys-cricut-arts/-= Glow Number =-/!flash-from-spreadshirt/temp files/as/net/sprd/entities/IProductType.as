package net.sprd.entities
{
    import flash.utils.*;
    import net.sprd.valueObjects.*;

    public interface IProductType extends IBaseEntity
    {

        public function IProductType();

        function get name() : String;

        function set name(param1:String) : void;

        function get description() : String;

        function set description(param1:String) : void;

        function get brand() : String;

        function set brand(param1:String) : void;

        function get price() : Money;

        function set price(param1:Money) : void;

        function get defaultAppearance() : IProductTypeAppearance;

        function set defaultAppearance(param1:IProductTypeAppearance) : void;

        function get appearances() : Array;

        function addAppearance(param1:IProductTypeAppearance) : void;

        function getAppearanceById(param1:String) : IProductTypeAppearance;

        function setDefaultAppearanceById(param1:String) : void;

        function get sizes() : Array;

        function addSize(param1:IProductTypeSize) : void;

        function getSizeById(param1:String) : IProductTypeSize;

        function get defaultView() : IProductTypeView;

        function setDefaultViewById(param1:String) : void;

        function get views() : Array;

        function addView(param1:IProductTypeView) : void;

        function getViewById(param1:String) : IProductTypeView;

        function get printAreas() : Array;

        function addPrintArea(param1:String) : void;

        function isOnStock(param1:String, param2:String) : Boolean;

        function setOnStock(param1:String, param2:String, param3:Boolean) : void;

        function get stockStates() : Dictionary;

        function get lifeCycleState() : int;

        function set lifeCycleState(param1:int) : void;

        function get attributes() : Array;

        function isValid() : Boolean;

    }
}
