package mobile;

import mobile.MobilePad;

import flixel.util.FlxSignal.FlxTypedSignal;
import flixel.graphics.frames.FlxTileFrames;
import flixel.graphics.FlxGraphic;
import openfl.display.BitmapData;
import openfl.utils.Assets;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.FlxCamera;

class MobilePadExtended extends MobilePad {
	public var onButtonDown:FlxTypedSignal<(MobileButton, Array<String>) -> Void> = new FlxTypedSignal<(MobileButton, Array<String>) -> Void>();
	public var onButtonUp:FlxTypedSignal<(MobileButton, Array<String>) -> Void> = new FlxTypedSignal<(MobileButton, Array<String>) -> Void>();

	public function new(DPad:String, Action:String, globalAlpha:Float = 0.7) {
		super(DPad, Action, globalAlpha);
	}

	override public function createVirtualButton(buttonIDs:Array<String>, x:Float, y:Float, framePath:String, ?scale:Float = 1, ?ColorS:Int = 0xFFFFFF):MobileButton {
		var frames:FlxGraphic;

		final path:String = MobileInputHandler.mobileFolderPath + 'MobilePad/Textures/$framePath.png';
		#if MODS_ALLOWED
		final modsPath:String = Paths.modFolders('mobile/MobilePad/Textures/$framePath.png');
		if(sys.FileSystem.exists(modsPath))
			frames = FlxGraphic.fromBitmapData(BitmapData.fromFile(modsPath));
		else #end if(Assets.exists(path))
			frames = FlxGraphic.fromBitmapData(Assets.getBitmapData(path));
		else
			frames = FlxGraphic.fromBitmapData(Assets.getBitmapData(MobileInputHandler.mobileFolderPath + 'MobilePad/Textures/default.png'));

		var button = new MobileButton(x, y);
		button.scale.set(scale, scale);
		button.frames = FlxTileFrames.fromGraphic(frames, FlxPoint.get(Std.int(frames.width / 2), frames.height));

		button.updateHitbox();
		button.updateLabelPosition();

		button.bounds.makeGraphic(Std.int(button.width - 50), Std.int(button.height - 50), FlxColor.TRANSPARENT);
		button.centerBounds();

		button.immovable = true;
		button.solid = button.moves = false;
		button.antialiasing = ClientPrefs.data.antialiasing;
		button.tag = framePath.toUpperCase();

		if (ColorS != -1) button.color = ColorS;
		button.IDs = buttonIDs;
		button.onDown.callback = () -> onButtonDown.dispatch(button, buttonIDs);
		button.onOut.callback = button.onUp.callback = () -> onButtonUp.dispatch(button, buttonIDs);
		return button;
	}

	override public function destroy():Void
	{
		super.destroy();
		onButtonUp.destroy();
		onButtonDown.destroy();

		for (fieldName in Reflect.fields(this))
		{
			var field = Reflect.field(this, fieldName);
			if (Std.isOfType(field, MobileButton))
				Reflect.setField(this, fieldName, FlxDestroyUtil.destroy(field));
		}
	}
}