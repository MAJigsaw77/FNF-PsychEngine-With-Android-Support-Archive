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

using StringTools;

class VisualsUISubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Opcije Za Vizulaciju I KI';
		rpcTitle = 'Visuals & UI Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Prskanja Strelica',
			"Ako Je Neocekivano, Stiskanjrm \"BOLESNO!\" Strelice Nece Pokazati Prskanja.",
			'noteSplashes',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Sakrij HUD',
			'Ako Je Ocekivano, Sakrije HUD Elemente.',
			'hideHud',
			'bool',
			false);
		addOption(option);
		
		var option:Option = new Option('Vremenska Traka:',
			"Kako Zelis Da Bude Vremesnka Traka?",
			'timeBarType',
			'string',
			'Time Left',
			['Time Left', 'Time Elapsed', 'Song Name', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Osvetljenje Ekrana',
			"Ako Je Neocekivano, Imaces Svetliji Ekran!",
			'flashing',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Zumiranje Kamere',
			"Ako Je Neocekivano, Kamera Nece Da Zumira Na Pritiskanju.",
			'camZooms',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Zumiranje Teksta Za Poen Na Zumiranju',
			"Ako Je Neocekivano, Iskljucuje Zumiranje Teksta Za Poen\nSvaki Put Kada Pritisnes Strelicu.",
			'scoreZoom',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Transpiracija Trake Za Stanje Srca',
			'Koliko Zelis Da Vidis Traku Za Stanje Srca I Ikonice.',
			'healthBarAlpha',
			'percent',
			1);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);

		var option:Option = new Option('BSS Brojac',
			'Ako Je Neocekivano, Sakrije BSS Brojac.',
			'showFPS',
			'bool',
			#if android false #else true #end);
		addOption(option);
		option.onChange = onChangeFPSCounter;
		
		var option:Option = new Option('Muzika Za Ekran-Pauzu:',
			"Koju Pesmu Zelis Da Ostavis Na Ekran-Pauzu?",
			'pauseMusic',
			'string',
			'Tea Time',
			['None', 'Breakfast', 'Tea Time']);
		addOption(option);
		option.onChange = onChangePauseMusic;
		
		#if CHECK_FOR_UPDATES
		var option:Option = new Option('Ocekuj Azuriranja',
			'Na Nova Azuriranja, Ukljuci Ovu Opciju Da Ocekujes Nova Azuriranja.',
			'checkForUpdates',
			'bool',
			true);
		addOption(option);
		#end

		super();
	}

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)));

		changedMusic = true;
	}

	override function destroy()
	{
		if(changedMusic) FlxG.sound.playMusic(Paths.music('freakyMenu'));
		super.destroy();
	}

	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.showFPS;
	}
}
