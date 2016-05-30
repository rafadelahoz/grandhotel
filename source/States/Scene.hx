package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.addons.display.FlxBackdrop;

class Scene extends FlxState
{
    var id : String;

    var backgrounds : FlxTypedGroup<FlxSprite>;
    var hotspots : FlxTypedGroup<Hotspot>;

    public function new(sceneId : String)
    {
        super();

        id = sceneId;
    }

    function loadScene(sceneId : String)
    {
        addBackground("test-bg-0.png");
        addHotspot("Picture", 413, 89, 337, 162);
    }

    function addBackground(bgId : String)
    {
        var bg : FlxSprite = new FlxSprite(0, 0, "assets/backgrounds/" + bgId);
        bg.setGraphicSize(FlxG.width, FlxG.height);
        bg.updateHitbox();
        backgrounds.add(bg);

        trace(FlxG.width + ", " + FlxG.height);
    }

    function addHotspot(Id : String, X : Float, Y : Float, Width : Float, Height : Float)
    {
        var hotspot : Hotspot = new Hotspot(Id, X, Y, Width, Height);
        hotspots.add(hotspot);
    }

    override public function create():Void
	{
		super.create();

        backgrounds = new FlxTypedGroup<FlxSprite>();
        hotspots = new FlxTypedGroup<Hotspot>();

        loadScene(id);

        add(backgrounds);
        add(hotspots);

        trace("all done");
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
