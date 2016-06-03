package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Hotspot extends FlxSprite
{
    public var scene : Scene;

    public var id : String;

    public function new(Id : String, X : Float, Y : Float, Width : Float, Height : Float, Scene : Scene)
    {
        super(X, Y);

        id = Id;
        makeGraphic(Std.int(Width), Std.int(Height), 0x44440044);

        scene = Scene;
    }

    override public function update(elapsed : Float)
    {
        if (!scene.inEditionMode()) {
            visible = FlxG.keys.pressed.SPACE;

            if (FlxG.mouse.justPressed && mouseOver())
            {
                trace(id);
            }
        }
        else
        {
            visible = true;
        }

        super.update(elapsed);
    }

    public function mouseOver() : Bool
    {
        var mx : Float = FlxG.mouse.x;
        var my : Float = FlxG.mouse.y;

        return getHitbox().containsPoint(new FlxPoint(mx, my));
    }
}
