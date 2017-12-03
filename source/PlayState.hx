package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxRandom;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.math.FlxPoint;

class PlayState extends FlxState
{
  var obstacleGroup:FlxSpriteGroup;

  override public function create():Void {
    super.create();
    FlxG.timeScale = 1;
    Reg.trackPosition = 0;

    add(new Background());

    Reg.player = new Player();
    Reg.player.init();
    Reg.random = new FlxRandom();

    obstacleGroup = new FlxSpriteGroup();
    Reg.obstacleService = new ObstacleService(obstacleGroup);
    add(obstacleGroup);

    for(i in 0...100) {
      Reg.obstacleService.spawnPattern(Reg.random.int(0, 4));
    }

    FlxG.debugger.drawDebug = true;

    add(Reg.player);
  }

  override public function destroy():Void {
    super.destroy();
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);

    FlxG.overlap(Reg.player, obstacleGroup, function(player:FlxObject, obstacle:FlxObject):Void {
      player.hurt(25);
    });

    Reg.trackPosition += elapsed;

    recordHighScores();
  }

  private function recordHighScores():Void {
    if (Reg.hardMode) {
      if (FlxG.save.data.hardHighScore == null) FlxG.save.data.hardHighScore = 0;
      if (Reg.score > FlxG.save.data.hardHighScore) FlxG.save.data.hardHighScore = Reg.score;
    } else {
      if (FlxG.save.data.highScore == null) FlxG.save.data.highScore = 0;
      if (Reg.score > FlxG.save.data.highScore) FlxG.save.data.highScore = Reg.score;
    }
  }
}
