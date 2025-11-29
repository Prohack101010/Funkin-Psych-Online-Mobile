package mobile;

import mobile.Hitbox as OGHitbox;

class FunkinHitbox extends OGHitbox {
	public var extraKey1 = ClientPrefs.data.extraKeyReturn1.toUpperCase();
	public var extraKey2 = ClientPrefs.data.extraKeyReturn2.toUpperCase();
	public var extraKey3 = ClientPrefs.data.extraKeyReturn3.toUpperCase();
	public var extraKey4 = ClientPrefs.data.extraKeyReturn4.toUpperCase();
	public function new(Mode:String, globalAlpha:Float = 0.7, ?disableCreation:Bool):Void
	{
		super(Mode, globalAlpha, true);
		if ((ClientPrefs.data.hitboxmode == 'V Slice' && Mode == null) || Mode == 'V Slice')
		{
			if (Note.maniaKeys == 4) {
				addHint('buttonLeft', ["NOTE_1 = 0"], 0, 0, 140, Std.int(FlxG.height), 0xFFC24B99);
				addHint('buttonDown', ["NOTE_2 = 1"], 0, 0, 140, Std.int(FlxG.height), 0xFF00FFFF);
				addHint('buttonUp', ["NOTE_3 = 2"], 0, 0, 140, Std.int(FlxG.height), 0xFF12FA05);
				addHint('buttonRight', ["NOTE_4 = 3"], 0, 0, 140, Std.int(FlxG.height), 0xFFF9393F);
			} else {
				if (Note.maniaKeys >= 1) addHint('buttonLeft', ["NOTE_1 = 0"], 0, 0, 110, Std.int(FlxG.height), 0xFFFFFFFF);
				if (Note.maniaKeys >= 2) addHint('buttonDown', ["NOTE_2 = 1"], 0, 0, 110, Std.int(FlxG.height), 0xFFFFFFFF);
				if (Note.maniaKeys >= 3) addHint('buttonUp', ["NOTE_3 = 2"], 0, 0, 110, Std.int(FlxG.height), 0xFFFFFFFF);
				if (Note.maniaKeys >= 4) addHint('buttonRight', ["NOTE_4 = 3"], 0, 0, 110, Std.int(FlxG.height), 0xFFFFFFFF);
				if (Note.maniaKeys >= 5) addHint('buttonNote5', ["NOTE_5 = 4"], 0, 0, 110, Std.int(FlxG.height), 0xFFFFFFFF);
				if (Note.maniaKeys >= 6) addHint('buttonNote6', ["NOTE_6 = 5"], 0, 0, 110, Std.int(FlxG.height), 0xFFFFFFFF);
				if (Note.maniaKeys >= 7) addHint('buttonNote7', ["NOTE_7 = 6"], 0, 0, 110, Std.int(FlxG.height), 0xFFFFFFFF);
				if (Note.maniaKeys >= 8) addHint('buttonNote8', ["NOTE_8 = 7"], 0, 0, 110, Std.int(FlxG.height), 0xFFFFFFFF);
				if (Note.maniaKeys >= 9) addHint('buttonNote9', ["NOTE_9 = 8"], 0, 0, 110, Std.int(FlxG.height), 0xFFFFFFFF);
			}
		}
		else
		{
			var Custom:String = Mode != null ? Mode : ClientPrefs.data.hitboxmode;
			if (!MobileInputHandler.hitboxModes.exists(Custom))
				throw 'The Custom Hitbox File doesn\'t exists.';

			var currentHint = MobileInputHandler.hitboxModes.get(Custom).hints;
			if (MobileInputHandler.hitboxModes.get(Custom).none != null)
				currentHint = MobileInputHandler.hitboxModes.get(Custom).none;
			if (ClientPrefs.data.extraKeys == 1 && MobileInputHandler.hitboxModes.get(Custom).single != null)
				currentHint = MobileInputHandler.hitboxModes.get(Custom).single;
			if (ClientPrefs.data.extraKeys == 2 && MobileInputHandler.hitboxModes.get(Custom).double != null)
				currentHint = MobileInputHandler.hitboxModes.get(Custom).double;
			if (ClientPrefs.data.extraKeys == 3 && MobileInputHandler.hitboxModes.get(Custom).triple != null)
				currentHint = MobileInputHandler.hitboxModes.get(Custom).triple;
			if (ClientPrefs.data.extraKeys == 4 && MobileInputHandler.hitboxModes.get(Custom).quad != null)
				currentHint = MobileInputHandler.hitboxModes.get(Custom).quad;
			if (ClientPrefs.data.extraKeys != 0 && MobileInputHandler.hitboxModes.get(Custom).hints != null)
				currentHint = MobileInputHandler.hitboxModes.get(Custom).hints;

			//Extra Key Stuff
			if (Note.maniaKeys == 1 && MobileInputHandler.hitboxModes.get(Custom).mania1 != null)
				currentHint = MobileInputHandler.hitboxModes.get(Custom).mania1;
			if (Note.maniaKeys == 2 && MobileInputHandler.hitboxModes.get(Custom).mania2 != null)
				currentHint = MobileInputHandler.hitboxModes.get(Custom).mania2;
			if (Note.maniaKeys == 3 && MobileInputHandler.hitboxModes.get(Custom).mania3 != null)
				currentHint = MobileInputHandler.hitboxModes.get(Custom).mania3;
			if (Note.maniaKeys == 4 && MobileInputHandler.hitboxModes.get(Custom).mania4 != null)
				currentHint = MobileInputHandler.hitboxModes.get(Custom).mania4;
			if (Note.maniaKeys == 5 && MobileInputHandler.hitboxModes.get(Custom).mania5 != null)
				currentHint = MobileInputHandler.hitboxModes.get(Custom).mania5;
			if (Note.maniaKeys == 6 && MobileInputHandler.hitboxModes.get(Custom).mania6 != null)
				currentHint = MobileInputHandler.hitboxModes.get(Custom).mania6;
			if (Note.maniaKeys == 7 && MobileInputHandler.hitboxModes.get(Custom).mania7 != null)
				currentHint = MobileInputHandler.hitboxModes.get(Custom).mania7;
			if (Note.maniaKeys == 8 && MobileInputHandler.hitboxModes.get(Custom).mania8 != null)
				currentHint = MobileInputHandler.hitboxModes.get(Custom).mania8;
			if (Note.maniaKeys == 9 && MobileInputHandler.hitboxModes.get(Custom).mania9 != null)
				currentHint = MobileInputHandler.hitboxModes.get(Custom).mania9;
			if (Note.maniaKeys == 20 && MobileInputHandler.hitboxModes.get(Custom).mania20 != null)
				currentHint = MobileInputHandler.hitboxModes.get(Custom).mania20;
			if (Note.maniaKeys == 55 && MobileInputHandler.hitboxModes.get(Custom).mania55 != null)
				currentHint = MobileInputHandler.hitboxModes.get(Custom).mania55;

			for (buttonData in currentHint)
			{
				var buttonX:Float = buttonData.x;
				var buttonY:Float = buttonData.y;
				var buttonWidth:Int = buttonData.width;
				var buttonHeight:Int = buttonData.height;
				var buttonColor = buttonData.color;
				var buttonReturn = buttonData.returnKey;
				var location = ClientPrefs.data.hitboxLocation;
				var addButton:Bool = false;

				switch (location) {
					case 'Top':
						if (buttonData.topX != null) buttonX = buttonData.topX;
						if (buttonData.topY != null) buttonY = buttonData.topY;
						if (buttonData.topWidth != null) buttonWidth = buttonData.topWidth;
						if (buttonData.topHeight != null) buttonHeight = buttonData.topHeight;
						if (buttonData.topColor != null) buttonColor = buttonData.topColor;
						if (buttonData.topReturnKey != null) buttonReturn = buttonData.topReturnKey;
					case 'Middle':
						if (buttonData.middleX != null) buttonX = buttonData.middleX;
						if (buttonData.middleY != null) buttonY = buttonData.middleY;
						if (buttonData.middleWidth != null) buttonWidth = buttonData.middleWidth;
						if (buttonData.middleHeight != null) buttonHeight = buttonData.middleHeight;
						if (buttonData.middleColor != null) buttonColor = buttonData.middleColor;
						if (buttonData.middleReturnKey != null) buttonReturn = buttonData.middleReturnKey;
					case 'Bottom':
						if (buttonData.bottomX != null) buttonX = buttonData.bottomX;
						if (buttonData.bottomY != null) buttonY = buttonData.bottomY;
						if (buttonData.bottomWidth != null) buttonWidth = buttonData.bottomWidth;
						if (buttonData.bottomHeight != null) buttonHeight = buttonData.bottomHeight;
						if (buttonData.bottomColor != null) buttonColor = buttonData.bottomColor;
						if (buttonData.bottomReturnKey != null) buttonReturn = buttonData.bottomReturnKey;
				}

				if (ClientPrefs.data.extraKeys == 0 && buttonData.extraKeyMode == 0 ||
				   ClientPrefs.data.extraKeys == 1 && buttonData.extraKeyMode == 1 ||
				   ClientPrefs.data.extraKeys == 2 && buttonData.extraKeyMode == 2 ||
				   ClientPrefs.data.extraKeys == 3 && buttonData.extraKeyMode == 3 ||
				   ClientPrefs.data.extraKeys == 4 && buttonData.extraKeyMode == 4)
				{
					addButton = true;
				}
				else if(buttonData.extraKeyMode == null)
					addButton = true;

				for (i in 1...9) {
					var buttonString = 'buttonExtra${i}';
					if (buttonData.button == buttonString && buttonReturn == null)
						buttonReturn = Reflect.getProperty(ClientPrefs.data, 'extraKeyReturn${i}');
				}
				if (addButton)
					addHint(buttonData.button, buttonData.buttonIDs, buttonX, buttonY, buttonWidth, buttonHeight, Util.colorFromString(buttonColor), buttonReturn);
			}
		}

		scrollFactor.set();
		updateTrackedButtons();

		instance = this;
	}

	override function createHintGraphic(Width:Int, Height:Int, Color:Int = 0xFFFFFF, ?isLane:Bool = false):BitmapData
	{
		var guh:Float = globalAlpha;
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

	override public function createHint(Name:Array<String>, X:Float, Y:Float, Width:Int, Height:Int, Color:Int = 0xFFFFFF, ?Return:String):MobileButton
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