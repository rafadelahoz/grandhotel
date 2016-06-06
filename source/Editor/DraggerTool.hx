package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class DraggerTool extends FlxSprite
{
    var editor : EditorController;
    var releaseCallback : Void -> Void;
    var updateCallback : Void -> Void;
    
    var target : FlxObject;
    var anchor : FlxPoint;
    
    public function new(Target : FlxObject, Anchor : FlxPoint, Editor : EditorController, ?ReleaseCallback : Void -> Void = null, ?UpdateCallback : Void -> Void = null)
    {
        super(0, 0);
        
        visible = false;
        
        editor = Editor;
        releaseCallback = ReleaseCallback;
        updateCallback = UpdateCallback;
        
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
            
            
            if (releaseCallback != null)
            {
                releaseCallback();
            }
            
            return;
        }
        
        if (target != null)
        {
            target.x = FlxG.mouse.x - anchor.x;
            target.y = FlxG.mouse.y - anchor.y;
            
            if (updateCallback != null)
            {
                updateCallback();
            }
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
