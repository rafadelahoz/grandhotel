package;

import flixel.addons.ui.*;

class Field extends FlxUIGroup
{
    var label : FlxUIText;
    var field : FlxUIInputText;

    public function new(X : Float, Y : Float, Label : String, ?UpdateCallback : String -> String -> Void = null)
    {
        super(X, Y);

        label = new FlxUIText(X, Y, Label);
        
        var space : Float = Math.max(label.width + 2, 40);
        
        field = new FlxUIInputText(X + space, Y, "");
        field.callback = UpdateCallback;
        
        add(label);
        add(field);
    }

    public var text(get, set) : String;
    public function get_text() : String
    {
        return field.text;
    }

    public function set_text(text : String) : String
    {
        field.text = text;
        return text;
    }

    override public function update(elapsed : Float)
    {
        super.update(elapsed);
    }
}
