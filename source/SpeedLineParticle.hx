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
  var depth:Int = 0;

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

    depth = Reg.random.int(1, 10);
    makeGraphic(1, depth * 2, FlxColor.fromHSB(160 + (depth/10) * 200, 1, depth/15));
    velocity.y = 100 * depth;
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);

    if (y >= FlxG.height + offset.y || !exists) {
      exists = false;
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
