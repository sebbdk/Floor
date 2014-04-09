package dk.sebb.model
{
	import flash.events.Event;
	
	import dk.sebb.tiled.TMXLoader;
	
	import starling.events.EventDispatcher;

	public class LevelModel extends EventDispatcher
	{
		public var tmxLoader:TMXLoader;
		public var path:String;
		
		public function LevelModel(path:String = null) {
			this.path = path;
		}
		
		public function load(path:String = null):void {
			this.path = path != null ? path:this.path;
			
			tmxLoader = new TMXLoader(this.path + "level.tmx");
			tmxLoader.addEventListener(Event.COMPLETE, onTMXLoaded);
			tmxLoader.load();
		}
		
		private function onTMXLoaded(evt:Event):void {
			tmxLoader.removeEventListener(Event.COMPLETE, onTMXLoaded);
		}
	}
}