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

		starFG = new FlxBackdrop(Paths.image('assets/images/menuDesat'), 1, 1, true, true);
		starFG.updateHitbox();
		starFG.antialiasing = false;
		starFG.scrollFactor.set();
		add(starFG);

		starBG = new FlxBackdrop(Paths.image('assets/images/menuDesat'), 1, 1, true, true);
		starBG.updateHitbox();
		starBG.antialiasing = false;
		starBG.scrollFactor.set();
		add(starBG);

		sorry = new FlxText(0, 175, 0, "-Obavestenje-\n
Ja Sam Stefan, Ovo Je Samo Obavestenje Da Je Ovo Psych Engine, Ali Na Srpskoj Verziji.\n
Hvala Vam Sto Ste Skinuli SB Engine 2.0.0 Verziju, Jako Predivno Od Vas.\n
Ja Sam Potrosio Skoro 4 Nedelje Za SB Engine Da Napravim Ovaj Veliki Update Za Sve Vas.\n
Nadam Se Da Ste Me Skapirali. Uzivaljte\n", 0);
		sorry.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
		sorry.borderSize = 2.0;
		sorry.screenCenter(X);
		sorry.antialiasing = true;
		add(sorry);

		changelog = new FlxText(0, 1005, 0, "-Promene:-\n
1. Novi FPS Stil I Stil Fonta.\n
2. Nove Promene Na PlayState.hx.\n
3. Nove Promene Na MainMenuState.hx\n
4. Izbrisan Je Stefan Decko (Nazalost :().\n
5. Sada Imate Najlaksi Nacin Za Stefanov Discord Na CreditsState.hx.\n
6. Male Promene U Vezi GameplayChangesState.hx.\n
7. Loading Screen Je Dodat - Nece Biti Obrisan.\n
8. Obrisano Je: Mods, Awards I Donate.\n
9. Stara Ikonica Vracena Za SB Engine.\n
10. Nova Vremenska Traka.\n
11. Nove Funkcije.\n
12. Potpuno Nova Podesavanja.\n
13. MasterEditorMenu.hx Je Popravljen.\n
14. Dodato Par Sitnica U Vezi MainMenuState.hx.\n
15. Dodate Nove Ikonice Za Null Karaktera.\n
16. Lag Fix Je Popravljen Za Android Port Na 6GB Rama Do 4GB Rama.\n
17. Mod Podrska Radi I Bez ModsMenuState.hx.\n
18. \n
(Vrlo Uskoro Jos Novih Promena).\n", 0);
		changelog.setFormat(Paths.font("vcr.ttf"), 18, FlxColor.WHITE, CENTER);
		changelog.borderSize = 2.0;
		changelog.screenCenter(X);
		changelog.antialiasing = true;
		add(changelog);

		up = new FlxSprite(0, 0).loadGraphic(Paths.image('assets/images/Strelice_Gore'));
		up.antialiasing = false;
		up.updateHitbox();
		up.scrollFactor.set();
		up.screenCenter();
		up.antialiasing = true;
		up.alpha = 0;
		add(up);

		down = new FlxSprite(0, 0).loadGraphic(Paths.image('assets/images/Strelice_Dole'));
		down.antialiasing = false;
		down.updateHitbox();
		down.scrollFactor.set();
		down.screenCenter();
		down.antialiasing = true;
		add(down);

		sus = new FlxSprite(0, 0).loadGraphic(Paths.image('assets/images/Interesanto'));
		sus.antialiasing = false;
		sus.updateHitbox();
		sus.scrollFactor.set();
		sus.screenCenter();
		sus.antialiasing = true;
		add(sus);

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
					CoolUtil.browserLoad('https://github.com/StefanBETA2008/SB-Engine');
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
					CoolUtil.browserLoad('https://github.com/StefanBETA2008/SB-Engine');
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
