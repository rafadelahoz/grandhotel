package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIGroup;
import flixel.util.FlxSpriteUtil;

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
        var newWidth = resizer.getX() - target.x;
        var newHeight = resizer.getY() - target.y;
        
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
    
    
    public function getX()
    {
        return x + halfSize;
    }
    
    public function getY()
    {
        return y + halfSize;
    }
}