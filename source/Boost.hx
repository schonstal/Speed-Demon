package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flash.geom.Point;
import flixel.system.FlxSound;
import flixel.math.FlxRandom;
import flixel.math.FlxVector;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxTimer;
import flixel.util.FlxSpriteUtil;

class Boost extends Obstacle {
  public function new() {
    super();
    loadGraphic("assets/images/boost.png", true, 30, 30);
    animation.add("idle", [0], 10);
    animation.play("idle");

    width = 8;
    height = 8;
    offset.x = 12;
    offset.y = 12;
  }

  override function onCollide() {
    Reg.speed += 25;
    exists = false;
  }
}
