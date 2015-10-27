package states;

import engine.State;
import engine.StateManager;
import engine.TextButton;
import openfl.text.TextField;
import openfl.events.MouseEvent;


class Explicacion1 extends State{

	var title:TextField;
	var explicacion:TextField;
	var comenzar:TextButton;

	public function new (sm:StateManager){
		super(sm);

		comenzar = new TextButton("Comenzar", 0xaa66aa, onComenzar);
		comenzar.x = (sm.mainStage.stageWidth-comenzar.width)/2;
		comenzar.y = 240;
		addChild(comenzar);
	}

	function onComenzar(e:MouseEvent){
		sm.switchState(new Game1(sm));
	}
	
}