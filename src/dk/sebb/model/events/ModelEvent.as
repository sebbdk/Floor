package dk.sebb.model.events
{
	import dk.sebb.model.mobs.Mob;
	
	import starling.events.Event;
	
	public class ModelEvent extends Event
	{
		public static var LOADED:String = 'loaded';
		public static var ADDED_MOB:String = 'added mob';
		public static var ADDED_INT_MOB:String = 'added behavior mob';
		
		public var mob:Mob;
		
		public function ModelEvent(type:String, mob:Mob=null, bubbles:Boolean=false, data:Object=null)
		{
			this.mob = mob;
			super(type, bubbles, data);
		}
	}
}