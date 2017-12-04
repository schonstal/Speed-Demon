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

class PlayState extends FlxState {
  var spawnRate:Float = 0.5;
  var spawnAmt:Float = 0;

  var obstacleGroup:FlxSpriteGroup;
  var enemyGroup:FlxSpriteGroup;
  var playerLaserGroup:FlxSpriteGroup;
  var teleportGroup:FlxSpriteGroup;
  var explosionGroup:FlxSpriteGroup;
  var gameOverGroup:GameOverGroup;
  var hud:HUD;

  var gameOver:Bool = false;

  override public function create():Void {
    super.create();
    FlxG.timeScale = 1;

    initializeRegistry();
    registerServices();

    FlxG.debugger.drawDebug = true;

    hud = new HUD();
    gameOverGroup = new GameOverGroup();
    gameOverGroup.exists = false;

    add(new Background());
    add(new SpeedLines());
    add(new ExhaustGroup());
    add(Reg.player);
    add(enemyGroup);
    add(obstacleGroup);
    add(playerLaserGroup);
    add(teleportGroup);
    add(explosionGroup);
    add(hud);
    add(gameOverGroup);

    add(new ShootingEnemy());
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

    teleportGroup = new FlxSpriteGroup();
    Reg.teleportService = new TeleportService(teleportGroup);

    explosionGroup = new FlxSpriteGroup();
    Reg.explosionService = new ExplosionService(explosionGroup);
  }

  override public function destroy():Void {
    super.destroy();
  }

  override public function update(elapsed:Float):Void {
    spawnAmt += elapsed;
    if (spawnAmt >= spawnRate) {
      Reg.hazardService.spawnPattern(Reg.random.int(0, SpawnPatterns.PATTERNS[0].length-1));
      spawnAmt = 0;
    }

    super.update(elapsed);

    if (Reg.speed > 100) {
      Reg.speed = 100;
    }

    if (Reg.speed < 0) {
      Reg.speed = 0;
    }

    if (Reg.speed > 25) {
      FlxG.camera.shake(0.004 * Reg.speed/100, 0.2);
    }

    Reg.trackPosition += elapsed * (1 + Reg.speed/100);


    if (!Reg.player.alive) {
      if (FlxG.keys.justPressed.R) {
        FlxG.switchState(new PlayState());
      }

      if (!gameOver) {
        FlxG.save.flush();
        //FlxG.sound.music.stop();
        FlxG.timeScale = 0.2;
        new FlxTimer().start(0.1, function(t) {
          gameOverGroup.exists = true;
          hud.exists = false;
          FlxTween.tween(FlxG, { timeScale: 1 }, 0.5, { ease: FlxEase.quartOut, onComplete: function(t) {
            FlxG.timeScale = 1;
          }});
        });
      }

      gameOver = true;
    }

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
