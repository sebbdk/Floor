package dk.sebb.model.mobs
{
	import dk.sebb.controller.behaviors.PlayerBehavior;
	import dk.sebb.tiled.layers.TMXObject;
	
	import nape.callbacks.CbEvent;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.shape.Polygon;
	import nape.space.Space;

	public class DetectorMob extends Mob
	{
		public var onEnterListener:InteractionListener;
		public var onLeaveListener:InteractionListener;
		
		public function DetectorMob(info:TMXObject, space:Space)
		{
			super(info);

			poly = new Polygon(Polygon.box(info.width, info.height));
			poly.sensorEnabled = true;
			body.shapes.add(poly);
			
			if(poly.sensorEnabled) {
				onEnterListener = new InteractionListener(CbEvent.BEGIN, 
					InteractionType.SENSOR,
					collisionType,
					PlayerBehavior.collisionType,
					onPlayerEnter);
				
				space.listeners.add(onEnterListener);
				
				onLeaveListener = new InteractionListener(CbEvent.END, 
					InteractionType.SENSOR,
					collisionType,
					PlayerBehavior.collisionType,
					onPlayerExit);
				
				space.listeners.add(onLeaveListener);
			}
			
			
		}
		
		private function onPlayerEnter(collision:InteractionCallback):void {
			trace('enter!!');
			if(info.onEnter) {
				//Level.lua.doString(object.onEnter);
			}
		}
		
		private function onPlayerExit(collision:InteractionCallback):void {
			trace('Exit!!');
			if(info.onExit) {
				//Level.lua.doString(object.onExit);
			}
		}
		
	}
}