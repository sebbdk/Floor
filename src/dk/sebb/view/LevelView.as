package dk.sebb.view
{
	import dk.sebb.model.LevelModel;
	import dk.sebb.model.events.ModelEvent;
	import dk.sebb.model.mobs.Mob;
	import dk.sebb.tiled.layers.ImageLayer;
	import dk.sebb.tiled.layers.Layer;
	import dk.sebb.tiled.layers.ObjectLayer;
	import dk.sebb.tiled.layers.TileLayer;
	import dk.sebb.view.mobs.PlayerView;
	import dk.sebb.view.mobs.ZombieView;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class LevelView extends Sprite
	{
		private var model:LevelModel; 
		public var assets:AssetManager; 
		
		public var mobViewMap:Object = {
			player:PlayerView,
			zombie01:ZombieView
		};
		
		public function LevelView(model:LevelModel) {
			this.model = model;
			model.addEventListener(ModelEvent.LOADED, onModelLoaded);
		}
		
		public function load():void {
			assets = new AssetManager();
			assets.verbose = true;
			assets.enqueue('../assets/mobs/atlas.xml');
			assets.enqueue('../assets/mobs/sprites.png');
			
			assets.loadQueue(function(ratio:Number):void
			{
			//	trace("Loading assets, progress:", ratio);
				
				if (ratio == 1.0) {
					//trace( assets.getTexture("fem01.png") );
					//trace( assets.getTexture("fem02.png") );
					
					setup();
				}
			});
		}
		
		private function setup():void {
			for each(var mob:Mob in model.mobs) {
				if(mob.info && mob.info.view && mobViewMap[mob.info.view]) {
					var view:Sprite = new mobViewMap[mob.info.view](mob, assets);
					addChild(view);
				}
			}
		}
		
		private function onModelLoaded(evt:ModelEvent):void {
			for each(var layer:Layer in model.layers) {
				if(layer.display === false) {
					continue;
				}
				
				if(layer is TileLayer) {
					setupTileLayer(layer as TileLayer);
				}
				
				if(layer is ImageLayer) {
					setupImageLayer(layer as ImageLayer);
				}
				
				if(layer is ObjectLayer) {
					setupObjectLayer(layer as ObjectLayer);
				}
			}
		}
		
		private function setupObjectLayer(layer:ObjectLayer):void {
			var texture:Texture = Texture.fromBitmapData(layer.bitmapData); 
			var img:Image = new Image(texture);
			addChild(img);
		}
		
		private function setupImageLayer(layer:ImageLayer):void {
			var texture:Texture = Texture.fromBitmapData(layer.bitmapData); 
			var img:Image = new Image(texture);
			addChild(img);
		}
		
		private function setupTileLayer(layer:TileLayer):void {
			var texture:Texture = Texture.fromBitmapData(layer.bitmapData); 
			var img:Image = new Image(texture);
			addChild(img);
		}
	}
}