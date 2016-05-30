package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		var zoom : Int = -1;
		var framerate : Int = 60;
		var skipSplash : Bool = true;
		var startFullscreen : Bool = false;

		addChild(new FlxGame(1136, 640, MenuState, zoom, framerate, framerate, skipSplash, startFullscreen));
	}
}
