package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;
import flixel.FlxObject;

class ObstacleService {
  var obstacles:Array<Obstacle> = new Array<Obstacle>();
  var group:FlxSpriteGroup;
  var rowIndex:Int = 0;

  public function new(group:FlxSpriteGroup):Void {
    this.obstacles = new Array<Obstacle>();
    this.group = group;
  }

  public function spawn(lane:Int, row:Int):Obstacle {
    var obstacle = recycle(lane, row);
    group.add(obstacle);
 
    return obstacle;
  }

  function recycle(lane:Int, row:Int):Obstacle {
    for(p in obstacles) {
      if(!p.exists) {
        p.initialize(lane, row);
        return p;
      }
    }

    var obstacle:Obstacle = new Obstacle();
    obstacle.initialize(lane, row);
    obstacles.push(obstacle);

    return obstacle;
  }
}
