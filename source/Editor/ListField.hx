package;

import flixel.addons.ui.*;

class ListField extends FlxUIGroup
{
    public var label : FlxUIText;
    public var field : FlxUIDropDownMenu;

    public function new(X : Float, Y : Float, Label : String, Items : Map<String, String>, ?SelectCallback : String -> Void = null)
    {
        super(X, Y);

        label = new FlxUIText(X, Y, Label);

        var space : Float = Math.max(label.width + 2, 40);

        var itemList : Array<StrNameLabel> = buildItemList(Items);

        field = new FlxUIDropDownMenu(X + space, Y, itemList, SelectCallback);

        add(label);
        add(field);
    }

    public var text(get, set) : String;
    public function get_text() : String
    {
        return field.selectedId;
    }

    public function set_text(selectedId : String) : String
    {
        field.selectedId = selectedId;
        return selectedId;
    }

    override public function update(elapsed : Float)
    {
        super.update(elapsed);
    }
    
    function buildItemList(items : Map<String, String>) : Array<StrNameLabel>
    {
        var list : Array<StrNameLabel> = new Array<StrNameLabel>();
        for (key in items.keys())
        {
            var listElem : StrNameLabel = new StrNameLabel(key, items.get(key));
            list.push(listElem);
        }
        
        return list;
    }
}
