package net.sprd.skins.d2c
{
    import flash.display.*;
    import flash.geom.*;
    import mx.skins.*;
    import net.sprd.common.graphics.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;

    public class ApplicationSkin extends Border
    {
        private static const log:ILogger = LogContext.getLogger(ConfomatClass);

        public function ApplicationSkin()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_5:uint;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = new Matrix();
            _loc_3.createGradientBox(param1, param2, UnitUtil.deg2rad(90));
            graphics.clear();
            graphics.beginGradientFill(GradientType.LINEAR, [13289153, 15461097], [1, 1], [0, 50], _loc_3);
            graphics.drawRect(0, 0, param1 - 1, param2 - 1);
            graphics.endFill();
            _loc_3 = new Matrix();
            _loc_3.translate(param1 / 2, param2 / 2);
            _loc_3.createGradientBox(param1, param2, UnitUtil.deg2rad(38));
            graphics.beginGradientFill(GradientType.RADIAL, [16777215, 13289153], [1, 0], [0, 255], _loc_3);
            graphics.drawRect(0, 0, param1 - 1, param2 - 1);
            graphics.endFill();
            graphics.lineStyle(1, 12894654, 0.8);
            var _loc_4:uint;
            while (_loc_4 <= param1 - 10)
            {
                
                _loc_5 = 38;
                while (_loc_5 <= param2 - 16)
                {
                    
                    if (_loc_4 % 12 != 10)
                    {
                    }
                    if (_loc_5 % 12 == 2)
                    {
                        graphics.moveTo(_loc_4, _loc_5);
                        graphics.lineTo(_loc_4 + 1, _loc_5 + 1);
                    }
                    _loc_5 = _loc_5 + 3;
                }
                _loc_4 = _loc_4 + 3;
            }
            log.debug("Update Application display list" + param1);
            return;
        }// end function

    }
}
