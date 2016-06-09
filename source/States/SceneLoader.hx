package;

import openfl.Assets;
import haxe.xml.Fast;

class SceneLoader
{
    var scene : Scene;

    public function new(Scene : Scene)
    {
        scene = Scene;
    }

    /* Loads the scene file with the provided id
     * creating the appropriate elements in the
     * previously provided scene entity
     */
    public function load(sceneId : String)
    {
        var basePath = "assets/scenes/";
        var filename = sceneId + ".xml";

        var fileContents : String = Assets.getText(basePath + filename);

        parseScene(fileContents);
    }

    function parseScene(fileContents : String)
    {
        var xml : Xml = Xml.parse(fileContents);

        var scene : Fast = new Fast(xml.firstElement());
        trace("Parsing scene with id=\"" + scene.att.id + "\"");

        if (scene.hasNode.backgrounds)
        {
            trace("Processing backgrounds");
            var bgs = scene.node.backgrounds;
            if (bgs != null)
            {
                for (bg in bgs.nodes.bg)
                {
                    parseBackground(bg);
                }
            }
        }

        if (scene.hasNode.hotspots)
        {
            trace("Processing hotspots");
            var hotspots = scene.node.hotspots;
            if (hotspots != null)
            {
                for (hotspot in hotspots.nodes.hotspot)
                {
                    parseHotspot(hotspot);
                }
            }
        }
    }

    function parseBackground(bg : Fast)
    {
        var id : String = bg.att.id;
        var image : String = bg.att.image;

        // TODO: Add other attributes: parallax, ...

        // id is not used yet
        scene.addBackground(image);
    }

    function parseHotspot(hspot : Fast)
    {
        var id : String = hspot.att.id;

        var x : Int = Std.parseInt(hspot.att.x);
        var y : Int = Std.parseInt(hspot.att.y);
        var w : Int = Std.parseInt(hspot.att.w);
        var h : Int = Std.parseInt(hspot.att.h);
        
        var hotspot : Hotspot = new Hotspot(id, x, y, w, h, scene);
        scene.addHotspot(hotspot);
        
        var qtype : String = null;        

        if (hspot.has.type)
        {
            switch (hspot.att.type)
            {
                case "nav":
                    if (hspot.has.target) 
                    {
                        var navTarget : String = hspot.att.target;
                        hotspot.setupNavigation(navTarget);
                    }
                default:
            }
        }
    }

}
