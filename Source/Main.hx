package;


import openfl.display.Sprite;
import openfl.Lib;
import engine.StateManager;
import states.MenuState;
import openfl.events.Event;
import openfl.events.KeyboardEvent;


class Main extends Sprite {
	
	public var stateManager:StateManager;
	var lastStageWidth:Float=0;
	var lastStageHeight:Float=0; 

	public function new () {
		
		super ();
		stateManager = new StateManager(Lib.current.stage);
		this.addChild(stateManager);
		stage.addEventListener(Event.ENTER_FRAME,gameLoop);
		stage.addEventListener(Event.RESIZE, onResize);
		stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		stateManager.switchState(new MenuState(stateManager));		
	}
	
	function gameLoop(e) {
        var time=1/60;
        stateManager.update(time);
    }

    private function onResize(e){
		//if(stateManager.currentState!=null) stateManager.currentState.redraw();
		this.lastStageWidth=stage.stageWidth;
		this.lastStageHeight=stage.stageHeight;
	}

	function onKeyUp(e:KeyboardEvent){
		if(e.keyCode==27){
			e.stopImmediatePropagation();
			stateManager.currentState.onBack(0);
		}
	}
	
}