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
  var spawnRate:Float = 0.5;
  var spawnAmt:Float = 0;

  var obstacleGroup:FlxSpriteGroup;
  var enemyGroup:FlxSpriteGroup;
  var playerLaserGroup:FlxSpriteGroup;

  override public function create():Void {
    super.create();
    FlxG.timeScale = 0.5;

    initializeRegistry();
    registerServices();

    FlxG.debugger.drawDebug = true;

    add(new Background());
    add(Reg.player);
    add(enemyGroup);
    add(obstacleGroup);
    add(playerLaserGroup);

    add(new ShootingEnemy());

    add(new HUD());
  }

  function initializeRegistry() {
    Reg.trackPosition = 0;
    Reg.random = new FlxRandom();
    Reg.player = new Player();
    Reg.speed = 0;
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

  override public function destroy():Void {
    super.destroy();
  }

  override public function update(elapsed:Float):Void {
    spawnAmt += elapsed;
    if (spawnAmt >= spawnRate) {
      Reg.hazardService.spawnPattern(Reg.random.int(0, 4));
      spawnAmt = 0;
    }

    if (FlxG.keys.justPressed.Q) {
      Reg.speed += 25;
      if (Reg.speed >= 100) {
        Reg.speed = 100;
      }
    }

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
