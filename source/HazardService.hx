package;

import flixel.math.FlxVector;
import flixel.FlxObject;

class HazardService {
  var rowIndex:Int = 0;

  public function new():Void {
  }

  public function spawnPattern(patternIndex:Int) {
    var pattern = SpawnPatterns.PATTERNS[patternIndex];

    var rows = pattern.split("\n").filter(function(e) {
      return e != "";
    });

    rows.reverse();

    for (row in rows) {
      for (laneIndex in 0...row.length) {
        switch(row.charAt(laneIndex)) {
          case "o":
            Reg.obstacleService.spawn(laneIndex, rowIndex);
            break;
          case "e":
            Reg.enemyService.spawn(laneIndex, rowIndex);
            break;
        }
      }
      rowIndex++;
    }
  }
}
