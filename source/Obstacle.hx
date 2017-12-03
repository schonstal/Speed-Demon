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
  var lane:Int = 0;

  public function new() {
    super();
    x = 60;
    y = 0;

    velocity.y = 200;

    loadGraphic("assets/images/player/player.png", true, 32, 32);

    animation.add("idle", [2, 3, 4], 30, true);
    animation.play("idle");
    angle = 180;

    FlxG.mouse.visible = false;

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
  }

  public function initialize(startLane):Void {
    visible = true;
    alive = true;
    solid = true;
    exists = true;

    lane = startLane;
    x = 60 + (lane * 30);
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
  }

  public override function kill():Void {
    visible = false;
    alive = false;
    solid = false;
    exists = false;
    //FlxG.sound.play("assets/sounds/player/die.wav", 1 * FlxG.save.data.sfxVolume);
  }
}
