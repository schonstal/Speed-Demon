package;

import flixel.util.FlxSave;
import flixel.FlxCamera;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.group.FlxSpriteGroup;

class Reg {
  public static var LANE_COUNT:Int = 3;

  public static var random:FlxRandom;

  public static var obstacleService:ObstacleService;

  public static var initialized:Bool = false;
  public static var started:Bool = false;
  public static var difficulty:Float = 1;
  public static var player:Player;
  public static var score:Int;
  public static var combo:Int;

  public static var hardMode:Bool = false;

  public static var TAU:Float = 6.28318530718;
}
