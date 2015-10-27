package engine;

import openfl.display.Sprite;

class GameElement extends Sprite{
	
	var hijos:Array<GameElement>;
	
	public function new () {
		super();
		hijos=new Array<GameElement>();
	}
	
	public function update(time:Float){
		var hijo:GameElement;
		for(hijo in hijos){
			hijo.update(time);
		}
	}
	
}