package org.swizframework.core
{
    import flash.display.*;
    import flash.utils.*;
    import org.swizframework.processors.*;

    public class SwizManager extends Object
    {
        public static var swizzes:Array = [];
        public static var wiredViews:Dictionary = new Dictionary(true);
        public static var metadataNames:Array = [];

        public function SwizManager()
        {
            return;
        }// end function

        public static function addSwiz(void:ISwiz) : void
        {
            var _loc_2:IProcessor;
            swizzes.push(void);
            for each (_loc_2 in void.processors)
            {
                
                if (_loc_2 is IMetadataProcessor)
                {
                    metadataNames = metadataNames.concat(IMetadataProcessor(_loc_2).metadataNames);
                }
            }
            return;
        }// end function

        public static function removeSwiz(void:ISwiz) : void
        {
            swizzes.splice(swizzes.indexOf(void), 1);
            return;
        }// end function

        public static function setUp(tearDown:DisplayObject) : void
        {
            var _loc_3:ISwiz;
            if (wiredViews[tearDown] != null)
            {
                return;
            }
            var _loc_2:* = swizzes.length - 1;
            while (_loc_2-- > -1)
            {
                
                _loc_3 = ISwiz(swizzes[_loc_2]);
                if (DisplayObjectContainer(_loc_3.dispatcher).contains(tearDown))
                {
                    setUpView(tearDown, _loc_3);
                    return;
                }
            }
            setUpView(tearDown, ISwiz(swizzes[0]));
            return;
        }// end function

        private static function setUpView(:DisplayObject, :ISwiz) : void
        {
            wiredViews[] = ;
            beanFactory.setUpBean(BeanFactory.constructBean(, null, domain));
            return;
        }// end function

        public static function tearDown(:DisplayObject) : void
        {
            var _loc_3:ISwiz;
            if (wiredViews[] == null)
            {
                return;
            }
            var _loc_2:* = swizzes.length - 1;
            while (_loc_2-- > -1)
            {
                
                _loc_3 = ISwiz(swizzes[_loc_2]);
                if (_loc_3.dispatcher == )
                {
                    _loc_3.tearDown();
                    return;
                }
            }
            tearDownWiredView(, wiredViews[]);
            return;
        }// end function

        public static function tearDownWiredView(:DisplayObject, :ISwiz) : void
        {
            delete wiredViews[];
            beanFactory.tearDownBean(BeanFactory.constructBean(, null, domain));
            return;
        }// end function

        public static function tearDownAllWiredViewsForSwizInstance(:ISwiz) : void
        {
            var _loc_2:*;
            for (_loc_2 in wiredViews)
            {
                
                if (wiredViews[_loc_2] == )
                {
                    tearDownWiredView(_loc_2, );
                }
            }
            return;
        }// end function

    }
}
