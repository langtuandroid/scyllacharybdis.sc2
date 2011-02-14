package com.scyllacharybdis.core.objects 
{
	import flash.events.TimerEvent;
	/**
	 * ...
	 * @author 
	 */
	public class ComponentObject extends BaseObject
	{
		private var _owner:Object;
		
		/**
		 * Get the owner of the component
		 */
		public final function get owner():Object { return _owner; }
		
		/**
		 * Set the owner of the component
		 */
		public final function set owner(value:Object):void 
		{
			_owner = value;
		}
		
		/**
		 * Get the component type
		 */
		public final function getComponentType():Class
		{
			return getClassDetails().componentType;
		}		
		
		/**
		 * Engine update
		 * @param	event
		 */
		public function engine_update(event:TimerEvent):void 
		{
			update(event);
		}
		
		/**
		 * User defined update
		 * @param	event
		 */
		public function update(event:TimerEvent):void 
		{
			
		}
		
	}

}