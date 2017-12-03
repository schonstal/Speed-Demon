package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;
import flixel.FlxObject;

class EnemyService {
  var enemys:Array<Enemy> = new Array<Enemy>();
  var group:FlxSpriteGroup;
  var rowIndex:Int = 0;

  public function new(group:FlxSpriteGroup):Void {
    this.enemys = new Array<Enemy>();
    this.group = group;
  }

  public function spawn(lane:Int, row:Int):Enemy {
    var enemy = recycle(lane, row);
    group.add(enemy);
 
    return enemy;
  }

  function recycle(lane:Int, row:Int):Enemy {
    for(p in enemys) {
      if(!p.exists) {
        p.initialize(lane, row);
        return p;
      }
    }

    var enemy:Enemy = new Enemy();
    enemy.initialize(lane, row);
    enemys.push(enemy);

    return enemy;
  }
}
