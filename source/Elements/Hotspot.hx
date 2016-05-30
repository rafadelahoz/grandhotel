package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;

class Hotspot extends FlxObject
{
    public var id : String;

    public function new(Id : String, X : Float, Y : Float, Width : Float, Height : Float)
    {
        super(X, Y, Width, Height);

        id = Id;
    }

    override public function update(elapsed : Float)
    {
        if (FlxG.mouse.justPressed && mouseOver())
        {
            trace(id);
        }

        super.update(elapsed);
    }

    function mouseOver() : Bool
    {
        var mx : Float = FlxG.mouse.x;
        var my : Float = FlxG.mouse.y;

        return getHitbox().containsPoint(new FlxPoint(mx, my));
    }
}
