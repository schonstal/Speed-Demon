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

class Enemy extends Obstacle {
  var justHurt:Bool = false;

  public function new() {
    super();
    loadGraphic("assets/images/enemies/goat1.png", true, 30, 30);
    animation.add("idle", [0, 1, 2, 3], 10);
    animation.play("idle");

    width = 8;
    height = 8;
    offset.x = 12;
    offset.y = 12;
  }

  public override function initialize(startLane, startRow):Void {
    super.initialize(startLane, startRow);

    animation.play("idle", true);
    animation.frameIndex = row % 4;
  }

  public override function hurt(damage:Float):Void {
    if (!justHurt) {
      justHurt = true;
      FlxSpriteUtil.flicker(this, 0.6, 0.04, true, true, function(flicker) {
        justHurt = false;
      });
    }
    //FlxG.sound.play("assets/sounds/player/hurt.wav", 1 * FlxG.save.data.sfxVolume);

    super.hurt(damage);
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
    if (lane == Reg.player.lane &&
        Reg.player.alive &&
        Reg.player.shooting &&
        y > -60 && y < Reg.player.y) {
      hurt(1500 * elapsed);
    }
  }

  override public function kill():Void {
    super.kill();
    Reg.explosionService.explode(x + 2, y + 4, 0, 0);
  }
}
