package 
{
	import com.scyllacharybdis.di.createInjector;
	import com.scyllacharybdis.di.Injector;
	import com.scyllacharybdis.scenegraph.SceneGraph;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			// Create the injector using the core module configuration
			var injector:Injector = createInjector( new CoreModule(), this );
			
			var sceneGraph:SceneGraph = injector.getInstance( SceneGraph );
			
		}
		
	}
	
}