package net.sprd.models.product.renderer
{
    import flash.display.*;

    public interface IConfigurationRenderer extends IEventDispatcher
    {

        public function IConfigurationRenderer();

        function loadAssets() : void;

        function render() : Sprite;

        function layers() : Array;

    }
}
