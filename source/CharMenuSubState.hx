package;

import flixel.FlxG;
import Controls.Control;
import flixel.system.FlxSound;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flash.text.TextField;
#if desktop
import Discord.DiscordClient;
#end

class CharMenuSubState extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['BF DEBUG', 'DAD DEBUG', 'GF DEBUG'];

	var selector:FlxSprite;
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<FlxText>;

	public function new()
	{
		super();

		grpOptionsTexts = new FlxTypedGroup<FlxText>();
		add(grpOptionsTexts);

		selector = new FlxSprite().makeGraphic(5, 5, FlxColor.RED);
		add(selector);

		for (i in 0...textMenuItems.length)
		{
			var optionText:FlxText = new FlxText(500, 250 + (i * 50), 0, textMenuItems[i], 40);
			optionText.ID = i;
			grpOptionsTexts.add(optionText);

			#if desktop
			DiscordClient.changePresence("In Anim Debug Menu Selection", null);
			#end
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UP_P)
			{
			curSelected -= 1;
		    FlxG.sound.play(Paths.sound('scrollMenu'));
			}

		if (controls.DOWN_P)
			{
			curSelected += 1;
		    FlxG.sound.play(Paths.sound('scrollMenu'));
			}

		if (controls.BACK)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxG.switchState(new MainMenuState());
			}

		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;

		if (curSelected >= textMenuItems.length)
			curSelected = 0;

		grpOptionsTexts.forEach(function(txt:FlxText)
		{
			txt.color = FlxColor.WHITE;

			if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
		});

		if (controls.ACCEPT)
		{
			switch (textMenuItems[curSelected])
			{
				case "BF DEBUG":
					FlxG.state.closeSubState();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.switchState(new FreeplayState());
				case "DAD DEBUG":
					FlxG.state.closeSubState();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.switchState(new StoryMenuState());
				case "GF DEBUG":
					FlxG.state.closeSubState();
					FlxG.sound.play(Paths.sound('cancelMenu'));
					FlxG.switchState(new MainMenuState());

			}
		}
	}
}
