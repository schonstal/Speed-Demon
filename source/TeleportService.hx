package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;
import flixel.FlxObject;

class TeleportService {
  var teleportSprites:Array<TeleportSprite> = new Array<TeleportSprite>();
  var group:FlxSpriteGroup;

  public function new(group:FlxSpriteGroup):Void {
    this.teleportSprites = new Array<TeleportSprite>();
    this.group = group;
  }

  public function teleport(fromLane:Int, toLane:Int):Void {
    var teleportSprite = recycle(fromLane);
    group.add(teleportSprite);
    teleportSprite.despawn();

    teleportSprite = recycle(toLane);
    group.add(teleportSprite);
    teleportSprite.spawn();
  }

  function recycle(lane):TeleportSprite {
    for(p in teleportSprites) {
      if(!p.exists) {
        p.initialize(lane);
        return p;
      }
    }

    var teleportSprite:TeleportSprite = new TeleportSprite();
    teleportSprite.initialize(lane);
    teleportSprites.push(teleportSprite);

    return teleportSprite;
  }
}
