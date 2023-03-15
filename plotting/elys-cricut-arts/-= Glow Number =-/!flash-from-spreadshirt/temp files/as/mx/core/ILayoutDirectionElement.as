package mx.core
{
    import flash.geom.*;

    public interface ILayoutDirectionElement
    {

        public function ILayoutDirectionElement();

        function get layoutDirection() : String;

        function set layoutDirection(Transform:String) : void;

        function invalidateLayoutDirection() : void;

    }
}
