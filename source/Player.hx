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

class Player extends FlxSprite {
  public static var POSITION = 258;

  // no such thing as a private variable in a game jam
  public var lane:Int = 0;
  public var shooting:Bool = false;

  var justHurt:Bool = false;

  public function new() {
    super();
    x = Reg.LANE_OFFSET;
    y = POSITION;
    loadGraphic("assets/images/player/player.png", true, 30, 30);

    animation.add("idle", [0], 15, true);
    animation.play("idle");

    width = 8;
    height = 8;
    offset.x = 12;
    offset.y = 12;

    FlxG.mouse.visible = false;

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);

    init();
  }

  public function init():Void {
    Reg.player = this;
    visible = false;

    facing = FlxObject.RIGHT;
    health = 100;
  }

  public override function hurt(damage:Float):Void {
    if(!alive || justHurt && damage < 100) return;

    //FlxG.camera.flash(0xccff1472, 0.5, null, true);
    FlxG.camera.shake(0.01, 0.2);

    Reg.speed -= 25;
    if(Reg.speed < 0) {
      Reg.speed = 0;
    }

    justHurt = true;
    FlxSpriteUtil.flicker(this, 0.6, 0.04, true, true, function(flicker) {
      justHurt = false;
    });
    //FlxG.sound.play("assets/sounds/player/hurt.wav", 1 * FlxG.save.data.sfxVolume);

    super.hurt(damage);
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);

    if (!Reg.started) {
      return;
    }

    x = Reg.LANE_OFFSET + (lane * 30);

    if (Reg.speed > 0 && FlxG.keys.pressed.SPACE) {
      Reg.speed -= 100 * elapsed;
      Reg.playerLaserService.shoot(lane);
      shooting = true;
    } else {
      shooting = false;
      if (!FlxG.keys.pressed.SPACE) {
        Reg.speed += 5 * elapsed;
      }

      if (FlxG.keys.justPressed.A) {
        Reg.teleportService.teleport(lane, 0);
        lane = 0;
      } else if (FlxG.keys.justPressed.S) {
        Reg.teleportService.teleport(lane, 1);
        lane = 1;
      } else if (FlxG.keys.justPressed.D) {
        Reg.teleportService.teleport(lane, 2);
        lane = 2;
      } else if (FlxG.keys.justPressed.F) {
        Reg.teleportService.teleport(lane, 3);
        lane = 3;
      }
    }

  }

  public override function kill():Void {
    visible = false;
    alive = false;
    solid = false;
    exists = false;
    Reg.explosionService.explode(Reg.LANE_OFFSET + (lane * 30), y + height/2, 0, 0, true);
    //FlxG.sound.play("assets/sounds/player/die.wav", 1 * FlxG.save.data.sfxVolume);
  }
}
