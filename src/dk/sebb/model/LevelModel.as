package dk.sebb.model
{
	import flash.events.Event;
	
	import dk.sebb.model.events.ModelEvent;
	import dk.sebb.model.mobs.Mob;
	import dk.sebb.model.mobs.DetectorMob;
	import dk.sebb.tiled.TMXLoader;
	import dk.sebb.tiled.TileSet;
	import dk.sebb.tiled.layers.Layer;
	import dk.sebb.tiled.layers.ObjectLayer;
	import dk.sebb.tiled.layers.TMXObject;
	import dk.sebb.tiled.layers.TileLayer;
	import dk.sebb.util.AStar;
	import dk.sebb.util.Cell;
	
	import nape.geom.Vec2;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import starling.events.EventDispatcher;

	public class LevelModel extends EventDispatcher
	{
		//Level related variables
		public var tmxLoader:TMXLoader;
		public var path:String;
		public var layers:Array;
		
		//Physics related
		public var space:Space;
		
		//Level objects
		public var mobs:Array = [];
		public var spawns:Array = [];
		
		//Time related
		public var deltaTime:Number = 0;
		public var lastFrameTime:Number = 0;
		
		//map related
		public var pathfinder:AStar; 
		
		public function LevelModel(path:String = null) {
			this.path = path;
		}
		
		public function get tileHeight():int {
			return tmxLoader.tileHeight;
		}
		
		public function get tileWidth():int {
			return tmxLoader.tileWidth;
		}
		
		public function load(path:String = null):void {
			this.path = path != null ? path:this.path;
			
			tmxLoader = new TMXLoader(this.path + "level.tmx");
			tmxLoader.addEventListener(Event.COMPLETE, onTMXLoaded);
			tmxLoader.load();
		}
		
		private function onTMXLoaded(evt:Event):void {
			tmxLoader.removeEventListener(Event.COMPLETE, onTMXLoaded);
			layers = tmxLoader.layers;
			
			//prep data
			preparePathfinding();
			preparePhysics();
			
			dispatchEvent(new ModelEvent(ModelEvent.LOADED));
		}
		
		private function preparePathfinding():void {
			pathfinder = new AStar();
		}
		
		private function preparePhysics():void {
			space = new Space(new Vec2(0, 0));
			
			for each(var layer:Layer in layers) {
				if(layer is TileLayer && layer.functional) {
					prepareFunctionalLayer(layer as TileLayer);
				}
				
				if(layer is ObjectLayer) {
					prepareObjectLayer(layer as ObjectLayer);
				}
			}
		}
		
		private function addMob(mob:Mob):void {
			mob.body.space = space;
			mobs.push(mob);
			dispatchEvent(new ModelEvent(ModelEvent.ADDED_MOB, mob));
		}
		
		private function prepareObjectLayer(layer:ObjectLayer):void {
			for each(var object:TMXObject in layer.objects) {
				if(object.type) {
					var mob:Mob = null; 
					
					switch(object.type) {
						case 'spawn':
							spawns.push(new Vec2(object.x + (object.width/2), object.y + (object.height/2)));
							mob = new Mob(object);
							dispatchEvent(new ModelEvent(ModelEvent.ADDED_INT_MOB, mob));
							break;
						case 'detector':
							mob = new DetectorMob(object, space);
							break;
						case 'agent':
							mob = new Mob(object);
							dispatchEvent(new ModelEvent(ModelEvent.ADDED_INT_MOB, mob));
							break;
						default:
							trace("unknown object type (" + object.type + ") found in level!");
							break;
					}
					
					if(mob) {
						addMob(mob);
					}
					
				}
			}
		}

		private function prepareFunctionalLayer(layer:TileLayer):void {
			for (var spriteForX:int = 0; spriteForX < tmxLoader.mapWidth; spriteForX++) {
				for (var spriteForY:int = 0; spriteForY < tmxLoader.mapHeight; spriteForY++) {
					var tileGid:int = int(layer.map[spriteForX][spriteForY]);
					
					if(TileSet.tiles[tileGid] && TileSet.tiles[tileGid].type && TileSet.tiles[tileGid].type === 'physic') {
						//add filled cell to oure pathfinding map
						pathfinder.setCell(new Cell(Cell.CELL_FILLED, spriteForX, spriteForY));
						
						//create phys body
						var mob:Mob = new Mob(null, BodyType.STATIC);
						var poly:Polygon = new Polygon(Polygon.box(tmxLoader.tileHeight, tmxLoader.tileWidth));
						mob.body.shapes.add(poly);
						mob.body.allowRotation = false;
						mob.body.position.x = tmxLoader.tileWidth * spriteForX + (tmxLoader.tileWidth/2);
						mob.body.position.y = tmxLoader.tileHeight * spriteForY + (tmxLoader.tileHeight/2);
						
						addMob(mob);
					}
					
				}
			}
		}
	}
}