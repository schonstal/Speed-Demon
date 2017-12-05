package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;

class HUD extends FlxSpriteGroup {
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
    healthBar.value = Reg.player.health;
    speedBar.value = Reg.speed;

    if (Reg.time < 6) {
      scoreText.color = flash ? 0xffffb9be : 0xffff4363;

      if (flashTime > 0.05) {
        flash = !flash;
        flashTime = 0;
      }
      flashTime += elapsed;
    } else {
      scoreText.color = 0xffffb9be;
    }

    scoreText.text = "" + Std.int(Reg.time); //Std.int(Reg.trackPosition * 10);
    scoreText.x = FlxG.width/2 - scoreText.width/2;

    super.update(elapsed);
  }
}
