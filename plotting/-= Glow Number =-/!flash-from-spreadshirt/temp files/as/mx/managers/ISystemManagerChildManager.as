package mx.managers
{
    import flash.display.*;

    public interface ISystemManagerChildManager
    {

        public function ISystemManagerChildManager();

        function addingChild(Number:DisplayObject) : void;

        function childAdded(Number:DisplayObject) : void;

        function childRemoved(Number:DisplayObject) : void;

        function removingChild(Number:DisplayObject) : void;

        function initializeTopLevelWindow(:Number, :Number) : void;

    }
}
