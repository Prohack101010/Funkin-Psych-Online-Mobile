package mobile;

import mobile.Hitbox;

import flixel.util.FlxSignal.FlxTypedSignal;
import flixel.graphics.FlxGraphic;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.geom.Matrix;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import objects.Note;

class HitboxExtended extends Hitbox
{
	public var extraKey1 = ClientPrefs.data.extraKeyReturn1.toUpperCase();
	public var extraKey2 = ClientPrefs.data.extraKeyReturn2.toUpperCase();
	public var extraKey3 = ClientPrefs.data.extraKeyReturn3.toUpperCase();
	public var extraKey4 = ClientPrefs.data.extraKeyReturn4.toUpperCase();

	public var onButtonDown:FlxTypedSignal<(MobileButton, Array<String>) -> Void> = new FlxTypedSignal<(MobileButton, Array<String>) -> Void>();
	public var onButtonUp:FlxTypedSignal<(MobileButton, Array<String>) -> Void> = new FlxTypedSignal<(MobileButton, Array<String>) -> Void>();

	/**
	 * Create the zone.
	 */
	public function new(?CustomMode:String, ?globalAlpha:Float = 0.7):Void
	{
		instance = this;
		super(CustomMode, globalAlpha);

		scrollFactor.set();
		updateTrackedButtons();

		instance = this;
	}

	/**
	 * Clean up memory.
	 */
	override function destroy():Void
	{
		super.destroy();
		onButtonUp.destroy();
		onButtonDown.destroy();

		for (field in Reflect.fields(this))
			if (Std.isOfType(Reflect.field(this, field), MobileButton))
				Reflect.setField(this, field, FlxDestroyUtil.destroy(Reflect.field(this, field)));
	}

	override function createHintGraphic(Width:Int, Height:Int, Color:Int = 0xFFFFFF, ?isLane:Bool = false):BitmapData
	{
		var guh:Float = ClientPrefs.data.hitboxalpha;
		var shape:Shape = new Shape();
		shape.graphics.beginFill(Color);
		switch (ClientPrefs.data.hitboxtype) {
			case "No Gradient":
				var matrix:Matrix = new Matrix();
				matrix.createGradientBox(Width, Height, 0, 0, 0);
				if (isLane)
					shape.graphics.beginFill(Color);
				else
					shape.graphics.beginGradientFill(RADIAL, [Color, Color], [0, guh], [60, 255], matrix, PAD, RGB, 0);
				shape.graphics.drawRect(0, 0, Width, Height);
				shape.graphics.endFill();
			case "No Gradient (Old)":
				shape.graphics.lineStyle(10, Color, 1);
				shape.graphics.drawRect(0, 0, Width, Height);
				shape.graphics.endFill();
			case "Gradient":
				shape.graphics.lineStyle(3, Color, 1);
				shape.graphics.drawRect(0, 0, Width, Height);
				shape.graphics.lineStyle(0, 0, 0);
				shape.graphics.drawRect(3, 3, Width - 6, Height - 6);
				shape.graphics.endFill();
				if (isLane)
					shape.graphics.beginFill(Color);
				else
					shape.graphics.beginGradientFill(RADIAL, [Color, FlxColor.TRANSPARENT], [guh, 0], [0, 255], null, null, null, 0.5);
				shape.graphics.drawRect(3, 3, Width - 6, Height - 6);
				shape.graphics.endFill();
		}

		var bitmap:BitmapData = new BitmapData(Width, Height, true, 0);
		bitmap.draw(shape);
		return bitmap;
	}

	override private function createHint(Name:Array<String>, X:Float, Y:Float, Width:Int, Height:Int, Color:Int = 0xFFFFFF, ?Return:String, ?Map:String):MobileButton
	{
		var hint:MobileButton = new MobileButton(X, Y);
		hint.loadGraphic(createHintGraphic(Width, Height, Color));

		if (ClientPrefs.data.hitboxhint && !ClientPrefs.data.VSliceControl) {
			var doHeightFix:Bool = false;
			if (Height == 144) doHeightFix = true;

			//Up Hint
			hint.hintUp = new FlxSprite();
			hint.hintUp.loadGraphic(createHintGraphic(Width, Math.floor(Height * (doHeightFix ? 0.060 : 0.020)), Color, true));
			hint.hintUp.x = X;
			hint.hintUp.y = hint.y;

			//Down Hint
			hint.hintDown = new FlxSprite();
			hint.hintDown.loadGraphic(createHintGraphic(Width, Math.floor(Height * (doHeightFix ? 0.060 : 0.020)), Color, true));
			hint.hintDown.x = X;
			hint.hintDown.y = hint.y + hint.height / (doHeightFix ? 1.060 : 1.020);
		}

		hint.solid = false;
		hint.immovable = true;
		hint.scrollFactor.set();
		hint.alpha = 0.00001;
		hint.IDs = Name;
		hint.onDown.callback = function()
		{
			onButtonDown.dispatch(hint, Name);
			if (hint.alpha != globalAlpha)
				hint.alpha = globalAlpha;
			if ((hint.hintUp?.alpha != 0.00001 || hint.hintDown?.alpha != 0.00001) && hint.hintUp != null && hint.hintDown != null)
				hint.hintUp.alpha = hint.hintDown.alpha = 0.00001;
		}
		hint.onOut.callback = hint.onUp.callback = function()
		{
			onButtonUp.dispatch(hint, Name);
			if (hint.alpha != 0.00001)
				hint.alpha = 0.00001;
			if ((hint.hintUp?.alpha != globalAlpha || hint.hintDown?.alpha != globalAlpha) && hint.hintUp != null && hint.hintDown != null)
				hint.hintUp.alpha = hint.hintDown.alpha = globalAlpha;
		}
		#if FLX_DEBUG
		hint.ignoreDrawDebug = true;
		#end
		if (Return != null) hint.returnedKey = Return;
		return hint;
	}
}