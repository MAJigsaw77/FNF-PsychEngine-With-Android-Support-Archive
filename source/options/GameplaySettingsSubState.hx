package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;
#if android
import android.Hardware;
#end

using StringTools;

class GameplaySettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Opcije Za Igranje';
		rpcTitle = 'Gameplay Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Mod Kontrolera',
			'Ocekuj Ovu Opciju Ako Si\nZainteresovan Da Uzmes Svoju Tastaturu.',
			'controllerMode',
			'bool',
			#if android true #else false #end);
		addOption(option);

		//I'd suggest using "Downscroll" as an example for making your own option since it is the simplest here
		var option:Option = new Option('Strelice-Dole', //Name
			'Ako Je Ocekivano, Imas Strelice Dole.', //Description
			'downScroll', //Save data variable name
			'bool', //Variable type
			false); //Default value
		addOption(option);

		var option:Option = new Option('Strelice U Sredini',
			'Ako Je Ocekivano, Tvoje Strelice Ce Biti U Sredini.',
			'middleScroll',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Protivnicke Strelice',
			'Ako Je Neocekivano, Protivnik Nece Imati Strelice Ako Imas Ukljucenu Opciju "Strelice U Sredini".',
			'opponentStrums',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Duh Stiskanja',
			"Ako Je Ocekivano, Neces Da Imas Nijednu Gresku\nAko Nemas Nijednu Strelicu.",
			'ghostTapping',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Iskljuci RESET Dugme',
			"Ako Je Ocekivano, Pritiskanjem Dugmeta RESET Nece Nista Uraditi.\n{Ova Opcija Je Samo Za Windows, Mac I Linux Podrsku.}",
			'noReset',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Hitsound Volume',
			'Zabavne Strelice Urade \"Tick!\" Ako Ih Pritisnes."',
			'hitsoundVolume',
			'percent',
			0);
		addOption(option);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		option.onChange = onChangeHitsoundVolume;

		var option:Option = new Option('Sadrzaj Ocene',
			'Promeni Koliko Kasno/Pre Zelis Da Stiskas  "BOLESNO!".',
			'ratingOffset',
			'int',
			0);
		option.displayFormat = '%vms';
		option.scrollSpeed = 20;
		option.minValue = -30;
		option.maxValue = 30;
		addOption(option);

		var option:Option = new Option('Stiskanje BOLESNO!',
			'Promeni Koliko Hoces Da Bude\nZa Stiskanje "BOLESNO!" U Milisekundima.',
			'sickWindow',
			'int',
			45);
		option.displayFormat = '%vms';
		option.scrollSpeed = 15;
		option.minValue = 15;
		option.maxValue = 45;
		addOption(option);

		var option:Option = new Option('Stiskanje ODLIČNO',
			'Promeni Koliko Hoces Da Bude\nZa Stiskanje "ODLICNO" U Milisekundima.',
			'goodWindow',
			'int',
			90);
		option.displayFormat = '%vms';
		option.scrollSpeed = 30;
		option.minValue = 15;
		option.maxValue = 90;
		addOption(option);

		var option:Option = new Option('Stiskanje LOSE',
			'Promeni Koliko Hoces Da Bude\nZa Stiskanje "LOSE" U Milisekundima.',
			'badWindow',
			'int',
			135);
		option.displayFormat = '%vms';
		option.scrollSpeed = 60;
		option.minValue = 15;
		option.maxValue = 135;
		addOption(option);

		var option:Option = new Option('Bezbedno Stiskanje',
			'Menja Koliko Mozes Da\nStiskas Strelice Pre Ili Posle.',
			'safeFrames',
			'float',
			10);
		option.scrollSpeed = 5;
		option.minValue = 2;
		option.maxValue = 10;
		option.changeValue = 0.1;
		addOption(option);

		#if android
		var option:Option = new Option('KrajIgre Vibracija',
			'Ako Je Ocekivano, SB Engine Ce Da Vibrira Kada Umres.\n{Ova Opcija Je Samo Za Android Podrsku}.',
			'vibration',
			'bool',
			false);
		addOption(option);
		option.onChange = onChangeGameOverVibration;
		#end

		super();
	}

	function onChangeHitsoundVolume()
	{
		FlxG.sound.play(Paths.sound('hitsound'), ClientPrefs.hitsoundVolume);
	}

	#if android
	function onChangeGameOverVibration()
	{
		if(ClientPrefs.vibration)
		{
			Hardware.vibrate(1000);
		}
	}
	#end
}
