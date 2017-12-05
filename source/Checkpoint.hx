package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;

class Checkpoint extends FlxSpriteGroup {
  var healthBar:HudBar;
  var speedBar:HudBar;
  var timeText:FlxBitmapText;
  var scoreText:FlxBitmapText;

  var flash:Bool = false;
  var flashTime:Float = 0;

  public function new():Void {
    super();

    speedBar = new HudBar(FlxG.width - 84, FlxG.height - 16, 0xff10a08d, true);
    add(speedBar);

    healthBar = new HudBar(4, FlxG.height - 16, 0xffff1472);
    add(healthBar);

    var font = FlxBitmapFont.fromMonospace(
      "assets/images/fonts/numbers2x.png",
      "0123456789",
      new FlxPoint(16, 16)
    );

    scoreText = new FlxBitmapText(font);
    scoreText.letterSpacing = -2;
    scoreText.text = "0";
    scoreText.x = 4;
    scoreText.y = FlxG.height - 16;
    add(scoreText);
  }

  public override function update(elapsed:Float):Void {
    if (y > Reg.player.y) {
      // award time
      // increment checkpoint count
    }

    y = Reg.trackPosition
    healthBar.value = Reg.player.health;
    speedBar.value = Reg.speed;

    if (Reg.time < 6) {
      scoreText.color = flash ? 0xffffb9be : 0xffff4363;

      if (flashTime > 0.05) {
        flash = !flash;
        flashTime = 0;
      }
      flashTime += elapsed;
    } else if (Reg.time < 11) {
      scoreText.color = 0xffff4363;
    } else if (Reg.time < 16) {
      scoreText.color = 0xffc02265;
    } else {
      scoreText.color = 0xff812256;
    }

    scoreText.text = "" + Std.int(Reg.time); //Std.int(Reg.trackPosition * 10);
    scoreText.x = FlxG.width/2 - scoreText.width/2;

    super.update(elapsed);
  }
}
