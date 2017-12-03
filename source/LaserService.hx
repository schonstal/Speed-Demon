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

  public function shoot(lane:Int):LaserGroup {
    var laserGroup = recycle(lane);
    group.add(laserGroup);
    laserGroup.shoot();

    return laserGroup;
  }

  function recycle(lane:Int):LaserGroup {
    for(p in laserGroups) {
      if(!p.exists) {
        p.initialize(lane);
        return p;
      }
    }

    var laserGroup:LaserGroup = new LaserGroup();
    laserGroup.initialize(lane);
    laserGroups.push(laserGroup);

    return laserGroup;
  }
}
