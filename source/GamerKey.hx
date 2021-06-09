package;

import flixel.FlxSprite;

class GamerKey extends FlxSprite
{
    public function new(x:Float, y:Float, character:String = "a")
    {
        super(x, y);

        antialiasing = false;
		frames = Paths.getSparrowAtlas('keys/keys');

        animation.addByPrefix(character, character.toLowerCase(), 1);

        animation.play(character, true, false, 0);
    }
}