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
    x = Reg.LANE_OFFSET;
    y = 0;

    loadGraphic("assets/images/enemies/flameskull.png", true, 30, 30);

    animation.add("idle", [0, 1, 2, 3], 15, true);
    animation.play("idle");

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
    health = 100;

    lane = startLane;
    row = startRow;

    x = Reg.LANE_OFFSET + (lane * CEL_WIDTH);
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
    y = -CEL_HEIGHT * row + SPEED * Reg.trackPosition;

    if (y >= FlxG.height + offset.y || !exists) {
      exists = false;
      return;
    }

    if (lane == Reg.player.lane &&
        y >= Player.POSITION - height &&
        y <= Player.POSITION + Reg.player.height) {
      onCollide();
    }

    //animation.curAnim.frameRate = Std.int((Reg.speed/100) * 10 + 10);
  }

  function onCollide() {
    Reg.player.hurt(15);
  }

  public override function kill():Void {
    visible = false;
    alive = false;
    solid = false;
    exists = false;
    //FlxG.sound.play("assets/sounds/player/die.wav", 1 * FlxG.save.data.sfxVolume);
  }
}
