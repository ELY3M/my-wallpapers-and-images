package net.sprd.models.product
{
    import flashx.textLayout.operations.*;

    public interface ITextOperationStrategy
    {

        public function ITextOperationStrategy();

        function execute(param1:FlowOperation) : TextOperationResult;

        function set decreaseFontSize(param1:Boolean) : void;

        function set checkMaxBounds(param1:Boolean) : void;

        function set collisionAllowed(param1:Boolean) : void;

        function set adjustY(param1:Boolean) : void;

        function get lastResult() : TextOperationResult;

    }
}
