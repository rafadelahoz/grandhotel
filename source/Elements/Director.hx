package;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.addons.transition.TransitionData;

/* Takes care of things, you know */
class Director
{
    static var director : Director;
    public static function get() : Director
    {
        return director;
    }

    public var scene : Scene;

    public function new()
    {
        // Init director
        Director.director = this;
        scene = null;
    }

    public function toScene(id : String)
    {
        // Check if scene exists, ...
        FlxG.switchState(new Scene(id, new TransitionData(0.25), new TransitionData(0.25)));
    }

    public function showMessage(message : String, ?hotspot : Hotspot = null)
    {
        var pos : FlxPoint = null;
        if (hotspot != null)
            pos = hotspot.getMidpoint();

        scene.add(new Message(message, pos));
    }
}
