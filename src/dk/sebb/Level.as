package dk.sebb
{	
	import dk.sebb.controller.LevelController;
	import dk.sebb.controller.LuaInterface;
	import dk.sebb.model.LevelModel;
	import dk.sebb.model.events.ModelEvent;
	import dk.sebb.view.LevelView;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Level
	{
		private var controller:LevelController
		private var model:LevelModel;
		private var lua:LuaInterface = new LuaInterface();
		
		public var view:LevelView;
		
		public static var instance:Level;
		
		public function Level() {}
		
		private function onModelLoaded(evt:ModelEvent):void {
			//load the view
			view.load();

			//start logic loop based on view framerate :P
			view.addEventListener(Event.ENTER_FRAME, controller.run);
		}
		
		public function load(levelPath:String, starlingMain:Sprite):void {
			model = new LevelModel(levelPath);
			view = new LevelView(model);
			controller = new LevelController(model);
			
			starlingMain.addChild(view);
			
			model.load();
			
			model.addEventListener(ModelEvent.LOADED, onModelLoaded);
		}
		
		public function unload():void {
			if(view && view.parent) {
				view.parent.removeChild(view);
				view.removeEventListener(Event.ENTER_FRAME, controller.run);
				view.unload();
			}
			
			if(controller) {
				controller.unload();
			}
		}
	}
}