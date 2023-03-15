package net.sprd.services.memento.serializers
{
    import net.sprd.api.*;
    import net.sprd.entities.*;
    import net.sprd.entities.impl.*;

    public class ProductSerializer extends Object
    {
        private var configurationSerializer:ConfigurationSerializer;

        public function ProductSerializer()
        {
            this.configurationSerializer = new ConfigurationSerializer();
            return;
        }// end function

        public function serialize(param1:Object) : Object
        {
            var _loc_4:IConfiguration;
            var _loc_2:* = IProduct(param1);
            var _loc_3:Object;
            _loc_3.id = _loc_2.id;
            _loc_3.name = _loc_2.name;
            _loc_3.user = API.em.userID;
            _loc_3.productType = _loc_2.productType;
            _loc_3.productTypeAppearance = _loc_2.productTypeAppearance;
            _loc_3.allowsFreeColorSelection = _loc_2.allowsFreeColorSelection;
            _loc_3.isExample = _loc_2.isExample;
            _loc_3.configurations = [];
            for each (_loc_4 in _loc_2.configurations)
            {
                
                _loc_3.configurations.push(this.configurationSerializer.serialize(_loc_4));
            }
            _loc_3.defaultView = _loc_2.defaultView;
            return _loc_3;
        }// end function

        public function deserialize(param1:Object) : Object
        {
            var _loc_4:IConfiguration;
            var _loc_5:Object;
            var _loc_2:* = Product(API.em.getOrCreate(param1.id, APIRegistry.PRODUCT));
            if (_loc_2.state == EntityState.LOADED)
            {
                return _loc_2;
            }
            _loc_2.name = param1.name;
            _loc_2.state = EntityState.LOADED;
            _loc_2.user = param1.user;
            _loc_2.productType = param1.productType;
            var _loc_3:* = param1.productTypeAppearance;
            if (_loc_3.indexOf("_") != -1)
            {
                _loc_3 = _loc_3.split("_")[1];
            }
            _loc_2.productTypeAppearance = _loc_3;
            _loc_2.allowsFreeColorSelection = param1.allowsFreeColorSelection;
            _loc_2.isExample = param1.isExample;
            for each (_loc_5 in param1.configurations)
            {
                
                _loc_4 = this.configurationSerializer.deserialize(_loc_5) as Configuration;
                _loc_2.addConfiguration(_loc_4);
            }
            _loc_2.defaultView = param1.defaultView;
            return _loc_2;
        }// end function

    }
}
