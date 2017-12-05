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
  var boostGroup:FlxSpriteGroup;
  var playerLaserGroup:FlxSpriteGroup;
  var teleportGroup:FlxSpriteGroup;
  var explosionGroup:FlxSpriteGroup;
  var gameOverGroup:GameOverGroup;
  var hud:HUD;

  var titlescreen:FlxSprite;

  var gameOver:Bool = false;

  override public function create():Void {
    super.create();
    FlxG.timeScale = 1;
    Reg.time = 30;
    Reg.difficulty = 0;

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
    add(new Checkpoint());
    add(playerLaserGroup);
    add(teleportGroup);
    add(new ShootingEnemy());
    add(explosionGroup);
    add(boostGroup);
    add(hud);
    add(gameOverGroup);

    if (!Reg.started) {
      titlescreen = new FlxSprite();
      titlescreen.loadGraphic("assets/images/hud/title.png");
      add(titlescreen);
      Reg.speed = -50;
    }

    if (Reg.started) {
      Reg.player.visible = true;
      Reg.hazardService.spawnPattern();
      Reg.hazardService.spawnPattern();
      Reg.hazardService.spawnPattern();
    }
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

    boostGroup = new FlxSpriteGroup();
    Reg.boostService = new BoostService(boostGroup);
  }

  override public function destroy():Void {
    super.destroy();
  }

  override public function update(elapsed:Float):Void {
    if (!Reg.player.alive) {
      if (FlxG.keys.justPressed.SPACE) {
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

    if (!Reg.started) {
      hud.visible = false;
      boostGroup.visible = false;
      FlxG.timeScale = 0.25;

      if (FlxG.keys.justPressed.SPACE) {
        FlxG.timeScale = 1;
        hud.visible = true;
        titlescreen.visible = false;
        boostGroup.visible = true;
        Reg.started = true;
        Reg.player.visible = true;
        Reg.hazardService.spawnPattern();
        Reg.hazardService.spawnPattern();
        Reg.hazardService.spawnPattern();
      }

      super.update(elapsed);
      return;
    }

    spawnAmt += elapsed;
    if (spawnAmt >= spawnRate) {
      Reg.hazardService.spawnPattern();
      spawnAmt = 0;
    }

    Reg.time -= elapsed;
    if (Reg.time < 0) {
      Reg.player.hurt(100);
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

    if (!gameOver && Reg.started) {
      Reg.trackPosition += elapsed * (1 + Reg.speed/100);
    }

    Reg.distance = Reg.trackPosition * 50;

    if (Reg.trackPosition > 100) {
      Reg.difficulty = 1;
    }

    if (Reg.trackPosition > 1000) {
      Reg.difficulty = 2;
    }

    recordHighScores();
  }

  private function recordHighScores():Void {
    if (FlxG.save.data.highScore == null) FlxG.save.data.highScore = 0;
    if (Reg.trackPosition * Reg.DISTANCE_COEFFICIENT > FlxG.save.data.highScore) {
      FlxG.save.data.highScore = Reg.trackPosition * Reg.DISTANCE_COEFFICIENT;
    }
  }
}
