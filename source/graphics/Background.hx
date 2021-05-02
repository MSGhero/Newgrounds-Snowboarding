package graphics;

import openfl.display.Sprite;
import openfl.Vector;
import openfl.utils.Assets;
import openfl.display.BitmapData;

class SnowBackground implements IBackground {
	
	public var display(default, null):Sprite;
	
	var bg:BitmapData;
	var backTrees:BitmapData;
	var foreSnow:BitmapData;
	var foreTrees:BitmapData;
	
	var bgVerts = new Vector<Float>(8, true, [0,0, 0,Global.HEIGHT, Global.WIDTH,Global.HEIGHT, Global.WIDTH,0]);
	var backTreeVerts = new Vector<Float>(8, true, [0,0, 0,Global.HEIGHT, Global.WIDTH,Global.HEIGHT, Global.WIDTH,0]);
	var foreTreeVerts = new Vector<Float>(8, true, [0,570, 0,Global.HEIGHT, Global.WIDTH,Global.HEIGHT, Global.WIDTH,570]);
	var foreSnowVerts = new Vector<Float>(8, true, [0,350, 0,Global.HEIGHT, Global.WIDTH,Global.HEIGHT, Global.WIDTH,350]);
	var rectIndices = new Vector<Int>(6, true, [0,1,2, 0,2,3]);
	var bgUVs = new Vector<Float>(8, true, [0,0, 0,1, 1,1, 1,0]);
	
	public function new() {
		
		display = new Sprite();
		display.graphics.beginFill(0x0);
		display.graphics.drawRect(0, 0, Global.WIDTH, Global.HEIGHT);
		display.graphics.endFill();
		
		backTrees = Assets.getBitmapData("assets/images/snowbg/back_trees.png");
		foreSnow = Assets.getBitmapData("assets/images/snowbg/snow.png");
		foreTrees = Assets.getBitmapData("assets/images/snowbg/fore_trees.png");
		bg = Assets.getBitmapData("assets/images/snowbg/sun_mt.png");
	}
	
	public function scroll(rawOffsetX:Float, rawOffsetY:Float):Void {
		
		display.graphics.clear();
		
		var tlx = rawOffsetX / 2 / foreTrees.width;
		var trx = (rawOffsetX / 2 + Global.WIDTH) / foreTrees.width;
		var tly = 0;
		var bly = 150 / foreTrees.height;
		
		var slx = rawOffsetX / 6 / foreSnow.width;
		var srx = (rawOffsetX / 6 + Global.WIDTH) / foreSnow.width;
		
		var btlx = rawOffsetX / 16 / backTrees.width;
		var btrx = (rawOffsetX / 16 + Global.WIDTH) / backTrees.width;
		
		var foreTreeUVs = new Vector<Float>(8, true, [tlx,tly, tlx,bly, trx,bly, trx,tly]);
		var foreSnowUVs = new Vector<Float>(8, true, [slx,0, slx,1, srx,1, srx,0]);
		var backTreeUVs = new Vector<Float>(8, true, [btlx,0, btlx,1, btrx,1, btrx,0]);
		
		display.graphics.beginBitmapFill(bg);
		display.graphics.drawTriangles(bgVerts, rectIndices, bgUVs);
		display.graphics.beginBitmapFill(backTrees);
		display.graphics.drawTriangles(backTreeVerts, rectIndices, backTreeUVs);
		display.graphics.beginBitmapFill(foreSnow);
		display.graphics.drawTriangles(foreSnowVerts, rectIndices, foreSnowUVs);
		display.graphics.beginBitmapFill(foreTrees);
		display.graphics.drawTriangles(foreTreeVerts, rectIndices, foreTreeUVs);
		display.graphics.endFill();
	}
}

class TankBackground implements IBackground {
	
	public var display(default, null):Sprite;
	
	var bg:BitmapData;
	var backTrees:BitmapData;
	var foreSnow:BitmapData;
	var foreTrees:BitmapData;
	
	var bgVerts = new Vector<Float>(8, true, [0,0, 0,Global.HEIGHT, Global.WIDTH,Global.HEIGHT, Global.WIDTH,0]);
	var backTreeVerts = new Vector<Float>(8, true, [0,281, 0,Global.HEIGHT, Global.WIDTH,Global.HEIGHT, Global.WIDTH,281]);
	var foreTreeVerts = new Vector<Float>(8, true, [0,507, 0,711, Global.WIDTH,711, Global.WIDTH,507]);
	var foreSnowVerts = new Vector<Float>(8, true, [0,365, 0,774, Global.WIDTH,774, Global.WIDTH,365]);
	var rectIndices = new Vector<Int>(6, true, [0,1,2, 0,2,3]);
	var bgUVs = new Vector<Float>(8, true, [0,0, 0,1, 1,1, 1,0]);
	
	public function new() {
		
		display = new Sprite();
		display.graphics.beginFill(0x0);
		display.graphics.drawRect(0, 0, Global.WIDTH, Global.HEIGHT);
		display.graphics.endFill();
		
		// lol
		backTrees = Assets.getBitmapData("assets/images/tankbg/mt.png");
		foreSnow = Assets.getBitmapData("assets/images/tankbg/ruin.png");
		foreTrees = Assets.getBitmapData("assets/images/tankbg/ground.png");
		bg = Assets.getBitmapData("assets/images/tankbg/bg.png");
	}
	
	public function scroll(rawOffsetX:Float, rawOffsetY:Float):Void {
		
		display.graphics.clear();
		
		var tlx = rawOffsetX / 2 / foreTrees.width;
		var trx = (rawOffsetX / 2 + Global.WIDTH) / foreTrees.width;
		
		var slx = rawOffsetX / 6 / foreSnow.width;
		var srx = (rawOffsetX / 6 + Global.WIDTH) / foreSnow.width;
		
		var btlx = rawOffsetX / 16 / backTrees.width;
		var btrx = (rawOffsetX / 16 + Global.WIDTH) / backTrees.width;
		
		var foreTreeUVs = new Vector<Float>(8, true, [tlx,0, tlx,1, trx,1, trx,0]);
		var foreSnowUVs = new Vector<Float>(8, true, [slx,0, slx,1, srx,1, srx,0]);
		var backTreeUVs = new Vector<Float>(8, true, [btlx,0, btlx,1, btrx,1, btrx,0]);
		
		display.graphics.beginBitmapFill(bg);
		display.graphics.drawTriangles(bgVerts, rectIndices, bgUVs);
		display.graphics.beginBitmapFill(backTrees);
		display.graphics.drawTriangles(backTreeVerts, rectIndices, backTreeUVs);
		display.graphics.beginBitmapFill(foreSnow);
		display.graphics.drawTriangles(foreSnowVerts, rectIndices, foreSnowUVs);
		display.graphics.beginBitmapFill(foreTrees);
		display.graphics.drawTriangles(foreTreeVerts, rectIndices, foreTreeUVs);
		display.graphics.endFill();
	}
}

interface IBackground {
	var display(default, null):Sprite;
	function scroll(x:Float, y:Float):Void;
}