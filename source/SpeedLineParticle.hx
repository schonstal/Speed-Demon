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
import flixel.util.FlxColor;

class SpeedLineParticle extends FlxSprite
{
  public function new() {
    super();
    x = Reg.LANE_OFFSET;
  }

  public function initialize():Void {
    visible = true;
    alive = true;
    exists = true;

    x = Reg.random.int(Reg.LANE_OFFSET, FlxG.width - Reg.LANE_OFFSET);
    y = -20;

    makeGraphic(1, Std.int(20 + 20 * Reg.speed/100), FlxColor.fromHSB(180, 0.3, 0.2));
    velocity.y = 1000;
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);

    if (y >= FlxG.height + offset.y || !exists) {
      exists = false;
    }

    velocity.y = 1000 + Reg.speed * 10;
  }

  public override function kill():Void {
    visible = false;
    alive = false;
    solid = false;
    exists = false;
    //FlxG.sound.play("assets/sounds/player/die.wav", 1 * FlxG.save.data.sfxVolume);
  }
}
