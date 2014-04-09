package dk.sebb.controller
{
	import dk.sebb.model.LevelModel;
	
	import starling.events.EventDispatcher;
	
	public class LevelController extends EventDispatcher
	{
		private var model:LevelModel; 
		
		public function LevelController(model:LevelModel) {
			this.model = model;
		}
	}
}