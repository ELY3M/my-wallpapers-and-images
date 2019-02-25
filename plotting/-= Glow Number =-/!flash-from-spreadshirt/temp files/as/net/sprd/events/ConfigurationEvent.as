package net.sprd.events
{
    import flash.events.*;
    import net.sprd.models.product.*;

    public class ConfigurationEvent extends Event
    {
        private var _configuration:IConfigurationModel;
        public static const ADDED:String = "configurationAdded";
        public static const INITIALIZED:String = "configurationInitialized";
        public static const REMOVED:String = "configurationRemoved";
        public static const TRANSFORMED:String = "configurationTransformed";
        public static const COLOR_CHANGED:String = "configurationColorChanged";
        public static const PRINT_TYPE_CHANGED:String = "configurationPrintTypeChanged";
        public static const FONT_CHANGED:String = "configurationFontChanged";
        public static const TEXT_CHANGED:String = "configurationTextChanged";
        public static const SELECTION_CHANGED:String = "configurationSelectionChanged";
        public static const LAYER_SELECTION_CHANGED:String = "layerSelectionChanged";
        public static const ERROR:String = "configurationError";

        public function ConfigurationEvent(param1:String, param2:IConfigurationModel, param3:Boolean = false, param4:Boolean = false)
        {
            super(param1, param3, param4);
            this._configuration = param2;
            return;
        }// end function

        public function get configuration() : IConfigurationModel
        {
            return this._configuration;
        }// end function

        override public function clone() : Event
        {
            return new ConfigurationEvent(type, this._configuration, bubbles, cancelable);
        }// end function

        override public function toString() : String
        {
            return formatToString("ConfigurationEvent", "type", "bubbles", "cancelable", "eventPhase");
        }// end function

    }
}
