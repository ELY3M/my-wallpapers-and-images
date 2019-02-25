package 
{
    import _Confomat_mx_managers_SystemManager.*;
    import flash.system.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.managers.*;

    public class _Confomat_mx_managers_SystemManager extends SystemManager implements IFlexModuleFactory, ISWFContext
    {
        private var _preloadedRSLs:Dictionary;

        public function _Confomat_mx_managers_SystemManager()
        {
            FlexVersion.compatibilityVersionString = "3.0.0";
            return;
        }// end function

        override public function callInContext(param1:Function, param2:Object, param3:Array, param4:Boolean = true)
        {
            if (param4)
            {
                return param1.apply(param2, param3);
            }
            param1.apply(param2, param3);
            return;
        }// end function

        override public function create(... args) : Object
        {
            if (args.length > 0)
            {
            }
            if (!(args[0] is String))
            {
                return super.create.apply(this, args);
            }
            var _loc_2:* = args.length == 0 ? ("Confomat") : (String(args[0]));
            var _loc_3:* = Class(getDefinitionByName(_loc_2));
            if (!_loc_3)
            {
                return null;
            }
            var _loc_4:* = new _loc_3;
            if (_loc_4 is IFlexModule)
            {
                IFlexModule(_loc_4).moduleFactory = this;
            }
            if (args.length == 0)
            {
                Singleton.registerClass("mx.core::IEmbeddedFontRegistry", Class(getDefinitionByName("mx.core::EmbeddedFontRegistry")));
                EmbeddedFontRegistry.registerFonts(this.info()["fonts"], this);
            }
            return _loc_4;
        }// end function

        override public function info() : Object
        {
            return {backgroundColor:"0xFFFFFF", cdRsls:[{rsls:["../lib/textLayout_1.0.0.595.swz"], policyFiles:[""], digests:["7421c71f94db4f028e7528b2d278f3fe4dc21273e3cc1c663c569f102564811c"], types:["SHA-256"], isSigned:[true]}, {rsls:["../lib/framework_4.0.0.14159.swz"], policyFiles:[""], digests:["f74fcd943bac79e6dadbf0307b55b0697c5907e49161e6970b8452e8dcd92d04"], types:["SHA-256"], isSigned:[true]}], compiledLocales:["en_US"], compiledResourceBundleNames:["SharedResources", "collections", "confomat7", "containers", "controls", "core", "effects", "formatters", "skins", "styles"], currentDomain:ApplicationDomain.currentDomain, fonts:{TheSerif:{regular:true, bold:false, italic:false, boldItalic:false}, TheSerifCCF:{regular:true, bold:false, italic:false, boldItalic:false}, TheSerifSemiBold:{regular:true, bold:false, italic:true, boldItalic:false}, Trebuchet:{regular:true, bold:false, italic:false, boldItalic:false}}, height:"560", horizontalScrollPolicy:"off", layout:"absolute", mainClassName:"Confomat", mixins:["_Confomat_FlexInit", "_Confomat_Styles", "mx.managers.systemClasses.ActiveWindowManager"], preinitialize:"preInit()", preloader:SprdPreloader, verticalScrollPolicy:"off", width:"980"};
        }// end function

        override public function get preloadedRSLs() : Dictionary
        {
            if (this._preloadedRSLs == null)
            {
                this._preloadedRSLs = new Dictionary(true);
            }
            return this._preloadedRSLs;
        }// end function

        override public function allowDomain(... args) : void
        {
            var _loc_2:Object;
            Security.allowDomain(args);
            for (_loc_2 in this._preloadedRSLs)
            {
                
                if (_loc_2.content)
                {
                }
                if ("allowDomainInRSL" in _loc_2.content)
                {
                    var _loc_5:* = _loc_2.content;
                    _loc_5._loc_2.content["allowDomainInRSL"](args);
                }
            }
            return;
        }// end function

        override public function allowInsecureDomain(... args) : void
        {
            var _loc_2:Object;
            Security.allowInsecureDomain(args);
            for (_loc_2 in this._preloadedRSLs)
            {
                
                if (_loc_2.content)
                {
                }
                if ("allowInsecureDomainInRSL" in _loc_2.content)
                {
                    var _loc_5:* = _loc_2.content;
                    _loc_5._loc_2.content["allowInsecureDomainInRSL"](args);
                }
            }
            return;
        }// end function

    }
}
