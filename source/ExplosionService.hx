package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;
import flixel.FlxObject;

class ExplosionService {
  var Explosions:Array<Explosion> = new Array<Explosion>();
  var group:FlxSpriteGroup;

  public function new(group:FlxSpriteGroup):Void {
    this.Explosions = new Array<Explosion>();
    this.group = group;
  }

  public function explode(X:Float, Y:Float, width:Float = 0, height:Float = 0, player:Bool = false):Explosion {
    var x = X + Reg.random.float(0, width);
    var y = Y + Reg.random.float(0, height);

    var Explosion = recycle(x, y, player);
    group.add(Explosion);
    Explosion.explode();

    return Explosion;
  }

  function recycle(X:Float, Y:Float, player:Bool):Explosion {
    for(p in Explosions) {
      if(!p.exists) {
        p.initialize(X, Y, player);
        return p;
      }
    }

    var Explosion:Explosion = new Explosion();
    Explosion.initialize(X, Y, player);
    Explosions.push(Explosion);

    return Explosion;
  }
}
