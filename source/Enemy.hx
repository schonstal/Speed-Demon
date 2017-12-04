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

    width = 8;
    height = 8;
    offset.x = 12;
    offset.y = 12;
  }

  public override function hurt(damage:Float):Void {
    if (!justHurt) {
      justHurt = true;
      FlxSpriteUtil.flicker(this, 0.1, 0.04, true, true, function(flicker) {
        justHurt = false;
      });
    }
    //FlxG.sound.play("assets/sounds/player/hurt.wav", 1 * FlxG.save.data.sfxVolume);

    super.hurt(damage);
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
    if (y < 38) {
      y += elapsed * 200;
    }

    if (lane == Reg.player.lane && Reg.player.alive && Reg.player.shooting) {
      hurt(elapsed * 400);
    }
  }
}
