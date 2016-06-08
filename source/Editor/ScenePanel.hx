package;

import flixel.addons.ui.*;

class ScenePanel extends FlxUIGroup
{
    var pLeft : Int = 2;

    var scene : Scene;

    var title : FlxUIText;
    var idField : Field;
    var saveButton : FlxUIButton;

    public function new(X : Float, Y : Float, Scene : Scene)
    {
        super(X, Y);

        scene = Scene;

        add(new FlxUISprite(0, 0).makeGraphic(200, 200, 0xAA443333));

        title = new FlxUIText(pLeft, 2, 0, "Scene properties: ");
        idField = new Field(pLeft, 20, "Id", updateId);
        saveButton = new FlxUIButton(pLeft, 60, "Save", handleSaveButton);

        loadSceneProperties();

        add(title);
        add(idField);
        add(saveButton);
    }

    function loadSceneProperties()
    {
        idField.field.text = scene.id;
    }

    function updateId(newId : String, action : String)
    {
        scene.id = newId;
    }

    function handleSaveButton()
    {
        var writer : SceneWriter = new SceneWriter(scene);
        writer.write();
    }
}
