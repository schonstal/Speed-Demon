package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;

class Checkpoint extends FlxSpriteGroup {
  var checkpointLine:FlxSprite;
  var distanceText:FlxBitmapText;
  var goalDistance:Int = 1000;
  var awarded:Bool = false;

  public function new():Void {
    super();

    checkpointLine = new FlxSprite();
    checkpointLine.loadGraphic("assets/images/hud/checkpoint_line.png");
    checkpointLine.x = 60;
    add(checkpointLine);

    var font = FlxBitmapFont.fromMonospace(
      "assets/images/hud/checkpoint_numbers.png",
      "<0123456789]",
      new FlxPoint(7, 11)
    );

    distanceText = new FlxBitmapText(font);
    distanceText.letterSpacing = 0;
    distanceText.text = "<0]";
    distanceText.x = checkpointLine.x + checkpointLine.width;
    add(distanceText);
  }

  public override function update(elapsed:Float):Void {
    distanceText.text = '<$goalDistance]';

    y = Obstacle.SPEED * Reg.trackPosition +
        -Obstacle.SPEED * (goalDistance / Reg.DISTANCE_COEFFICIENT) - checkpointLine.height;

    if (y > Player.POSITION && !awarded) {
      awarded = true;
      Reg.time += 15;
      Reg.speed += 25;
      if (Reg.time > 99) {
        Reg.time = 99;
      }
    }

    if (y > FlxG.height) {
      awarded = false;
      goalDistance += 1000 + 500 * Reg.difficulty;
    }

    super.update(elapsed);
  }
}
