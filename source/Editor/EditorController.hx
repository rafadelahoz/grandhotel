package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIGroup;

class EditorController extends FlxUIGroup
{
    public var scene : Scene;
    public var inEdition : Bool;

    public var selectedHotspot : Hotspot;

    var inspectorPanel : InspectorPanel;

    public function new(Scene : Scene)
    {
        super(0, 0);

        scene = Scene;

        inEdition = false;

        add(new FlxUIButton(5, 5, "Inspector", function() {inspectorPanel.visible = !inspectorPanel.visible;}));

        inspectorPanel = new InspectorPanel(5, 32);
        add(inspectorPanel);
    }

    override public function update(elapsed : Float)
    {
        if (FlxG.keys.justPressed.E && FlxG.keys.pressed.ALT)
        {
            inEdition = !inEdition;
            if (inEdition)
            {
                currentTool = TOOL_NONE;
            }
        }

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

    static var TOOL_NONE : String = "None";
    static var TOOL_DRAG_ELEM : String = "DragElem";
    static var TOOL_DRAG_POINT : String = "DragPoint";
    
    var currentTool : String;

    function handleEdition()
    {
        // Let the user select a hotspot
        if (FlxG.mouse.justPressed)
        {
            // If the current hotspot is clicked, drag
            if (selectedHotspot != null && selectedHotspot.mouseOver())
            {
                currentTool = TOOL_DRAG_ELEM;
                add(new DraggerTool(selectedHotspot, null, this, function() {
                    currentTool = TOOL_NONE;
                }));
            }
            else 
            {
                for (hotspot in scene.hotspots)
                {
                    if (hotspot.mouseOver())
                    {
                        selectedHotspot = hotspot;
                        inspectorPanel.setSelectedHotspot(selectedHotspot);
                        return;
                    }
                }
            }
        }
    }

    function cleanEdition()
    {

    }
}

class DraggerTool extends FlxSprite
{
    var editor : EditorController;
    var callback : Void -> Void;
    
    var target : FlxObject;
    var anchor : FlxPoint;
    
    public function new(Target : FlxObject, Anchor : FlxPoint, Editor : EditorController, ?Callback : Void -> Void = null)
    {
        super(0, 0);
        
        visible = false;
        
        editor = Editor;
        callback = Callback;
        
        target = Target;
        anchor = Anchor;
        
        if (anchor == null)
        {
            anchor = DraggerTool.getAnchor(target);
        }
    }
    
    override public function update(elapsed : Float)
    {
        if (!FlxG.mouse.pressed)
        {
            target = null;
            anchor = null;
            
            editor.remove(this);
            destroy();
            
            
            if (callback != null)
            {
                callback();
            }
            
            return;
        }
        
        if (target != null)
        {
            target.x = FlxG.mouse.x - anchor.x;
            target.y = FlxG.mouse.y - anchor.y;
        }
        
        super.update(elapsed);
    }
    
    public static function getAnchor(object : FlxObject) : FlxPoint
    {
        var anchor : FlxPoint = new FlxPoint();
        anchor.x = FlxG.mouse.x - object.x;
        anchor.y = FlxG.mouse.y - object.y;
        
        return anchor;
    }
}
