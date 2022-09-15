package;

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

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		
		blackScreen = new FlxSprite(0, 0).loadGraphic(Paths.image('upozorenje'));
		add(blackScreen);

		#if android
		warnText = new FlxText(0, 0, FlxG.width,
			"Hej, Pazi Se!\n
			Pazi Kako Stiskas Svoj Ekran!\n
			Mozes Da Polomis Telefon Na Bilo Koji Nacin, Ali\n
			Ovaj Mod Ima Osvetljenje Ekrana!\n
			Pritisni A Da Iskljucis Odmah Ili Idi Na Opcije.\n
			Pritisni B Da Bi Preskocio.\n
			Ti Si Bio Upozoren!",
			32);
		#else
		warnText = new FlxText(0, 0, FlxG.width,
			"Hej, Pazi Se!\n
			Ovaj Mod Ima Osvetljenje Ekrana\n
			Pritisni ENTER Da Iskljucis Odmah Ili Idi Na Opcije.\n
			Pritisni ESCAPE Da Bi Preskocio.\n
			Ti Si Bio Upozoren!",
			32);
		#end
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);

		#if android
		addVirtualPad(NONE, A_B);
		#end
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			var back:Bool = controls.BACK;
			if (controls.ACCEPT || back) {
				leftState = true;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if(!back) {
					ClientPrefs.flashing = false;
					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxFlicker.flicker(warnText, 1, 0.1, false, true, function(flk:FlxFlicker) {
						#if android
						virtualPad.alpha = 0;
						#end
						new FlxTimer().start(0.5, function (tmr:FlxTimer) {
							MusicBeatState.switchState(new TitleState());
						});
					});
				} else {
					FlxG.sound.play(Paths.sound('cancelMenu'));
					#if android
					FlxTween.tween(virtualPad, {alpha: 0}, 1);
					#end
					FlxTween.tween(warnText, {alpha: 0}, 1, {
						onComplete: function (twn:FlxTween) {
							MusicBeatState.switchState(new TitleState());
						}
					});
				}
			}
		}
		super.update(elapsed);
	}
}
