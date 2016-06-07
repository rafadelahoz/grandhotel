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
    var scenePanel : ScenePanel;

    public function new(Scene : Scene)
    {
        super(0, 0);

        scene = Scene;

        inEdition = false;


        var inspectorButton : FlxUIButton = new FlxUIButton(5, 5, "Inspector", function() {inspectorPanel.visible = !inspectorPanel.visible;});
        add(inspectorButton);
        inspectorPanel = new InspectorPanel(5, 32);
        add(inspectorPanel);

        var addHotspotButton : FlxUIButton = new FlxUIButton(inspectorButton.x + inspectorButton.width + 5, 5, "Add Hotspot", function() { currentTool = TOOL_ADD_HOTSPOT; });
        add(addHotspotButton);

        var scenePanelButton : FlxUIButton = new FlxUIButton(FlxG.width - 195, 5, "Scene panel", function() {scenePanel.visible = !scenePanel.visible;});
        add(scenePanelButton);
        scenePanel = new ScenePanel(FlxG.width - 200, 32, scene);
        add(scenePanel);
    }

    static var sWidth : Int = 1136;
    static var sHeight: Int = 640;

    override public function update(elapsed : Float)
    {
        if (FlxG.keys.justPressed.E && FlxG.keys.pressed.ALT)
        {
            inEdition = !inEdition;
            if (inEdition)
            {
                /*FlxG.camera.setSize(Std.int(sWidth * 1.5), Std.int(sHeight * 1));
                FlxG.resizeWindow(Std.int(sWidth * 1.5), Std.int(sHeight * 1));

                FlxG.scaleMode = new flixel.system.scaleModes.FixedScaleMode();*/

                currentTool = TOOL_NONE;
                deselectHotspot();
            }
            else
            {
                /*FlxG.camera.setSize(sWidth, sHeight);
                FlxG.resizeWindow(sWidth, sHeight);*/

                trace(FlxG.camera.width + ", " + FlxG.camera.height);
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
    static var TOOL_ADD_HOTSPOT : String = "AddHotspot";

    var currentTool : String;
    var selector : SelectorTool;

    function handleEdition()
    {
        switch (currentTool)
        {
            case EditorController.TOOL_NONE:

                // Scene management tools
                if (FlxG.keys.justPressed.S && FlxG.keys.pressed.CONTROL)
                {
                    // Save scene
                }

                // Edition tools
                if (!inspectorPanel.hasFocus())
                {
                    if (FlxG.keys.justPressed.A && FlxG.keys.pressed.ALT)
                    {
                        currentTool = TOOL_ADD_HOTSPOT;
                        return;
                    }
                }

                if (!inspectorPanel.hasFocus() && FlxG.mouse.justPressed)
                {
                    if (selectedHotspot != null)
                    {
                        // If the resizer is selected, resize
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
                            return;
                        }
                        // If the current hotspot is clicked, drag
                        else if (selectedHotspot.mouseOver())
                        {
                            currentTool = TOOL_DRAG_ELEM;
                            add(new DraggerTool(selectedHotspot, null, this, function() {
                                currentTool = TOOL_NONE;
                            }));

                            return;
                        }
                    }

                    // Otherwise, try to select a hotspot
                    {
                        for (hotspot in scene.hotspots)
                        {
                            if (hotspot.mouseOver())
                            {
                                selectHotspot(hotspot);
                                return;
                            }
                        }
                    }

                    // Else just deselect whatever was selected
                    deselectHotspot();
                }
            case EditorController.TOOL_DRAG_POINT, EditorController.TOOL_DRAG_ELEM:
                // No?
            case EditorController.TOOL_ADD_HOTSPOT:

                var hotspot : Hotspot = new Hotspot("_" + scene.hotspots.length, FlxG.mouse.x, FlxG.mouse.y, 100, 100, scene);
                scene.addHotspot(hotspot);
                selectHotspot(hotspot);

                currentTool = TOOL_NONE;
        }
    }

    function selectHotspot(hotspot : Hotspot)
    {
        // De-select previously selected hotspot (if any)
        deselectHotspot();

        // Select the new hotspot
        selectedHotspot = hotspot;
        add(selector = new SelectorTool(selectedHotspot, true));
        inspectorPanel.setSelectedHotspot(selectedHotspot);
    }

    function deselectHotspot()
    {
        // De-select previously selected hotspot (if any)
        if (selectedHotspot != null && selector != null) {
            remove(selector);
            selector.destroy();
            selector = null;

            selectedHotspot = null;
        }

        inspectorPanel.setSelectedHotspot(null);
    }

    function cleanEdition()
    {

    }
}
