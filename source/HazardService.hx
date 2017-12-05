package;

import flixel.math.FlxVector;
import flixel.FlxObject;

class HazardService {
  var rowIndex:Int = 0;

  public function new():Void {
  }

  public function spawnPattern() {
    var difficulty = Reg.random.int(0, Reg.difficulty);
    var patternIndex = Reg.random.int(0, SpawnPatterns.PATTERNS[difficulty].length - 1);

    var pattern = SpawnPatterns.PATTERNS[difficulty][patternIndex];
    if (pattern == null) return;

    var rows = pattern.split("\n").filter(function(e) {
      return e != "";
    });

    rows.reverse();

    for (row in rows) {
      for (laneIndex in 0...row.length) {
        var char = row.charAt(laneIndex);
        if (char == "o") {
          Reg.obstacleService.spawn(laneIndex, rowIndex);
        } else if (char == "e") {
          Reg.enemyService.spawn(laneIndex, rowIndex);
          // TODO: Think about this later
        } else if (false && char == "^" && Reg.random.float(0, 1) < 0.25) {
          Reg.boostService.spawn(laneIndex, rowIndex);
        }
      }
      rowIndex++;
    }
  }
}
