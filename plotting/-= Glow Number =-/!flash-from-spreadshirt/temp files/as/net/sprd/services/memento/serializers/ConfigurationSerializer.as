package net.sprd.services.memento.serializers
{
    import flash.geom.*;
    import net.sprd.common.colors.*;
    import net.sprd.entities.*;
    import net.sprd.entities.impl.*;
    import net.sprd.graphics.svg.*;
    import net.sprd.graphics.svg.xml.*;

    public class ConfigurationSerializer extends Object
    {

        public function ConfigurationSerializer()
        {
            return;
        }// end function

        public function serialize(param1:Object) : Object
        {
            var _loc_4:SVGImage;
            var _loc_2:* = IConfiguration(param1);
            var _loc_3:Object;
            _loc_3.id = _loc_2.id;
            _loc_3.type = _loc_2.type;
            _loc_3.printArea = _loc_2.printArea;
            _loc_3.printType = _loc_2.printType;
            _loc_3.offset_x = _loc_2.offset.x;
            _loc_3.offset_y = _loc_2.offset.y;
            _loc_3.designId = _loc_2.designId;
            if (_loc_2.type == ConfigurationType.TEXT)
            {
                _loc_3.text = this.serializeText(SVGText(_loc_2.svgContent));
            }
            else
            {
                _loc_4 = SVGImage(_loc_2.svgContent);
                _loc_3.image = {};
                _loc_3.image.height = _loc_4.height;
                _loc_3.image.width = _loc_4.width;
                _loc_3.image.designID = _loc_4.imageId;
                _loc_3.image.transformations = XMLUtil.transformationAsString(_loc_4);
                _loc_3.image.printColors = _loc_4.printColors;
                _loc_3.image.rgbColors = _loc_4.rgbColors;
            }
            _loc_3.changeable = _loc_2.isChangeable;
            return _loc_3;
        }// end function

        public function deserialize(param1:Object) : Object
        {
            var _loc_2:* = new Configuration();
            _loc_2.id = param1.id;
            _loc_2.state = EntityState.LOADED;
            _loc_2.type = param1.type;
            _loc_2.printArea = param1.printArea;
            _loc_2.printType = param1.printType;
            _loc_2.designId = param1.designId;
            if (_loc_2.type == ConfigurationType.TEXT)
            {
                _loc_2.svgContent = this.deserializeText(param1.text);
            }
            else
            {
                _loc_2.svgContent = new SVGImage();
                _loc_2.svgContent.height = param1.image.height;
                _loc_2.svgContent.width = param1.image.width;
                SVGImage(_loc_2.svgContent).imageId = param1.image.designID;
                _loc_2.svgContent.transformations = SVGParser.parseTransformations(param1.image.transformations);
                _loc_2.svgContent.printColors = param1.image.printColors;
                _loc_2.svgContent.rgbColors = param1.image.rgbColors;
            }
            if (true)
            {
            }
            _loc_2.isChangeable = true;
            _loc_2.offset = new Point(param1.offset_x, param1.offset_y);
            return _loc_2;
        }// end function

        private function deserializeText(param1:Object) : ISVGShape
        {
            var _loc_3:Object;
            var _loc_2:* = new SVGText();
            if (!param1)
            {
                return _loc_2;
            }
            _loc_2.text = param1.text;
            _loc_2.x = param1.x;
            _loc_2.y = param1.y;
            _loc_2.width = param1.width;
            _loc_2.height = param1.height;
            _loc_2.transformations = SVGParser.parseTransformations(String(param1.transformations));
            _loc_2.fontFamily = param1.fontFamily;
            _loc_2.fontStyle = param1.fontStyle;
            _loc_2.fontWeight = param1.fontWeight;
            _loc_2.fontSize = param1.fontSize;
            _loc_2.fillColor = param1.fillColor;
            _loc_2.textAnchor = param1.textAnchor;
            _loc_2.fontFamilyID = param1.fontFamilyID;
            _loc_2.fontID = param1.fontID;
            _loc_2.printColors = param1.printColors;
            _loc_2.rgbColors = param1.rgbColors;
            _loc_2.lineWidth = param1.lineWidth;
            for each (_loc_3 in param1.children)
            {
                
                _loc_2.addTSpan(SVGText(this.deserializeText(_loc_3)));
            }
            return _loc_2;
        }// end function

        public function serializeText(param1:SVGText) : Object
        {
            var _loc_2:Object;
            this.partAttributes(_loc_2, param1);
            this.addChildNodes(_loc_2, param1);
            return _loc_2;
        }// end function

        private function addChildNodes(param1:Object, param2:SVGText) : void
        {
            var _loc_4:Object;
            param1.children = [];
            var _loc_3:int;
            while (_loc_3++ < param2.tspans.length)
            {
                
                _loc_4 = {};
                _loc_4.text = param2.tspans[_loc_3].text;
                this.partAttributes(_loc_4, param2.tspans[_loc_3]);
                param1.children.push(_loc_4);
            }
            return;
        }// end function

        private function partAttributes(param1:Object, param2:SVGText) : void
        {
            param1.x = param2.x;
            param1.y = param2.y;
            param1.width = param2.width;
            param1.height = param2.height;
            param1.transformations = XMLUtil.transformationAsString(param2);
            param1.fontFamily = param2.fontFamily;
            param1.fontStyle = param2.fontStyle;
            param1.fontWeight = param2.fontWeight;
            param1.fontSize = param2.fontSize;
            param1.fillColor = ColorUtil.getStringColor(param2.fillColor);
            param1.textAnchor = param2.textAnchor;
            param1.fontFamilyID = param2.fontFamilyID;
            param1.fontID = param2.fontID;
            param1.printColors = param2.printColors;
            param1.rgbColors = param2.rgbColors;
            param1.lineWidth = param2.lineWidth;
            return;
        }// end function

    }
}
