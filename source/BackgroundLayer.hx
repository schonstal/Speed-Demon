package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class BackgroundLayer extends FlxSpriteGroup
{
  public var z:Float = 0;

  var activeSprite:FlxSprite;
  var bufferSprite:FlxSprite;

  public function new(image:String, Z:Float) {
    super();

    z = Z;

    activeSprite = new FlxSprite(0, 0);
    activeSprite.loadGraphic(image);
    activeSprite.x = (FlxG.width - activeSprite.width)/2;
    activeSprite.velocity.y = z * Background.SCROLL_SPEED;

    add(activeSprite);

    bufferSprite = new FlxSprite(0, -activeSprite.height);
    bufferSprite.loadGraphic(image);
    bufferSprite.x = (FlxG.width - bufferSprite.width)/2;
    bufferSprite.velocity.y = z * Background.SCROLL_SPEED;

    add(bufferSprite);
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);

    if (activeSprite.y > FlxG.height) {
      var sprite:FlxSprite = activeSprite;
      activeSprite = bufferSprite;
      bufferSprite = sprite;
    }

    bufferSprite.y = activeSprite.y - activeSprite.height;
  }
}
