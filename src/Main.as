package
{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	
	import starling.core.Starling;
	
	[SWF(backgroundColor="#999999", frameRate="60", height="600", width="800", quality="HIGH")]
	public class Main extends Sprite
	{
		private var starlingStage:Starling;
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			
			// create our Starling instance
			starlingStage = new Starling(StarlingStage, stage);
			
			// set anti-aliasing (higher the better quality but slower performance)
			starlingStage.antiAliasing = 1;
			
			// start it!
			starlingStage.start();
		}
	}
}