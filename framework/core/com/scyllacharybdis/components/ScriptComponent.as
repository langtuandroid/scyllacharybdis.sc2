package com.scyllacharybdis.components 
{
	import com.scyllacharybdis.interfaces.IComponent;
	import com.scyllacharybdis.objects.GameObject;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;

	/**
	 */
	[Component (type="ScriptComponent")]
	public class ScriptComponent implements IComponent
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
		
		/*
		 * Handler mouse down 
		 * Override to define your own behaviour
		 */
		public function onMouseDown( e:MouseEvent ):void
		{
		}
		
		/*
		 * Handler mouse up
		 * Override to define your own behaviour
		 */
		public function onMouseUp( e:MouseEvent ):void
		{
		}
		
		/*
		 * Handler click
		 * Override to define your own behaviour
		 */
		public function onClick( e:MouseEvent ):void
		{
			//trace( "clicked" );
		}
		
		/*
		 * Handler double click
		 * Override to define your own behaviour
		 */
		public function onDoubleClick( e:MouseEvent ):void
		{
		}
		
		/*
		 * Handler mouse move
		 * Override to define your own behaviour
		 */
		public function onMouseMove( e:MouseEvent ):void
		{
		}
		
		/*
		 * Handler mouse lost focus
		 * Override to define your own behaviour
		 */
		public function onMouseOut( e:MouseEvent ):void
		{
		}
		
		/*
		 * Handler mouse over
		 * Override to define your own behaviour
		 */
		public function onMouseOver( e:MouseEvent ):void
		{
		}
		
		/*
		 * Handler wheel mouse
		 * Override to define your own behaviour
		 */
		public function onMouseWheel( e:MouseEvent ):void
		{
		}
		
		/*
		 * Handler roll over
		 * Override to define your own behaviour
		 */
		public function onRollOver( e:MouseEvent ):void
		{
			
		}

		/*
		 * Handler roll out (Whatever that is)
		 * Override to define your own behaviour
		 */
		public function onRollOut( e:MouseEvent ):void
		{
		}
		
		/*
		 * Handler key down
		 * Override to define your own behaviour
		 */
		public function onKeyDown( e:KeyboardEvent ):void
		{
		}
		
		/*
		 * Handler key up
		 * Override to define your own behaviour
		 */
		public function onKeyUp( e:KeyboardEvent ):void
		{
		}
		
		/**
		 * A colision has happened
		 * @param	obj (GameObject) The game object that you colided with
		 */
		public function onBeginContact( obj:GameObject ):void
		{
		}

		/**
		 * A colision has stoped
		 * @param	obj (GameObject) The game object that you colided with
		 */
		public function onEndContact( obj:GameObject ):void
		{
		}
	}
}