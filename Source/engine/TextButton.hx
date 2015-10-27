package engine;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.events.MouseEvent;

class TextButton extends GameElement{

	var sprite:Sprite;
	var tf:TextField;
	
	public function new(text:String, color:Int, onClick:Dynamic->Void){
		super();

		sprite = new Sprite();
		sprite.graphics.beginFill(color);
		sprite.graphics.drawRoundRect(0, 0, 300, 100, 20);
		sprite.graphics.endFill();
		tf = new TextField(); tf.width = 300; tf.text = text;
		var tfFormat = new TextFormat(); tfFormat.size = 35; tfFormat.color = 0xffffff; tfFormat.align = TextFormatAlign.CENTER;
		tf.defaultTextFormat = tfFormat; tf.setTextFormat(tfFormat);
		tf.x = (sprite.width-tf.width)/2;
		tf.y = (sprite.height - tf.textHeight)/2;
		tf.height = tf.textHeight+5;
		sprite.addChild(tf);
		addChild(sprite);
		addEventListener(MouseEvent.CLICK, onClick);
	}

		
}