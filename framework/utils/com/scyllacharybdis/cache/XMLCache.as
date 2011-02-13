package com.scyllacharybdis.cache 
{
	import flash.utils.Dictionary;

	/**
	 */
	public class XMLCache 
	{
		private var _xmlList:Dictionary = new Dictionary(true);
	
		/**
		 *  Return the loaded xml
		 * @param	fileName (String) Key to the data
		 */
		public function getCache( fileName:String ):XML
		{
			return _xmlList[fileName];
		}
		
		/**
		 * Store the xml
		 * @param	fileName (String) Key to the data
		 * @param	xml (XML) The xml data
		 */
		public function setCache(fileName:String, xml:XML):void 
		{
			_xmlList[fileName] = xml;
		} 
	}
}