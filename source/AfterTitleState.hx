package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;

class AfterTitleState extends MusicBeatState // AfterTitleState By: Merphi
{
	var sorry:FlxText;
	var explanation:FlxSprite;
	var changelog:FlxText;

	var starFG:FlxBackdrop;
	var starBG:FlxBackdrop;
	var bg:FlxSprite;

	var FirstScreen:Bool = true;
	var SorryText:Bool = false;
	var ChangelogText:Bool = false;
	var CanPress:Bool = true;

	var StarsMove:Bool = false;

	var up:FlxSprite;
	var down:FlxSprite;
	var sus:FlxSprite;

	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		starFG = new FlxBackdrop(Paths.image('menu/starFG'), 1, 1, true, true);
		starFG.updateHitbox();
		starFG.antialiasing = true;
		starFG.scrollFactor.set();
		add(starFG);

		starBG = new FlxBackdrop(Paths.image('menu/starBG'), 1, 1, true, true);
		starBG.updateHitbox();
		starBG.antialiasing = true;
		starBG.scrollFactor.set();
		add(starBG);

		sorry = new FlxText(0, 175, 0, "-Sorry-\n
I'm Merphi, I don't own all the art and songs\n
I just tried to recreate a mod that will be out soon\n
All rights to songs, art, etc. belong to Team Funktastic\n
I spent over 700 hours of my time recreating the Impostor V4\n
I hope you understand and enjoy what i did\n", 0);
		sorry.setFormat(Paths.font("dialogue.ttf"), 32, FlxColor.WHITE, CENTER);
		sorry.borderSize = 2.0;
		sorry.screenCenter(X);
		sorry.antialiasing = true;
		add(sorry);

		changelog = new FlxText(0, 1005, 0, "-Changelog-\n
1. Downscroll and Middlescroll now works\n
2. Changed a bit Airship and Boiling Point stage\n
3. Changed White, Gray and Black sprites\n
4. Added Drip Black Sprite\n
5. Changed Oversight Song\n
6. Changed Ejected Song to newer\n
7. Added 2 new songs to Airship Week - Influence and Death Blow\n
8. Added 2 new songs to Gray Triple Trouble Week - Nyctophobia and Massacre\n
9. Changed Blackout Song to newer\n
10. Added 1 new song for pink - Heartbroken\n
11. Added Achievements\n
12. Changed Freeplay\n
13. Changed Time bar\n
14. Changed game icon\n
15. Changed some icons\n
16. Added 4 new bonus songs - Cleaning, Devil's Gambit, Bad Time and Despair\n
17. Henry songs are no longer part of Airship Week\n
18. Changed Double Kill Song\n
(Not all changes are listed here)\n", 0);
		changelog.setFormat(Paths.font("dialogue.ttf"), 18, FlxColor.WHITE, CENTER);
		changelog.borderSize = 2.0;
		changelog.screenCenter(X);
		changelog.antialiasing = true;
		add(changelog);

		up = new FlxSprite(0, 0).loadGraphic(Paths.image('cool/sussy_up'));
		up.antialiasing = false;
		up.updateHitbox();
		up.scrollFactor.set();
		up.screenCenter();
		up.antialiasing = true;
		up.alpha = 0;
		add(up);

		down = new FlxSprite(0, 0).loadGraphic(Paths.image('cool/sussy_down'));
		down.antialiasing = false;
		down.updateHitbox();
		down.scrollFactor.set();
		down.screenCenter();
		down.antialiasing = true;
		add(down);

		sus = new FlxSprite(0, 0).loadGraphic(Paths.image('cool/sussy'));
		sus.antialiasing = false;
		sus.updateHitbox();
		sus.scrollFactor.set();
		sus.screenCenter();
		sus.antialiasing = true;
		add(sus);

		explanation = new FlxSprite(0, 0).loadGraphic(Paths.image('cool/hi'));
		explanation.antialiasing = false;
		explanation.updateHitbox();
		explanation.scrollFactor.set();
		explanation.screenCenter();
		explanation.antialiasing = true;
		add(explanation);

		#if android
		addVirtualPad(UP_DOWN, A_B);
		#end
	}

	override function update(elapsed:Float)
	{
		if (!StarsMove)
		{
			starFG.x -= 0.12;
			starBG.x -= 0.04;
			new FlxTimer().start(0, function(tmr:FlxTimer)
			{
				StarsMove = true;
			});
		}
		if (StarsMove)
		{
			starFG.x -= 0.12;
			starBG.x -= 0.04;
			new FlxTimer().start(0, function(tmr:FlxTimer)
			{
				StarsMove = false;
			});
		}
		if (CanPress)
		{
			if (FirstScreen)
			{
				if (controls.ACCEPT)
				{
					CanPress = false;
					FlxTween.tween(explanation, {alpha: 0}, 0.25, {type: FlxTweenType.ONESHOT, ease: FlxEase.quadInOut});
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FirstScreen = false;
					new FlxTimer().start(0.25, function(tmeri:FlxTimer)
					{
						SorryText = true;
					});
					new FlxTimer().start(0.25, function(tmer:FlxTimer)
					{
						CanPress = true;
					});
				}
				if (controls.BACK)
				{
					ClientPrefs.ShowScreenAfterTitleState = false;
					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					MusicBeatState.switchState(new MainMenuState());
					CanPress = false;
				}
			}

			if (SorryText)
			{
				#if desktop
				DiscordClient.changePresence("Sorry", null);
				#end

				if (controls.ACCEPT)
				{
					MusicBeatState.switchState(new MainMenuState());
					FlxG.sound.play(Paths.sound('confirmMenu'));
					CanPress = false;
				}

				if (controls.BACK)
				{
					CoolUtil.browserLoad('https://github.com/MerphiG/Impostor-V4-Fanmade');
					FlxG.sound.play(Paths.sound('confirmMenu'));
				}

				if (controls.UI_DOWN_P)
				{
					CanPress = false;
					new FlxTimer().start(0.1, function(ti:FlxTimer)
					{
						FlxTween.tween(sorry, {y: sorry.y - 1000}, 1, {ease: FlxEase.quadInOut});
						FlxTween.tween(changelog, {y: changelog.y - 1000}, 1, {ease: FlxEase.quadInOut});
					});
					FlxTween.tween(down, {alpha: 0}, 0.50, {type: FlxTweenType.ONESHOT, ease: FlxEase.quadInOut});
					new FlxTimer().start(0.70, function(ti1:FlxTimer)
					{
						FlxTween.tween(up, {alpha: 1}, 0.50, {type: FlxTweenType.ONESHOT, ease: FlxEase.quadInOut});
					});
					FlxG.sound.play(Paths.sound('scrollMenu'));
					SorryText = false;
					ChangelogText = true;
					new FlxTimer().start(1.1, function(tim:FlxTimer)
					{
						CanPress = true;
					});
				}
			}

			if (ChangelogText)
			{
				#if desktop
				DiscordClient.changePresence("Changelog", null);
				#end

				if (controls.ACCEPT)
				{
					MusicBeatState.switchState(new MainMenuState());
					FlxG.sound.play(Paths.sound('confirmMenu'));
					CanPress = false;
				}

				if (controls.BACK)
				{
					CoolUtil.browserLoad('https://github.com/MerphiG/Impostor-V4-Fanmade');
					FlxG.sound.play(Paths.sound('confirmMenu'));
				}

				if (controls.UI_UP_P)
				{
					CanPress = false;
					new FlxTimer().start(0.1, function(ti:FlxTimer)
					{
						FlxTween.tween(sorry, {y: sorry.y + 1000}, 1, {ease: FlxEase.quadInOut});
						FlxTween.tween(changelog, {y: changelog.y + 1000}, 1, {ease: FlxEase.quadInOut});
					});
					FlxTween.tween(up, {alpha: 0}, 0.50, {type: FlxTweenType.ONESHOT, ease: FlxEase.quadInOut});
					new FlxTimer().start(0.70, function(ti2:FlxTimer)
					{
						FlxTween.tween(down, {alpha: 1}, 0.50, {type: FlxTweenType.ONESHOT, ease: FlxEase.quadInOut});
					});
					FlxG.sound.play(Paths.sound('scrollMenu'));
					SorryText = true;
					ChangelogText = false;
					new FlxTimer().start(1.1, function(tima:FlxTimer)
					{
						CanPress = true;
					});
				}
			}
		}

		super.update(elapsed);
	}
}
