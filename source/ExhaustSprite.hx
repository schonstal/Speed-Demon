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

class ExhaustSprite extends FlxSprite {
  public static var CEL_WIDTH:Int = 30;
  public static var CEL_HEIGHT:Int = 30;
  public static var SPEED:Float = 200;

  var lane:Int = 0;
  var wasAlive:Bool = false;

  public function new() {
    super();
    x = Reg.LANE_OFFSET;
    y = 0;

    loadGraphic("assets/images/player/exhaust.png", true, 32, 32);

    animation.add("idle", [0, 1, 2, 3], 15, true);
    animation.add("teleport", [4, 5, 6], 15, false);
    animation.play("idle");

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
  }

  public function initialize(startLane):Void {
    visible = false;
    alive = true;
    solid = true;
    exists = true;

    lane = startLane;
    x = Reg.LANE_OFFSET + (lane * CEL_WIDTH) - Reg.player.offset.x - 1;
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);

    if (!Reg.player.alive) {
      kill();
      return;
    }

    y = Reg.player.y - Reg.player.offset.y + 28;
    if (lane == Reg.player.lane) {
      visible = true;
      wasAlive = true;
      animation.play("idle");
    } else if (wasAlive) {
      animation.play("teleport", true);
      wasAlive = false;
    }
  }

  public override function kill():Void {
    visible = false;
    alive = false;
    solid = false;
    exists = false;
    //FlxG.sound.play("assets/sounds/player/die.wav", 1 * FlxG.save.data.sfxVolume);
  }
}
