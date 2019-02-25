package net.sprd.services.i18n
{
    import flash.events.*;
    import flash.net.*;
    import mx.controls.*;
    import mx.resources.*;
    import mx.utils.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;
    import net.sprd.events.*;

    public class I18n extends Object
    {
        public var bus:IEventDispatcher;
        private var mustUpdate:Boolean;
        private var locale:String;
        private var initialized:Boolean;
        public static const C7:String = "confomat7";
        private static const DEFAULT_BOGUS_LOCALE:String = "en_US";
        private static var _endPoint:String = "http://www.spreadshirt.net/cache/xml/languages";
        private static const log:ILogger = LogContext.getLogger(this);
        private static var rm:IResourceManager = ResourceManager.getInstance();
        private static const locales:Object = {de_DE:"de", de_AT:"de", dk_DK:"dk", en_EU:"en", en_GB:"en", en_IE:"en", us_US:"us", es_ES:"es", fi_FI:"fi", fr_FR:"fr", fr_BE:"fr", fr_US:"fr", fr_CA:"fr", it_IT:"it", ja_JA:"ja", jp_JP:"jp", nl_NL:"nl", nl_BE:"nl", no_NO:"no", pl_PL:"pl", ru_RU:"ru", se_SE:"se"};

        public function I18n()
        {
            return;
        }// end function

        public function postConstruct() : void
        {
            this.initialized = true;
            if (this.mustUpdate)
            {
                this.mustUpdate = false;
                this.update();
            }
            return;
        }// end function

        private function getLanguageCode(param1:String) : String
        {
            return param1.substring(0, 2);
        }// end function

        private function update() : void
        {
            var loader:URLLoader;
            var url:String;
            var request:URLRequest;
            if (!this.initialized)
            {
                this.mustUpdate = true;
                return;
            }
            if (!rm.getResourceBundle(String(this.locale), C7))
            {
                loader = new URLLoader();
                url = _endPoint + "/" + this.getLanguageCode(this.locale) + "/confomat7.properties";
                request = new URLRequest(url);
                EventUtil.registerOnetimeListeners(loader, [Event.COMPLETE, IOErrorEvent.IO_ERROR, SecurityErrorEvent.SECURITY_ERROR], [function (param1:Event) : void
            {
                parseData(locale, String(loader.data));
                replaceHTMLEncodedCharactersInLoadedBundle();
                bus.dispatchEvent(new ApplicationEvent(ApplicationEvent.COUNTRY_CHANGED));
                return;
            }// end function
            , function (param1:Event)
            {
                log.warn("IO Error loading locale \'" + locale + "\': " + param1.toString());
                replaceHTMLEncodedCharactersInLoadedBundle();
                return;
            }// end function
            , function (param1:Event)
            {
                log.warn("Security Error loading locale \'" + locale + "\': " + param1.toString());
                replaceHTMLEncodedCharactersInLoadedBundle();
                return;
            }// end function
            ]);
                loader.load(request);
            }
            else
            {
                this.replaceHTMLEncodedCharactersInLoadedBundle();
            }
            return;
        }// end function

        public function set endPoint(param1:String) : void
        {
            _endPoint = param1;
            return;
        }// end function

        public function setLocale(param1:String) : void
        {
            this.locale = param1;
            rm.localeChain = [param1, DEFAULT_BOGUS_LOCALE];
            this.update();
            return;
        }// end function

        public function updateGeneralContent() : void
        {
            Alert.yesLabel = rm.getString("confomat7", "universal.yes");
            Alert.noLabel = rm.getString("confomat7", "universal.no");
            Alert.okLabel = rm.getString("confomat7", "universal.proceed");
            Alert.cancelLabel = rm.getString("confomat7", "universal.cancel");
            return;
        }// end function

        private function parseData(param1:String, param2:String) : void
        {
            var lines:Array;
            var currentLine:String;
            var line:String;
            var i:int;
            var locale:* = param1;
            var data:* = param2;
            var bundle:* = new ResourceBundle(locale, C7);
            rm.addResourceBundle(bundle);
            lines;
            currentLine;
            var flushLine:* = function () : void
            {
                if (currentLine)
                {
                    lines.push(currentLine);
                }
                currentLine = "";
                return;
            }// end function
            ;
            var appendMode:Boolean;
            var _loc_4:int;
            var _loc_5:* = data.split("\n");
            while (_loc_5 in _loc_4)
            {
                
                line = _loc_5[_loc_4];
                line = StringUtil.trim(line);
                if (line.length != 0)
                {
                }
                if (line.charAt(0) == "#")
                {
                    this.flushLine();
                    continue;
                }
                appendMode = line.charAt(line.length - 1) == "\\";
                if (appendMode)
                {
                    currentLine = currentLine + (line.substring(0, line.length - 1) + " ");
                    continue;
                }
                currentLine = currentLine + line;
                this.flushLine();
            }
            this.flushLine();
            var _loc_4:int;
            var _loc_5:* = lines;
            while (_loc_5 in _loc_4)
            {
                
                line = _loc_5[_loc_4];
                i = line.indexOf("=");
                if (i == -1)
                {
                    log.warn("Can\'t interprete resource line \'" + line + "\' for locale \'" + locale + "\'.");
                    continue;
                }
                bundle.content[line.substring(0, i)] = line.substring(i + 1);
            }
            rm.update();
            this.updateGeneralContent();
            return;
        }// end function

        private function replaceHTMLEncodedCharactersInLoadedBundle() : void
        {
            var _loc_2:String;
            var _loc_1:* = rm.getResourceBundle(String(this.locale), C7);
            if (!_loc_1)
            {
                _loc_1 = rm.getResourceBundle(DEFAULT_BOGUS_LOCALE, C7);
            }
            if (_loc_1)
            {
                for (_loc_2 in _loc_1.content)
                {
                    
                    _loc_1.content[_loc_2] = this.replaceHTMLEncodedCharacters(_loc_1.content[_loc_2]);
                }
            }
            return;
        }// end function

        private function replaceHTMLEncodedCharacters(param1:String) : String
        {
            var _loc_2:* = param1.replace(/&nbsp;/g, " ");
            return _loc_2;
        }// end function

    }
}
