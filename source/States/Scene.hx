package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.addons.display.FlxBackdrop;

import flixel.addons.ui.FlxUIState;

class Scene extends FlxUIState
{
    var id : String;

    public var editor : EditorController;

    public var backgrounds : FlxTypedGroup<FlxSprite>;
    public var hotspots : FlxTypedGroup<Hotspot>;

    public function new(sceneId : String)
    {
        super();

        id = sceneId;
    }

    function loadScene(sceneId : String)
    {
        var loader : SceneLoader = new SceneLoader(this);
        loader.load(id);
    }

    public function addBackground(bgId : String)
    {
        var bg : FlxSprite = new FlxSprite(0, 0, "assets/backgrounds/" + bgId);
        bg.setGraphicSize(FlxG.width, FlxG.height);
        bg.updateHitbox();
        backgrounds.add(bg);

        trace(FlxG.width + ", " + FlxG.height);
    }

    public function addHotspot(hotspot : Hotspot)
    {
        hotspots.add(hotspot);
    }
    
    public function removeHotspot(hotspot : Hotspot)
    {
        hotspots.remove(hotspot);
    }

    override public function create():Void
	{
		super.create();

        backgrounds = new FlxTypedGroup<FlxSprite>();
        hotspots = new FlxTypedGroup<Hotspot>();

        loadScene(id);

        add(backgrounds);
        add(hotspots);

        editor = new EditorController(this);
        add(editor);

        trace("all done");
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

    public function inEditionMode() : Bool
    {
        return editor.inEdition;
    }
}
