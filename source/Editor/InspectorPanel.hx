package;

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

        xPosField = new Field(pLeft, 36, "X", updateX);
        yPosField = new Field(pLeft, 46, "Y", updateY);
        widthField = new Field(pLeft, 56, "Width", updateW);
        heightField = new Field(pLeft, 66, "Height", updateH);

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
