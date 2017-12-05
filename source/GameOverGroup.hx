package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;

class GameOverGroup extends FlxSpriteGroup {
  var scoreText:FlxBitmapText;
  var highScoreText:FlxBitmapText;
  var gameOverSprite:FlxSprite;

  public function new():Void {
    super();

    var font = FlxBitmapFont.fromMonospace(
      "assets/images/fonts/numbers2x.png",
      "0123456789",
      new FlxPoint(16, 16)
    );

    gameOverSprite = new FlxSprite();
    gameOverSprite.loadGraphic("assets/images/hud/YouDied.png");
    add(gameOverSprite);

    scoreText = new FlxBitmapText(font);
    scoreText.letterSpacing = -2;
    scoreText.text = "0";
    scoreText.x = 4;
    scoreText.y = 142;
    scoreText.color = 0xff10a08d;
    add(scoreText);

    highScoreText = new FlxBitmapText(font);
    highScoreText.letterSpacing = -2;
    highScoreText.text = "0";
    highScoreText.x = FlxG.width/2 - 8;
    highScoreText.y = 177;
    highScoreText.color = 0xff10a08d;
    add(highScoreText);
  }

  public override function update(elapsed:Float):Void {
    scoreText.text = "" + Std.int(Reg.trackPosition * 50);
    highScoreText.text = "" + Std.int(FlxG.save.data.highScore);

    scoreText.x = FlxG.width / 2 - scoreText.width / 2;
    highScoreText.x = FlxG.width / 2 - highScoreText.width / 2;

    super.update(elapsed);
  }
}
