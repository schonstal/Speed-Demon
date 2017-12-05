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
  public static var SPAWN_TIME:Float = 15;

  var lane:Int = 0;
  var justHurt:Bool = false;

  var shootTimer:Float = 0;
  var shootThreshold:Float = 3;
  var shooting:Bool = false;

  var CHARGE_TIME = 1;
  var SHOOT_TIME = 0.3;

  public function new() {
    super();
    x = Reg.LANE_OFFSET;
    y = 0;

    loadGraphic("assets/images/enemies/goat2.png", true, 30, 30);
    animation.add("idle", [0]);
    animation.add("charge", [0, 1], 30, true);
    animation.add("shoot", [1], 30);

    width = 8;
    height = 8;
    offset.x = 12;
    offset.y = 12;
    health = 100;

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);

    kill();
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

  public function initialize(startLane):Void {
    visible = true;
    alive = true;
    solid = true;
    exists = true;
    health = 100;
    y = -50;

    lane = startLane;

    x = Reg.LANE_OFFSET + (lane * Obstacle.CEL_WIDTH);
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
    if (y < 38) {
      y += elapsed * 100;
    }

    if (lane == Reg.player.lane && Reg.player.alive && Reg.player.shooting) {
      hurt(elapsed * 400);
    }

    shootTimer += elapsed;
    if (shootTimer >= shootThreshold) {
      x = Reg.LANE_OFFSET + (lane * Obstacle.CEL_WIDTH);
      shoot();
      shootTimer = 0;
    }

    if (!shooting) {
      x += (Reg.player.x - x) / 4;
      lane = Reg.player.lane;
    }
  }

  public override function kill():Void {
    visible = false;
    alive = false;
    solid = false;
    exists = false;
    //FlxG.sound.play("assets/sounds/player/die.wav", 1 * FlxG.save.data.sfxVolume);
    new FlxTimer().start(SPAWN_TIME, function(t) {
      initialize(Reg.random.int(0, 3));
    });
  }

  function shoot():Void {
    shooting = true;
    animation.play("charge");
    new FlxTimer().start(CHARGE_TIME, function(t) {
      if (!alive) return;

      animation.play("shoot");
      Reg.playerLaserService.shoot(lane, "enemies");
      if (lane == Reg.player.lane) {
        Reg.player.hurt(40);
      }
      new FlxTimer().start(SHOOT_TIME, function(t) {
        animation.play("idle");
        shooting = false;
      });
    });
  }
}
