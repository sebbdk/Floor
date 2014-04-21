package dk.sebb.view.mobs
{
	
	import dk.sebb.model.mobs.Mob;
	
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	
	public class MobView extends Sprite
	{
		protected var mob:Mob;
		
		public function MobView(mob:Mob, assets:AssetManager)
		{
			this.mob = mob;
			super();
		}
	}
}