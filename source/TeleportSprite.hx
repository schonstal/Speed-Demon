package;

import flixel.FlxSprite;
import flixel.FlxG;

class TeleportSprite extends FlxSprite {
  public function new() {
    super();

    loadGraphic("assets/images/player/teleport.png", true, 32, 32);
    animation.add("spawn", [3, 4, 5], 15, false);
    animation.add("despawn", [0, 1, 2], 15, false);
    animation.finishCallback = onAnimationComplete;
  }

  public function initialize(lane:Int):Void {
    exists = true;

    x = Reg.LANE_OFFSET + lane * Reg.LANE_WIDTH - width / 2 + 3;
    y = Reg.player.y - Reg.player.offset.y;
  }

  public function spawn():Void {
    animation.play("spawn");
  }

  public function despawn():Void {
    animation.play("despawn");
  }

  function onAnimationComplete(name:String):Void {
    exists = false;
  }
}
