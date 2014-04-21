package dk.sebb.controller.behaviors
{
	import dk.sebb.model.LevelModel;
	import dk.sebb.model.mobs.Mob;
	
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
			mob.body.mass = 30;
		}
		
		public function run(mob:Mob, levelModel:LevelModel):void {}
	}
}