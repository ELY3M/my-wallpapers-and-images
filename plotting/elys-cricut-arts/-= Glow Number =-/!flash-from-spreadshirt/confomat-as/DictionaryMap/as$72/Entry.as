package DictionaryMap.as$72
{

    private class Entry extends Object implements IEntry
    {
        private var _key:Object;
        private var _value:Object;

        private function Entry(param1:Object, param2:Object)
        {
            this._key = param1;
            this._value = param2;
            return;
        }// end function

        public function get key() : Object
        {
            return this._key;
        }// end function

        public function get value() : Object
        {
            return this._value;
        }// end function

    }
}
