package 
{
    import flash.net.*;
    import flash.system.*;
    import mx.accessibility.*;
    import mx.collections.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.graphics.*;
    import mx.managers.systemClasses.*;
    import mx.messaging.messages.*;
    import mx.styles.*;
    import mx.utils.*;

    public class _Confomat_FlexInit extends Object
    {

        public function _Confomat_FlexInit()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var styleManager:IStyleManager2;
            var fbs:* = param1;
            new ChildManager(fbs);
            styleManager = StyleManagerImpl.getInstance();
            fbs.registerImplementation("mx.styles::IStyleManager2", styleManager);
            styleManager.qualifiedTypeSelectors = false;
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("addedEffect", "added");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("completeEffect", "complete");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("creationCompleteEffect", "creationComplete");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("focusInEffect", "focusIn");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("focusOutEffect", "focusOut");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("hideEffect", "hide");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("itemsChangeEffect", "itemsChange");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("mouseDownEffect", "mouseDown");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("mouseUpEffect", "mouseUp");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("moveEffect", "move");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("removedEffect", "removed");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("resizeEffect", "resize");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("resizeEndEffect", "resizeEnd");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("resizeStartEffect", "resizeStart");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("rollOutEffect", "rollOut");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("rollOverEffect", "rollOver");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("showEffect", "show");
            if (Capabilities.hasAccessibility)
            {
                ComboBoxAccImpl.enableAccessibility();
                PanelAccImpl.enableAccessibility();
                TabBarAccImpl.enableAccessibility();
                ListBaseAccImpl.enableAccessibility();
                TitleWindowAccImpl.enableAccessibility();
                ListAccImpl.enableAccessibility();
                AlertAccImpl.enableAccessibility();
                MenuAccImpl.enableAccessibility();
                LabelAccImpl.enableAccessibility();
                RadioButtonAccImpl.enableAccessibility();
                LinkButtonAccImpl.enableAccessibility();
                MenuBarAccImpl.enableAccessibility();
                CheckBoxAccImpl.enableAccessibility();
                ButtonAccImpl.enableAccessibility();
                UIComponentAccProps.enableAccessibility();
                ComboBaseAccImpl.enableAccessibility();
            }
            try
            {
                if (getClassByAlias("flex.messaging.io.ArrayCollection") == null)
                {
                    registerClassAlias("flex.messaging.io.ArrayCollection", ArrayCollection);
                }
            }
            catch (e:Error)
            {
                registerClassAlias("flex.messaging.io.ArrayCollection", ArrayCollection);
                try
                {
                }
                if (getClassByAlias("flex.messaging.io.ArrayList") == null)
                {
                    registerClassAlias("flex.messaging.io.ArrayList", ArrayList);
                }
            }
            catch (e:Error)
            {
                registerClassAlias("flex.messaging.io.ArrayList", ArrayList);
                try
                {
                }
                if (getClassByAlias("flex.graphics.ImageSnapshot") == null)
                {
                    registerClassAlias("flex.graphics.ImageSnapshot", ImageSnapshot);
                }
            }
            catch (e:Error)
            {
                registerClassAlias("flex.graphics.ImageSnapshot", ImageSnapshot);
                try
                {
                }
                if (getClassByAlias("flex.messaging.messages.AcknowledgeMessage") == null)
                {
                    registerClassAlias("flex.messaging.messages.AcknowledgeMessage", AcknowledgeMessage);
                }
            }
            catch (e:Error)
            {
                registerClassAlias("flex.messaging.messages.AcknowledgeMessage", AcknowledgeMessage);
                try
                {
                }
                if (getClassByAlias("DSK") == null)
                {
                    registerClassAlias("DSK", AcknowledgeMessageExt);
                }
            }
            catch (e:Error)
            {
                registerClassAlias("DSK", AcknowledgeMessageExt);
                try
                {
                }
                if (getClassByAlias("flex.messaging.messages.AsyncMessage") == null)
                {
                    registerClassAlias("flex.messaging.messages.AsyncMessage", AsyncMessage);
                }
            }
            catch (e:Error)
            {
                registerClassAlias("flex.messaging.messages.AsyncMessage", AsyncMessage);
                try
                {
                }
                if (getClassByAlias("DSA") == null)
                {
                    registerClassAlias("DSA", AsyncMessageExt);
                }
            }
            catch (e:Error)
            {
                registerClassAlias("DSA", AsyncMessageExt);
                try
                {
                }
                if (getClassByAlias("flex.messaging.messages.ErrorMessage") == null)
                {
                    registerClassAlias("flex.messaging.messages.ErrorMessage", ErrorMessage);
                }
            }
            catch (e:Error)
            {
                registerClassAlias("flex.messaging.messages.ErrorMessage", ErrorMessage);
                try
                {
                }
                if (getClassByAlias("flex.messaging.io.ObjectProxy") == null)
                {
                    registerClassAlias("flex.messaging.io.ObjectProxy", ObjectProxy);
                }
            }
            catch (e:Error)
            {
                registerClassAlias("flex.messaging.io.ObjectProxy", ObjectProxy);
            }
            var styleNames:Array;
            var i:int;
            while (i < styleNames.length)
            {
                
                styleManager.registerInheritingStyle(styleNames[i]);
                i = i++;
            }
            return;
        }// end function

    }
}
