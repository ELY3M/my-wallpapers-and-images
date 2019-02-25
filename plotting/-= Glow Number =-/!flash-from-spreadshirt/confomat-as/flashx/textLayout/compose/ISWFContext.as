package flashx.textLayout.compose
{

    public interface ISWFContext
    {

        public function ISWFContext();

        function callInContext(Array:Function, Boolean:Object, callInContext:Array, ISWFContext:Boolean = true);

    }
}
