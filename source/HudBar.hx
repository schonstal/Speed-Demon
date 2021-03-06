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
  var invert:Bool = false;
  var defaultColor:Int;

  var flash:Bool = false;
  var flashTime:Float = 0;

  public var value(default, set):Float;

  function set_value(newValue:Float):Float {
    var width:Int = Std.int((barBackground.width - 8) * newValue/100);

    if (newValue != value && width > 0) {

      if (invert && newValue < value) {
        bar.color = 0xffffffff;
      } else if (newValue < 100 && value < 100) {
        bar.color = defaultColor;
      }

      bar.makeGraphic(width, Std.int(bar.height), 0xffffffff);
      if (invert) {
        bar.x = barBackground.x + barBackground.width - 4 - bar.width;
      }
      bar.visible = true;
    } else if (width <= 0) {
      bar.visible = false;
    }

    return value = newValue;
  }

  public function new(X:Float, Y:Float, color:Int, invert:Bool = false):Void {
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
    defaultColor = color;

    this.invert = invert;

    add(bar);
  }

  public override function update(elapsed:Float) {
    super.update(elapsed);

    if (invert && Reg.speed == 100) {
      bar.color = flash ? 0xffffb9be : 0xff44ecb7;

      if (flashTime > 0.05) {
        flash = !flash;
        flashTime = 0;
      }
      flashTime += elapsed;
    }
  }
}
