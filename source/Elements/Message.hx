package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.math.FlxPoint;

class Message extends FlxGroup
{
    var pos : FlxPoint;
    var text : FlxText;

    public function new(message : String, ?position : FlxPoint=null)
    {
        super();

        if (position == null)
        {
            pos = new FlxPoint(FlxG.width/2, FlxG.height/2);
        }
        else
        {
            pos = position;
        }

        text = new FlxText(pos.x, pos.y);
        text.text = message;
        text.setFormat("assets/fonts/Keyboard.ttf", 20, 0xFF202020, CENTER);

        var bg : FlxSprite = new FlxSprite(pos.x, pos.y).makeGraphic(Std.int(text.width) + 10, 40, 0xFFEFEFEF);
        add(bg);
        add(text);
    }
}
