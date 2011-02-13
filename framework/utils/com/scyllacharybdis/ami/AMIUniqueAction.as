package com.scyllacharybdis.ami 
{
	/**
	 * ...
	 * @author 
	 */
	public class AMIUniqueAction extends AMIAction
	{
		private var _key:String;
		
		public function AMIUniqueAction( key:String ) 
		{
			_key = key;
		}

		public function get key():String { return _key; }
		
		public function set key(value:String):void 
		{
			_key = value;
		}
		
	}

}