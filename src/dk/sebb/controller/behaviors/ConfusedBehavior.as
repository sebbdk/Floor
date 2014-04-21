package dk.sebb.controller.behaviors
{
	import dk.sebb.model.LevelModel;
	import dk.sebb.model.mobs.Mob;
	import dk.sebb.util.SMath;
	
	import nape.geom.Vec2;
	import nape.shape.Polygon;

	public class ConfusedBehavior extends BaseBehavior implements IBehavior
	{	
		public function ConfusedBehavior()
		{
			super();
		}
		
		public function initialize(mob:Mob):void {
			var poly:Polygon = new Polygon(Polygon.box(20, 20));
			mob.body.shapes.add(poly);
			mob.body.allowRotation = false;
			mob.body.mass = 0.1;
		}
		
		public function run(mob:Mob, levelModel:LevelModel):void {
			findRandomPath(mob, levelModel);
			move(mob, levelModel);
		}
		
		public function move(mob:Mob, levelModel:LevelModel):void {
			if(mob.path && mob.path.length > 0) {
				var average:Number = ((levelModel.tileWidth + levelModel.tileHeight) / 2) / 2;
				var pathPos:Vec2 = new Vec2(
					(mob.path[0].x * levelModel.tileWidth) + levelModel.tileWidth/2,
					(mob.path[0].y * levelModel.tileHeight) + levelModel.tileHeight/2
				);
				
				if(Vec2.distance(mob.body.position,  pathPos) < average) {
					mob.path.shift();
				} else {
					var vec:Vec2 = pathPos.sub(mob.body.position);
					vec.length = mob.movementSpeed;

					mob.body.kinematicVel = vec;
					mob.body.velocity = vec;
					mob.body.force = vec;
				}
			}
		}
		
		public function findRandomPath(mob:Mob, levelModel:LevelModel):void {
			//implement gentleman "wait" if the path is occupied
			
			if(!mob.path || mob.path.length === 0) {
				var tilHeight:int = levelModel.tmxLoader.tileHeight;
				var tilWidth:int = levelModel.tmxLoader.tileWidth;
				var from:Vec2 = new Vec2(Math.floor(mob.body.position.x/tilWidth), Math.floor(mob.body.position.y/tilHeight));
				var to:Vec2 = new Vec2(from.x + SMath.randomRange(-2, 2) ,from.y + SMath.randomRange(-2, 2));
				var path:Array = levelModel.pathfinder.findPath(from, to);
				mob.path = path;
				
				trace("pathfinding!!");
			}
		}
	}
}