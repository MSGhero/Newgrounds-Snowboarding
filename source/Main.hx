package;

import haxe.DynamicAccess;
import openfl.net.SharedObject;
import openfl.Assets;
import io.newgrounds.NG;
import states.CharSelectState;
import input.KeyboardInput;
import haxe.Timer;
import openfl.events.Event;
import openfl.display.Sprite;
import states.DebugState;
import states.GameState;

class Main extends Sprite {
	
	var lastTime:Float;
	
	public function new() {
		super();
		
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	function onAddedToStage(_):Void {
		
		Global.SHARED_OBJ = SharedObject.getLocal("msg_ngsnowboard121");
		
		if (!(Global.SHARED_OBJ.data:DynamicAccess<Dynamic>).exists("version")) {
			var data:DynamicAccess<Dynamic> = Global.SHARED_OBJ.data;
			
			data.set("version", "1.0 i guess");
			data.set("points", 0);
			data.set("boards", [for (i in 0...15) true]);
			data.set("chars", [for (i in 0...20) true]);
			data.set("nextCost", 0);
			
			Global.SHARED_OBJ.flush();
		}
		
		Global.POINTS = Global.SHARED_OBJ.data.points;
		
		Global.STAGE = stage;
		Global.INPUT.addDevice(new KeyboardInput());
		
		Global.MUSIC = new Global.Music();
		Global.MUSIC.loopMenuTracks();
		
		var ngapi = Assets.getText("assets/ngapi.txt");
		var lines = ngapi.split("\r\n");
		
		NG.createAndCheckSession(StringTools.trim(lines[0]));
		NG.core.initEncryption(StringTools.trim(lines[1]));
		
		if (!NG.core.attemptingLogin) NG.core.requestLogin(onNGLogin);
		else NG.core.onLogin.add(onNGLogin);
		
		Global.GAME_FSM.addState(new CharSelectState(this));
		Global.GAME_FSM.addState(new GameState(this));
		#if debug
		Global.GAME_FSM.addState(new DebugState(this));
		#end
		Global.GAME_FSM.initAll();
		Global.GAME_FSM.swapStates("charsel");
		#if debug
		Global.GAME_FSM.push("debug");
		#end
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		
		lastTime = Timer.stamp();
	}
	
	function onNGLogin():Void {
		
		trace('hi ${NG.core.user.name}');
		
		NG.core.requestMedals(() -> {
			trace('got medals');
			Global.MEDALS_READY = true;
		});
	}
	
	function onEnterFrame(_):Void {
		
		Global.INPUT.update();
		
		final newTime = Timer.stamp();
		Global.GAME_FSM.update(newTime - lastTime);
		lastTime = newTime;
		
		if (Global.INPUT.justPressed.getAction(FULLSCREEN)) {
			stage.displayState = stage.displayState == FULL_SCREEN_INTERACTIVE ? NORMAL : FULL_SCREEN_INTERACTIVE;
		}
		
		if (Global.INPUT.justPressed.getAction(MUTE)) {
			Global.MUSIC.toggleMute();
		}
	}
}