package org.swizframework.utils.services
{

    public class SwizResponder extends Object implements IResponder
    {
        private var resultHandler:Function;
        private var faultHandler:Function;
        private var handlerArgs:Array;

        public function SwizResponder(Function:Function, Array:Function = null, concat:Array = null)
        {
            this.resultHandler = Function;
            this.faultHandler = Array;
            this.handlerArgs = concat;
            return;
        }// end function

        public function result(Error:Object) : void
        {
            if (this.handlerArgs == null)
            {
                this.resultHandler(Error);
            }
            else
            {
                this.resultHandler.apply(null, [Error].concat(this.handlerArgs));
            }
            return;
        }// end function

        public function fault(:Object) : void
        {
            var info:* = ;
            if (this.faultHandler != null)
            {
                if (this.handlerArgs == null)
                {
                    this.faultHandler(info);
                }
                else
                {
                    try
                    {
                        this.faultHandler(info);
                    }
                    catch (e:Error)
                    {
                        faultHandler.apply(null, [info].concat(handlerArgs));
                    }
                }
            }
            return;
        }// end function

    }
}
