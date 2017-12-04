package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;
import flixel.FlxObject;

class BoostService {
  var boosts:Array<Boost> = new Array<Boost>();
  var group:FlxSpriteGroup;
  var rowIndex:Int = 0;

  public function new(group:FlxSpriteGroup):Void {
    this.boosts = new Array<Boost>();
    this.group = group;
  }

  public function spawn(lane:Int, row:Int):Boost {
    var boost = recycle(lane, row);
    group.add(boost);
 
    return boost;
  }

  function recycle(lane:Int, row:Int):Boost {
    for(p in boosts) {
      if(!p.exists) {
        p.initialize(lane, row);
        return p;
      }
    }

    var boost:Boost = new Boost();
    boost.initialize(lane, row);
    boosts.push(boost);

    return boost;
  }
}
