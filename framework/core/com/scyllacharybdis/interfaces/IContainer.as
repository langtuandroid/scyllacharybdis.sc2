package com.scyllacharybdis.interfaces 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface IContainer extends IStartStop
	{
		function addComponent( component:IComponent ):void;

		/**
		 * Get a component from the game object
		 * @param	type (int) The component id
		 */
		function getComponent( type:Class ):*;

		/**
		 * Remove the component by its type
		 * @param	type
		 */
		function removeComponentByType( type:Class ):void;

		/**
		 * Remove a component from the game object
		 * @param	component (Component)
		 */
		function removeComponent( component:* ):void;
	}
}