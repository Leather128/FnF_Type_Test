package;

import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class OptionsMenu extends MusicBeatState
{
	var textMenuItems:Array<String> = ['Sound'];
	var curSelected:Int = 0;
	var grpOptionsTexts:FlxTypedGroup<Alphabet>;

	var inMenu = false;

	override function create()
	{
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		super.create();

		//openSubState(new OptionsSubState());
		grpOptionsTexts = new FlxTypedGroup<Alphabet>();
		add(grpOptionsTexts);

		spawnInTexts();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!inMenu)
		{
			if (controls.UP_P)
			{
				curSelected -= 1;
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
			}

			if (controls.DOWN_P)
			{
				curSelected += 1;
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
			}
		} else {
			if (controls.UP_P)
			{
				if (textMenuItems[curSelected] == 'Volume')
				{
					if (FlxG.sound.volume < 1)
					{
						FlxG.sound.volume += 1;
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					}
				}
			}

			if (controls.DOWN_P)
			{
				if (textMenuItems[curSelected] == 'Volume')
				{
					if (FlxG.sound.volume > 0.1)
					{
						FlxG.sound.volume -= 0.1;
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					}
				}
			}
		}

		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;

		if (curSelected >= textMenuItems.length)
			curSelected = 0;

		if (controls.BACK)
		{
			if (!inMenu)
			{
				FlxG.switchState(new MainMenuState());
			} else {
				inMenu = false;
			}
		}

		if (controls.ACCEPT)
		{
			if (!inMenu)
			{
				// yes ik weird ordering, but if i dont do it this way then things kinda mess up (switching pages specifically)
				if (textMenuItems[curSelected] != 'Muted')
				{
					inMenu = true;
				}

				switch(textMenuItems[curSelected])
				{
					case 'Muted':
						FlxG.sound.muted = !FlxG.sound.muted;

					case 'Back':
					{
						textMenuItems = ['Sound'];
						spawnInTexts();
					}

					case 'Sound':
					{
						textMenuItems = ["Back", "Muted", "Volume"];
						spawnInTexts();
					}
				}
			}
		}

		var bruh = 0;

		for (x in grpOptionsTexts.members)
		{
			x.targetY = bruh - curSelected;
			bruh++;
		}
	}

	function spawnInTexts()
	{
		curSelected = 0;
		inMenu = false;

		grpOptionsTexts.clear();

		for (i in 0...textMenuItems.length)
		{
			var option = new Alphabet(20, 20 + (i * 100), textMenuItems[i], true, false);
			option.isMenuItem = true;
			option.targetY = i;
			grpOptionsTexts.add(option);
		}
	}
}
