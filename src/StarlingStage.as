package
{
	import dk.sebb.Level;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class StarlingStage extends Sprite
	{
		public function StarlingStage()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage( e:Event ):void {
			var level:Level = new Level();
			addChild(level.view);
		}
	}
}