package net.sprd.entities.impl
{
    import net.sprd.common.collections.*;

    public class FontFamily extends BaseEntity implements IFontFamily
    {
        private var _name:String;
        private var _styles:ICollection;
        private var _deprecated:Boolean;

        public function FontFamily()
        {
            this._styles = new ArrayList();
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function get styles() : Array
        {
            return this._styles.toArray();
        }// end function

        public function addStyle(param1:String) : void
        {
            this._styles.add(param1);
            return;
        }// end function

        public function set deprecated(param1:Boolean) : void
        {
            this._deprecated = param1;
            return;
        }// end function

        public function get deprecated() : Boolean
        {
            return this._deprecated;
        }// end function

        public function getEmbeddedFontName() : String
        {
            return this._name ? ("_" + this._name.split(" ").join("")) : ("");
        }// end function

    }
}
