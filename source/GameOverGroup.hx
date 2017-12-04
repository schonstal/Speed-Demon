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
    scoreText.y = 240;
    //add(scoreText);

    highScoreText = new FlxBitmapText(font);
    highScoreText.letterSpacing = -2;
    highScoreText.text = "0";
    highScoreText.x = FlxG.width/2 - 8;
    highScoreText.y = 260;
    //add(highScoreText);
  }

  public override function update(elapsed:Float):Void {
    scoreText.text = "" + Reg.score;
    highScoreText.text = "" + FlxG.save.data.highScore;

    var X:Float = scoreText.width > highScoreText.width ? scoreText.width : highScoreText.width;
    scoreText.x = FlxG.width/2 - X/2;
    highScoreText.x = FlxG.width/2 - X/2;

    super.update(elapsed);
  }
}
