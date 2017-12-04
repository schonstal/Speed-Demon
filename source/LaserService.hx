package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;
import flixel.FlxObject;

class LaserService {
  var laserGroups:Array<LaserGroup> = new Array<LaserGroup>();
  var group:FlxSpriteGroup;

  public function new(group:FlxSpriteGroup):Void {
    this.laserGroups = new Array<LaserGroup>();
    this.group = group;
  }

  public function shoot(lane:Int, type:String = "player"):LaserGroup {
    var laserGroup = recycle(lane, type);
    group.add(laserGroup);
    laserGroup.shoot();

    return laserGroup;
  }

  function recycle(lane:Int, type:String):LaserGroup {
    for(p in laserGroups) {
      if(!p.exists) {
        p.initialize(lane, type);
        return p;
      }
    }

    var laserGroup:LaserGroup = new LaserGroup();
    laserGroup.initialize(lane, type);
    laserGroups.push(laserGroup);

    return laserGroup;
  }
}
