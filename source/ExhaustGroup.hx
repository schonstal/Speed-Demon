package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.math.FlxVector;

class ExhaustGroup extends FlxSpriteGroup {
  var particles:FlxSpriteGroup;

  public function new():Void {
    super();

    particles = new FlxSpriteGroup(); 
    particles.solid = false;
    add(particles);

    for(lane in 0...Reg.LANE_COUNT) {
      var exhaust:ExhaustSprite = new ExhaustSprite();
      exhaust.initialize(lane);

      add(exhaust);
    }

    initialize();
  }

  public function initialize():Void {
    exists = true;
    particles.exists = false;
  }


  public override function update(elapsed:Float):Void {
    if (Reg.random.float(0, 1) > 0.8) {
      var particle:SpeedLineParticle = cast(particles.recycle(SpeedLineParticle), SpeedLineParticle);
      particle.initialize();
      add(particle);
    }

    super.update(elapsed);
  }
}
