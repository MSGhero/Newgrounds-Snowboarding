package;

import openfl.net.SharedObject;
import openfl.events.Event;
import openfl.media.Sound;
import openfl.Assets;
import openfl.media.SoundChannel;
import tink.core.Pair;
import tink.core.Signal;
import msg.utils.states.StackFSM;
import openfl.display.Stage;
import input.InputManager;

class Global {
	
	public static inline var FPS:Int = 60;
	public static var DT:Float = 0;
	
	public static var SHARED_OBJ:SharedObject;
	
	public static inline var WIDTH:Int = 1280;
	public static inline var HEIGHT:Int = 720;
	public static var STAGE:Stage;
	
	public static inline var TILE_WIDTH:Float = 80;
	
	public static var MEDALS_READY:Bool = false;
	
	public static var POINTS:Int = 0;
	public static var POINT_SIGNAL:Signal<Pair<String, Int>>;
	
	public static var GAME_FSM:StackFSM = new StackFSM();
	public static var INPUT:InputManager = new InputManager();
	public static var DEBUG:Debug = new Debug();
	public static var MUSIC:Music;
}

private class Debug {
	// this was just for debug stuff, but then I ended up putting everything here
	
	public var SELECTED_CHAR:Chars = NONE;
	public var SELECTED_BOARD:Int = 0;
	
	public var JUMP_BOOST:Float = 1.1;
	public var HOP_VEL:Float = -.3;
	public var STICKY:Bool = false;
	
	public var DEBUG_DRAW:Bool = false;
	public var PLAYER_X:Float = 320;
	public var CAMERA_Y:Float = 160;
	public var CAMERA_ANGLE:Int = 0;
	
	public var GRIND_HEIGHT:Float = -80;
	
	public var PROJ_ANGLE_EPS:Float = 12.1 / 180 * Math.PI;
	
	public var VECTOR_VEL:Bool = false;
	public var MIN_VELX:Float = 100;
	public var MAX_VELX:Float = 600;
	public var GRAV_SLOPE:Float = 70;
	public var GRAV_Y:Float = 480;
	public var ROT_VEL:Float = 270;
	public var ROT_ACC:Float = 360;
	public var ROT_MULT:Float = .5;
	public var ROT_MULT_DIR:Int = 0;
	public var ROT_DELTA_CRASH:Float = 45;
	public var NUM_TUMBLES:Int = 4;
	public var SNOW_HEIGHT:Float = 40;
	
	public function new() { }
}

class Music {
	
	var menu:Array<Sound>;
	var menuIndex:Int;
	
	var game:Array<Sound>;
	var gameIndex:Int;
	
	var active:SoundChannel;
	
	var isMenu:Bool;
	var isMuted:Bool;
	
	public function new() {
		
		active = null;
		
		menu = [];
		
		menu.push(Assets.getSound("assets/sounds/Endless_Handbag_Loop.mp3"));
		
		game = [];
		
		game.push(Assets.getSound("assets/sounds/740627_Miston-Music---Snowy-Lands.mp3"));
		game.push(Assets.getSound("assets/sounds/17131_newgrounds_snow.mp3"));
		game.push(Assets.getSound("assets/sounds/1000851_taiga.mp3"));
		
		isMenu = false;
		isMuted = false;
	}
	
	public function stopActiveTrack():Void {
		
		if (active != null) {
			active.removeEventListener(Event.SOUND_COMPLETE, isMenu ? onMenuComplete : onGameComplete);
			active.stop();
		}
	}
	
	public function loopMenuTracks():Void {
		
		if (!isMenu || active == null) {
			
			stopActiveTrack();
			
			isMenu = true;
			
			menuIndex = Std.random(menu.length);
			
			active = menu[menuIndex].play();
			active.addEventListener(Event.SOUND_COMPLETE, onMenuComplete);
			
			if (isMuted) {
				var xform = active.soundTransform;
				xform.volume = 0;
				active.soundTransform = xform;
			}
		}
	}
	
	function onMenuComplete(e:Event):Void {
		// play next
		
		active.removeEventListener(Event.SOUND_COMPLETE, onMenuComplete);
		
		menuIndex = ++menuIndex % menu.length;
		active = menu[menuIndex].play();
		active.addEventListener(Event.SOUND_COMPLETE, onMenuComplete);
		
		if (isMuted) {
			var xform = active.soundTransform;
			xform.volume = 0;
			active.soundTransform = xform;
		}
	}
	
	public function loopGameTracks():Void {
		
		if (isMenu || active == null) {
			
			stopActiveTrack();
			
			isMenu = false;
			
			gameIndex = Std.random(game.length);
			
			active = game[gameIndex].play();
			active.addEventListener(Event.SOUND_COMPLETE, onGameComplete);
			
			if (isMuted) {
				var xform = active.soundTransform;
				xform.volume = 0;
				active.soundTransform = xform;
			}
		}
	}
	
	function onGameComplete(e:Event):Void {
		// play next
		
		active.removeEventListener(Event.SOUND_COMPLETE, onGameComplete);
		
		menuIndex = ++menuIndex % menu.length;
		active = menu[menuIndex].play();
		active.addEventListener(Event.SOUND_COMPLETE, onGameComplete);
		
		if (isMuted) {
			var xform = active.soundTransform;
			xform.volume = 0;
			active.soundTransform = xform;
		}
	}
	
	public function toggleMute():Void {
		
		isMuted = !isMuted;
		
		var xform = active.soundTransform;
		xform.volume = isMuted ? 0 : 1;
		active.soundTransform = xform;
	}
}