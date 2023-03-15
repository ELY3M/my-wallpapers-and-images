package net.sprd.services.image
{
    import net.sprd.services.image.model.*;

    public interface IImageService
    {

        public function IImageService();

        function get endPoint() : String;

        function set endPoint(param1:String) : void;

        function get version() : String;

        function set version(param1:String) : void;

        function productTypeImage(param1:String, param2:String, param3:String, param4:Number, param5:Number, param6:String) : ProductTypeImage;

        function designImage(param1:String, param2:Number, param3:Number) : ConfigurationImage;

    }
}
