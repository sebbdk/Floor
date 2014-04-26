package
{
	import flash.ui.Keyboard;
	
	import dk.sebb.Level;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	
	public class StarlingMain extends Sprite
	{
		public var levelindex:int = -1;
		public var level:Level;
		public var levels:Array = [
			"../levels/test/",
			"../levels/test_2/"
		];		
		
		public function StarlingMain() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage( e:Event ):void {
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			level = new Level();
			loadNextLevel();
		}
		
		public function loadNextLevel():void {
			trace('load next!');
			if(levels[levelindex+1]) {
				levelindex++;
				level.unload();
				level.load(levels[levelindex], this);
			}
		}
		
		public function loadPrevLevel():void {
			if(levels[levelindex-1]) {
				levelindex--;
				level.unload();
				level.load(levels[levelindex], this);
			}
		}
		
		public function onKeyUp(evt:KeyboardEvent):void {
			if(evt.keyCode === Keyboard.RIGHT && evt.shiftKey) {
				loadNextLevel();
			}
			
			if(evt.keyCode === Keyboard.LEFT && evt.shiftKey) {
				loadPrevLevel();
			}		
		}
	}
}