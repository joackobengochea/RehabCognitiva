package engine;

import openfl.display.Sprite;
import openfl.display.Graphics;
import openfl.text.TextFormatAlign;
import openfl.text.TextFormat;
import openfl.text.TextField;
import openfl.events.MouseEvent;

class LanguageButton extends Sprite{

	var selectedSprite:Sprite;
	var tf:TextField;

	public function new(width:Int, height:Int, text:String, onClick:Dynamic, selected:Bool){
		super();
		var textFormat = new TextFormat();
		textFormat.size = 30;
		textFormat.bold=true;
		textFormat.color = 0xffffff;
		textFormat.font = Main.FONT_1;
		textFormat.align=openfl.text.TextFormatAlign.CENTER;
		selectedSprite = new Sprite();
		var g= selectedSprite.graphics;
		g.lineStyle(3, 0xffffff);
		g.drawRoundRect(0, 0, width, height, height, height);
		g.endFill();
		addChild(selectedSprite);
		selectedSprite.visible=selected;
		tf = new TextField();
		tf.text = text;
		tf.width=width;
		tf.selectable=false;
		tf.setTextFormat(textFormat);
		tf.defaultTextFormat=textFormat;
		tf.y = (height-tf.textHeight)*0.5;
		addChild(tf);
		addEventListener(MouseEvent.CLICK, onClick);
	}

	public function setButton(text:String, selected:Bool){
		selectedSprite.visible = selected;
		tf.text = text;
	}
	
}