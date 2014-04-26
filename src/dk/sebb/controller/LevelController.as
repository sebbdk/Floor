package dk.sebb.controller
{
	import flash.utils.getTimer;
	
	import dk.sebb.controller.behaviors.ConfusedBehavior;
	import dk.sebb.controller.behaviors.PlayerBehavior;
	import dk.sebb.model.LevelModel;
	import dk.sebb.model.events.ModelEvent;
	import dk.sebb.model.mobs.Mob;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	public class LevelController extends EventDispatcher
	{
		public var model:LevelModel; 
		
		private var behaviorMap:Object = {
			confused:new ConfusedBehavior(),
			player:new PlayerBehavior()
		};
		
		public function unload():void {
			model = null;
		}
		
		public function LevelController(model:LevelModel) {
			this.model = model;
			this.model.addEventListener(ModelEvent.ADDED_INT_MOB, onIntMobAdded);
		}
		
		private function onIntMobAdded(evt:ModelEvent):void {
			if(evt.mob) {
				if(behaviorMap[evt.mob.info.behavior]) {
					behaviorMap[evt.mob.info.behavior].initialize(evt.mob);
				} else {
					trace('unknown behavior '+ evt.mob.info.behavior);
				}
			}
		}
		
		public function run(evt:Event = null):void {
			for each(var mob:Mob in model.mobs) {
				if(mob && mob.info && behaviorMap[mob.info.behavior]) {
					behaviorMap[mob.info.behavior].run(mob, model);
				}
			}
			
			model.deltaTime = (getTimer() - model.lastFrameTime) / (1000/30);
			
			if(model.space && model.deltaTime  > 0) {
				model.space.step((1/30) * model.deltaTime, 10, 10);
				Main.shapeDebug.clear();
				Main.shapeDebug.draw(model.space);
			}
			
			if(model.deltaTime > 1) {
				model.lastFrameTime = getTimer();
			}
		}
	}
}