package dk.sebb.controller.behaviors
{
	import flash.ui.Keyboard;
	
	import dk.sebb.model.LevelModel;
	import dk.sebb.model.mobs.Mob;
	import dk.sebb.util.Key;
	
	import nape.geom.Vec2;
	import nape.shape.Polygon;
	
	public class PlayerBehavior extends BaseBehavior implements IBehavior
	{
		public function PlayerBehavior()
		{
			super();
		}
		
		public function initialize(mob:Mob):void {
			var poly:Polygon = new Polygon(Polygon.box(22, 22));
			poly.sensorEnabled = true;
			mob.body.shapes.add(poly);
			
			var poly2:Polygon = new Polygon(Polygon.box(16, 5));
			poly2.translate(Vec2.get(0, 10, true));
			mob.body.shapes.add(poly2);
			
			mob.body.allowRotation = false;
		}
		
		public function run(mob:Mob, levelModel:LevelModel):void {
			controllMovement(mob);
		}
		
		public function controllMovement(mob:Mob):void {
			var moveVec:Vec2 = new Vec2();
			
			var vel:int = mob.movementSpeed;

			if(Key.isDown(Keyboard.D)) {
				moveVec.x += 1;
			}

			if(Key.isDown(Keyboard.A)) {
				moveVec.x += -1;
			}

			if(Key.isDown(Keyboard.W)) {
				moveVec.y += -1;
			}
			
			if(Key.isDown(Keyboard.S)) {
				moveVec.y += 1;
			}

			if(moveVec.length > 0) {
				moveVec = moveVec.mul( 1/moveVec.length );
				moveVec = moveVec.mul(vel);
			}
			
			mob.body.force = moveVec;
			mob.body.velocity = moveVec;
			mob.body.kinematicVel= new Vec2(-moveVec.x*3, -moveVec.y*3);
		}
	}
}