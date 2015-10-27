package states;

import engine.State;
import engine.StateManager;
import openfl.display.Sprite;

class Game1 extends State{

	var verticalLine:Sprite;
	var horizontalLine:Sprite;

	public function new(sm:StateManager){
		super(sm);

		verticalLine = new Sprite();
		verticalLine.graphics.lineStyle(10, 0xffff00);
		verticalLine.graphics.lineTo(0, sm.mainStage.stageHeight);
		verticalLine.graphics.endFill();
		verticalLine.x = (sm.mainStage.stageWidth - verticalLine.width)/2;
		addChild(verticalLine);	

		horizontalLine = new Sprite();
		horizontalLine.graphics.lineStyle(10, 0x00ffff);
		horizontalLine.graphics.lineTo(sm.mainStage.stageWidth, 0);
		horizontalLine.graphics.endFill();
		horizontalLine.y = (sm.mainStage.stageHeight - horizontalLine.height)/2;
		addChild(horizontalLine);
	}
	
}