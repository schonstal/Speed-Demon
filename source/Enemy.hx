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

class Enemy extends Obstacle
{
  public function new() {
    super();
    loadGraphic("assets/images/goat1.png", true, 30, 30);

    animation.add("idle", [0], 10, true);
    animation.add("oddIdle", [1], 10, true);
    animation.play("idle");

    width = 8;
    height = 8;
    offset.x = 12;
    offset.y = 12;
  }
}
