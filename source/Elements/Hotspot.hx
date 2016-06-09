package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

import flixel.addons.transition.TransitionData;

class Hotspot extends FlxSprite
{
    public static var TYPE_NONE : String = "none";
    public static var TYPE_NAV  : String = "nav";
    
    public var scene : Scene;

    public var id : String;
    
    public var quickType : String;
    public var navTarget : String;

    public function new(Id : String, X : Float, Y : Float, Width : Float, Height : Float, Scene : Scene)
    {
        super(X, Y);

        id = Id;
        onResize(Width, Height);

        scene = Scene;
        
        quickType = TYPE_NONE;
    }
    
    public function setupNavigation(targetScene : String)
    {
        quickType = TYPE_NAV;
        navTarget = targetScene;
    }

    override public function update(elapsed : Float)
    {
        if (!scene.inEditionMode()) {
            visible = FlxG.keys.pressed.SPACE;

            if (FlxG.mouse.justPressed && mouseOver())
            {
                onInteract();
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
    
    public function onResize(width : Float, height : Float)
    {
        makeGraphic(Std.int(width), Std.int(height), 0x44440044);
    }
    
    public function onInteract()
    {
        switch (quickType)
        {
            case Hotspot.TYPE_NAV:
                if (navTarget == null)
                    trace("No navigation target set");
                else 
                {
                    FlxG.switchState(new Scene(navTarget, new TransitionData(0.25), new TransitionData(0.25)));
                }
            case Hotspot.TYPE_NONE:
                trace(id);
        }
    }
}
