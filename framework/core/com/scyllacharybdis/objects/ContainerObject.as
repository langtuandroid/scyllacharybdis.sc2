package com.scyllacharybdis.objects 
{
	import com.scyllacharybdis.interfaces.IComponent;
	import com.scyllacharybdis.interfaces.IContainer;
	import com.scyllacharybdis.interfaces.IDestruct;
	import com.scyllacharybdis.memory.deallocate;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	/**
	 */
	public class ContainerObject implements IContainer
	{
		/****************************************/
		// Class Details
		/****************************************/
		
		private var _components:Dictionary = new Dictionary(true);
		
		
		public function destructor():void
		{
			_components = null;
		}
		
		/**
		 * The engine start method
		 * @private
		 */
		public function start():void
		{
			// Start everything else
			for each ( var component:IComponent in _components )
			{
				component.start();
			}
		}
		
		/**
		 * Engine update
		 * @param	event
		 */
		public function update(event:TimerEvent):void 
		{
			for each ( var comp:IComponent in _components ) 
			{
				comp.update(event);
			}
		}		

		/**
		 * The engine stop function
		 * @private
		 */
		public function stop():void
		{
			for each ( var component:IComponent in _components )
			{
				component.stop();
			}
		}
		
		/**
		 * Add a component to the game object
		 * @param	component (Component)
		 */
		public final function addComponent( component:IComponent ):void 
		{
			//trace( "AddComponent: " + component + " type: " + component.getComponentType() );
			// Set the owner of the component
			component.owner = this;
			
			// Check to see if there is an old one
			if ( _components[ component.getComponentType() ] != null )
			{
				// Remove the old component 
				removeComponentByType( component.getComponentType() );
			}

			_components[component.getComponentType()] =  component;

			// Setup the component
			//component.engine_start();
		}

		/**
		 * Get a component from the game object
		 * @param	type (int) The component id
		 */
		public final function getComponent( type:Class ):*
		{
			return _components[type];
		}
		
		public final function removeComponentByType( type:Class ):void
		{
			removeComponent( _components[type] );
		}

		/**
		 * Remove a component from the game object
		 * @param	component (Component)
		 */
		public final function removeComponent( component:* ):void
		{
			if (component == null)
			{
				return;
			}

			// Remove reference from the dictionary
			delete _components[component.getComponentType()];
			
			deallocate(component);
		}
	}
}