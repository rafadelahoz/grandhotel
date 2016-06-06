package;

import flixel.addons.ui.*;

class Field extends FlxUIGroup
{
    public var label : FlxUIText;
    public var field : AdvInputText;

    public function new(X : Float, Y : Float, Label : String, ?Numeric : Bool = false, ?UpdateCallback : String -> String -> Void = null)
    {
        super(X, Y);

        label = new FlxUIText(X, Y, Label);

        var space : Float = Math.max(label.width + 2, 40);

        field = new AdvInputText(X + space, Y, "");
        field.callback = UpdateCallback;
        if (Numeric)
            field.filterMode = FlxInputText.ONLY_NUMERIC;

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

    public function hasFocus() : Bool
    {
        return field.hasFocus && field.caretVisible();
    }
}

class AdvInputText extends FlxUIInputText
{
    public function new(?X:Float, ?Y:Float, ?Width:Int, ?Text:String, ?size:Int, ?TextColor:Int, ?BackgroundColor:Int, ?EmbeddedFont:Bool)
    {
        super(X, Y, Width, Text, size, TextColor, BackgroundColor, EmbeddedFont);
    }

    public function caretVisible() : Bool
    {
        return caret.visible;
    }
}
