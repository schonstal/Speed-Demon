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
  var enemyGroup:FlxSpriteGroup;
  var playerLaserGroup:FlxSpriteGroup;

  override public function create():Void {
    super.create();
    FlxG.timeScale = 1;

    initializeRegistry();
    registerServices();
    spawnPatterns();

    FlxG.debugger.drawDebug = true;

    add(new Background());
    add(Reg.player);
    add(enemyGroup);
    add(obstacleGroup);
    add(playerLaserGroup);
  }

  function initializeRegistry() {
    Reg.trackPosition = 0;
    Reg.random = new FlxRandom();
    Reg.player = new Player();
  }

  function registerServices() {
    Reg.hazardService = new HazardService();

    obstacleGroup = new FlxSpriteGroup();
    Reg.obstacleService = new ObstacleService(obstacleGroup);

    enemyGroup = new FlxSpriteGroup();
    Reg.enemyService = new EnemyService(enemyGroup);

    playerLaserGroup = new FlxSpriteGroup();
    Reg.playerLaserService = new LaserService(playerLaserGroup);

  }

  function spawnPatterns() {
    for(i in 0...100) {
      Reg.hazardService.spawnPattern(Reg.random.int(0, 4));
    }
  }


  override public function destroy():Void {
    super.destroy();
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);

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
