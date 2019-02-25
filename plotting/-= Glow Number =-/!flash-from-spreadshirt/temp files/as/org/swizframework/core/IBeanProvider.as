package org.swizframework.core
{
    import flash.system.*;

    public interface IBeanProvider
    {

        public function IBeanProvider();

        function get beans() : Array;

        function addBean(beans:Bean) : void;

        function removeBean(beans:Bean) : void;

        function initialize(:ApplicationDomain) : void;

    }
}
