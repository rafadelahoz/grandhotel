package;

import flixel.FlxG;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIGroup;

class EditorController extends FlxUIGroup
{
    public var scene : Scene;
    public var inEdition : Bool;

    public function new(Scene : Scene)
    {
        super(0, 0);

        scene = Scene;

        inEdition = false;

        add(new FlxUIButton(5, 5, "Editor button!", function() {trace("Hi!");}));
    }

    override public function update(elapsed : Float)
    {
        if (FlxG.keys.justPressed.E)
            inEdition = !inEdition;

        visible = inEdition;

        super.update(elapsed);
    }
}
