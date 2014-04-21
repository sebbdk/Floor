package dk.sebb.model.mobs
{
	import dk.sebb.tiled.layers.TMXObject;
	
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionListener;
	import nape.phys.BodyType;
	import nape.shape.Polygon;

	public class ObjectMob extends Mob
	{
		public var onEnterListener:InteractionListener;
		public var onLeaveListener:InteractionListener;
		public var collisionType:CbType = new CbType();
		
		public function ObjectMob(info:TMXObject, isSensor:Boolean = false, type:BodyType=null, color:uint=0x00FFFF)
		{
			super(info, type);

			poly = new Polygon(Polygon.box(info.width, info.height));
			poly.sensorEnabled = isSensor;
			body.cbTypes.add(collisionType);
			body.shapes.add(poly);
			
			/*
			if(poly.sensorEnabled) {
				onEnterListener = new InteractionListener(CbEvent.BEGIN, 
					InteractionType.SENSOR,
					collisionType,
					Player.collisionType,
					onPlayerEnter);
				
				Level.space.listeners.add(onEnterListener);
				
				onLeaveListener = new InteractionListener(CbEvent.END, 
					InteractionType.SENSOR,
					collisionType,
					Player.collisionType,
					onPlayerExit);
				
				Level.space.listeners.add(onLeaveListener);
			}
			*/
			
		}
		/*
		private function onPlayerEnter(collision:InteractionCallback):void {
			if(object.onEnter) {
				Level.lua.doString(object.onEnter);
			}
		}
		
		private function onPlayerExit(collision:InteractionCallback):void {
			if(object.onExit) {
				Level.lua.doString(object.onExit);
			}
		}
		*/
	}
}