package dk.sebb.controller.behaviors
{
	import dk.sebb.model.LevelModel;
	import dk.sebb.model.mobs.Mob;

	public interface IBehave
	{
		function initialize(mob:Mob):void;
		function run(mob:Mob, levelModel:LevelModel):void;
	}
}