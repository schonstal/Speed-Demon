package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;
import flixel.FlxObject;

class ObstacleService {
  var obstacles:Array<Obstacle> = new Array<Obstacle>();
  var group:FlxSpriteGroup;

  public function new(group:FlxSpriteGroup):Void {
    this.obstacles = new Array<Obstacle>();
    this.group = group;
  }

  public function spawn(lane:Int, rowOffset:Int):Obstacle {
    var obstacle = recycle(lane);
    obstacle.y = rowOffset * 30;
    group.add(obstacle);

    return obstacle;
  }

  public function spawnPattern(patternIndex:Int) {
    var pattern = SpawnPatterns.PATTERNS[patternIndex];

    var rowIndex = 0;
    var rows = pattern.split("\n").filter(function(e) {
      return e != "";
    });

    for (row in rows) {
      for (laneIndex in 0...row.length) {
        if (row.charAt(laneIndex) == "o") {
          spawn(laneIndex, rows.length - rowIndex);
        }
      }
      rowIndex++;
    }
  }

  function recycle(lane:Int):Obstacle {
    for(p in obstacles) {
      if(!p.exists) {
        p.initialize(lane);
        return p;
      }
    }

    var obstacle:Obstacle = new Obstacle();
    obstacle.initialize(lane);
    obstacles.push(obstacle);

    return obstacle;
  }
}
