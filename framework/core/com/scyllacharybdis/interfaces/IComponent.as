package com.scyllacharybdis.interfaces 
{
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IComponent extends IStartStop
	{
		/**
		 * Get the owner of the component
		 */
		function get owner():Object;
		
		/**
		 * Set the owner of the component
		 */
		function set owner(value:Object):void;
		
		/**
		 * Get the component type
		 */
		function getComponentType():Class;
	
		/**
		 * User defined update
		 * @param	event
		 */
		function update(event:TimerEvent):void;
	}
}