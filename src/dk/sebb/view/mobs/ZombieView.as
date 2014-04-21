package dk.sebb.view.mobs
{
	import dk.sebb.model.mobs.Mob;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	public class ZombieView extends MobView
	{
		private var img:Image;
		
		public function ZombieView(mob:Mob, assets:AssetManager)
		{
			super(mob, assets);
			
			img = new Image(assets.getTexture('zombie01.png'));
			img.smoothing = TextureSmoothing.NONE;
			img.x = -(img.width/2) +1;
			img.y = -(img.height/2) - 4;
			addChild(img);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function onEnterFrame(evt:Event):void {
			x = Math.round(mob.body.position.x);
			y = Math.round(mob.body.position.y);
		}
	}
}