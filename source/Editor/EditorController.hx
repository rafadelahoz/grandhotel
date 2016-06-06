package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIGroup;
import flixel.util.FlxSpriteUtil;

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
    var selector : SelectorTool;

    function handleEdition()
    {
        // Let the user select a hotspot
        if (FlxG.mouse.justPressed)
        {
            var operationPerformed : Bool = false;
            
            // If the current hotspot is clicked, drag
            if (selectedHotspot != null)
            {
                if (selector != null && selector.resizable && selector.resizer.mouseOver())
                {
                    currentTool = TOOL_DRAG_POINT;
                    add(new DraggerTool(selector.resizer, null, this, 
                        function() {
                            currentTool = TOOL_NONE;
                        }, function() {
                            selector.onResize();
                        })
                    );
                    operationPerformed = true;
                } 
                else if (selectedHotspot.mouseOver())
                {
                    currentTool = TOOL_DRAG_ELEM;
                    add(new DraggerTool(selectedHotspot, null, this, function() {
                        currentTool = TOOL_NONE;
                    }));
                    
                    operationPerformed = true;
                }
            }
            
            if (!operationPerformed)
            {
                for (hotspot in scene.hotspots)
                {
                    if (hotspot.mouseOver())
                    {
                        if (selectedHotspot != null && selector != null) {
                            remove(selector);
                            selector.destroy();
                            selector = null;
                        }
                        
                        selectedHotspot = hotspot;
                        add(selector = new SelectorTool(selectedHotspot, true));
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