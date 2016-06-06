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

class SelectorTool extends FlxUIGroup
{
    static var padding : Int = 4;
    static var halfPad : Int = Std.int(padding/2);
    static var doublePad : Int = Std.int(padding/2);
    
    public var resizable : Bool;
    public var resizer : Resizer;
    
    var cursorFrame : FlxSprite;
    public var target : FlxObject;
    
    public function new(Target : FlxObject, ?Resizable : Bool = false)
    {
        target = Target;
        resizable = Resizable;
        
        super(target.x - padding, target.y - padding);
        
        cursorFrame = new FlxSprite(0, 0);
        refreshGraphic();
        
        add(cursorFrame);
        
        if (resizable)
        {
            resizer = new Resizer(width - doublePad, height - doublePad, 8);
            add(resizer);
        }
    }
    
    public function refreshGraphic()
    {        
        cursorFrame.makeGraphic(Std.int(target.width + doublePad), Std.int(target.height + doublePad), 0x00000000);
        FlxSpriteUtil.drawRoundRect(cursorFrame, halfPad, halfPad, cursorFrame.width - padding, cursorFrame.height - padding, padding, padding, 0x00000000, {color : 0xFFDDDDDD, thickness: 2});
    }
    
    public function onResize()
    {
        var newWidth = resizer.x - target.x;
        var newHeight = resizer.y - target.y;
        
        if (newWidth != target.width || newHeight != target.height) 
        {
            target.width = newWidth;
            target.height = newHeight;
        
            if (Std.is(target, Hotspot))
            {
                cast(target, Hotspot).onResize(target.width, target.height);
            }
            
            refreshGraphic();
        }
    }
    
    override public function update(elapsed : Float)
    {
        if (target != null)
        {
            x = target.x - padding;
            y = target.y - padding;
        }
        
        super.update(elapsed);
    }
}

class Resizer extends FlxSprite
{
    var size : Int;
    var halfSize : Int;
    
    public function new(X : Float, Y : Float, Size : Int)
    {
        super(X, Y);
        
        size = Size;
        halfSize = Std.int(size/2);
        
        makeGraphic(size, size, 0x00000000);
        FlxSpriteUtil.drawCircle(this, halfSize, halfSize, halfSize);
    }
    
    public function mouseOver() : Bool
    {
        var mx : Float = FlxG.mouse.x;
        var my : Float = FlxG.mouse.y;

        return getHitbox().containsPoint(new FlxPoint(mx, my));
    }
}