package;

import flixel.addons.ui.*;

class InspectorPanel extends FlxUIGroup
{
    var pLeft : Int = 2;
    
    var title : FlxUIText;
    
    var idField : FlxUIInputText;
    var xPosField : FlxUIInputText;
    var yPosField : FlxUIInputText;
    var widthField : FlxUIInputText;
    var heightField : FlxUIInputText;
    
    public function new(X : Float, Y : Float)
    {
        super(X, Y);
        
        title = new FlxUIText(pLeft, 2, 0, "Inspector: ");
        
        idField = new FlxUIInputText(pLeft, 20, "asd");
        
        xPosField = new FlxUIInputText(pLeft, 40, "");
        yPosField = new FlxUIInputText(pLeft, 60, "");
        widthField = new FlxUIInputText(pLeft, 80, "");
        heightField = new FlxUIInputText(pLeft, 100, "");
        
        add(title);
        add(idField);
        add(xPosField);
        add(yPosField);
        add(widthField);
        add(heightField);
    }
}