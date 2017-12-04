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

  public function new():Void {
    super();

    speedBar = new HudBar(FlxG.width - 84, FlxG.height - 16, 0xff10a08d, true);
    add(speedBar);

    healthBar = new HudBar(4, FlxG.height - 16, 0xffff1472);
    add(healthBar);
  }

  public override function update(elapsed:Float):Void {
    healthBar.value = Reg.player.health;
    speedBar.value = Reg.speed;

    super.update(elapsed);
  }
}
