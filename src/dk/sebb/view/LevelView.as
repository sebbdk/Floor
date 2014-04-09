package dk.sebb.view
{
	import dk.sebb.model.LevelModel;
	
	import starling.display.Sprite;
	
	public class LevelView extends Sprite
	{
		private var model:LevelModel; 
		
		public function LevelView(model:LevelModel) {
			this.model = model;
		}
	}
}