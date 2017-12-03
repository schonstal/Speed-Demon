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

class Obstacle extends FlxSprite
{
  public static var CEL_WIDTH:Int = 30;
  public static var CEL_HEIGHT:Int = 30;
  public static var SPEED:Float = 200;

  var lane:Int = 0;
  var row:Int = 0;

  public function new() {
    super();
    x = 60;
    y = 0;

    loadGraphic("assets/images/player/player.png", true, 32, 32);

    animation.add("idle", [2, 3, 4], 10, true);
    animation.add("oddIdle", [4, 3, 2], 10, true);
    animation.play("idle");
    angle = 180;

    width = 8;
    height = 8;
    offset.x = 12;
    offset.y = 12;

    FlxG.mouse.visible = false;

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
  }

  public function initialize(startLane, startRow):Void {
    visible = true;
    alive = true;
    solid = true;
    exists = true;

    lane = startLane;
    row = startRow;

    if(row % 2 == 0) {
      animation.play("idle", true);
    } else {
      animation.play("oddIdle", true);
    }

    x = 60 + (lane * CEL_WIDTH);
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);

    y = -CEL_HEIGHT * row + SPEED * Reg.trackPosition;
  }

  public override function kill():Void {
    visible = false;
    alive = false;
    solid = false;
    exists = false;
    //FlxG.sound.play("assets/sounds/player/die.wav", 1 * FlxG.save.data.sfxVolume);
  }
}
