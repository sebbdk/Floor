package dk.sebb
{	
	import dk.sebb.controller.LevelController;
	import dk.sebb.model.LevelModel;
	import dk.sebb.model.events.ModelEvent;
	import dk.sebb.view.LevelView;
	
	import starling.events.Event;
	
	public class Level
	{
		private var controller:LevelController
		private var model:LevelModel;
		
		public var view:LevelView;
		
		public function Level()
		{
			model = new LevelModel("../levels/test/");
			view = new LevelView(model);
			controller = new LevelController(model);
			
			model.load();
			
			model.addEventListener(ModelEvent.LOADED, onModelLoaded);
			view.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onModelLoaded(evt:ModelEvent):void {
			view.load();
		}
		
		private function onAddedToStage(evt:Event):void {
			view.addEventListener(Event.ENTER_FRAME, controller.run);
		}
	}
}