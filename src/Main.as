package
{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	
	import dk.sebb.util.Key;
	
	import nape.util.ShapeDebug;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;
	
	[SWF(backgroundColor="#333333", frameRate="60", quality="HIGH")]
	public class Main extends Sprite
	{
		private var starlingStage:Starling;

		public static var shapeDebug:ShapeDebug = new ShapeDebug(512, 512);
		public static var debug:Boolean = true; 
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//init key class
			Key.init(stage);
			
			// create our Starling instance
			starlingStage = new Starling(StarlingMain, stage, new Rectangle(0,0, 512, 512));
			
			// set anti-aliasing (higher the better quality but slower performance)
			starlingStage.antiAliasing = 0;
			
			// start it!
			starlingStage.start();
			
			if(debug) {
				addChild(shapeDebug.display);

				var stats:Stats = new Stats()
				stats.x = 512;
				addChild(stats);
			}
		}
	}
}