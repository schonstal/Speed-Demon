package;

import flixel.math.FlxVector;
import flixel.FlxObject;

class HazardService {
  var rowIndex:Int = 0;

  public function new():Void {
  }

  public function spawnPattern(patternIndex:Int) {
    var pattern = SpawnPatterns.PATTERNS[0][patternIndex];

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
        }
      }
      rowIndex++;
    }
  }
}
