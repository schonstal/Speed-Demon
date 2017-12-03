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

class ShootingEnemy extends FlxSprite {
  var lane:Int = 0;

  public function new() {
    super();
    x = 60;
    y = 0;

    loadGraphic("assets/images/enemies/goat2.png", true, 30, 30);

    width = 8;
    height = 8;
    offset.x = 12;
    offset.y = 12;

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
  }

  public function initialize(startLane):Void {
    visible = true;
    alive = true;
    solid = true;
    exists = true;

    lane = startLane;

    x = 60 + (lane * Obstacle.CEL_WIDTH);
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
    if (y < 38) {
      y += elapsed * 200;
    }

    x += (Reg.player.x - x) / 8;
  }

  public override function kill():Void {
    visible = false;
    alive = false;
    solid = false;
    exists = false;
    //FlxG.sound.play("assets/sounds/player/die.wav", 1 * FlxG.save.data.sfxVolume);
  }
}
