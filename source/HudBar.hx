package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;

class HudBar extends FlxSpriteGroup {
  var barBackground:FlxSprite;
  var bar:FlxSprite;

  public var value(default, set):Float;

  function set_value(newValue:Float):Float {
    var width:Int = Std.int((barBackground.width - 8) * newValue/100);

    if (newValue != value && width > 0) {
      bar.makeGraphic(width, Std.int(bar.height), 0xffffffff);
      bar.x = barBackground.x + barBackground.width - 4 - bar.width;
    } else if (width <= 0) {
      bar.visible = false;
    }

    return value = newValue;
  }

  public function new(X:Float, Y:Float, color:Int):Void {
    super();
    barBackground = new FlxSprite(0, 0);
    barBackground.loadGraphic("assets/images/hud/bar.png");
    barBackground.x = X;
    barBackground.y = Y;
    add(barBackground);

    bar = new FlxSprite(barBackground.x + 4, barBackground.y + 4);
    bar.makeGraphic(
      Std.int(barBackground.width) - 8,
      Std.int(barBackground.height) - 10,
      0xffffffff
    );
    bar.color = color;

    add(bar);
  }
}
