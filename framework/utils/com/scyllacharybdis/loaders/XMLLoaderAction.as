package com.scyllacharybdis.loaders 
{
	import com.scyllacharybdis.core.ami.AMIUniqueAction;
	import com.scyllacharybdis.core.cache.XMLCache;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 */
	public class XMLLoaderAction extends AMIUniqueAction
	{
		private var _fileName:String;
		private static var _cache:XMLCache = new XMLCache();
		
		public function XMLLoaderAction(fileName:String) 
		{
			super(fileName);
			_fileName = fileName;
		}
		
		/**
		 * Execute the loading of the file
		 */
		public override function execute():void
		{
			// Check to see if we have already loaded it
			if ( _cache.getCache( _fileName ) ) 
			{
				// Call the success handler
				task.results.success( _cache.getCache( _fileName ) );
				return;
			}
			
			// Load the xml file
			var loader:URLLoader = new URLLoader( new URLRequest("xml/" + _fileName ) );
			loader.addEventListener(Event.COMPLETE, loadedCompleteHandler);	
		}
		
		/**
		 * Load completed handler
		 * @param	e
		 */
		private function loadedCompleteHandler(e:Event):void
		{
			// Remove the listeners
			e.target.removeEventListener(Event.COMPLETE, loadedCompleteHandler);
			
			// Get the data
			var xml:XML = XML(e.target.data);
			
			// Store it in the cache
			_cache.setCache( _fileName, xml );
			
			// Call the success handler
			success( xml );
		}		
	}
}