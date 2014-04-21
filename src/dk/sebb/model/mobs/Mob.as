package dk.sebb.model.mobs
{
	import dk.sebb.tiled.layers.TMXObject;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;

	public class Mob
	{
		public var info:TMXObject;
		public var body:Body;
		public var poly:Polygon;
		
		public var entity:String;
		public var graphic:String;
		
		public function Mob(info:TMXObject=null, type:BodyType=null) {
			this.info = info;
			body = new Body(type || BodyType.DYNAMIC, new Vec2(0, 0));
			
			if(info) {
				body.position.x = info.x + (info.width/2);
				body.position.y = info.y + (info.height/2);
			}
		}
	}
}