package;

import flixel.FlxSprite;
import flixel.addons.ui.*;

class InspectorPanel extends FlxUIGroup
{
    var pLeft : Int = 2;

    var title : FlxUIText;

    var selectedHotspot : Hotspot;

    var idField : Field;
    var xPosField : Field;
    var yPosField : Field;
    var widthField : Field;
    var heightField : Field;

    public function new(X : Float, Y : Float)
    {
        super(X, Y);

        add(new FlxUISprite(0, 0).makeGraphic(200, 200, 0x66333333));

        title = new FlxUIText(pLeft, 2, 0, "Inspector: ");

        idField = new Field(pLeft, 20, "Id", updateId);

        xPosField = new Field(pLeft, 36, "X", true, updateX);
        yPosField = new Field(pLeft, 46, "Y", true, updateY);
        widthField = new Field(pLeft, 56, "Width", true, updateW);
        heightField = new Field(pLeft, 66, "Height", true, updateH);

        add(title);
        add(idField);
        add(xPosField);
        add(yPosField);
        add(widthField);
        add(heightField);
    }

    public function setSelectedHotspot(hotspot : Hotspot)
    {
        selectedHotspot = hotspot;

        refreshSelectedData();
    }

    function refreshSelectedData()
    {
        idField.text = selectedHotspot.id;
        xPosField.text = "" + selectedHotspot.x;
        yPosField.text = "" + selectedHotspot.y;
        widthField.text = "" + selectedHotspot.width;
        heightField.text = "" + selectedHotspot.height;
    }

    override public function update(elapsed : Float)
    {
        if (selectedHotspot != null)
        {
            refreshSelectedData();
        }
        else
        {
            idField.text = "";
            xPosField.text = "";
            yPosField.text = "";
            widthField.text = "";
            heightField.text = "";
        }

        super.update(elapsed);
    }

    public function hasFocus() : Bool
    {
        if (!visible)
            return false;

        for (field in iterator(filter))
        {
            var ffield : Field = cast(field, Field);
            if (ffield.hasFocus())
            {
                return true;
            }
        }

        return false;
    }

    function filter(elem : FlxSprite) : Bool
    {
        return Std.is(elem, Field);
    }

    function updateId(newId : String, action : String)
    {
        if (selectedHotspot != null)
        {
            selectedHotspot.id = newId;
        }
    }

    function updateX(newX : String, action : String)
    {
        if (selectedHotspot != null)
        {
            selectedHotspot.x = Std.parseFloat(newX);
        }
    }

    function updateY(newY : String, action : String)
    {
        if (selectedHotspot != null)
        {
            selectedHotspot.y = Std.parseFloat(newY);
        }
    }

    function updateW(newW : String, action : String)
    {
        if (selectedHotspot != null)
        {
            selectedHotspot.setSize(Std.parseInt(newW), selectedHotspot.height);
        }
    }

    function updateH(newH : String, action : String)
    {
        if (selectedHotspot != null)
        {
            selectedHotspot.setSize(selectedHotspot.width, Std.parseInt(newH));
        }
    }
}
