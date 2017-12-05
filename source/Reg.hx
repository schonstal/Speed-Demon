package;

import flixel.util.FlxSave;
import flixel.FlxCamera;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.group.FlxSpriteGroup;

class Reg {
  public static var LANE_COUNT:Int = 4;
  public static var LANE_OFFSET:Int = 72;
  public static var LANE_WIDTH:Int = 30;

  public static var random:FlxRandom;

  public static var obstacleService:ObstacleService;
  public static var enemyService:EnemyService;
  public static var boostService:BoostService;
  public static var hazardService:HazardService;
  public static var playerLaserService:LaserService;
  public static var teleportService:TeleportService;
  public static var explosionService:ExplosionService;

  public static var initialized:Bool = false;
  public static var started:Bool = false;
  public static var player:Player;

  public static var time:Float = 0;

  public static var trackPosition:Float = 0;
  public static var speed:Float = 25;

  public static var TAU:Float = 6.28318530718;
}
