package path;

import msg.utils.LinkedList;

@:forward(length, isEmpty, iterator, shift)
abstract Path(LinkedList<Segment>) {
	
	public function new() {
		this = new LinkedList();
	}
	
	public function append(s:Segment):Segment {
		
		if (!this.isEmpty) {
			s.resetInit(this.last.yf(), this.last.xf());
		}
		
		this.push(s);
		
		return s;
	}
	
	public function y(x:Float):Float {
		if (this.isEmpty) return 0;
		
		for (node in this) {
			if (node.xf() >= x) return node.y(x);
		}
		
		return 0;
	}
	
	public function dy(x:Float):Float {
		if (this.isEmpty) return 0;
		
		for (node in this) {
			if (node.xf() >= x) return node.dy(x);
		}
		
		return 0;
	}
	
	public function x0():Float {
		if (this.isEmpty) return 0;
		
		return this.first.x0;
	}
	
	public function segment(x:Float):Segment {
		if (this.isEmpty) return null;
		
		for (node in this) {
			if (node.xf() >= x) return node;
		}
		
		return null;
	}
	
	public function pastFirstSeg(x:Float):Bool {
		return !this.isEmpty && x >= this.first.xf();
	}
	
	public function toString():String {
		
		var s = "Path{";
		
		for (seg in this) {
			s += seg + ",";
		}
		
		s += "}";
		
		return s;
	}
}