package net.sprd.api.resource
{

    public interface IResourceLoader
    {

        public function IResourceLoader();

        function getResource() : void;

        function putResource() : void;

        function postResource() : void;

        function deleteResource() : void;

    }
}
