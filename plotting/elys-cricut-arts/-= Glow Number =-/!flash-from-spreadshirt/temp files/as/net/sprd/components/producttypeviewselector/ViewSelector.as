package net.sprd.components.producttypeviewselector
{
    import mx.binding.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.effects.easing.*;
    import mx.states.*;

    public class ViewSelector extends ViewSelectorClass
    {
        private var _documentDescriptor_:UIComponentDescriptor;
        private var __moduleFactoryInitialized:Boolean = false;

        public function ViewSelector()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:ViewSelectorClass});
            mx_internal::_document = this;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.states = [this._ViewSelector_State1_c(), this._ViewSelector_State2_c()];
            this._ViewSelector_Fade2_i();
            this._ViewSelector_Move1_i();
            this._ViewSelector_Fade1_i();
            return;
        }// end function

        override public function set moduleFactory(param1:IFlexModuleFactory) : void
        {
            super.moduleFactory = param1;
            if (this.__moduleFactoryInitialized)
            {
                return;
            }
            this.__moduleFactoryInitialized = true;
            return;
        }// end function

        override public function initialize() : void
        {
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            super.initialize();
            return;
        }// end function

        private function _ViewSelector_Fade2_i() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaFrom = 1;
            _loc_1.alphaTo = 0;
            _loc_1.duration = 100;
            _loc_1.startDelay = 500;
            hideThumb = _loc_1;
            BindingManager.executeBindings(this, "hideThumb", hideThumb);
            return _loc_1;
        }// end function

        private function _ViewSelector_Move1_i() : Move
        {
            var _loc_1:* = new Move();
            _loc_1.easingFunction = Cubic.easeInOut;
            _loc_1.duration = 500;
            _loc_1.startDelay = 0;
            positionComponent = _loc_1;
            BindingManager.executeBindings(this, "positionComponent", positionComponent);
            return _loc_1;
        }// end function

        private function _ViewSelector_Fade1_i() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.alphaFrom = 0;
            _loc_1.alphaTo = 1;
            _loc_1.duration = 300;
            _loc_1.startDelay = 1000;
            showThumb = _loc_1;
            BindingManager.executeBindings(this, "showThumb", showThumb);
            return _loc_1;
        }// end function

        private function _ViewSelector_State1_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "open";
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

        private function _ViewSelector_State2_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "closed";
            BindingManager.executeBindings(this, "temp", _loc_1);
            return _loc_1;
        }// end function

    }
}
