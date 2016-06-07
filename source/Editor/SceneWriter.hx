package;

import haxe.xml.Printer;

class SceneWriter
{
    var scene : Scene;

    public function new(Scene : Scene)
    {
        scene = Scene;
    }

    public function write()
    {
        if (scene == null)
            throw "Scene is null. Can't save.";

        var basePath = "assets/scenes/";
        var filename = scene.id + ".xml";
        var filePath = basePath + filename;

        var pathExists = sys.FileSystem.exists(basePath);
        var fileExists = sys.FileSystem.exists(filePath);

        if (!pathExists)
            throw "Scenes folder does not exist at " + basePath;

        if (fileExists)
            trace("File " + filename + " exists and will be replaced");

        var xml : Xml = buildSceneXML();
        if (xml != null)
        {
            var xmlString : String = Printer.print(xml, true);
            sys.io.File.saveContent(filePath, xmlString);
            trace("Scene file " + filePath + " saved successfully");
        }
    }

    function buildSceneXML()
    {
        var xml : Xml = Xml.createDocument();
        xml.addChild(Xml.createDocType("xml"));

        var sceneNode : Xml = Xml.createElement("scene");
        sceneNode.set("id", scene.id);
        xml.addChild(sceneNode);

        var bgsNode : Xml = buildBackgroundsXml();
        sceneNode.addChild(bgsNode);

        var hotspotsNode : Xml = buildHotspotsXml();
        sceneNode.addChild(hotspotsNode);

        return xml;
    }

    function buildBackgroundsXml()
    {
        var bgsNode : Xml = Xml.createElement("backgrounds");

        for (bg in ["bg0", "bg1"])
        {
            var bgNode : Xml = Xml.createElement("bg");
            bgNode.set("id", bg);
            bgNode.set("image", bg + ".png");
            bgsNode.addChild(bgNode);
        }

        return bgsNode;
    }

    function buildHotspotsXml()
    {
        var hotspotsNode : Xml = Xml.createElement("hotspots");

        for (hotspot in scene.hotspots)
        {
            var hsNode : Xml = Xml.createElement("hotspot");
            hsNode.set("id", hotspot.id);
            hsNode.set("x", Std.string(hotspot.x));
            hsNode.set("y", Std.string(hotspot.y));
            hsNode.set("w", Std.string(hotspot.width));
            hsNode.set("h", Std.string(hotspot.height));
            hotspotsNode.addChild(hsNode);
        }

        return hotspotsNode;
    }
}
