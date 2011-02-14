package com.scyllacharybdis.components
{
	import com.scyllacharybdis.interfaces.IComponent;
	import com.scyllacharybdis.rendering.DoubleBuffer;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	
	/**
	 * 
	 */
	[Component (type="RenderComponent")]
	public class RenderComponent implements IComponent
	{
		private var _owner:Object;
		
		/**
		 * Get the owner of the component
		 */
		public function get owner():Object
		{
			return _owner;
		}
		
		/**
		 * Set the owner of the component
		 */
		public function set owner(value:Object):void
		{
			_owner = value;
		}
		
		/**
		 * Get the component type
		 */
		public function getComponentType():Class
		{
			return RenderComponent;
		}

		public function start():void
		{
		}
		
		/**
		 * User defined update
		 * @param	event
		 */
		public function update(event:TimerEvent):void
		{
		}

		public function stop():void
		{
		}

		public function destructor():void
		{
		}
		
		
		/**
		 * Get the comparator used for sorting
		 * @private
		 */ 
		public function get comparator():Number { return owner.position.z }
		

		/**
		 * Add the renderable to the surface
		 * @param	surface (DisplayObjectContainer) 
		 */
		public function render( surface:DoubleBuffer ):void
		{
		}
		
		/**
		 * Get the world rectangle
		 * @return
		 */
		public function getWorldRectange():Rectangle
		{
			return null;
		}
	}
}