package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

class Background extends FlxGroup
{
  public static var SCROLL_SPEED = 600;

  public function new() {
    super();

    var bgColor:FlxSprite = new FlxSprite(0, 0);
    bgColor.makeGraphic(FlxG.width, FlxG.height, 0xff060c2d);
    add(bgColor);

    add(new BackgroundLayer("assets/images/backgrounds/3.png", 0.2));
    add(new BackgroundLayer("assets/images/backgrounds/2.png", 0.425));
    add(new BackgroundLayer("assets/images/backgrounds/1.png", 0.65));
    add(new BackgroundLayer("assets/images/backgrounds/0.png", 1));
  }
}
