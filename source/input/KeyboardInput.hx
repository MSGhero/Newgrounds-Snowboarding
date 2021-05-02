package input;

import openfl.events.KeyboardEvent;
import haxe.ds.IntMap;
import openfl.ui.Keyboard;

class KeyboardInput extends InputDevice {
	
	var keyMap:IntMap<Bool>;
	
	var mappings:Array<Array<Int>>;
	
	public function new() {
		super("kb");
		
		keyMap = new IntMap();
		
		for (i in 0...256) {
			keyMap.set(i, false);
		}
		
		mappings = [];
		
		mappings[Actions.L] = [Keyboard.LEFT, Keyboard.J];
		mappings[Actions.R] = [Keyboard.RIGHT, Keyboard.L];
		mappings[Actions.U] = [Keyboard.UP, Keyboard.I, Keyboard.SPACE];
		mappings[Actions.D] = [Keyboard.DOWN, Keyboard.K];
		mappings[Actions.TAIL] = [Keyboard.A];
		mappings[Actions.TRICK] = [Keyboard.S];
		mappings[Actions.NOSE] = [Keyboard.D];
		
		
		mappings[Actions.SELECT] = [Keyboard.ENTER];
		mappings[Actions.BACK] = [Keyboard.BACKSPACE, Keyboard.ESCAPE];
		mappings[Actions.PAUSE] = [Keyboard.P, Keyboard.BACKQUOTE];
		mappings[Actions.FULLSCREEN] = [Keyboard.F];
		mappings[Actions.TAB_L] = [Keyboard.SHIFT];
		mappings[Actions.TAB_R] = [Keyboard.C];
		mappings[Actions.MUTE] = [Keyboard.M];
		mappings[Actions.DEBUG] = [Keyboard.BACKQUOTE];
		
		Global.STAGE.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		Global.STAGE.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}
	
	override function getStatus(action:Actions):Bool {
		return areAnyDown(mappings[action]);
	}
	
	function onKeyDown(e:KeyboardEvent):Void {
		
		if (e.keyCode == Keyboard.SPACE || e.keyCode == Keyboard.UP || e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.ENTER || e.keyCode == Keyboard.ESCAPE) {
			// ty flixel
			e.stopImmediatePropagation();
			e.stopPropagation();
			#if html5
			e.preventDefault();
			#end
		}
		
		keyMap.set(e.keyCode, true);
	}
	
	function onKeyUp(e:KeyboardEvent):Void {
		
		if (e.keyCode == Keyboard.SPACE || e.keyCode == Keyboard.UP || e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.ENTER || e.keyCode == Keyboard.ESCAPE) {
			// ty flixel
			e.stopImmediatePropagation();
			e.stopPropagation();
			#if html5
			e.preventDefault();
			#end
		}
		
		keyMap.set(e.keyCode, false);
	}
	
	public function isKeyDown(keyCode:Int):Bool {
		return keyMap.get(keyCode);
	}
	
	public function areAllDown(keyCodes:Array<Int>):Bool {
		
		if (keyCodes == null) return false;
		
		for (key in keyCodes) {
			if (!isKeyDown(key)) return false;
		}
		
		return true;
	}
	
	public function areAnyDown(keyCodes:Array<Int>):Bool {
		
		if (keyCodes == null) return false;
		
		for (key in keyCodes) {
			if (isKeyDown(key)) return true;
		}
		
		return false;
	}
}