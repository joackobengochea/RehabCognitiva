package states;

import engine.TextButton;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.events.MouseEvent;
import engine.State;
import engine.StateManager;

class MenuState extends State{
	
	var background:Sprite;
	var title:TextField;
	var comenzar:TextButton;
	var escudos:Sprite;

	public function new(sm:StateManager){
		super(sm);

		trace("menu");

		background = new Sprite();
		background.graphics.beginFill(0x16a085);
		background.graphics.drawRect(0, 0, sm.mainStage.stageWidth, sm.mainStage.stageHeight);
		background.graphics.endFill();
		addChild(background);

		title = new TextField();
		var titleFormat = new TextFormat(); titleFormat.size = 60; titleFormat.color = 0xffffff; titleFormat.align = TextFormatAlign.CENTER;
		title.width = sm.mainStage.stageWidth;
		title.text = "Rehabilitación Cognitiva";
		title.setTextFormat(titleFormat);
		title.defaultTextFormat = titleFormat;
		title.x = (sm.mainStage.stageWidth-title.width)/2;
		title.y = 50;
		addChild(title);

		comenzar = new TextButton("Comenzar", 0xaa66aa, onComenzar);
		comenzar.x = (sm.mainStage.stageWidth-comenzar.width)/2;
		comenzar.y = 240;
		addChild(comenzar);

		escudos  = new Sprite();
		escudos.graphics.beginFill(0xfedbca); escudos.graphics.drawRect(0, 0, 400, 300); escudos.graphics.endFill();
		//var b = new Bitmap(Assets.getBitmapData("images/escudos.png"));
		//escudos.addChild(b);
		escudos.x = (sm.mainStage.stageWidth-escudos.width)/2;
		escudos.y = sm.mainStage.stageHeight-escudos.height-10;
		addChild(escudos);
		redraw();

	}

	function onComenzar(e:MouseEvent){
		sm.switchState(new Explicacion1(sm));
	}

	override function redraw(){
		super.redraw();
		//dibujar de nuevo el background, no escalarlo
	}
}