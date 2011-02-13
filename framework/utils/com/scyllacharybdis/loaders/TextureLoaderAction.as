package com.scyllacharybdis.loaders 
{
	import com.scyllacharybdis.core.ami.AMIUniqueAction;
	import com.scyllacharybdis.core.cache.TextureCache;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	/**
	 */
	public class TextureLoaderAction extends AMIUniqueAction
	{
		private var _fileName:String;
		private var _loader:Loader = new Loader();
		private static var _cache:TextureCache = new TextureCache();
		
		public function TextureLoaderAction(fileName:String) 
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
			
			// Load the textire file
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedCompleteHandler);
			_loader.load( new URLRequest("textures/" + _fileName ) );
		}
		
		/**
		 * Load completed handler
		 * @param	e
		 */
		private function loadedCompleteHandler(e:Event):void
		{
			// Remove the listeners
			e.target.removeEventListener(Event.COMPLETE, loadedCompleteHandler);
			
			// Get the bitmap
			var bitmap:Bitmap = Bitmap(_loader.content);
			
			// Get the data
			var texture:BitmapData = bitmap.bitmapData;			
			
			// Store it in the cache
			_cache.setCache( _fileName, texture );
			
			//trace( "success( texture )" );
			// Call the success handler
			success( texture );
		}			
	}
}