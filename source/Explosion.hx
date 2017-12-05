package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;

class Explosion extends FlxSprite {
  var isPlayer:Null<Bool> = null;

  public function new() {
    super();
    animation.finishCallback = onAnimationComplete;
  }

  public function initialize(X:Float, Y:Float, player:Null<Bool> = false):Void {
    exists = true;
    x = X;
    y = Y;

    if (isPlayer != player) {
      if (player) {
        loadGraphic("assets/images/explosion.png", true, 32, 32);
        offset.x = 16;
        offset.y = 16;
        animation.add("explode", [0, 1, 2, 3, 4], 15, false);
        color = FlxColor.fromHSB(161, 0.2, 0.9);
      } else {
        loadGraphic("assets/images/pentagram.png", true, 32, 32);
        offset.x = 16;
        offset.y = 16;
        animation.add("explode", [0, 1, 2, 3, 4], 15, false);
        color = FlxColor.fromHSB(350, 0.2, 0.9);
      }
    }
    isPlayer = player;
  }

  public function explode():Void {
    animation.play("explode");
  }

  function onAnimationComplete(name:String):Void {
    exists = false;
  }
}
