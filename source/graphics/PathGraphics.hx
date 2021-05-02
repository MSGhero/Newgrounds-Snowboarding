package graphics;

import openfl.display.Sprite;
import path.Path;
import openfl.Vector;

class PathGraphics extends Sprite {
	
	var slope:SlopeGraphics;
	var snow:SnowGraphics;
	var grind:GrindGraphics;
	
	var shadowOffset:Float = 190;
	var shadowAmp:Float = 16;
	
	var snowOffset:Float = 90;
	var snowAmp:Float = 20;
	
	public function new() {
		super();
		
		slope = new SlopeGraphics();
		slope.x = -6; slope.y = 6;
		addChild(slope);
		
		snow = new SnowGraphics();
		addChild(snow);
		
		grind = new GrindGraphics();
		addChild(grind);
	}
	
	public function drawPathTris(path:Path, offsetX:Float, offsetY:Float):Void {
		
		var verts = new Vector<Float>();
		var indices = new Vector<Int>();
		var uvs = new Vector<Float>();
		
		var snowVerts = new Vector<Float>();
		var snowIndices = new Vector<Int>();
		
		var shadowVerts = new Vector<Float>();
		var shadowIndices = new Vector<Int>();
		
		var grindVerts = new Vector<Float>();
		// var grindIndices = new Vector<Float>();
		var grindUVs = new Vector<Float>();
		
		var vertI = 0, indI = 0;
		var svertI = 0, snowIndI = 0;
		var shvertI = 0, shadowIndI = 0;
		var grvertI = 0;
		var noQuad = false;
		var x0:Float, y0:Float, xf:Float, yf:Float, rawxf:Float;
		for (segment in path) {
			
			x0 = segment.x0 - offsetX;
			y0 = path.y(segment.x0) + offsetY;
			
			if (y0 >= Global.HEIGHT) break; // if the first segment is already below the screen
			
			rawxf = xf = segment.xf() - offsetX;
			yf = path.y(segment.xf()) + offsetY;
			
			if (yf >= Global.HEIGHT) {
				xf = segment.x(Global.HEIGHT - offsetY) - offsetX;
				noQuad = true;
			}
			
			if (vertI == 0) {
				// first verts are not already in verts (for indices)
				uvs[vertI] = (x0 + offsetX) / slope.tileWidth;
				verts[vertI++] = x0;
				uvs[vertI] = (y0 - offsetY) / slope.tileHeight;
				verts[vertI++] = y0;
				
				uvs[vertI] = (x0 + offsetX) / slope.tileWidth;
				verts[vertI++] = x0;
				uvs[vertI] = (Global.HEIGHT - offsetY) / slope.tileHeight;
				verts[vertI++] = Global.HEIGHT;
			
				uvs[vertI] = (xf + offsetX) / slope.tileWidth;
				verts[vertI++] = xf;
				uvs[vertI] = (Global.HEIGHT - offsetY) / slope.tileHeight;
				verts[vertI++] = Global.HEIGHT;
				
				indices[indI++] = 0;
				indices[indI++] = 1;
				indices[indI++] = 2;
			}
			
			else {
				
				uvs[vertI] = (xf + offsetX) / slope.tileWidth;
				verts[vertI++] = xf;
				uvs[vertI] = (Global.HEIGHT - offsetY) / slope.tileHeight;
				verts[vertI++] = Global.HEIGHT;
				
				indices[indI] = indices[indI++ - 1];
				indices[indI] = indices[indI++ - 3];
				indices[indI] = indices[indI++ - 3] + 1;
			}
			
			// add grind indices later
			if (segment.hasGrind) {
				
				grindUVs[grvertI] = (x0 + offsetX) / grind.tileWidth;
				grindVerts[grvertI++] = x0;
				grindUVs[grvertI] = (y0 + Global.DEBUG.GRIND_HEIGHT - offsetY) / grind.tileHeight;
				grindVerts[grvertI++] = y0 + Global.DEBUG.GRIND_HEIGHT;
				
				grindUVs[grvertI] = (x0 + offsetX) / grind.tileWidth;
				grindVerts[grvertI++] = x0;
				grindUVs[grvertI] = (y0 - offsetY) / grind.tileHeight;
				grindVerts[grvertI++] = y0;
				
				grindUVs[grvertI] = (rawxf + offsetX) / grind.tileWidth;
				grindVerts[grvertI++] = rawxf;
				grindUVs[grvertI] = (yf - offsetY) / grind.tileHeight;
				grindVerts[grvertI++] = yf;
				
				grindUVs[grvertI] = (x0 + offsetX) / grind.tileWidth;
				grindVerts[grvertI++] = x0;
				grindUVs[grvertI] = (y0 + Global.DEBUG.GRIND_HEIGHT - offsetY) / grind.tileHeight;
				grindVerts[grvertI++] = y0 + Global.DEBUG.GRIND_HEIGHT;
				
				grindUVs[grvertI] = (rawxf + offsetX) / grind.tileWidth;
				grindVerts[grvertI++] = rawxf;
				grindUVs[grvertI] = (yf - offsetY) / grind.tileHeight;
				grindVerts[grvertI++] = yf;
				
				// incorrect if going past the bottom?
				grindUVs[grvertI] = (rawxf + offsetX) / grind.tileWidth;
				grindVerts[grvertI++] = rawxf;
				grindUVs[grvertI] = (yf + Global.DEBUG.GRIND_HEIGHT - offsetY) / grind.tileHeight;
				grindVerts[grvertI++] = yf + Global.DEBUG.GRIND_HEIGHT;
			}
			
			var span = 5;
			var numTris = Math.ceil((xf - x0) / span);
			var scale = 1 / 5 / 3.14;
			
			for (i in 0...numTris) {
				
				if (svertI == 0) {
					
					var xx = x0 + i * span;
					
					snowVerts[svertI++] = xx;
					snowVerts[svertI++] = path.y(xx + offsetX) + offsetY;
					
					snowVerts[svertI++] = xx;
					snowVerts[svertI++] = path.y(xx + offsetX) + offsetY + snowOffset + snowAmp * snowFunc((xx + offsetX) * scale);
					
					shadowVerts[shvertI++] = xx;
					shadowVerts[shvertI++] = path.y(xx + offsetX) + offsetY;
					
					shadowVerts[shvertI++] = xx;
					shadowVerts[shvertI++] = path.y(xx + offsetX) + offsetY + shadowOffset + shadowAmp * shadowFunc((xx + offsetX) * scale);
					
					xx += span;
					
					snowVerts[svertI++] = xx;
					snowVerts[svertI++] = path.y(xx + offsetX) + offsetY + snowOffset + snowAmp * snowFunc((xx + offsetX) * scale);
					
					shadowVerts[shvertI++] = xx;
					shadowVerts[shvertI++] = path.y(xx + offsetX) + offsetY + shadowOffset + shadowAmp * shadowFunc((xx + offsetX) * scale);
					
					snowIndices[snowIndI++] = 0;
					snowIndices[snowIndI++] = 1;
					snowIndices[snowIndI++] = 2;
					
					shadowIndices[shadowIndI++] = 0;
					shadowIndices[shadowIndI++] = 1;
					shadowIndices[shadowIndI++] = 2;
				}
				
				else {
					
					snowVerts[svertI++] = x0 + (i + 1) * span;
					snowVerts[svertI++] = path.y(x0 + (i + 1) * span + offsetX) + offsetY + snowOffset + snowAmp * snowFunc((x0 + (i + 1) * span + offsetX) * scale);
					
					shadowVerts[shvertI++] = x0 + (i + 1) * span;
					shadowVerts[shvertI++] = path.y(x0 + (i + 1) * span + offsetX) + offsetY + shadowOffset + shadowAmp * shadowFunc((x0 + (i + 1) * span + offsetX) * scale);
					
					snowIndices[snowIndI] = snowIndices[snowIndI++ - 1];
					snowIndices[snowIndI] = snowIndices[snowIndI++ - 3];
					snowIndices[snowIndI] = snowIndices[snowIndI++ - 3] + 1;
					
					shadowIndices[shadowIndI] = shadowIndices[shadowIndI++ - 1];
					shadowIndices[shadowIndI] = shadowIndices[shadowIndI++ - 3];
					shadowIndices[shadowIndI] = shadowIndices[shadowIndI++ - 3] + 1;
				}
				
				snowVerts[svertI++] = x0 + (i + 1) * span;
				snowVerts[svertI++] = path.y(x0 + (i + 1) * span + offsetX) + offsetY;
				
				shadowVerts[shvertI++] = x0 + (i + 1) * span;
				shadowVerts[shvertI++] = path.y(x0 + (i + 1) * span + offsetX) + offsetY;
				
				snowIndices[snowIndI] = snowIndices[snowIndI++ - 3];
				snowIndices[snowIndI] = snowIndices[snowIndI++ - 2];
				snowIndices[snowIndI] = snowIndices[snowIndI++ - 3] + 1;
				
				shadowIndices[shadowIndI] = shadowIndices[shadowIndI++ - 3];
				shadowIndices[shadowIndI] = shadowIndices[shadowIndI++ - 2];
				shadowIndices[shadowIndI] = shadowIndices[shadowIndI++ - 3] + 1;
			}
			
			if (noQuad) break;
			
			uvs[vertI] = (xf + offsetX) / slope.tileWidth;
			verts[vertI++] = xf;
			uvs[vertI] = (yf - offsetY) / slope.tileHeight;
			verts[vertI++] = yf;
			
			indices[indI] = indices[indI++ - 3];
			indices[indI] = indices[indI++ - 2];
			indices[indI] = indices[indI++ - 3] + 1;
			
			if (xf >= Global.WIDTH || yf >= Global.HEIGHT) break;
		}
		
		slope.clear();
		snow.clear();
		grind.clear();
		
		if (verts.length > 0) {
			slope.draw(verts, indices, uvs);
			snow.draw(shadowVerts, shadowIndices, snowVerts, snowIndices);
			grind.draw(grindVerts, grindUVs);
		}
	}
	
	function shadowFunc(x:Float):Float {
		return Math.cos(x / 4.7 - 2.2) / 1.1 + Math.cos(x / 3.2) + Math.sin(x * 1.1) * 0.9;
	}
	
	function snowFunc(x:Float):Float {
		return Math.cos(x / 4.7 - 2.2) / 1.1 + Math.cos(x / 3.2) + Math.sin(x * 1.1);
	}
}