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

class Player extends FlxSprite
{
  var justHurt:Bool = false;
  var lane:Int = 0;

  public function new() {
    super();
    x = 60;
    y = 258;
    loadGraphic("assets/images/player/player.png", true, 32, 32);

    animation.add("idle", [5], 15, true);
    animation.play("idle");
    angle = 180;

    FlxG.mouse.visible = false;

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
  }

  public function init():Void {
    Reg.player = this;

    facing = FlxObject.RIGHT;
    health = 100;
  }

  public override function hurt(damage:Float):Void {
    if(justHurt && damage < 100) return;

    FlxG.camera.flash(0xccff1472, 0.5, null, true);
    FlxG.camera.shake(0.005, 0.2);
    Reg.combo = 0;

    justHurt = true;
    FlxSpriteUtil.flicker(this, 0.6, 0.04, true, true, function(flicker) {
      justHurt = false;
    });
    //FlxG.sound.play("assets/sounds/player/hurt.wav", 1 * FlxG.save.data.sfxVolume);

    super.hurt(damage);
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);

    if (FlxG.keys.justPressed.A) {
      lane = 0;
    } else if (FlxG.keys.justPressed.S) {
      lane = 1;
    } else if (FlxG.keys.justPressed.D) {
      lane = 2;
    } else if (FlxG.keys.justPressed.F) {
      lane = 3;
    }

    x = 60 + (lane * 30);
    //x = FlxG.mouse.x;
  }

  public override function kill():Void {
    visible = false;
    alive = false;
    solid = false;
    exists = false;
    //FlxG.sound.play("assets/sounds/player/die.wav", 1 * FlxG.save.data.sfxVolume);
  }
}
