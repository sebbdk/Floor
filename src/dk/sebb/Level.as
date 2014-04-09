package dk.sebb
{
	import dk.sebb.controller.LevelController;
	import dk.sebb.model.LevelModel;
	import dk.sebb.view.LevelView;
	
	import starling.events.EventDispatcher;
	
	public class Level extends EventDispatcher
	{
		private var controller:LevelController
		private var model:LevelModel;
		
		public var view:LevelView;
		
		public function Level()
		{
			model = new LevelModel("../levels/test/");
			controller = new LevelController(model);
			view = new LevelView(model);
			
			model.load();
		}
	}
}