package;

import flixel.FlxG;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIGroup;

class EditorController extends FlxUIGroup
{
    public var scene : Scene;
    public var inEdition : Bool;

    public var selectedHotspot : Hotspot;
    
    var inspectorPanel : FlxUIGroup;

    public function new(Scene : Scene)
    {
        super(0, 0);

        scene = Scene;

        inEdition = false;

        add(new FlxUIButton(5, 5, "Editor button!", function() {trace("Hi!");}));
        
        inspectorPanel = new InspectorPanel(5, 40);
        add(inspectorPanel);
    }

    override public function update(elapsed : Float)
    {
        if (FlxG.keys.justPressed.E)
            inEdition = !inEdition;

        visible = inEdition;
        
        if (inEdition)
        {
            handleEdition();
        }
        else 
        {
            cleanEdition();
        }

        super.update(elapsed);
    }
    
    function handleEdition()
    {
        // Let the user select a hotspot
        if (FlxG.mouse.justPressed) 
        {
            for (hotspot in scene.hotspots)
            {
                if (hotspot.mouseOver())
                {
                    selectedHotspot = hotspot;
                    return;
                }
            }
        }
    }
    
    function cleanEdition()
    {
        
    }
}
