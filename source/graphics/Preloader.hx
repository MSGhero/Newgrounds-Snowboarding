package graphics;

import openfl.text.TextFormat;
import openfl.text.TextField;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.ProgressEvent;
import openfl.display.Sprite;
import openfl.events.Event;

class Preloader extends DefaultPreloader {
	
	var _loaded:Bool = false;
	var _percent:Float = 0;
	var _destroyed:Bool = false;
	var _ready:Bool = false;
	
	var bm:Bitmap;
	var rotBM:Sprite;
	var tf:TextField;
	
	var timer:Float = 5000;
	var lastTime:Float;
	
	var snTimer:Float = 3000;
	var rotAngle:Float = 3;
	
	public function new() {
		super();
	}
	
	override function onInit() {
		super.onInit();
		
		rotBM = new Sprite();
		rotBM.x = 200; rotBM.y = 450;
		
		Assets.loadBitmapData("assets/images/preload.png").onComplete((bmd) -> {
			bm = new Bitmap(bmd);
			addChildAt(bm, 0);
		});
		
		Assets.loadBitmapData("assets/images/gf_tumble.png").onComplete((bmd) -> {
			var bm = new Bitmap(bmd, true);
			bm.x = -63; bm.y = -109;
			rotBM.addChild(bm);
		});
		
		tf = new TextField();
		tf.selectable = false;
		tf.wordWrap = false;
		tf.width = 200;
		tf.defaultTextFormat = new TextFormat("Arial", 48, 0xffffff);
		tf.x = 160; tf.y = 600;
		
		addChild(tf);
		addChild(rotBM);
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	override function onUpdate(bytesLoaded:Int, bytesTotal:Int):Void {
		#if web
		_percent = (bytesTotal != 0) ? bytesLoaded / bytesTotal : 0;
		#else
		super.onUpdate(bytesLoaded, bytesTotal);
		#end
	}
	
	override function onLoaded() {
		_percent = 1;
		_loaded = true;
		lastTime = Date.now().getTime();
	}
	
	function onEnterFrame(e:Event):Void {
		
		if (!_destroyed) {
			
			var perc = Std.int(_percent * 100);
			
			if (perc > 68 && snTimer > 0) {
				
				if (snTimer == 3000) {
					tf.text = '69%';
					snTimer--;
					lastTime = Date.now().getTime();
					rotAngle = 0; // lol
				}
				
				else {
					
					var now = Date.now().getTime();
					snTimer -= (now - lastTime);
					lastTime = now;
					
					if (snTimer <= 0) rotAngle = 3;
				}
			}
			
			else if (_loaded) {
				
				if (timer == 5000) {
					tf.text = '100%';
				}
				
				var now = Date.now().getTime();
				timer -= (now - lastTime);
				lastTime = now;
				
				if (timer <= 0) {
					_ready = true;
				}
			}
			
			else {
				tf.text = '${perc}%';
			}
			
			if (rotBM != null) {
				rotBM.rotation += rotAngle;
			}
		}
		
		if (_ready) {
			
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			super.onLoaded();
			_destroyed = true;
			
			if (bm != null) removeChild(bm);
			if (rotBM != null) removeChild(rotBM);
			removeChild(tf);
			bm = null;
			tf = null;
		}
	}
}

// stolen from flixel
private class DefaultPreloader extends Sprite
{
	public function new()
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	public function onAddedToStage(_)
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		onInit();
		onUpdate(loaderInfo.bytesLoaded, loaderInfo.bytesTotal);

		addEventListener(ProgressEvent.PROGRESS, onProgress);
		addEventListener(Event.COMPLETE, onComplete);
	}

	function onComplete(event:Event):Void
	{
		event.preventDefault();

		removeEventListener(ProgressEvent.PROGRESS, onProgress);
		removeEventListener(Event.COMPLETE, onComplete);

		onLoaded();
	}

	public function onProgress(event:ProgressEvent):Void
	{
		onUpdate(Std.int(event.bytesLoaded), Std.int(event.bytesTotal));
	}

	public function onInit() {}

	public function onLoaded()
	{
		dispatchEvent(new Event(Event.UNLOAD));
	}

	public function onUpdate(bytesLoaded:Int, bytesTotal:Int):Void
	{
		var percentLoaded = 0.0;
		if (bytesTotal > 0)
		{
			percentLoaded = bytesLoaded / bytesTotal;
			if (percentLoaded > 1)
				percentLoaded = 1;
		}
	}
}