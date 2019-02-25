package org.swizframework.metadata
{
    import org.swizframework.core.*;
    import org.swizframework.reflection.*;

    public class EventTypeExpression extends Object
    {
        protected var swiz:ISwiz;
        protected var expression:String;
        protected var _eventClass:Class;
        protected var _eventTypes:Array;

        public function EventTypeExpression(TypeDescriptor:String, Constant:ISwiz)
        {
            this.swiz = Constant;
            this.expression = TypeDescriptor;
            this.parse();
            return;
        }// end function

        public function get eventClass() : Class
        {
            return this._eventClass;
        }// end function

        public function get eventTypes() : Array
        {
            return this._eventTypes;
        }// end function

        protected function parse() : void
        {
            var _loc_1:TypeDescriptor;
            var _loc_2:Constant;
            if (this.swiz.config.strict)
            {
            }
            if (ClassConstant.isClassConstant(this.expression))
            {
                this._eventClass = ClassConstant.getClass(this.swiz.domain, this.expression, this.swiz.config.eventPackages);
                if (this.expression.substr(-2) == ".*")
                {
                    _loc_1 = TypeCache.getTypeDescriptor(this._eventClass, this.swiz.domain);
                    this._eventTypes = new Array();
                    for each (_loc_2 in _loc_1.constants)
                    {
                        
                        this._eventTypes.push(_loc_2.value);
                    }
                }
                else
                {
                    this._eventTypes = [ClassConstant.getConstantValue(this.swiz.domain, this._eventClass, ClassConstant.getConstantName(this.expression))];
                }
            }
            else
            {
                this._eventClass = null;
                this._eventTypes = [this.expression];
            }
            return;
        }// end function

    }
}
